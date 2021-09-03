
#include "estimator/state.hpp"
#include "estimator/instr.hpp"
#include "estimator/expr.hpp"
#include "estimator/sat_checker.hpp"
#include "estimator/stats.hpp"
#include "estimator/features.hpp"

#include <vector>
#include <set>
#include <utility>
#include <memory>
#include <limits>
#include <iostream>
#include <err.h>


bool state::debug_assignments = false;
std::set<std::uint32_t> state::debug_instrs = {};

auto o_sat_strategy = features::strategies<state::sat_strategy>("sat-strategy", {
	features::s<state::sat_strategy, state::sat_strategy::unsat_core>("unsat-core"),
	features::s<state::sat_strategy, state::sat_strategy::incremental>("incremental"),
});

state::perf::perf(unsigned int cycles, double dram_cycles)
	: summaxcycles(cycles),
	  sumdramcycles(dram_cycles) {}

state::exec::exec(unsigned int cycles, double dram_cycles, updates input, std::shared_ptr<const struct expr::bvvariable<14>> minimize, std::uint32_t min_value, std::uint32_t max_value, std::initializer_list<sat_checker::assumption> assumptions)
	: perf(cycles, dram_cycles),
	  sumcycles(cycles),
	  lastmem(cycles),
	  lastcc(cycles),
	  minimize(minimize),
	  min_value(min_value),
	  max_value(max_value),
	  assumptions(assumptions) {
	for (auto& i: input)
		i->store(*this);
}

state::perf::info state::perf::info::max() {
	info i;
	i.sincecc = std::numeric_limits<unsigned int>::max();
	i.sincemem = std::numeric_limits<unsigned int>::max();
	return i;
}

state::perf::info::info(unsigned int sincecc, unsigned int sincemem)
	: sincecc(sincecc),
	  sincemem(sincemem) {}

state::perf::info state::perf::info::apply(const instr& n, bool branchtrue) const {
	unsigned int c = cycles(n, *this, branchtrue);
	info r = info(this->sincecc + c, this->sincemem + c);
	if (n.writescc())
		r.sincecc = 0;
	if (n.type() == instr::MEM)
		r.sincemem = 0;
	return r;
}

state::perf::info state::perf::info::merge(const info& i) const {
	return info(
		std::min(this->sincecc, i.sincecc),
		std::min(this->sincemem, i.sincemem)
	);
}

unsigned int state::perf::cycles(const instr& n, const info& i, bool branchtrue) {
	switch (n.type()) {
	case instr::BRANCH:
		// TODO: handle defer
		if (branchtrue) {
			if (i.sincecc > 0) {
				return instr::branch::COST_TRUE_EARLY;
			} else {
				return instr::branch::COST_TRUE;
			}
		} else {
			return instr::branch::COST_FALSE;
		}
	case instr::MEM: {
		unsigned int min = n.cycles();
		if (!n.waits())
			return min;
		unsigned int max = n.max_cycles();
		if (i.sincemem >= max-min) {
			return min;
		} else {
			return max-i.sincemem;
		}}
	case instr::FIN:
		return 0;
	default:
		return n.cycles();
	}
}

void state::perf::apply(const instr& n, const info& i, std::size_t loopdepth, bool branchtrue) {
	this->summaxcycles += cycles(n, i, branchtrue);
	this->sumdramcycles += n.dram_cycles();
}

unsigned int state::perf::max_cycles() const {
	return this->summaxcycles;
}

double state::perf::dram_cycles() const {
	return this->sumdramcycles;
}

void state::exec::assume(const sat_checker::assumption& a) {
	std::shared_ptr<const struct expr::boolean> bl = std::dynamic_pointer_cast<const struct expr::boolean>(a.e);
	if (bl) {
		if (!bl->value) {
			this->sat = false;
			this->model = sat_checker::model();
			this->unsat_core = sat_checker::unsat_core({a.id});
		}
		return;
	}

	for (const auto & as: this->assumptions) {
		if (a == as)
			return;
	}

	if (this->minimize) {
		std::shared_ptr<const expr::bvugecomparison<14>> compge = std::dynamic_pointer_cast<const expr::bvugecomparison<14>>(a.e);
		std::shared_ptr<const expr::bitvector<14>> val;
		if (compge)
			val = std::dynamic_pointer_cast<const expr::bitvector<14>>(compge->b);
		if (compge && val && *compge->a == *this->minimize) {
			if (val->value > this->min_value)
				this->min_value = val->value;
			if (this->min_value >= this->max_value) {
				this->sat = false;
				this->model = sat_checker::model();
				this->unsat_core = sat_checker::unsat_core({a.id});
			}
			return;
		}
		std::shared_ptr<const expr::bvultcomparison<14>> complt = std::dynamic_pointer_cast<const expr::bvultcomparison<14>>(a.e);
		if (complt)
			val = std::dynamic_pointer_cast<const expr::bitvector<14>>(complt->b);
		if (complt && val && *complt->a == *this->minimize) {
			if (val->value <= this->max_value)
				this->max_value = val->value;
			if (this->min_value >= this->max_value) {
				this->sat = false;
				this->model = sat_checker::model();
				this->unsat_core = sat_checker::unsat_core({a.id});
			}
			return;
		}
	}

	this->assumptions.push_back(a);
}

std::string state::exec::assumption_name(const instr& n, std::size_t loopdepth, bool branchtrue) {
	return n.name()+(branchtrue ? "T" : "F" )+std::to_string(n.get_id())+"L"+std::to_string(loopdepth);
}

void state::exec::apply(const instr& n, const perf::info& i, std::size_t loopdepth, bool branchtrue) {
	if (debug_assignments ||(!debug_instrs.empty() && debug_instrs.find(n.get_id()) != debug_instrs.end()))
		std::cerr << n.str() << std::endl;

	perf::info d(
		this->sumcycles - this->lastcc,
		this->sumcycles - this->lastmem
	);
	this->summaxcycles  += perf::cycles(n, i, branchtrue);
	this->sumdramcycles += n.dram_cycles();
	this->sumcycles     += perf::cycles(n, d, branchtrue);

	if (n.type() == instr::MEM)
		this->lastmem = this->sumcycles;
	if (n.writescc())
		this->lastcc = this->sumcycles;

	if (this->sat && !*this->sat)
		return;

	if (n.type() == instr::BRANCH) {
		this->sat = {};
		this->model = {};
		if (branchtrue) {
			assume(sat_checker::assumption(n.check(*this), assumption_name(n, loopdepth, branchtrue)));
		} else {
			assume(sat_checker::assumption(expr::isfalse(n.check(*this)), assumption_name(n, loopdepth, branchtrue)));
		}
	}

	updates updates = n.perform(*this);

	for(auto d = this->defered.begin(); d != this->defered.end();) {
		if (d->first > this->sumcycles) {
			d++;
			continue;
		}
		d->second->store(*this);
		d = this->defered.erase(d);
	}

	if (!debug_instrs.empty() && debug_instrs.find(n.get_id()) != debug_instrs.end()) {
		for (auto& u: updates)
			u = u->debug();
	}

	for (auto& u: updates)
		u->store(*this);
}

state::exec state::exec::static_merge(const state::exec& o) const {
	state::exec n;
	n.summaxcycles = std::max(this->summaxcycles, o.summaxcycles);
	n.sumdramcycles = std::max(this->sumdramcycles, o.sumdramcycles);
	n.sumcycles = std::max(this->sumcycles, o.sumcycles);
	n.lastmem = std::max(this->lastmem, o.lastmem);
	n.lastcc = std::max(this->lastcc, o.lastcc);

	for (auto& a: this->assumptions) {
		for (auto& b: o.assumptions) {
			if (a == b)
				n.assumptions.push_back(a);
		}
	}
	for (auto& [r,e]: this->registers) {
		auto f = o.registers.find(r);
		if (f != o.registers.end())
			n.registers[r] = e->static_merge(f->second);
	}
	for (auto& [r,e]: this->flags) {
		auto f = o.flags.find(r);
		if (f != o.flags.end())
			n.flags[r] = e->static_merge(f->second);
	}
	for (auto& [r,e]: this->mem8) {
		auto f = o.mem8.find(r);
		if (f != o.mem8.end())
			n.mem8[r] = e->static_merge(f->second);
	}
	for (auto& [r,e]: this->mem32) {
		auto f = o.mem32.find(r);
		if (f != o.mem32.end())
			n.mem32[r] = e->static_merge(f->second);
	}
	for (auto& d: this->defered)
		d.second->to_undef("no_defered_merge")->store(n);
	for (auto& d: o.defered)
		d.second->to_undef("no_defered_merge")->store(n);
	if (this->sat && !*this->sat && o.sat && !*o.sat)
		n.sat = false;

	if (this->minimize == o.minimize)
		n.minimize = this->minimize;
	n.min_value = std::min(this->min_value, o.min_value);
	n.max_value = std::max(this->max_value, o.max_value);

	return n;
}

unsigned int state::exec::cycles() const {
	return this->sumcycles;
}

void state::update::noop::store(state::exec& state) const {
}

void state::update::reg::store(state::exec& state) const {
	if (debug_assignments || this->is_debugged)
		std::cerr << this->d.location() << " -> " << this->e->str()  << std::endl;
	state.registers[this->d.location()] = this->e;
}

void state::update::flag::store(state::exec& state) const {
	if (debug_assignments || this->is_debugged)
		std::cerr << this->d.location() << " -> " << this->e->str()  << std::endl;
	state.flags[this->d.location()] = this->e;
}

template<>
void state::update::mem<8>::store(state::exec& state) const {
	if (debug_assignments || this->is_debugged)
		std::cerr << this->d->declname << " -> " << this->e->str()  << std::endl;
	state.mem8[this->d->declname] = this->e;
}

template<>
void state::update::mem<32>::store(state::exec& state) const {
	if (debug_assignments || this->is_debugged)
		std::cerr << this->d->declname << " -> " << this->e->str()  << std::endl;
	state.mem32[this->d->declname] = this->e;
}

void state::update::invalidate_mem::store(state::exec& state) const {
	if (debug_assignments || this->is_debugged)
		std::cerr << "invalidate memory" << std::endl;
	state.mem8 = {};
	state.mem32 = {};
}

void state::update::defered::store(state::exec& state) const {
	state.defered.push_back({state.sumcycles + this->cycles, this->u});
}

expr::bvptr<32> state::exec::operator[](const state::deposit::reg& d) const {
	std::string loc = d.location();
	auto i = this->registers.find(loc);
	if (i != this->registers.end())
		return i->second;
	return expr::undef<32>(loc);
}

expr::bvptr<1> state::exec::operator[](const state::deposit::flag& d) const {
	std::string loc = d.location();
	auto i = this->flags.find(loc);
	if (i != this->flags.end())
		return i->second;
	return expr::undef<1>(loc);
}

expr::aptr<32,8> state::exec::operator[](expr::avptr<32,8> a) const {
	auto i = this->mem8.find(a->declname);
	if (i != this->mem8.end())
		return i->second;
	return expr::undef_array<32,8>("unknown_mem8", a);
}

expr::aptr<32,32> state::exec::operator[](expr::avptr<32,32> a) const {
	auto i = this->mem32.find(a->declname);
	if (i != this->mem32.end())
		return i->second;
	return expr::undef_array<32,32>("unknown_mem32", a);
}

bool state::exec::is_decided() const {
	return (bool) this->sat;
}

bool state::exec::is_unsat() const {
	return this->sat && !*this->sat;
}

bool state::exec::check_sat(const decltype(assumptions)& assumptions, bool minimize_unsat_prefix) {
	if (this->sat)
		return *this->sat;
	if (assumptions.empty()) {
		this->sat = true;
		this->model = sat_checker::model();
		this->unsat_core = {};
		return *this->sat;
	}

	auto result = o_sat_strategy().check_sat(*this, assumptions, minimize_unsat_prefix);

	this->sat = result.sat;
	if (*this->sat) {
		this->model = std::move(result.model);
		this->unsat_core = {};
		if (this->minimize) {
			std::optional<std::uint32_t> m = this->model->get_value(this->minimize->declname);
			if (m && *m > this->min_value) {
				static stats::counter s_tighter_bound("z3.tighter_bound");
				s_tighter_bound.count();
				this->min_value = *m;
			}
		}
	} else {
		this->model = {};
		this->unsat_core = std::move(result.unsat_core);
	}

	return *this->sat;
}

bool state::exec::check_sat(bool minimize_unsat_prefix) {
	return check_sat(this->assumptions, minimize_unsat_prefix);
}

void state::exec::partial_minimize() {
	if (this->sat)
		return;

	bool minimizes = false;
	decltype(this->assumptions) assumptions;
	assumptions.reserve(this->assumptions.size());
	for (auto& a: this->assumptions) {
		class expr::defs defs;
		a.e->defs(defs);
		if (defs.undef().size())
			continue;
		assumptions.push_back(a);
		if (defs.decls().find(this->minimize) != defs.decls().end())
			minimizes = true;
	}

	if (minimizes)
		check_sat(assumptions, false);
}

std::uint32_t state::exec::minimum_value() const {
	return this->min_value;
}

std::optional<std::uint64_t> state::exec::get_value(std::string name) {
	if (!this->model)
		check_sat(false);
	return this->model->get_value(name);
}

std::optional<std::uint64_t> state::exec::get_value(std::string name, std::uint64_t offset) {
	if (!this->model)
		check_sat(false);
	return this->model->get_value(name, offset);
}

std::map<std::uint64_t,std::uint64_t> state::exec::get_values(std::string name) {
	if (!this->model)
		check_sat(false);
	return std::move(this->model->get_values(name));
}

bool state::exec::in_unsat_core(const instr& n, std::size_t loopdepth, bool branchtrue) {
	if (!this->model)
		check_sat(false);
	return this->unsat_core->includes(assumption_name(n, loopdepth, branchtrue));
}

state::sat_strategy::result state::sat_strategy::unsat_core::check_sat(const state::exec& state, const std::vector<sat_checker::assumption>& assumptions, bool minimize_unsat_prefix) {
	c.reset();
	if (minimize_unsat_prefix)
		c.enable_unsat_cores();

	class expr::defs defs;
	if (state.minimize)
		state.minimize->defs(defs);
	for (auto& a: assumptions)
		a.e->defs(defs);
	for (auto& d: defs.decls())
		c.declare(d);
	for (auto& d: defs.def())
		c.define(d, defs);
	if (state.minimize) {
		c.minimize(state.minimize);
		c.assert_named(sat_checker::assumption(expr::bvuge<14>(state.minimize, expr::constant<14>(state.min_value)), "min_value"), defs);
		c.assert_named(sat_checker::assumption(expr::bvule<14>(state.minimize, expr::constant<14>(state.max_value)), "max_value"), defs);
	}
	for (auto& a: assumptions)
		c.assert_named(a, defs);

	bool sat;
	try {
		sat = c.check_sat();
	}
	catch (std::string msg) {
		for (auto& d: defs.def()) {
			std::cerr << d->p << d->n << ": ";
			d->e->write(std::cerr, defs, false);
			std::cerr << "\n";
		}
		std::cerr << "\n";
		for (auto& a: assumptions) {
			std::cerr << a.id << ": ";
			a.e->write(std::cerr, defs);
			std::cerr << "\n";
		}
		std::cerr << "\n";
		errx(-1, "%s", msg.c_str());
	}

	if (sat) {
		return result(c.get_model());
	} else {
		if (minimize_unsat_prefix) {
			return c.get_unsat_core();
		} else {
			return sat_checker::unsat_core({assumptions.back().id});
		}
	}
}

state::sat_strategy::result state::sat_strategy::incremental::check_sat(const state::exec& state, const std::vector<sat_checker::assumption>& assumptions_, bool minimize_unsat_prefix) {
	std::shared_ptr<const class expr::defs> parent_defs = this->start_defs;

	if (this->minimize != state.minimize) {
		c.reset();
		this->stack.clear();
		auto defs = std::make_shared<class expr::defs>("min");
		this->start_defs = parent_defs = defs;
		this->minimize = state.minimize;
		this->minimize->defs(*defs);
		for (auto& d: defs->decls())
			c.declare(d);
		for (auto& d: defs->def())
			c.define(d, *defs);
		c.minimize(this->minimize);
	}

	std::vector<sat_checker::assumption> assumptions = assumptions_;
	if (this->minimize) {
		assumptions.push_back(sat_checker::assumption(expr::bvuge<14>(this->minimize, expr::constant<14>(state.min_value)), "min_value"));
		assumptions.push_back(sat_checker::assumption(expr::bvule<14>(this->minimize, expr::constant<14>(state.max_value)), "max_value"));
	}

	if (assumptions.size() > this->stack.capacity())
		this->stack.reserve(assumptions.size());

	auto si = this->stack.begin();
	for (auto ai = assumptions.begin(); ai != assumptions.end(); ai++) {
		if (si != this->stack.end() && *ai == si->assumption) {
			parent_defs = si->defs;
			si++;
			continue;
		}

		if (si != this->stack.end()) {
			c.pop(this->stack.end() - si);
			this->stack.erase(si, this->stack.end());
		}
		auto defs = std::make_shared<expr::defs::scoped>("s" + std::to_string(this->stack.size()), parent_defs);
		this->stack.push_back(stack_t(*ai, defs));
		si = this->stack.end();
		parent_defs = defs;

		c.push();
		ai->e->defs(*defs);
		for (auto& d: defs->decls())
			c.declare(d);
		for (auto& d: defs->def())
			c.define(d, *defs);
		c.assert(*ai, *defs);
		if (!c.check_sat())
			goto unsat;
	}

	if (si != this->stack.end()) {
		if (this->model)
			return result(*this->model);
		c.pop(this->stack.end() - si);
		this->stack.erase(si, this->stack.end());
	}

	if (c.check_sat()) {
		this->model = c.get_model();
		return result(*this->model);
	}

unsat:
	this->model = {};
	std::unordered_set<std::string> ids;
	for (const auto& s: this->stack)
		ids.insert(s.assumption.id);
	return sat_checker::unsat_core(std::move(ids));
}

