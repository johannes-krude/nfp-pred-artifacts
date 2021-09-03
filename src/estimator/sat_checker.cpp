
#include "estimator/sat_checker.hpp"
#include "estimator/model.tab.hpp"
#include "estimator/model.lex.hpp"
#include "estimator/unsat_core.tab.hpp"
#include "estimator/unsat_core.lex.hpp"
#include "estimator/stats.hpp"

#include <optional>
#include <unordered_set>
#include <string>
#include <mutex>
#include <cstdint>
#include <iostream>
#include <ext/stdio_filebuf.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <err.h>

bool sat_checker::debug = false;

std::string sat_checker::z3_version() {
	int out[2];
	pid_t pid;
	int wstatus;

	if (pipe(out) == -1)
		err(-1, "pipe()");
	pid = fork();
	switch (pid) {
	case -1:
		err(-1, "fork()");
	case 0:
		if (close(out[0]) ||
		    close(0) ||
		    close(1))
			err(-1, "close()");
		if (dup2(out[1], 1) == -1)
			err(-1, "dup2()");
		if (close(out[1]))
			err(-1, "close()");
		execlp("z3", "z3", "--version", nullptr);
		err(-1, "execlp(z3 --version)");
	}
	if (close(out[1]))
		err(-1, "close()");
	if (waitpid(pid, &wstatus, 0) == -1)
		err(-1, "waitpid()");
	
	char buf[256] = {};
	if (read(out[0], buf, sizeof(buf)-1) < 0)
		err(-1, "read");
	close(out[0]);

	char* nl = strchr(buf, '\n');
	if (nl)
		*nl = 0;
	return buf;
}

sat_checker::sat_checker()
	: in(nullptr),
	  out(nullptr) {
	static stats::cputime cputime("z3.cputime");
	static stats::maxmem maxmem("z3.maxmem");

	int in[2];
	int out[2];

	static std::mutex m;

	m.lock();
	if ((pipe(in) == -1) ||
	    (pipe(out) == -1))
		err(-1, "pipe()");
	this->pid = fork();
	switch (this->pid) {
	case -1:
		err(-1, "fork()");
	case 0:
		if (close(in[1]) ||
		    close(out[0]) ||
		    close(0) ||
		    close(1))
			err(-1, "close()");
		if (dup2(in[0], 0) == -1 ||
		    dup2(out[1], 1) == -1)
			err(-1, "dup2()");
		if (close(in[0]) ||
		    close(out[1]))
			err(-1, "close()");
		if (debug) {
			execlp("bash", "bash", "-c", "tee -a /dev/fd/2 | z3 -in | tee -a /dev/fd/2", nullptr);
		} else {
			execlp("z3", "z3", "-in", nullptr);
		}
		err(-1, "execlp(z3 -in)");
	}
	if (close(in[0]) ||
	    close(out[1]))
		err(-1, "close()");
	cputime.add(this->pid);
	maxmem.add(this->pid);
	m.unlock();

	this->fbi = new __gnu_cxx::stdio_filebuf<char>(in[1], std::ios_base::out);
	this->in.rdbuf(this->fbi);
	this->fbo = new __gnu_cxx::stdio_filebuf<char>(out[0], std::ios_base::in);
	this->out.rdbuf(this->fbo);

	this->in << "(set-option :model.partial true)\n";
}

sat_checker::~sat_checker() {
	int wstatus;

	this->in.rdbuf(nullptr);
	delete this->fbi;
	if (waitpid(this->pid, &wstatus, 0) == -1)
		err(-1, "waitpid()");
	std::string z3_out = std::string(std::istreambuf_iterator<char>(this->out), {});
	if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus))
		errx(-1, "z3 terminated abnormal: %s", z3_out.c_str());
	this->out.rdbuf(nullptr);
	delete this->fbo;
}

void sat_checker::reset() {
	this->in << "(reset)\n";
}

void sat_checker::push() {
	this->in << "(push)\n";
}

void sat_checker::pop(size_t size) {
	this->in << "(pop " + std::to_string(size) + ")\n";
}

void sat_checker::enable_unsat_cores() {
	this->in << "(set-option :produce-unsat-cores true)\n";
	this->in << "(set-option :smt.core.minimize true)\n";
}

void sat_checker::declare(std::shared_ptr<const expr::decl> var) {
	this->in << var->declare();
}

void sat_checker::minimize(expr::bvptr<14> e) {
	this->in << e->minimize(); 
}

void sat_checker::define(std::shared_ptr<const expr::def> e, const class expr::defs& d) {
	e->define(this->in, d);
}

void sat_checker::assert(const assumption& a, const class expr::defs& d) {
	a.e->assert(this->in, d);
}

void sat_checker::assert_named(const assumption& a, const class expr::defs& d) {
	a.e->assert(this->in, a.id, d);
}

bool sat_checker::check_sat() {
	static stats::counter s_sat_checks("z3.sat_checks");
	static stats::counter s_sat("z3.sat");
	static stats::counter s_unsat("z3.unsat");

	this->in << "(check-sat)" << std::endl;
	this->in.flush();
	s_sat_checks.count();

	for (;;) {
		std::string line;
		getline(this->out, line);
		if (line.find("(error ") != std::string::npos)
			//errx(-1, "%s", line.c_str());
			throw(line);
		if (line == "sat") {
			s_sat.count();
			return true;
		}
		if (line == "unsat") {
			s_unsat.count();
			return false;
		}
	}
}

std::string sat_checker::read_balanced() {
	std::string z3_out;
	std::ptrdiff_t braces = 0;
	do {
		std::string line;
		getline(this->out, line);
		z3_out += line;
		for (const char& c: line) {
			if (c == '(')
				braces += 1;
			if (c == ')')
				braces -= 1;
		}
	} while (braces > 0);
	return z3_out;
}

sat_checker::model sat_checker::get_model() {
	this->in << "(get-model)" << std::endl;
	this->in.flush();
	std::string z3_out = read_balanced();

	model_fun* list = nullptr;
	yyscan_t scanner;
	if (modellex_init(&scanner))
		errx(-1, "model_lex_init");
	YY_BUFFER_STATE buf = model_scan_string(z3_out.c_str(), scanner);
	model_parse(scanner, &list, z3_out);
	model_delete_buffer(buf, scanner);
	modellex_destroy(scanner);

	std::map<std::string, std::string> fa;
	for (model_fun* l = list; l; l = l->next) {
		if (l->type == model_fun::ARRAY_FUN)
			fa[l->fun] = l->name;
	}
	model m;
	for (model_fun* l = list; l; l = l->next) {
		switch (l->type) {
		case model_fun::BV:
			m.variables[l->name] = l->bv;
			break;
		case model_fun::FUN: {
			std::string a = fa[l->name];
			for (model_kv* kv = l->kv; kv; kv = kv->next)
				m.arrays[std::make_pair(a,kv->key)] = kv->value;
			break;}
		case model_fun::ARRAY_FUN:
			break;
		}
	}
	if (list)
		delete list;

	return m;
}

std::optional<std::uint64_t> sat_checker::model::get_value(const std::string n) const {
	auto i = this->variables.find(n);
	if (i == this->variables.end())
		return {};
	return i->second;
}

std::optional<std::uint64_t> sat_checker::model::get_value(std::string n, std::uint64_t o) const {
	auto i = this->arrays.find(std::make_pair(n, o));
	if (i == this->arrays.end())
		return {};
	return i->second;
}

std::map<std::uint64_t,std::uint64_t> sat_checker::model::get_values(std::string n) const {
	std::map<std::uint64_t,std::uint64_t> map;

	auto i = this->arrays.lower_bound(std::make_pair(n, 0));
	auto e = this->arrays.upper_bound(std::make_pair(n, std::numeric_limits<std::uint64_t>::max()));
	for (; i != e; i++)
		map[i->first.second] = i->second;

	return map;
}

sat_checker::unsat_core sat_checker::get_unsat_core() {
	this->in << "(get-unsat-core)" << std::endl;
	this->in.flush();
	std::string z3_out = read_balanced();

	unsat_core_list* list = nullptr;
	yyscan_t scanner;
	if (unsat_corelex_init(&scanner))
		errx(-1, "unsat_core_lex_init");
	YY_BUFFER_STATE buf = unsat_core_scan_string(z3_out.c_str(), scanner);
	unsat_core_parse(scanner, &list, z3_out);
	unsat_core_delete_buffer(buf, scanner);
	unsat_corelex_destroy(scanner);

	unsat_core c;
	for (unsat_core_list* l = list; l; l = l->next)
		c.set.insert(l->id);
	if (list)
		delete list;
	
	return c;
}

sat_checker::unsat_core::unsat_core(std::unordered_set<std::string>&& set)
	: set(set) {}

sat_checker::unsat_core::unsat_core(std::initializer_list<std::string> l)
	: set(l) {}

bool sat_checker::unsat_core::includes(std::string id) const {
	return this->set.find(id) != this->set.end();
}

