#pragma once

#include "estimator/expr.hpp"

#include <string>
#include <map>
#include <unordered_set>
#include <iostream>
#include <optional>
#include <functional>
#include <ext/stdio_filebuf.h>
#include <cstdint>
#include <cstddef>
#include <sys/types.h>

class sat_checker {
public:
	static bool debug;

	struct assumption {
		expr::lptr e;
		std::string id;
		assumption(const expr::lptr& e, std::string id)
			: e(e),
			  id(id) {}
		bool operator==(const assumption& o) const {
			return *this->e == *o.e;
		}
	};
	class model {
		friend sat_checker;
	private:
		std::map<std::string,std::uint64_t> variables = {};
		std::map<std::pair<std::string,std::uint64_t>,std::uint64_t> arrays = {};
	public:
		std::optional<std::uint64_t> get_value(const std::string n) const;
		std::optional<std::uint64_t> get_value(std::string n, std::uint64_t o) const;
		std::map<std::uint64_t,std::uint64_t> get_values(std::string n) const;
	};
	class unsat_core {
		friend sat_checker;
	private:
		std::unordered_set<std::string> set = {};
	public:
		unsat_core() = default;
		unsat_core(std::unordered_set<std::string>&& set);
		unsat_core(std::initializer_list<std::string> l);
		bool includes(std::string id) const;
	};
	static std::string z3_version();
private:
	__gnu_cxx::stdio_filebuf<char>* fbi;
	__gnu_cxx::stdio_filebuf<char>* fbo;
	std::ostream in;
	std::istream out;
	pid_t pid;

	std::string read_balanced();
public:
	sat_checker();
	~sat_checker();
	void reset();
	void push();
	void pop(size_t size);
	void enable_unsat_cores();
	void declare(std::shared_ptr<const expr::decl> var);
	void minimize(expr::bvptr<14> e);
	void define(std::shared_ptr<const expr::def> e, const class expr::defs& d);
	void assert(const assumption& a, const class expr::defs& d);
	void assert_named(const assumption& a, const class expr::defs& d);
	bool check_sat();
	model get_model();
	unsat_core get_unsat_core();
};

