#include "estimator/cfg.hpp"
#include "estimator/state.hpp"
#include "estimator/instr.hpp"
#include "estimator/thread_pool.hpp"
#include "estimator/stats.hpp"
#include "estimator/features.hpp"

bool mem_available();

#include <memory>
#include <thread>
#include <atomic>
#include <string>
#include <vector>
#include <list>
#include <stack>
#include <queue>
#include <map>
#include <set>
#include <optional>
#include <iterator>
#include <algorithm>
#include <sstream>
#include <iostream>
#include <fstream>
#include <chrono>
#include <limits>
#include <cinttypes>
#include <typeinfo>
#include <err.h>


unsigned int cfg::COST_FIRMWARE = 224;
double cfg::DRAM_COST_FIRMWARE = 0.0;
std::size_t cfg::PARALLELISM = std::thread::hardware_concurrency();
std::size_t cfg::UNROLL_LIMIT = 0;
std::map<std::uint32_t,std::size_t> cfg::UNROLL_LIMITS = {};
std::uint32_t cfg::MIN_PACKETSIZE = 60;
std::uint32_t cfg::MTU = 1500;
unsigned int cfg::NUM_WORKERS = 50;
std::uint32_t cfg::PACKET_HEADROOM = 1<<31;

auto o_impossible_prefixes     = features::flag("impossible-prefixes", true);
auto o_check_each_branch       = features::flag("check-each-branch", false);
auto o_check_unlikely_edges    = features::flag("check-unlikely-edges", false);
auto o_impossible_path_merging = features::flag("impossible-path-merging", true);
auto o_keep_impossible_paths   = features::flag("keep-impossible-paths", true);

struct node_data;

class cfg::node : public std::enable_shared_from_this<cfg::node> {
public:
	struct pred_data {
		std::shared_ptr<node> nd;
		bool branchtrue;
		pred_data(nptr nd, bool branchtrue)
			: nd(nd),
			  branchtrue(branchtrue) {}
		mpathq::sizev& sizes() {
			return this->nd->succ(this->branchtrue).sizes;
		}
		bool operator ==(const pred_data& o) const {
			return this->nd == o.nd && this->branchtrue == o.branchtrue;
		};

		template<typename S> struct _d {
			pathq q = {};
			mpathq mq = mpathq();
		};
		template<typename S> const struct _d<S>& d() const { return std::get<_d<S>>(this->td); }
		template<typename S> struct _d<S>& d() { return std::get<_d<S>>(this->td); }
		template<typename S> const pathq& q(const S&) const { return d<S>().q; }
		template<typename S> pathq& q(const S&) { return d<S>().q; }
		template<typename S> const mpathq& mq(const S&) const { return d<S>().mq; }
		template<typename S> mpathq& mq(const S&) { return d<S>().mq; }
		std::tuple<_d<path::MAX_CYCLES>,_d<path::DRAM_CYCLES>> td = {};
	};
private:
	std::vector<std::shared_ptr<const instr>> instructions;
	succ_data successor_false = {};
	succ_data successor_true = {};
	std::vector<pred_data> predecessors = {};
	std::size_t depth = 0;

	template<typename S> struct _d {
		std::vector<node::pred_data>::iterator pred_begin;
	};
	template<typename S> struct _d<S>& d() { return std::get<_d<S>>(this->td); }
	template<typename S> auto& pred_begin(const S&) { return d<S>().pred_begin; }
	std::tuple<_d<path::MAX_CYCLES>,_d<path::DRAM_CYCLES>> td = {{predecessors.begin()},{predecessors.begin()}};
	void reset_pred_begin() { this->td = {{predecessors.begin()},{predecessors.begin()}}; }

public:
	node(std::shared_ptr<const instr> n)
		: instructions({n}) {}
	node(const std::vector<std::shared_ptr<const instr>> ns)
		: instructions(ns) {}

	std::vector<std::shared_ptr<const instr>>& instrs() {
		return this->instructions;
	}

	std::uint32_t id() const {
		return this->instructions.front()->get_id();
	}

	std::size_t loopdepth() const {
		return this->depth;
	}

	std::string did() const {
		return std::to_string(id()) +
		(this->depth ? ("_" + std::to_string(this->depth)) : "");
	}

	std::uint32_t next_id() const {
		return this->instructions.back()->get_id() + 1;
	}

	std::uint32_t br_id() const {
		return std::static_pointer_cast<const instr::branch>(this->instructions.back())->br_target();
	}

	enum instr::type exit_type() const {
		return this->instructions.back()->type();
	}

	std::size_t indegree() const {
		return this->predecessors.size();
	}

	auto& pred() {
		return this->predecessors;
	}

	std::size_t outdegree() const {
		std::size_t d = 0;
		if (this->successor_true)
			d += 1;
		if (this->successor_false)
			d += 1;
		return d;
	}

	succ_data& succ(bool branchtrue) {
		if (branchtrue) {
			return this->successor_true;
		} else {
			return this->successor_false;
		}
	}

	std::vector<std::pair<std::reference_wrapper<succ_data>,bool>> succ() {
		std::vector<std::pair<std::reference_wrapper<succ_data>,bool>> s;
		s.reserve(2);
		if (this->successor_true)
			s.push_back(std::make_pair(std::ref(this->successor_true), true));
		if (this->successor_false)
			s.push_back(std::make_pair(std::ref(this->successor_false), false));
		return s;
	}

	std::vector<std::pair<std::reference_wrapper<const succ_data>,bool>> succ() const {
		std::vector<std::pair<std::reference_wrapper<const succ_data>,bool>> s;
		s.reserve(2);
		if (this->successor_true)
			s.push_back(std::make_pair(std::ref(this->successor_true), true));
		if (this->successor_false)
			s.push_back(std::make_pair(std::ref(this->successor_false), false));
		return s;
	}

	void link(nptr nd, bool branchtrue) {
		if (branchtrue) {
			this->successor_true = succ_data(nd);
		} else {
			this->successor_false = succ_data(nd);
		}
		nd->predecessors.push_back(pred_data(shared_from_this(), branchtrue));
		nd->reset_pred_begin();
	}

	void unlink(bool branchtrue) {
		nptr nd;
		if (branchtrue) {
			nd = this->successor_true.nd;
			this->successor_true = {};
		} else {
			nd = this->successor_false.nd;
			this->successor_false = {};
		}
		auto& pds = nd->predecessors;
		pds.erase(std::remove(pds.begin(), pds.end(), pred_data(shared_from_this(), branchtrue)), pds.end());
		nd->reset_pred_begin();
	}

	void unlink() {
		if (this->successor_true) {
			auto& sp = this->successor_true.nd->predecessors;
			sp.erase(std::remove(sp.begin(), sp.end(), pred_data(shared_from_this(), true)), sp.end());
			this->successor_true.nd->reset_pred_begin();
			this->successor_true = {};
		}
		if (this->successor_false) {
			auto& sp = this->successor_false.nd->predecessors;
			sp.erase(std::remove(sp.begin(), sp.end(), pred_data(shared_from_this(), false)), sp.end());
			this->successor_false.nd->reset_pred_begin();
			this->successor_false = {};
		}
		for (auto& pr: this->predecessors) {
			if (pr.branchtrue) {
				pr.nd->successor_true = {};
			} else {
				pr.nd->successor_false = {};
			}
		}
		this->predecessors.clear();
		reset_pred_begin();
	}

	void merge_node(nptr nd) {
		this->instructions.insert(this->instructions.end(), nd->instructions.begin(), nd->instructions.end());
		nd->instructions.clear();
		this->successor_true = nd->successor_true;
		this->successor_false = nd->successor_false;
		if (this->successor_true) {
			auto& sp = this->successor_true.nd->predecessors;
			std::replace(sp.begin(), sp.end(), pred_data(nd, true), pred_data(shared_from_this(), true));
			this->successor_true.nd->reset_pred_begin();
		}
		if (this->successor_false) {
			auto& sp = this->successor_false.nd->predecessors;
			std::replace(sp.begin(), sp.end(), pred_data(nd, false), pred_data(shared_from_this(), false));
			this->successor_false.nd->reset_pred_begin();
		}
	}

	nptr clone(std::size_t depth) const {
		nptr c = std::make_shared<cfg::node>(this->instructions);
		for (auto s: this->succ())
			c->link(s.first.get().nd, s.second);
		c->depth = depth;
		return c;
	}

	template<typename S>
	pathq::sizet qsize(bool branchtrue) const {
		if (branchtrue && this->successor_true)
			return this->successor_true.q(S{}).size();
		if (!branchtrue && this->successor_false)
			return this->successor_false.q(S{}).size();
		return 0;
	}

	template<typename S>
	pathq qtake(bool branchtrue) {
		pathq r;
		if (branchtrue && this->successor_true)
			std::swap(r, this->successor_true.q(S{}));
		if (!branchtrue && this->successor_false)
			std::swap(r, this->successor_false.q(S{}));
		return r;
	}

	template<typename S>
	mpathq mqtake(bool branchtrue) {
		if (branchtrue && this->successor_true) {
			mpathq r(this->successor_true.sizes);
			std::swap(r, this->successor_true.mq(S{}));
			return r;
		}
		if (!branchtrue && this->successor_false) {
			mpathq r(this->successor_false.sizes);
			std::swap(r, this->successor_false.mq(S{}));
			return r;
		}
		return mpathq();
	}

	template<typename S>
	void qpush(bool branchtrue, const pathq& q) {
		if (branchtrue && this->successor_true)
			this->successor_true.q(S{}).push(q);
		if (!branchtrue && this->successor_false)
			this->successor_false.q(S{}).push(q);
	}

	template<typename S>
	void mqpush(bool branchtrue, const pathq& q) {
		if (branchtrue && this->successor_true)
			this->successor_true.mq(S{}).push(q);
		if (!branchtrue && this->successor_false)
			this->successor_false.mq(S{}).push(q);
	}

	template<typename S>
	void mqpush(bool branchtrue, const pathq& q, std::uint32_t s) {
		if (branchtrue && this->successor_true)
			this->successor_true.mq(S{}).push(q, s);
		if (!branchtrue && this->successor_false)
			this->successor_false.mq(S{}).push(q, s);
	}

	template<typename S>
	auto shortest_q() {
		auto s = std::min_element(this->predecessors.begin(), this->predecessors.end(), [](const auto& a, const auto& b) { return a.q(S{}).size() < b.q(S{}).size();});
		if (s == this->predecessors.end()) {
			static std::vector<node::pred_data> e = {node::pred_data(nullptr, true)};
			return e.begin();
		}
		return s;
	};

	template<typename S>
	auto shortest_mq(const mpathq::sizev& v) {
		mpathq::sizev sv;
		auto pr = this->predecessors.end();
		if (this->predecessors.empty())
			return std::make_pair(pr, sv);
		for (auto [s, ss]: v) {
			auto prs = std::min_element(this->predecessors.begin(), this->predecessors.end(), [s](const auto& a, const auto& b) { return a.mq(S{}).size(s) < b.mq(S{}).size(s);});
			pathq::sizet prss = prs->mq(S{}).size(s);
			sv << std::pair(s, prss);
			if (pr == this->predecessors.end() && prss < ss)
				pr = prs;
		}
		return std::make_pair(pr, sv);
	};

	template<typename S> auto q_with_longest_path();
	template<typename S> auto q_with_longest_path(std::uint32_t s);

	void enable_sat_check(bool branchtrue) {
		if (!o_check_unlikely_edges)
			return;
		if (branchtrue && this->successor_true)
			this->successor_true.sat_check = true;
		if (!branchtrue && this->successor_false)
			this->successor_false.sat_check = true;
	}
	bool sat_check_enabled(bool branchtrue) {
		if (o_check_each_branch)
			return true;
		if (branchtrue && this->successor_true)
			return this->successor_true.sat_check;
		if (!branchtrue && this->successor_false)
			return this->successor_false.sat_check;
		return false;
	}

	template<typename... S>
	void reset() {
		((this->successor_true.q(S{}) = pathq()),...);
		((this->successor_false.q(S{}) = pathq()),...);
		((this->successor_true.mq(S{}) = mpathq()),...);
		((this->successor_false.mq(S{}) = mpathq()),...);
		this->successor_true.sat_check = false;
		this->successor_false.sat_check = false;
		for (auto& pr: this->predecessors) {
			((pr.q(S{}) = pathq()),...);
			((pr.mq(S{}) = mpathq()),...);
		}
		((this->pred_begin(S{}) = this->predecessors.begin()),...);
	}
};

class cfg::path::none : public path, public std::enable_shared_from_this<cfg::path::none> {
public:
	none() = default;

	std::string str() const override {
		return "N";
	}

	std::uint32_t min_packetsize() const override {
		return cfg::MIN_PACKETSIZE;
	}

	unsigned int max_cycles() const override {
		return 0;
	}

	unsigned int max_cycles(bool branchtrue) const override {
		return 0;
	}

	double dram_cycles() const override {
		static_assert(std::numeric_limits<double>::has_infinity);
		return -std::numeric_limits<double>::infinity();
	}

	double dram_cycles(bool branchtrue) const override {
		static_assert(std::numeric_limits<double>::has_infinity);
		return -std::numeric_limits<double>::infinity();
	}

	std::size_t size() const override {
		return std::numeric_limits<std::size_t>::max();
	}

	bool is_none() const override {
		return true;
	}

	bool is_decided() const override {
		return true;
	}

	bool is_unsat() const override {
		return false;
	}

	bool may_satcheck(bool branchtrue) const override {
		return false;
	}

	bool is_same(pptr o) const override {
		std::shared_ptr<none> n = std::dynamic_pointer_cast<none>(o);
		return (bool) n;
	}

	pptr extend(bool branchtrue) override {
		return shared_from_this();
	}

	pptr check() override {
		return shared_from_this();
	}

	pptr merge(pptr o) const override {
		std::shared_ptr<none> n = std::dynamic_pointer_cast<none>(o);
		return n;
	}
};

template<class S>
class cfg::path::withstate : public path {
	template<typename> friend class withstate;
	friend impossible;
protected:
	const succ_data& s;
	std::uint32_t minpacketsize;
	S state;
	std::weak_ptr<path> succ_true = {};
	std::weak_ptr<path> succ_false = {};
public:
	withstate(const succ_data& s, std::uint32_t min_packetsize, const S& state)
		: s(s),
		  minpacketsize(std::max(s.min_packetsize, min_packetsize)),
		  state(state) {
		for (auto i = s.instructions.begin(); i != s.instructions.end()-1; i++)
			this->state.apply(*i->n, i->i, s.nd->loopdepth());
	}
	withstate(withstate<state::exec>* w)
		: s(w->s),
		  minpacketsize(w->min_packetsize()),
		  state(w->state) {}

	const S& get_state() const {
		return this->state;
	}

	std::uint32_t min_packetsize() const override {
		return this->minpacketsize;
	}

	unsigned int max_cycles() const override {
		return this->state.max_cycles();
	}

	unsigned int max_cycles(bool branchtrue) const override {
		unsigned int c= this->state.max_cycles();
		auto& i = this->s.instructions.back();
		c += state::perf::cycles(*i.n, i.i, branchtrue);
		auto& s = this->s.nd->succ(branchtrue);
		for (auto i = s.instructions.begin(); i != s.instructions.end()-1; i++)
			c += state::perf::cycles(*i->n, i->i);
		return c;
	}

	double dram_cycles() const override {
		return this->state.dram_cycles();
	}

	double dram_cycles(bool branchtrue) const override {
		double c= this->state.dram_cycles();
		auto& i = this->s.instructions.back();
		c += i.n->dram_cycles();
		auto& s = this->s.nd->succ(branchtrue);
		for (auto i = s.instructions.begin(); i != s.instructions.end()-1; i++)
			c += i->n->dram_cycles();
		return c;
	}

	std::vector<std::pair<std::reference_wrapper<succ_data>,bool>> succ() const {
		return this->s.nd->succ();
	}

	virtual pptr extendn(bool branchtrue) = 0;

	pptr extend(bool branchtrue) override {
		pptr p;
		if (branchtrue) {
			p = this->succ_true.lock();
		} else {
			p = this->succ_false.lock();
		}
		if (p)
			return p;

		p = extendn(branchtrue);
		if (branchtrue) {
			this->succ_true = p;
		} else {
			this->succ_false = p;
		}
		return p;
	}
};

class cfg::path::impossible : public withstate<state::perf>, public std::enable_shared_from_this<cfg::path::impossible> {
private:
	std::size_t count;
public:
	impossible(const succ_data& s, std::uint32_t min_packetsize, const class state::perf& state, std::size_t count=1)
		: withstate(s, min_packetsize, state),
		  count(count) {}
	impossible(withstate<state::exec>* w)
		: withstate(w),
		  count(1) {}

	std::string str() const override {
		return "(" + std::to_string(this->count) + ")";
	}

	std::size_t size() const override {
		return this->count;
	}

	bool is_none() const override {
		return false;
	}

	bool is_decided() const override {
		return true;
	}

	bool is_unsat() const override {
		return true;
	}

	bool may_satcheck(bool branchtrue) const override {
		return false;
	}

	bool is_same(pptr o) const override {
		return shared_from_this() == o;
	}

	virtual iptr extendi(bool branchtrue) const {
		class state::perf state = this->state;
		auto& i = this->s.instructions.back();
		state.apply(*i.n, i.i, this->s.nd->loopdepth(), branchtrue);
		return std::make_shared<path::impossible>(this->s.nd->succ(branchtrue), this->minpacketsize, state, this->count);
	}
	pptr extendn(bool branchtrue) override {
		return extendi(branchtrue);
	}

	pptr check() override {
		return shared_from_this();
	}

	pptr merge(pptr o) const override {
		if (!o_impossible_path_merging)
			return nullptr;
		iptr i = std::dynamic_pointer_cast<impossible>(o);
		if (!i)
			return nullptr;
		std::shared_ptr<impossible> n = std::make_shared<impossible>(*this);
		n->count += i->count;
		return n;
	}
};

class cfg::path::possible : public withstate<state::exec>, public std::enable_shared_from_this<cfg::path::possible> {
private:
	std::shared_ptr<cfg::path::possible> pred;
	pptr as_impossible = nullptr;
	bool branchtrue;
	std::atomic<bool> marked_unsat = false;

public:
	possible(std::shared_ptr<cfg::path::possible> pred, const succ_data& s, std::uint32_t min_packetsize, const class state::exec& state, bool branchtrue)
		: withstate(s, min_packetsize, state),
		  pred(pred),
		  branchtrue(branchtrue) {}

	std::string str() const override {
		std::string s;
		for (auto p = shared_from_this(); p; p = p->pred)
			s = (p->branchtrue ? "->" : "--") + std::to_string(p->s.nd->id()) + s;
		return s;
	}

	std::size_t size() const override {
		return 1;
	}

	std::uint32_t min_packetsize() const override {
		return std::max(this->minpacketsize, state.minimum_value());
	}

	virtual unsigned int cycles() const{
		return this->state.cycles();
	}

	bool is_none() const override {
		return false;
	}

	bool is_decided() const override {
		return this->marked_unsat || this->state.is_decided();
	}

	bool is_unsat() const override {
		return this->marked_unsat || this->state.is_unsat();
	}

	bool may_satcheck(bool branchtrue) const override {
		return this->s.nd->sat_check_enabled(branchtrue);
	}

	bool is_same(pptr o) const override {
		return shared_from_this() == o || this->as_impossible == o;
	}

	pptr to_impossible() {
		if (!this->as_impossible) {
			mark_unsat();
			this->as_impossible = std::make_shared<path::impossible>(this);
		}
		return this->as_impossible;
	}

	pptr extendn(bool branchtrue) override {
		if (this->marked_unsat)
			return to_impossible()->extend(branchtrue);

		class state::exec state = this->state;
		auto& i = this->s.instructions.back();
		state.apply(*i.n, i.i, this->s.nd->loopdepth(), branchtrue);
		auto& s = this->s.nd->succ(branchtrue);
		if (state.is_unsat())
			return std::make_shared<path::impossible>(s, min_packetsize(), state);
		if (may_satcheck(branchtrue) && !state.check_sat(o_impossible_prefixes)) {
			apply_unsat_core(state, branchtrue);
			return std::make_shared<path::impossible>(s, min_packetsize(), state);
		}

		return std::make_shared<path::possible>(shared_from_this(), s, min_packetsize(), state, branchtrue);
	}

	pptr check() override {
		if (is_unsat())
			return to_impossible();
		if (this->state.is_decided())
			return shared_from_this();

		static stats::counter s_checked_paths("cfg.checked-paths");

		bool unsat = !this->state.check_sat(o_impossible_prefixes);
		s_checked_paths.count();

		if (unsat) {
			this->pred->apply_unsat_core(this->state, this->branchtrue);
			return to_impossible();
		}

		return shared_from_this();
	}

	void apply_unsat_core(state::exec& state, bool branchtrue) {
		if (!o_impossible_prefixes)
			return;
		std::shared_ptr<cfg::path::possible> n;
		for (auto p = shared_from_this(); p; p = p->pred) {
			if (state.in_unsat_core(*p->s.instructions.back().n, p->s.nd->loopdepth(), branchtrue)) {
				p->s.nd->enable_sat_check(p->branchtrue);
				if (n)
					n->mark_unsat();
				return;
			}
			branchtrue = p->branchtrue;
			n = p;
		}
	}

	void mark_unsat() {
		std::stack<std::shared_ptr<cfg::path::possible>> stack;
		stack.push(shared_from_this());

		while (!stack.empty()) {
			auto p = stack.top();
			stack.pop();
			if (p->marked_unsat.exchange(true))
				continue;
			if (auto s = std::dynamic_pointer_cast<path::possible>(p->succ_true.lock())) {
				stack.push(s);
				p->succ_true = {};
			}
			if (auto s = std::dynamic_pointer_cast<path::possible>(p->succ_false.lock())) {
				stack.push(s);
				p->succ_false = {};
			}
		}
	}

	pptr merge(pptr o) const override {
		return nullptr;
	}
};

const cfg::pathq::sizet cfg::pathq::sizet::MAX = std::numeric_limits<std::size_t>::max();

cfg::pathq::pathq(std::initializer_list<pptr> l)
	: paths(l) {
	for (const pptr p: l)
		this->count += p->size();
}

cfg::pathq::pathq(const pptr& p)
	: paths({p}),
	  count(p->size()) {};

void cfg::pathq::swap(pathq& o) {
	this->paths.swap(o.paths);
	std::swap(this->count, o.count);
}

cfg::pathq::sizet cfg::pathq::size() const {
	return this->count;
}

auto cfg::pathq::begin() const {
	return this->paths.begin();
}

auto cfg::pathq::end() const {
	return this->paths.end();
}

cfg::pptr cfg::pathq::front() const {
	if (this->paths.empty())
		return nullptr;
	return this->paths.front();
}

cfg::pptr cfg::pathq::back() const {
	if (this->paths.empty())
		return nullptr;
	return this->paths.back();
}

void cfg::pathq::push(const pathq& q) {
	this->count += q.size();
	auto b = q.paths.begin();
	if (this->paths.size() && q.paths.size()) {
		pptr m = q.paths.front()->merge(this->paths.back());
		if (m) {
			this->paths.pop_back();
			this->paths.push_back(m);
			b++;
		}
	}
	this->paths.insert(this->paths.end(), b, q.paths.end());
}

void cfg::pathq::push(pathq&& q) {
	if (!this->count) {
		*this = std::move(q);
		return;
	}

	this->count += q.size();
	auto b = q.paths.begin();
	if (this->paths.size() && q.paths.size()) {
		pptr m = q.paths.front()->merge(this->paths.back());
		if (m) {
			this->paths.pop_back();
			this->paths.push_back(m);
			b++;
		}
	}
	this->paths.insert(this->paths.end(), std::make_move_iterator(b), std::make_move_iterator(q.paths.end()));
}

cfg::pptr cfg::pathq::take() {
	if (this->paths.empty())
		return nullptr;
	pptr p = this->paths.front();
	this->paths.pop_front();
	this->count -= p->size();
	if (this->count == sizet::MAX) {
		this->count = 0;
		for (const pptr i: this->paths)
			this->count += i->size();
	}
	return p;
}

class cfg::mpathq::sizev::intersection {
private:
	class iterator {
	private:
		std::vector<std::pair<std::uint32_t,pathq::sizet>>::const_iterator ac, ae, bc, be;
	public:
		iterator(decltype(ac) ac, decltype(ae) ae, decltype(bc) bc, decltype(be) be)
			: ac(ac), ae(ae), bc(bc), be(be) {}
		bool operator != (const iterator& o) {
			return this->ac != o.ac || this->bc != o.bc;
		}
		iterator& operator ++() {
			if (ac == ae) {
				bc++;
			} else if (bc == be) {
				ac++;
			} else if (ac->first < bc->first) {
				ac++;
			} else if (bc->first < ac->first) {
				bc++;
			} else {
				ac++;
				bc++;
			}
			return *this;
		}
		auto operator * () {
			std::pair<std::optional<std::pair<std::uint32_t,pathq::sizet>>,std::optional<std::pair<std::uint32_t,pathq::sizet>>> r;
			if (ac == ae) {
				r.second = *bc;
			} else if (bc == be) {
				r.first = *ac;
			} else if (ac->first < bc->first) {
				r.first = *ac;
			} else if (bc->first < ac->first) {
				r.second = *bc;
			} else {
				r.first = *ac;
				r.second = *bc;
			}
			return r;
		}
	};
	const sizev& a;
	const sizev& b;
public:
	intersection(const sizev& a, const sizev& b)
		: a(a), b(b) {
	}
	iterator begin() const {
		return iterator(this->a.begin(), this->a.end(), this->b.begin(), this->b.end());
	};
	iterator end() const {
		return iterator(this->a.end(), this->a.end(), this->b.end(), this->b.end());
	};
};

cfg::mpathq::sizev::sizev(const std::pair<std::uint32_t,pathq::sizet>& p) {
	*this << p;
}

void cfg::mpathq::sizev::swap(sizev& o) {
	this->sizes.swap(o.sizes);
}

std::string cfg::mpathq::sizev::str() const {
	std::string str;
	for (auto [s,ss]: this->sizes)
		str += (str.empty() ? "" : ", ") + std::to_string(s) + ": " + std::to_string(ss);
	return str;
}

cfg::mpathq::sizev& cfg::mpathq::sizev::operator << (std::pair<std::uint32_t,pathq::sizet> p) {
	if (p.second)
		this->sizes.push_back(p);
	return *this;
}

std::uint32_t cfg::mpathq::sizev::min_packetsize() const {
	if (this->sizes.empty())
		return std::numeric_limits<std::uint32_t>::max();
	return this->sizes.front().first;
}

std::uint32_t cfg::mpathq::sizev::max_packetsize() const {
	if (this->sizes.empty())
		return 0;
	return this->sizes.back().first;
}

const std::vector<std::pair<std::uint32_t,cfg::pathq::sizet>>::const_iterator cfg::mpathq::sizev::begin() const {
	return this->sizes.begin();
}

const std::vector<std::pair<std::uint32_t,cfg::pathq::sizet>>::const_iterator cfg::mpathq::sizev::end() const {
	return this->sizes.end();
}

cfg::pathq::sizet cfg::mpathq::sizev::operator [] (const std::uint32_t& s) const {
	for (auto [c,ss]: this->sizes) {
		if (c == s)
			return ss;
		if (c > s)
			return 0;
	}
	return 0;
}

cfg::mpathq::sizev cfg::mpathq::sizev::operator + (const sizev& o) const {
	std::size_t n = 0;
	for (auto x: intersection(*this, o)) {
		(void) x;
		n++;
	}

	sizev v;
	v.sizes.reserve(n);
	for (const auto& [a,b]: intersection(*this, o)) {
		pathq::sizet r;
		if (a)
			r += a->second;
		if (b)
			r += b->second;
		v.sizes.emplace_back((a ? a : b)->first, r);
	}
	return v;
}

cfg::mpathq::sizev cfg::mpathq::sizev::operator - (const sizev& o) const {
	std::size_t n = 0;
	for (const auto& [a,b]: intersection(*this, o)) {
		if ((a && !b) || (a && b && a->second > b->second))
			n++;
	}

	sizev v;
	v.sizes.reserve(n);
	for (const auto& [a,b]: intersection(*this, o)) {
		if (a && !b) {
			v.sizes.push_back(*a);
		} else if (a && b && a->second > b->second) {
			v.sizes.emplace_back(a->first, a->second - b->second);
		}
	}
	return v;
}

cfg::mpathq::sizev cfg::mpathq::sizev::operator | (const sizev& o) const {
	std::size_t n = 0;
	for (auto x: intersection(*this, o)) {
		(void) x;
		n++;
	}

	sizev v;
	v.sizes.reserve(n);
	for (const auto& [a,b]: intersection(*this, o)) {
		pathq::sizet r;
		if (a)
			r = r | a->second;
		if (b)
			r = r | b->second;
		v.sizes.emplace_back((a ? a : b)->first, r);
	}
	return v;
}

cfg::mpathq::sizev cfg::mpathq::sizev::operator & (const sizev& o) const {
	std::size_t n = 0;
	for (const auto& [a,b]: intersection(*this, o)) {
		if (a && b && a->second & b->second)
			n++;
	}

	sizev v;
	v.sizes.reserve(n);
	for (const auto& [a,b]: intersection(*this, o)) {
		if (a && b && a->second & b->second)
			v.sizes.emplace_back(a->first, a->second & b->second);
	}
	return v;
}

cfg::mpathq::sizev cfg::mpathq::sizev::operator & (std::uint32_t m) const {
	auto i = this->sizes.begin();
	while (i != this->sizes.end() && i->first < m)
		i++;

	sizev v;
	v.sizes.insert(v.sizes.begin(), i, this->sizes.end());
	return v;
}

bool cfg::mpathq::sizev::operator < (const cfg::mpathq::sizev& o) const {
	for (const auto& [a,b]: intersection(*this, o)) {
		if ((!a && b) || (a && b && a->second < b->second))
			return true;
	}
	return false;
}

bool cfg::mpathq::sizev::operator >= (const cfg::mpathq::sizev& o) const {
	return !(*this < o);
}

cfg::mpathq::mpathq(const sizev& v)
	: min(v.min_packetsize()),
	  max(v.max_packetsize()),
	  v(v) {
	if (this->min <= this->max)
		this->qs.resize(this->max-this->min+1);
	for (auto [s,ss]: v)
		this->qs[s-this->min] = pathq();
}

const cfg::pathq& cfg::mpathq::operator [] (std::uint32_t s) const {
	static cfg::pathq eq;
	if (s < this->min || s > this->max)
		return eq;

	s -= this->min;
	if (!this->qs[s])
		return eq;
	return *this->qs[s];
}

void cfg::mpathq::swap(mpathq& o) {
	std::swap(this->min, o.min);
	std::swap(this->max, o.max);
	this->v.swap(o.v);
	this->qs.swap(o.qs);
}

cfg::pathq::sizet cfg::mpathq::size(std::uint32_t s) const {
	if (s < this->min || s > this->max)
		return pathq::sizet::MAX;

	s -= this->min;
	if (!this->qs[s])
		return pathq::sizet::MAX;
	return this->qs[s]->size();
}

cfg::mpathq::sizev cfg::mpathq::sizes() const {
	if (this->max < this->min)
		return {};
	
	sizev v;
	std::size_t n = 0;
	for (auto [s,x]: this->v) {
		if (size(s))
			n += 1;
	}
	v.sizes.reserve(n);
	for (auto [s,x]: this->v) {
		pathq::sizet ss = size(s);
		if (ss)
			v.sizes.emplace_back(s, ss);
	}
	return v;
}

void cfg::mpathq::push(const pathq& q, std::uint32_t s) {
	if (s < this->min || s > this->max)
		return;

	s -= this->min;
	if (!this->qs[s])
		return;
	this->qs[s]->push(q);
}

void cfg::mpathq::push(pathq&& q, std::uint32_t s) {
	if (s < this->min || s > this->max)
		return;

	s -= this->min;
	if (!this->qs[s])
		return;
	this->qs[s]->push(std::move(q));
}

void cfg::mpathq::push(const pathq& q) {
	for (auto [s,x]: this->v)
		push(q, s);
}

void cfg::mpathq::push(const mpathq& mq) {
	if (this->max < this->min)
		return;

	for (auto [s,x]: mq.v)
		push(*mq.qs[s-mq.min], s);
}

void cfg::mpathq::push(mpathq&& mq) {
	if (this->max < this->min)
		return;

	for (auto [s,x]: mq.v)
		push(std::move(*mq.qs[s-mq.min]), s);
}

cfg::pptr cfg::mpathq::front(std::uint32_t s) const {
	if (s < this->min || s > this->max)
		return nullptr;

	s -= this->min;
	if (!this->qs[s])
		return nullptr;
	return this->qs[s]->front();
}

cfg::pptr cfg::mpathq::take(std::uint32_t s) {
	if (s < this->min || s > this->max)
		return nullptr;

	s -= this->min;
	if (!this->qs[s])
		return nullptr;
	return this->qs[s]->take();
}

template<typename S>
struct cfg::tratio {
	using value_type = typename S::value_type;
	value_type value;
	unsigned int size;

	tratio(value_type value, unsigned int size)
		: value(value),
		size(size) {}
	tratio(const pptr& p)
		: value(S{}(p)),
		size(p->min_packetsize()) {}
	tratio(const pptr& p, unsigned int size)
		: value(S{}(p)),
		size(size) {}

	static inline tratio MIN = tratio(S::MIN, std::numeric_limits<unsigned int>::max());
	static inline tratio MAX = tratio(S::MAX, 0);

	explicit operator double () const {
		return (double) S{}(this->value, this->size);
	}

	bool operator < (const tratio& o) const {
		return S{}(S::normalize(this->value), this->size) < S{}(S::normalize(o.value), o.size);
	}

	bool operator > (const tratio& o) const {
		return S{}(S::normalize(o.value), o.size) < S{}(S::normalize(this->value), this->size);
	}

	bool operator == (const tratio& o) const {
		return S{}(S::normalize(this->value), this->size) == S{}(S::normalize(o.value), o.size);
	}
};

static stats::counter& s_deferred_paths() {
	static stats::counter s("cfg.deferred-paths");
	return s;
}

template<typename S>
class cfg::tpathq {
	std::multimap<tratio<S>,std::pair<pptr,bool>,std::greater<tratio<S>>> q = {};
	std::multimap<tratio<S>,pptr,std::greater<tratio<S>>> undecided = {};
	std::map<pptr,tratio<S>> pathes = {};
	std::map<std::uint32_t,tratio<S>> sizes = {};
	tratio<S> limit = tratio<S>::MAX;
public:
	tpathq(const mpathq::sizev& sizes) {
		for (const auto [s,ss]: sizes)
			this->sizes.emplace(s, tratio<S>::MAX);
	}

	void push(const pptr& p) {
		tratio<S> r = tratio<S>(p);
		auto [i, success] = this->pathes.emplace(p, r);
		if (!success)
			return;
		bool decided = p->is_decided();
		this->q.emplace(r,std::make_pair(p, decided));
		if (!decided) {
			this->undecided.emplace(r,p);
		} else {
			s_deferred_paths().count();
		}
	}

	void push(const mpathq& mq) {
		this->limit = tratio<S>::MIN;
		for (auto& [s, l]: this->sizes) {
			for (pptr p: mq[s]) {
				l = tratio<S>(p, s);
				push(p);
			}
			this->limit = std::max(this->limit, l);
		}
	}

	template<typename F>
	void push(const mpathq& mq, F f) {
		this->limit = tratio<S>::MIN;
		for (auto& [s, l]: this->sizes) {
			for (pptr p: mq[s]) {
				l = tratio<S>(p, s);
				if (!p->is_none() && !f(p))
					continue;
				push(p);
			}
			this->limit = std::max(this->limit, l);
		}
	}

	std::optional<std::pair<pptr,std::uint32_t>> front() const {
		auto f = this->q.begin();
		if (f == this->q.end() || f->first < this->limit)
			return {};
		return std::make_pair(f->second.first, f->first.size);
	}

	pptr take_lowest_bitrate() {
		auto f = this->q.begin();
		if (f == this->q.end() || f->first < this->limit)
			return nullptr;
		pptr p = f->second.first;
		if (!f->second.second)
			return nullptr;
		this->pathes.erase(this->pathes.find(p));
		this->q.erase(f);

		s_deferred_paths().down();
		return p;
	}

	std::optional<std::pair<pptr,std::uint32_t>> undecided_front() const {
		auto f = this->undecided.begin();
		if (f == this->undecided.end() || f->first < this->limit)
			return {};
		return std::make_pair(f->second, f->first.size);
	}

	pptr take_undecided() {
		auto f = this->undecided.begin();
		if (f == this->undecided.end() || f->first < this->limit)
			return nullptr;
		pptr p = f->second;
		this->undecided.erase(f);
		return p;
	}

	tratio<S> back() const {
		return this->limit;
	}

	void adjust_size(pptr p, pptr c) {
		s_deferred_paths().count();

		auto r = this->pathes.find(p);
		auto [s,e] = this->q.equal_range(r->second);
		auto f = std::find(s, e, std::pair<const tratio<S>,std::pair<pptr,bool>>(r->second, std::make_pair(p, false)));
		tratio<S> n = tratio<S>(c);
		if (r->second.size == n.size) {
			f->second.second = true;
			return;
		}
		this->q.erase(f);
		r->second = n;
		this->q.emplace(n, std::make_pair(c, true));
	}

	mpathq::sizev sizes_to(std::size_t k) const {
		mpathq::sizev v;
		for (auto [s, l]: this->sizes) {
			pathq::sizet sk = k;
			auto i = this->q.begin();
			while (sk && i != this->q.end() && !(i->first < l)) {
				sk -= i->second.first->size();
				i++;
			}
			v << std::make_pair(s, sk);
		}
		return v;
	}
};

template<typename... S>
class cfg::vmax {
public:
	using max_t = typename std::common_type<typename S::value_type...>::type;

private:
	using max_pair_t = std::pair<std::reference_wrapper<const std::type_info>,max_t>;

	std::tuple<typename S::value_type...> values;
	max_pair_t maxp;

	template<typename V> static max_pair_t max_(max_pair_t mp) {
		return mp;
	}
	template<typename V0, typename V1, typename... V> static max_pair_t max_(max_pair_t mp, typename V1::value_type v1, typename V::value_type... v) {
		max_pair_t mp1 = std::make_pair(std::cref(typeid(V1)), (max_t) V1::normalize(v1));
		if (mp.second < mp1.second)
			mp = mp1;
		return max_<V1,V...>(mp, v...);
	}
	template<typename V0, typename... V> static max_pair_t max_(typename V0::value_type v0, typename V::value_type... v) {
		return max_<V0,V...>(std::make_pair(std::cref(typeid(V0)), (max_t) V0::normalize(v0)), v...);
	}

	template<typename... V> struct get_;
	template<typename V> struct get_<V> {
		static typename V::value_type g(const std::tuple<typename S::value_type...>& values) {
			return V::MIN;
		}
	};
	template<typename V0, typename... V> struct get_<V0,V0,V...> {
		static typename V0::value_type g(const std::tuple<typename S::value_type...>& values) {
			return std::get<typename V0::value_type>(values);
		}
	};
	template<typename V0, typename V1, typename... V> struct get_<V0,V1,V...> {
		static typename V0::value_type g(const std::tuple<typename S::value_type...>& values) {
			return get_<V0,V...>::g(values);
		}
	};

public:
	vmax(const typename S::value_type&... values)
		: values(values...),
		  maxp(max_<S...>(values...)) {}
	vmax(const pptr& p)
		: vmax(S{}(p)...) {}

	template<typename V> void set(typename V::value_type value) {
		std::get<typename V::value_type>(this->values) = value;
		this->maxp = std::apply([this](auto... v) { return max_<S...>(v...); }, this->values);
	}

	template<typename V> typename V::value_type get() const {
		return get_<V,S...>::g(this->values);
	}

	const std::type_info& type() const {
		return this->maxp.first.get();
	}

	max_t max() const {
		return this->maxp.second;
	}

	bool operator < (const vmax<S...>& o) {
		return this->maxp.second < o.maxp.second;
	}
};

template<typename... S>
class cfg::rmax {
	using max_pair_t = std::pair<std::reference_wrapper<const std::type_info>,double>;

	std::tuple<tratio<S>...> ratios;
	max_pair_t maxp;

	template<typename V> static max_pair_t max_(max_pair_t mp) {
		return mp;
	}
	template<typename V0, typename V1, typename... V> static max_pair_t max_(max_pair_t mp, tratio<V1> r1, tratio<V>... r) {
		max_pair_t mp1 = std::make_pair(std::cref(typeid(V1)), (double) V1{}(V1::normalize(r1.value), r1.size));
		if (mp.second < mp1.second)
			mp = mp1;
		return max_<V1,V...>(mp, r...);
	}
	template<typename V0, typename... V> static max_pair_t max_(tratio<V0> r0, tratio<V>... r) {
		return max_<V0,V...>(std::make_pair(std::cref(typeid(V0)), (double) V0{}(V0::normalize(r0.value), r0.size)), r...);
	}

	template<typename V> std::string str_() const {
		return V::str() + ": " + std::to_string((double) std::get<tratio<V>>(this->ratios));
	}
	template<typename V0, typename V1, typename... V> std::string str_() const {
		return str_<V0>() + ", " + str_<V1,V...>();
	}


	template<typename... V> struct get_;
	template<typename V> struct get_<V> {
		static tratio<V> g(const std::tuple<tratio<S>...>& ratios) {
			return tratio<V>::MIN;
		}
	};
	template<typename V0, typename... V> struct get_<V0,V0,V...> {
		static tratio<V0> g(const std::tuple<tratio<S>...>& ratios) {
			return std::get<tratio<V0>>(ratios);
		}
	};
	template<typename V0, typename V1, typename... V> struct get_<V0,V1,V...> {
		static tratio<V0> g(const std::tuple<tratio<S>...>& ratios) {
			return get_<V0,V...>::g(ratios);
		}
	};

public:
	rmax(const tratio<S>&... ratios)
		: ratios(ratios...),
		  maxp(max_<S...>(ratios...)) {}

	rmax(const pptr& p, std::uint32_t size)
		: rmax(tratio<S>(S{}(p), size)...) {}

	rmax(const pptr& p)
		: rmax(p, p->min_packetsize()) {}

	std::string str() const {
		return str_<S...>();
	}

	template<typename V> void set(const tratio<V>& ratio) {
		std::get<tratio<V>>(this->ratios) = ratio;
		this->maxp = std::apply([this](auto... r) { return max_<S...>(r...); }, this->ratios);
	}

	template<typename V> tratio<V> get() const {
		return get_<V,S...>::g(this->ratios);
	}

	const std::type_info& type() const {
		return this->maxp.first.get();
	}

	double max() const {
		return this->maxp.second;
	}

	bool operator < (const rmax<S...>& o) {
		return this->maxp.second < o.maxp.second;
	}
};

template<typename... S>
class cfg::ipathq {
	vmax<S...> limits;
	using limit_t = typename vmax<S...>::max_t;

	template<typename V> using next_t = std::function<pathq(std::size_t)>;
	template<typename V>
	void pull_(std::size_t k, const next_t<V>& next_k) {
		push<V>(next_k(k));
	}
	template<typename V0, typename V1, typename... V>
	void pull_(std::size_t k, const next_t<V0>& next_k0, const next_t<V1>& next_k1, const next_t<V>&... next_k) {
		if (typeid(V0) == this->limits.type()) {
			pull_<V0>(k, next_k0);
		} else {
			pull_<V1,V...>(k, next_k1, next_k...);
		}
	}

	template<typename V> class q_of : public pathq {};
	std::tuple<q_of<S>...> qs = {};
	template<typename V>
	void push(const pathq& q) {
		for (const pptr& p: q) {
			if (vmax<S...>(S{}(p)...).type() == typeid(V))
				std::get<q_of<V>>(this->qs).push(p);
		}
		this->limits.template set<V>(V{}(q.back()));
	}

	template<typename V0>
	pptr front_(pptr p, limit_t l) const {
		if (!p || l < this->limits.max())
			return nullptr;
		return p;
	}
	template<typename V0, typename V1, typename... V>
	cfg::pptr front_(pptr p, limit_t l) const {
		pptr p1 = std::get<q_of<V1>>(this->qs).front();
		limit_t l1 = (limit_t) V1::normalize(p1);
		if (p1 && l < l1) {
			p = p1;
			l = l1;
		}
		return front_<V1,V...>(std::move(p), l);
	}
	template<typename V0, typename... V>
	pptr front_() const {
		pptr p = std::get<q_of<V0>>(this->qs).front();
		return front_<V0,S...>(p, (limit_t) V0::normalize(p));
	}

	template<typename V0>
	pptr take_(pathq& q, limit_t l) {
		if (l < this->limits.max())
			return nullptr;
		return q.take();
	}
	template<typename V0, typename V1, typename... V>
	pptr take_(pathq& q, limit_t l) {
		pathq* pq = &q;
		pathq& q1 = std::get<q_of<V1>>(this->qs);
		pptr p1 = q1.front();
		limit_t l1 = (limit_t) V1::normalize(p1);
		if (p1 && l < l1) {
			pq = &q1;
			l = l1;
		}
		return take_<V1,V...>(*pq, l);
	}
	template<typename V0, typename... V>
	pptr take_() {
		pathq& q = std::get<q_of<V0>>(this->qs);
		return take_<V0,V...>(q, (limit_t) V0::normalize(q.front()));
	}

public:
	ipathq(const vmax<S...>& limits)
		: limits(limits) {}

	void pull(std::size_t k, const next_t<S>&... next_k) {
		pull_<S...>(k, next_k...);
	};

	pptr front() const {
		return front_<S...>();
	}

	pptr take() {
		return take_<S...>();
	}
};

template<typename S>
class cfg::ipathq<S> : public cfg::pathq {
public:
	ipathq(const vmax<S>&) {}
	void pull(std::size_t k, const std::function<pathq(std::size_t)>& next_k) {
		push(next_k(k));
	}
};

template<typename... S>
class cfg::itpathq {
	rmax<S...> limits;

	template<typename V> using next_t = std::function<mpathq(std::size_t)>;
	template<typename V>
	void pull_(std::size_t k, const next_t<V>& next_k) {
		push<V>(next_k(k));
	}
	template<typename V0, typename V1, typename... V>
	void pull_(std::size_t k, const next_t<V0>& next_k0, const next_t<V1>& next_k1, const next_t<V>&... next_k) {
		if (typeid(V0) == this->limits.type()) {
			pull_<V0>(k, next_k0);
		} else {
			pull_<V1,V...>(k, next_k1, next_k...);
		}
	}

	std::tuple<tpathq<S>...> tqs = {};
	template<typename V>
	void push(const mpathq& mq) {
		tpathq<V>& tq = std::get<tpathq<V>>(this->tqs);
		tq.push(mq, [](const pptr& p) {return vmax<S...>(S{}(p)...).type() == typeid(V); });
		this->limits.template set<V>(tq.back());
	}

	template<typename V0>
	std::optional<std::pair<pptr,std::uint32_t>> front_(std::optional<std::pair<pptr,std::uint32_t>> f, double l) const {
		if (!f || l < this->limits.max())
			return {};
		return f;
	}
	template<typename V0, typename V1, typename... V>
	auto front_(std::optional<std::pair<pptr,std::uint32_t>> f, double l) const {
		auto f1 = std::get<tpathq<V1>>(this->tqs).front();
		auto l1 = (double) tratio<V1>::MIN;
		if (f1)
			l1 = (double) V1{}(V1::normalize(f1->first), f1->second);
		if (f1 && l < l1) {
			f = f1;
			l = l1;
		}
		return front_<V1,V...>(std::move(f), l);
	}
	template<typename V0, typename... V>
	auto front_() const {
		auto f = std::get<tpathq<V0>>(this->tqs).front();
		auto l = (double) tratio<V0>::MIN;
		if (f)
			l = (double) V0{}(V0::normalize(f->first), f->second);
		return front_<V0,S...>(f, l);
	}

	template<typename V0>
	pptr take_lowest_bitrate_(std::optional<std::function<pptr()>> t, double l) {
		if (!t || l < this->limits.max())
			return nullptr;
		return (*t)();
	}
	template<typename V0, typename V1, typename... V>
	pptr take_lowest_bitrate_(std::optional<std::function<pptr()>> t, double l) {
		tpathq<V1>& tq1 = std::get<tpathq<V1>>(this->tqs);
		auto f1 = tq1.front();
		auto l1 = (double) tratio<V1>::MIN;
		if (f1) {
			l1 = (double) V1{}(V1::normalize(f1->first), f1->second);
			if (l < l1) {
				l = l1;
				t = [&tq1]() { return tq1.take_lowest_bitrate(); };
			}
		}
		return take_lowest_bitrate_<V1,V...>(t, l);
	}
	template<typename V0, typename... V>
	pptr take_lowest_bitrate_() {
		tpathq<V0>& tq = std::get<tpathq<V0>>(this->tqs);
		auto f = tq.front();
		std::optional<std::function<pptr()>> t = {};
		auto l = (double) tratio<V0>::MIN;
		if (f) {
			l = (double) V0{}(V0::normalize(f->first), f->second);
			t = [&tq]() { return tq.take_lowest_bitrate(); };
		}
		return take_lowest_bitrate_<V0,V...>(t, l);
	}

	template<typename V0>
	pptr take_undecided_(std::optional<std::function<pptr()>> t, double l) {
		if (!t || l < this->limits.max())
			return nullptr;
		return (*t)();
	}
	template<typename V0, typename V1, typename... V>
	pptr take_undecided_(std::optional<std::function<pptr()>> t, double l) {
		tpathq<V1>& tq1 = std::get<tpathq<V1>>(this->tqs);
		auto f1 = tq1.undecided_front();
		auto l1 = (double) tratio<V1>::MIN;
		if (f1) {
			l1 = (double) V1{}(V1::normalize(f1->first), f1->second);
			if (l < l1) {
				l = l1;
				t = [&tq1]() { return tq1.take_undecided(); };
			}
		}
		return take_undecided_<V1,V...>(t, l);
	}
	template<typename V0, typename... V>
	pptr take_undecided_() {
		tpathq<V0>& tq = std::get<tpathq<V0>>(this->tqs);
		auto f = tq.undecided_front();
		std::optional<std::function<pptr()>> t = {};
		auto l = (double) tratio<V0>::MIN;
		if (f) {
			l = (double) V0{}(V0::normalize(f->first), f->second);
			t = [&tq]() { return tq.take_undecided(); };
		}
		return take_undecided_<V0,V...>(t, l);
	}

	template<typename V>
	void adjust_size_(pptr p, pptr c, const std::type_info& type) {
		std::get<tpathq<V>>(this->tqs).adjust_size(p,c);
	}
	template<typename V0, typename V1, typename... V>
	void adjust_size_(pptr p, pptr c, const std::type_info& type) {
		if (typeid(V0) == type) {
			std::get<tpathq<V0>>(this->tqs).adjust_size(p,c);
		} else {
			adjust_size_<V1,V...>(p, c, type);
		}
	}

public:
	itpathq(const mpathq::sizev& sizes, const rmax<S...>& limits)
		: limits(limits),
		  tqs(tpathq<S>(sizes)...) {}

	void pull(std::size_t k, const next_t<S>&... next_k) {
		pull_<S...>(k, next_k...);
	};

	auto front() const {
		return front_<S...>();
	}

	pptr take_lowest_bitrate() {
		return take_lowest_bitrate_<S...>();
	}

	pptr take_undecided() {
		return take_undecided_<S...>();
	}

	template<typename V>
	mpathq::sizev sizes_to(std::size_t k) const {
		return std::get<tpathq<V>>(this->tqs).sizes_to(k);
	}

	void adjust_size(pptr p, pptr c) {
		return adjust_size_<S...>(p, c, vmax<S...>(S{}(p)...).type());
	}
};

template<typename S>
class cfg::itpathq<S> : public cfg::tpathq<S> {
public:
	itpathq(const mpathq::sizev& sizes, const rmax<S>&)
		: tpathq<S>(sizes) {}
	void pull(std::size_t k, const std::function<mpathq(std::size_t k)>& next_k) {
		((tpathq<S>*) this)->push(next_k(k));
	}
	template<typename V> mpathq::sizev sizes_to(std::size_t k) const {
		return ((const tpathq<V>*) this)->sizes_to(k);
	}
};

template<typename S>
auto cfg::node::q_with_longest_path() {
	if (this->predecessors.begin() == this->predecessors.end())
		return this->predecessors.end();

	auto l = this->pred_begin(S{});

	for (auto i = std::next(l); i != this->predecessors.end(); i++) {
		if (S{}(l->q(S{}).front(), l->branchtrue) < S{}(i->q(S{}).front(), i->branchtrue))
			l = i;
	}
	for (auto i = this->predecessors.begin(); i != this->pred_begin(S{}); i++) {
		if (S{}(l->q(S{}).front(), l->branchtrue) < S{}(i->q(S{}).front(), i->branchtrue))
			l = i;
	}

	this->pred_begin(S{}) = std::next(l);
	if (this->pred_begin(S{}) == this->predecessors.end())
		this->pred_begin(S{}) = this->predecessors.begin();
	return l;
}

template<typename S>
auto cfg::node::q_with_longest_path(std::uint32_t s) {
	if (this->predecessors.begin() == this->predecessors.end())
		return this->predecessors.end();

	auto l = this->pred_begin(S{});
	while (!l->mq(S{}).front(s)) {
		l++;
		if (l == this->predecessors.end())
			l = this->predecessors.begin();
	}

	for (auto i = std::next(l); i != this->predecessors.end(); i++) {
		pptr p = i->mq(S{}).front(s);
		if (!p)
			continue;
		if (S{}(l->mq(S{}).front(s), l->branchtrue) < S{}(p, i->branchtrue))
			l = i;
	}
	for (auto i = this->predecessors.begin(); i != this->pred_begin(S{}); i++) {
		pptr p = i->mq(S{}).front(s);
		if (!p)
			continue;
		if (S{}(l->mq(S{}).front(s), l->branchtrue) < S{}(p, i->branchtrue))
			l = i;
	}

	this->pred_begin(S{}) = std::next(l);
	if (this->pred_begin(S{}) == this->predecessors.end())
		this->pred_begin(S{}) = this->predecessors.begin();
	return l;
}

state::exec cfg::initial_state() {
	auto packetsize = expr::var<14>("packetsize");
	auto packet = expr::ptr<32,8>("packet");
	auto ctx = expr::ptr<32,32>("ctx");
	auto stack = expr::ptr<32,32>("stack");
	auto map = expr::ptr_base<32,8>("map", 8);

	return state::exec(
		COST_FIRMWARE, DRAM_COST_FIRMWARE,
		{
			state::update(packet, {}),
			state::update(stack, {}),
			state::update(map, {}),
			state::update(ctx, {{0, expr::extend<18,14>(packetsize)}, {2, expr::bvadd<32>(packet, expr::constant<32>(PACKET_HEADROOM))}}),
			state::update(instr::gpr('A', 22), stack),
			state::update(instr::gpr('B', 23), map),
			state::update(instr::ActLMAddr[0], stack),
			state::update(instr::ActLMAddr[1], ctx),
		},
		packetsize, MIN_PACKETSIZE, MTU,
		{
		});
}

template<typename S>
auto cfg::underestimate_packetrate() {
	std::map<nptr,path::iptr> map;
	map[this->start.nd] = std::make_shared<path::impossible>(this->start, MIN_PACKETSIZE, initial_state());

	for (nptr nd: this->nodes) {
		path::iptr p = map[nd];
		for (auto& [sd,branchtrue]: nd->succ()) {
			path::iptr n = p->extendi(branchtrue);
			path::iptr& e = map[sd.get().nd];
			if (!e || S{}(e) < S{}(n))
				e = n;
		}
	}

	path::iptr& m = map[this->fin_nd];
	return S{}(m);
}

template<typename S>
auto cfg::underestimate_bitrate(const mpathq::sizev& sizes) {
	std::map<std::pair<nptr,std::uint32_t>, path::iptr> map;
	path::iptr start = std::make_shared<path::impossible>(this->start, MIN_PACKETSIZE, initial_state());
	for (auto [s,ss]: sizes)
		map[std::make_pair(this->start.nd,s)] = start;

	for (nptr nd: this->nodes) {
		for (auto& [sd,branchtrue]: nd->succ()) {
			for (auto [s, ss]: sd.get().sizes) {
				path::iptr n = map[std::make_pair(nd,s)]->extendi(branchtrue);
				path::iptr& m = map[std::make_pair(sd.get().nd,s)];
				if (!m || S{}(m) < S{}(n))
					m = n;
			}
		}
	}

	path::iptr m;
	std::uint32_t ms;
	for (auto [s,ss]: sizes) {
		path::iptr& e = map[std::make_pair(this->fin_nd, s)];
		if (!m || S{}(m, ms) < S{}(e, s)) {
			m = e;
			ms = s;
		}
	}
	return tratio<S>(m,ms);
}

template<typename S>
cfg::pathq cfg::next_k(std::size_t k) {
	std::vector<node::pred_data> output = {node::pred_data(this->fin_nd, true)};
	struct {
		std::vector<node::pred_data>::iterator pr;
		std::size_t k;
	} e = {output.begin(), k};
	std::stack<decltype(e)> stack;

	auto pr = e.pr->nd->template shortest_q<S>();
	for (;;) {
		do {
			pr->q(S{}).push(pr->nd->template qtake<S>(pr->branchtrue));
			stack.push(e);
			e = {pr, e.k - e.pr->q(S{}).size()};
			pr = e.pr->nd->template shortest_q<S>();
		} while (pr->q(S{}).size() + e.pr->q(S{}).size() < e.k);
		do {
			pathq q;
			auto ordered = thread_pool.ordered_completion<pptr>();
			for (pathq::sizet i = e.pr->q(S{}).size(); i < e.k;) {
				nptr nd = e.pr->nd;
				auto m = nd->q_with_longest_path<S>();
				pptr p = m->q(S{}).take();
				i += p->size();
				ordered.may_delegate([p,m] {
					return p->extend(m->branchtrue);
				}, [&q](pptr px, unsigned long i) {
					if (!px->is_unsat() || o_keep_impossible_paths)
						q.push(px);
				}, p->may_satcheck(m->branchtrue));
			}
			this->thread_pool.wait();
			e.pr->nd->template qpush<S>(!e.pr->branchtrue, q);
			e.pr->q(S{}).push(std::move(q));
			if (stack.empty())
				return output.front().q(S{});
			e = stack.top();
			stack.pop();
			pr = e.pr->nd->template shortest_q<S>();
		} while (pr->q(S{}).size() + e.pr->q(S{}).size() >= e.k);
	}
}

template<typename S>
cfg::mpathq cfg::next_k(const mpathq::sizev& k) {
	std::vector<node::pred_data> output = {node::pred_data(this->fin_nd, true)};
	struct {
		std::vector<node::pred_data>::iterator pr;
		mpathq::sizev k;
	} e = {output.begin(), k};
	e.pr->mq(S{}) = mpathq(k);
	std::stack<decltype(e)> stack;

	auto [pr, prv] = e.pr->nd->template shortest_mq<S>(e.k-e.pr->mq(S{}).sizes());
	for (;;) {
		while (prv + e.pr->mq(S{}).sizes() < e.k) {
			pr->mq(S{}).push(pr->nd->template mqtake<S>(pr->branchtrue));
			stack.push(e);
			e = {pr, (e.k & pr->sizes()) - e.pr->mq(S{}).sizes()};
			std::tie(pr, prv) = e.pr->nd->template shortest_mq<S>(e.k-e.pr->mq(S{}).sizes());
		}
		do {
			for (auto [s,sk]: e.k) {
				pathq q;
				auto ordered = thread_pool.ordered_completion<pptr>();
				for (pathq::sizet i = e.pr->mq(S{}).size(s); i < sk;) {
					nptr nd = e.pr->nd;
					auto m = nd->q_with_longest_path<S>(s);
					pptr p = m->mq(S{}).take(s);
					i += p->size();
					ordered.may_delegate([p,m] {
						return p->extend(m->branchtrue);
					}, [&q](pptr px, unsigned long i) {
						if (!px->is_unsat() || o_keep_impossible_paths)
							q.push(px);
					}, p->may_satcheck(m->branchtrue));
				}
				this->thread_pool.wait();
				e.pr->nd->template mqpush<S>(!e.pr->branchtrue, q, s);
				e.pr->mq(S{}).push(std::move(q), s);
			}
			if (stack.empty())
				return output.front().mq(S{});
			e = stack.top();
			stack.pop();
			std::tie(pr, prv) = e.pr->nd->template shortest_mq<S>(e.k-e.pr->mq(S{}).sizes());
		} while (prv + e.pr->mq(S{}).sizes() >= e.k);
	}
}

template<typename S>
void cfg::push_impossible() {
	for (nptr nd: this->nodes) {
		for (auto& pr: nd->pred()) {
			pr.q(S{}).push(pr.nd->qtake<S>(pr.branchtrue));
			pathq q;
			for (;;) {
				if (!pr.nd->shortest_q<S>()->q(S{}).size())
					break;
				auto m = pr.nd->q_with_longest_path<S>();
				if (!m->q(S{}).front()->is_unsat())
					break;
				q.push(m->q(S{}).take()->extend(m->branchtrue));
			}
			pr.nd->qpush<S>(!pr.branchtrue, q);
			pr.q(S{}).push(std::move(q));
		}
	}
}

template<typename S>
void cfg::push_mimpossible() {
	for (nptr nd: this->nodes) {
		for (auto& pr: nd->pred()) {
			pr.mq(S{}).push(pr.nd->mqtake<S>(pr.branchtrue));
			for (auto [s,ss] : pr.sizes()) {
				pathq q;
				for (;;) {
					if (!pr.nd->shortest_mq<S>(std::pair<std::uint32_t,pathq::sizet>(s,1)).second[s])
						break;
					auto m = pr.nd->q_with_longest_path<S>(s);
					if (!m->mq(S{}).front(s)->is_unsat())
						break;
					q.push(m->mq(S{}).take(s)->extend(m->branchtrue));
				}
				pr.nd->template mqpush<S>(!pr.branchtrue, q, s);
				pr.mq(S{}).push(std::move(q), s);
			}
		}
	}
}

template<typename... S>
void cfg::report_max(const vmax<S...>& max) {
	std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - this->start_time;
	auto max_cycles = max.template get<path::MAX_CYCLES>();
	auto dram_cycles = max.template get<path::DRAM_CYCLES>();

	this->out << "####" << "\n";
	this->out << this->index << ": " << elapsed.count() << " s\n";
	this->out << "max cycles: " << max_cycles << "\n";
	this->out << "DRAM cycles: " << dram_cycles << "\n";
	stats::write(this->out);
	this->out << "\n" << std::flush;
}

template<typename... S>
void cfg::report_max(const rmax<S...>& max) {
	std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - this->start_time;
	auto max_cycles = max.template get<path::MAX_CYCLES>();
	auto dram_cycles = max.template get<path::DRAM_CYCLES>();

	this->out << "####" << "\n";
	this->out << this->index << ": " << elapsed.count() << " s\n";
	this->out << "max cycles: " << max_cycles.value << "\n";
	this->out << "max cycles/b: " << (double) max_cycles << "\n";
	this->out << "min packet size(max cycles): " << max_cycles.size << "\n";
	this->out << "DRAM cycles: " << dram_cycles.value << "\n";
	this->out << "DRAM cycles/b: " << (double) dram_cycles << "\n";
	this->out << "min packet size(DRAM cycles): " << dram_cycles.size << "\n";
	stats::write(this->out);
	this->out << "\n" << std::flush;
}

void cfg::report_timeout() {
	std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - this->start_time;
	this->out << "#### Timeout" << "\n";
	this->out << this->index << ": " << elapsed.count() << " s\n";
	stats::write(this->out);
	this->out << "\n" << std::flush;
}

void cfg::report_path(pptr p) {
	std::chrono::duration<double> elapsed = std::chrono::steady_clock::now() - this->start_time;
	std::shared_ptr<const path::possible> pp = std::dynamic_pointer_cast<const path::possible>(p);
	this->out << "#### " << p->str() << "\n";
	this->out << this->index << ": " << elapsed.count() << " s\n";
	this->out << "max cycles: " << p->max_cycles() << "\n";
	this->out << "max cycles/b: " << (double) path::cycleratio(p->max_cycles(), p->min_packetsize()) << "\n";
	this->out << "DRAM cycles: " << p->dram_cycles() << "\n";
	this->out << "DRAM cycles/b: " << p->dram_cycles()/p->min_packetsize() << "\n";
	this->out << "min packet size: " << p->min_packetsize() << "\n";

	if (!pp) {
		stats::write(this->out);
		this->out << "\n" << std::flush;
		return;
	}
	state::exec s = pp->get_state();
	std::uint32_t packetsize = p->min_packetsize();

	this->out << "cycles: " << pp->cycles() << "\n";
	this->out << "cycles/b: " << (double) path::cycleratio(pp->cycles(), pp->min_packetsize()) << "\n";

	this->out << std::hex;

	for (std::uint32_t i = 0; i < packetsize; i++) {
		if (!(i%4))
			this->out << "|0x" << std::setfill('0') << std::setw(4) << i << "|";
		std::optional<std::uint8_t> b = s.get_value("packet", i+PACKET_HEADROOM);
		if (b) {
			this->out << " " << std::setfill('0') << std::setw(2) << (unsigned int) *b << " |";
		} else {
			this->out << " -- |";
		}
		if ((i%4) == 3)
			this->out << "\n";
	}
	if (packetsize%4)
		this->out << "\n";

	std::uint32_t last = -1U;
	for (const auto [k,v]: s.get_values("map")) {
		if (!(k%4) || last+1 != k) {
			if (last != -1U)
				this->out << "\n";
			this->out << "map[0x" << std::setfill('0') << std::setw(8) << k << "]=";
		}
		this->out << " " << std::setfill('0') << std::setw(2) << (unsigned int) v;
		last = k;
	}
	this->out << "\n";

	this->out << std::dec;

	stats::write(this->out);
	this->out << "\n" << std::flush;
	this->index += 1;
}

template<typename... S>
void cfg::enumerate_by_packetrate(std::size_t count) {
	overestimate_cycles();
	auto max = vmax<S...>(underestimate_packetrate<S>()...);
	ipathq iq(max);
	report_max(max);
	if (!count)
		return;

	pptr start = std::make_shared<path::possible>(nullptr, this->start, MIN_PACKETSIZE, initial_state(), true);
	pptr none = std::make_shared<path::none>();
	(this->start.nd->qpush<S>(true, {start, none}),...);
	(this->start.nd->qpush<S>(false, {start, none}),...);
	std::size_t k = std::max(PARALLELISM, 1LU);

	for (bool done = false; !done;) {
		auto ordered = thread_pool.ordered_completion<pptr>();
		iq.pull(k, [this](std::size_t k) { return next_k<S>(k); }...);
		pptr f = iq.front();
		vmax m = vmax<S...>(f);
		if (f && !f->is_decided() && m < max)
			report_max(m);
		while (pptr p = iq.take()) {
			pptr n = iq.front();
			ordered.delegate([p] {
				return p->check();
			}, [&,n](pptr p, unsigned int i) {
				report_path(p);
				if (this->index >= count || p->is_none())
					done = true;
				max = vmax<S...>(p);
				vmax m = vmax<S...>(n);
				if (n && !n->is_decided() && m < max && !ordered.waiting(i+1))
					report_max(m);
			});
		}
		this->thread_pool.wait();
		if (o_keep_impossible_paths)
			(push_impossible<S>(),...);
		if (k < 20 * PARALLELISM && mem_available())
			k = k + k/2;
	}

	for (nptr nd: this->nodes)
		nd->reset<S...>();
}

template<typename... S>
void cfg::enumerate_by_bitrate(std::size_t count) {
	overestimate_cycles();
	mpathq::sizev sizes = propagate_sizes<S...>();
	auto max = rmax<S...>(underestimate_bitrate<S>(sizes)...);
	report_max(max);
	itpathq itq(sizes, max);
	if (!count)
		return;

	pptr start = std::make_shared<path::possible>(nullptr, this->start, MIN_PACKETSIZE, initial_state(), true);
	pptr none = std::make_shared<path::none>();
	(this->start.nd->mqpush<S>(true, {start, none}),...);
	(this->start.nd->mqpush<S>(false, {start, none}),...);
	std::size_t k = std::max(PARALLELISM, 1LU);

	for (bool done = false; !done;) {
		auto w = [&] {
			while (pptr l = itq.take_lowest_bitrate()) {
				l = l->check();
				report_path(l);
				if (this->index >= count || l->is_none())
					done = true;
				max = rmax<S...>(l);
			}
			auto f = itq.front();
			auto m = rmax<S...>(f->first, f->second);
			if (f && !f->first->is_decided() && m < max) {
				report_max(m);
				max = m;
			}
		};

		auto ordered = thread_pool.ordered_completion<pptr>();
		itq.pull(k, [this,&itq](std::size_t k) { return next_k<S>(itq.template sizes_to<S>(k)); }...);
		w();
		while (pptr p = itq.take_undecided()) {
			ordered.delegate([p] {
				return p->check();
			}, [&,p](pptr c, unsigned int i) {
				itq.adjust_size(p, c);
				w();
			});
		}
		this->thread_pool.wait();
		if (o_keep_impossible_paths)
			(push_mimpossible<S>(),...);
		if (k < 20 * PARALLELISM && mem_available())
			k = k + k/2;
	}

	for (nptr nd: this->nodes)
		nd->reset<S...>();
}

void cfg::enumerate_by_proc_packetrate(std::size_t count) {
	enumerate_by_packetrate<path::MAX_CYCLES>(count);
}

void cfg::enumerate_by_dram_packetrate(std::size_t count) {
	enumerate_by_packetrate<path::DRAM_CYCLES>(count);
}

void cfg::enumerate_by_packetrate(std::size_t count) {
	enumerate_by_packetrate<path::MAX_CYCLES,path::DRAM_CYCLES>(count);
}

void cfg::enumerate_by_proc_bitrate(std::size_t count) {
	enumerate_by_bitrate<path::MAX_CYCLES>(count);
}

void cfg::enumerate_by_dram_bitrate(std::size_t count) {
	enumerate_by_bitrate<path::DRAM_CYCLES>(count);
}

void cfg::enumerate_by_bitrate(std::size_t count){
	enumerate_by_bitrate<path::MAX_CYCLES,path::DRAM_CYCLES>(count);
}

void cfg::save_dot_graph() const {
	this->out << "digraph asm{\n";
	for(nptr nd: this->nodes){
		this->out << "\t_" << nd->did() << " [label=\"";
		for(auto i : nd->instrs()) {
			this->out << i->str() << "\\l";
		}
		this->out << "\", shape=\"box\"];\n";
		for(const auto& pr: nd->pred())
			this->out << "\t_" << pr.nd->did() << "->_" << nd->did() << "[style=" << (pr.branchtrue ? "solid" : "dashed")  << ",label=\"" << pr.nd->succ(pr.branchtrue).min_packetsize << "\"];\n";
	}
	this->out << "}\n";
}

void cfg::static_analysis(bool sat_check) {
	topo_sort();

	std::map<nptr,state::exec> map;
	map[this->start.nd] = initial_state();

	for (nptr nd: this->nodes) {
		if (!nd->indegree() && nd != this->start.nd) {
			nd->unlink();
			continue;
		}
		state::exec& state = map[nd];
		for (auto i = nd->instrs().begin(); i != nd->instrs().end()-1; i++)
			state.apply(**i, state::perf::info(), nd->loopdepth());
		auto ordered = thread_pool.ordered_completion<state::exec>();
		for (auto [s, branchtrue]: nd->succ()) {
			ordered.delegate([&,s,branchtrue] {
				state::exec sstate = state;
				auto& i = nd->instrs().back();
				sstate.apply(*i, state::perf::info(), nd->loopdepth(), branchtrue);
				if (sat_check && nd->outdegree() > 1)
					sstate.partial_minimize();
				return sstate;
			}, [&,s,branchtrue](state::exec sstate, unsigned long i) {
				if (sstate.is_unsat()) {
					nd->unlink(branchtrue);
					return;
				}
				s.get().min_packetsize = sstate.minimum_value();
				auto m = map.find(s.get().nd);
				if (m == map.end()) {
					map[s.get().nd] = sstate;
				} else {
					map[s.get().nd] = m->second.static_merge(sstate);
				}
			});
		}
		this->thread_pool.wait();
	}
	for (auto i = this->nodes.rbegin(); i != this->nodes.rend(); i++) {
		if (!(*i)->outdegree() && *i != this->fin_nd)
			(*i)->unlink();
	}

	remove_unreachable();
}

void cfg::overestimate_cycles() {
	topo_sort();

	this->start.instructions.reserve(this->start.nd->instrs().size());
	for (auto& i: this->start.nd->instrs())
		this->start.instructions.push_back(i);
	for (nptr nd: this->nodes) {
		for (auto& s: nd->succ()) {
			s.first.get().instructions.reserve(s.first.get().nd->instrs().size());
			for (auto& i: s.first.get().nd->instrs())
				s.first.get().instructions.push_back(instr_data(i, state::perf::info::max()));
		}
	}

	for (auto i = this->start.instructions.begin()+1; i != this->start.instructions.end(); i++)
		i->i = (i-1)->i.apply(*(i-1)->n);
	auto& l = this->start.instructions.back();
	for (auto& s: this->start.nd->succ()) {
		auto &i = s.first.get().instructions.front();
		i.i = i.i.merge(l.i.apply(*l.n));
	}

	for (nptr nd: this->nodes) {
		for (auto& s: nd->succ()) {
			auto& in = s.first.get().instructions;
			for (auto i = in.begin()+1; i != in.end(); i++)
				i->i = (i-1)->i.apply(*(i-1)->n);
			auto& l = in.back();
			for (auto& ss: s.first.get().nd->succ()) {
				auto &i = ss.first.get().instructions.front();
				i.i = i.i.merge(l.i.apply(*l.n));
			}
		}
	}
}

template<typename... S>
cfg::mpathq::sizev cfg::propagate_sizes() {
	std::map<succ_data*,mpathq::sizev> possible;
	std::map<succ_data*,mpathq::sizev> produced;

	for (auto i = this->nodes.rbegin(); i != this->nodes.rend(); i++) {
		for (auto& pr: (*i)->pred()) {
			succ_data& ps = pr.nd->succ(pr.branchtrue);
			ps.sizes = ps.sizes & ps.min_packetsize;
			ps.sizes = ps.sizes | std::make_pair(ps.min_packetsize, pathq::sizet::MAX);
			for (auto& ppr: pr.nd->pred()) {
				succ_data& pps = ppr.nd->succ(ppr.branchtrue);
				pps.sizes = pps.sizes | ps.sizes;
			}
		}
	}

	for (auto [s,b]: this->start.nd->succ())
		possible[&s.get()] = s.get().sizes;

	for (nptr nd: this->nodes) {
		for (auto& pr: nd->pred()) {
			succ_data& ps = pr.nd->succ(pr.branchtrue);
			mpathq::sizev& pos = possible[&ps];
			mpathq::sizev& pro = produced[&ps];
			for (auto& ppr: pr.nd->pred()) {
				succ_data& pps = ppr.nd->succ(ppr.branchtrue);
				pos = pos | possible[&pps];
				pro = pro | produced[&pps];
			}
			pos = pos & ps.min_packetsize;
			pro = pro & ps.min_packetsize;
			pro = pro | std::make_pair(ps.min_packetsize, pathq::sizet::MAX);
			ps.sizes = (ps.sizes & pos) | pro;
			((pr.mq(S{}) = mpathq(ps.sizes)),...);
			((ps.mq(S{}) = mpathq(ps.sizes)),...);
		}
	}

	mpathq::sizev sizes;
	for (auto& pr: this->fin_nd->pred())
		sizes = sizes | pr.sizes();
	return sizes;
}

bool cfg::is_in_loop(nptr start) {
	std::set<nptr> visited;
	std::queue<nptr> queue;
	queue.push(start);

	while (!queue.empty()) {
		nptr nd = queue.front();
		queue.pop();
		for (auto& p: nd->succ()) {
			nptr s = p.first.get().nd;
			if (s == start) {
				return true;
			}
			if (visited.find(s) != visited.end())
				continue;
			visited.insert(s);
			queue.push(s);
		}
	}
	return false;
}

std::set<cfg::nptr> cfg::loopfree_nodes() {
	std::set<nptr> nds;

	for (auto& nd: this->nodes) {
		if (!cfg::is_in_loop(nd))
			nds.insert(nd);
	}

	return nds;
}

void cfg::unroll(std::size_t limit, const std::map<std::uint32_t,std::size_t>& limits) {
	std::set<nptr> nounroll = loopfree_nodes();

	std::map<nptr,bool> finished;
	std::map<std::uint32_t,std::size_t> visited;
	std::map<std::pair<std::uint32_t,std::size_t>,nptr> unrolled;
	std::stack<std::pair<nptr,std::size_t>> stack;
	stack.push(std::make_pair(this->start.nd, 0));

	while (!stack.empty()) {
		auto& t = stack.top();
		nptr nd = t.first;
		std::size_t& i = t.second;

		if (i < nd->succ().size()) {
			nptr s = nd->succ()[i].first.get().nd;
			bool branchtrue = nd->succ()[i].second;
			std::size_t depth = std::max(visited[s->id()], nd->loopdepth());

			std::size_t l = limit;
			auto li = limits.find(s->id());
			if (li != limits.end())
				l = li->second;
			if (l && nounroll.find(s) == nounroll.end()) {
				if (depth >= l) {
					nd->unlink(branchtrue);
					continue;
				} else if (depth > s->loopdepth()) {
					nptr& u = unrolled[std::make_pair(s->id(), depth)];
					if (!u)
						u = s->clone(depth);
					nd->unlink(branchtrue);
					nd->link(u, branchtrue);
					s = u;
				}
			}
			if (!finished[s]) {
				visited[s->id()]++;
				stack.push(std::make_pair(s, 0));
			}
			i++;
		} else {
			finished[nd] = true;
			visited[nd->id()]--;
			stack.pop();
		}
	}

	this->nodes.reserve(this->nodes.size() + unrolled.size());
	for (auto u: unrolled)
		this->nodes.push_back(u.second);
}

void cfg::topo_sort() {
	std::set<nptr> r(this->nodes.begin(), this->nodes.end());
	std::size_t size = this->nodes.size();
	this->nodes.clear();
	this->nodes.reserve(size);

	std::map<nptr,std::size_t> visited;
	std::stack<nptr> stack;
	stack.push(this->start.nd);

	while (!stack.empty()) {
		nptr nd = stack.top();
		stack.pop();
		r.erase(nd);
		this->nodes.push_back(nd);
		for (auto& s: nd->succ()) {
			visited[s.first.get().nd] += 1;
			if (visited[s.first.get().nd] == s.first.get().nd->indegree())
				stack.push(s.first.get().nd);
		}
	}

	if (r.find(this->fin_nd) != r.end())
		errx(-1, "cfg not loop-free");

	for (auto nd: r)
		this->nodes.push_back(nd);
}

void cfg::merge_edges() {
	std::map<nptr,bool> deleted;

	for (auto i = this->nodes.begin(); i != this->nodes.end();) {
		nptr nd = *i;
		nptr succ;
		if (deleted[nd])
			goto next;
		if (nd->exit_type() == instr::JUMP)
			goto next;
		if (nd->outdegree() != 1)
			goto next;
		succ = nd->succ()[0].first.get().nd;
		if (succ->indegree() != 1)
			goto next;

		nd->merge_node(succ);
		deleted[succ] = true;
		continue;
	next:
		i++;
	}

	for (auto i = this->nodes.begin(); i != this->nodes.end();) {
		nptr nd = *i;
		if (!deleted[nd]) {
			i++;
			continue;
		}
		*i = *(this->nodes.end()-1);
		this->nodes.erase(this->nodes.end()-1);
	}
}

void cfg::remove_unreachable() {
	std::map<nptr,bool> visited;
	std::stack<nptr> stack;
	stack.push(this->start.nd);

	while (!stack.empty()) {
		nptr nd = stack.top();
		stack.pop();
		visited[nd] = true;
		for (auto& s: nd->succ()) {
			if (visited[s.first.get().nd])
				continue;
			stack.push(s.first.get().nd);
		}
	}

	for (auto i = this->nodes.begin(); i != this->nodes.end(); ) {
		nptr nd = *i;
		if (visited[nd]) {
			i++;
			continue;
		}
		nd->unlink();
		*i = *(this->nodes.end()-1);
		this->nodes.erase(this->nodes.end()-1);
	}
}

void cfg::link_nodes(nptr src, std::uint32_t dst, std::map<std::uint32_t,nptr>& map, bool branchtrue) {
	nptr dst_nd = this->fin_nd;

	auto i = map.find(dst);
	if (i != map.end())
		dst_nd = i->second;

	src->link(dst_nd, branchtrue);
}

void cfg::create_edges(nptr nd, std::map<std::uint32_t,nptr> map) {
	switch(nd->exit_type()){
	case instr::FIN:
		if (nd != this->fin_nd)
			errx(-1, "unexpected final node");
		break;
	case instr::BRANCH:
		//push false branche edge
		link_nodes(nd, nd->next_id(), map, false);
		[[fallthrough]];
	case instr::JUMP:
		link_nodes(nd, nd->br_id(), map, true);
		break;
	default:
		link_nodes(nd, nd->next_id(), map, false);
		break;
	}
}

void cfg::init_nodes(std::string asm_listing) {
	/*assume instruction in listing will have next format:
		3  alu[$xfer_0, --, B, $xfer_16]*/
	std::stringstream ss(asm_listing);
	for (std::string line; std::getline(ss, line);) {
		nptr nd = std::make_shared<node>(instr::build_instr(line));
		if (nd->id() >= instr::fin::ID)
			errx(-1, "instr at addr %" PRIu32 " >= %" PRIu32, nd->id(), instr::fin::ID);
		this->nodes.push_back(nd);
	}

	/*create final node to which all branches will be linked if label 
	is out of range of listing e.g. for bpf programs*/
	this->fin_nd = std::make_shared<node>(instr::fin::build());
	this->nodes.push_back(this->fin_nd);
}

void cfg::build_cfg(std::string asm_listing) {
	init_nodes(asm_listing);

	std::map<std::uint32_t,nptr> map;
	for (nptr nd: this->nodes) {
		if (map.find(nd->id()) != map.end())
			errx(-1, "multiple instructions at %" PRIu32, nd->id());
		map[nd->id()] = nd;
	}
	if (map.find(0) == map.end())
		errx(-1, "missing instruction at address 0");
	this->start.nd = map[0];


	for (nptr nd: this->nodes)
		create_edges(nd, map);

	remove_unreachable();
	merge_edges();
	if (UNROLL_LIMIT || !UNROLL_LIMITS.empty())
		unroll(UNROLL_LIMIT, UNROLL_LIMITS);
}

cfg::cfg(std::string asm_listing, std::ostream &out)
	: out(out),
	  thread_pool(PARALLELISM) {
	static stats::threadtime cfg_cputime("cfg.cputime", pthread_self());
	static stats::threadtime threads_cputime("cfg.threads.cputime");
	static stats::maxmem maxmem("cfg.maxmem", 0);

	for (auto handle: thread_pool.thread_handles())
		threads_cputime.add(handle);

	build_cfg(asm_listing);
}

cfg::~cfg() {
	for (nptr nd: this->nodes)
		for (auto& pr: nd->pred())
			pr.nd = nullptr;
}

