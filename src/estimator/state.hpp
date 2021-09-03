#pragma once

//#include "instr.hpp"
class instr;
#include "estimator/expr.hpp"
#include "estimator/sat_checker.hpp"

#include <memory>
#include <map>
#include <set>
#include <vector>
#include <utility>
#include <limits>
#include <cstdint>


class state {
public:
	static bool debug_assignments;
	static std::set<std::uint32_t> debug_instrs;

	class perf;
	class exec;

	class deposit {
	public:
		class reg;
		class flag;

		virtual std::string location() const = 0;
	};
	class deposit::reg : public deposit {};
	class deposit::flag : public deposit {};

	class update;
	using uptr = std::shared_ptr<const class update>;
	class update {
		friend class state::exec;
	public:
		class defered;
		class noop;
		class reg;
		class flag;
		class invalidate_mem;
		template<std::uint8_t V> class mem;
		bool is_debugged = false;
	private:
		virtual void store(state::exec& state) const = 0;
		virtual uptr debug() const = 0;
		virtual std::shared_ptr<const class update> to_undef(const std::string& reason) const = 0;
	};

	static uptr update() {
		static std::shared_ptr<const update::noop> noop = std::make_shared<const update::noop>();
		return noop;
	}
	static uptr update(const state::deposit::reg& d, expr::bvptr<32> e) {
		return std::make_shared<const update::reg>(d, e);
	}
	static uptr update(const state::deposit::flag& d, expr::bvptr<1> e) {
		return std::make_shared<const update::flag>(d, e);
	}
	template<std::uint8_t V>
	static uptr update(expr::avptr<32,V> d, expr::aptr<32,V> e) {
		return std::make_shared<const update::mem<V>>(d, e);
	}
	template<std::uint8_t V>
	static uptr update(std::shared_ptr<const expr::pointer<32,V>> p, std::initializer_list<std::pair<std::uint32_t, expr::bvptr<V>>> l) {
		expr::aptr<32,V> a = p->array;
		for (auto& e: l)
			a = expr::store(a, expr::constant<32>(e.first), e.second);
		return update(p->array, a);
	}
	template<std::uint8_t V>
	static uptr update(std::shared_ptr<const expr::pointer_base<32,V>> p, std::initializer_list<std::pair<std::uint32_t, expr::bvptr<V>>> l) {
		expr::aptr<32,V> a = p->array;
		for (auto& e: l)
			a = expr::store(a, expr::constant<32>(e.first), e.second);
		return update(p->array, a);
	}
	static uptr invalidate_mem(const std::string& reason) {
		return std::make_shared<const update::invalidate_mem>(reason);
	}
	static uptr invalidate_mem(const std::string& reason, expr::eptr e) {
		return std::make_shared<const update::invalidate_mem>(reason, e);
	}
	static uptr defer(unsigned int cycles, uptr u) {
		return std::make_shared<const update::defered>(cycles, u);
	}
	using updates = std::vector<uptr>;

	class update::defered : public update {
	private:
		unsigned int cycles;
		uptr u;
	public:
		defered(unsigned int cycles, uptr u)
			: cycles(cycles),
			  u(u) {}
		void store(state::exec& state) const override;
		uptr debug() const override {
			return std::make_shared<const update::defered>(cycles, this->u->debug());
		}
		uptr to_undef(const std::string& reason) const override {
			return u->to_undef(reason);
		}
	};
	class update::noop : public update, public std::enable_shared_from_this<update::noop>  {
	public:
		noop() = default;
		void store(state::exec& state) const override;
		uptr debug() const override {
			return shared_from_this();
		}
		uptr to_undef(const std::string& reason) const override {
			return shared_from_this();
		}
	};

	class update::reg : public update {
	private:
		const deposit::reg& d;
		expr::bvptr<32> e;
	public:
		reg(const state::deposit::reg& d, expr::bvptr<32> e)
			: d(d), e(e) {}
	private:
		void store(state::exec& state) const override;
		uptr debug() const override {
			auto u = std::make_shared<update::reg>(*this);
			u->is_debugged = true;
			return u;
		}
		uptr to_undef(const std::string& reason) const override {
			return state::update(this->d, expr::undef<32>(reason));
		}
	};

	class update::flag : public update {
	private:
		const deposit::flag& d;
		expr::bvptr<1> e;
	public:
		flag(const state::deposit::flag& d, expr::bvptr<1> e)
			: d(d), e(e) {}
	private:
		void store(state::exec& state) const override;
		uptr debug() const override {
			auto u = std::make_shared<update::flag>(*this);
			u->is_debugged = true;
			return u;
		}
		uptr to_undef(const std::string& reason) const override {
			return state::update(this->d, expr::undef<1>(reason));
		}
	};

	template<std::uint8_t V>
	class update::mem : public update {
	private:
		expr::avptr<32,V> d;
		expr::aptr<32,V> e;
	public:
		mem(expr::avptr<32,V> d, expr::aptr<32,V> e)
			: d(d),
			  e(e) {}
	private:
		void store(state::exec& state) const override;
		uptr debug() const override {
			auto u = std::make_shared<update::mem<V>>(*this);
			u->is_debugged = true;
			return u;
		}
		uptr to_undef(const std::string& reason) const override {
			return state::invalidate_mem(reason);
		};
	};

	class update::invalidate_mem: public update, std::enable_shared_from_this<invalidate_mem> {
	private:
		const std::string& reason;
		expr::eptr e;
	public:
		invalidate_mem(const std::string& reason)
			: reason(reason) {};
		invalidate_mem(const std::string& reason, expr::eptr e)
			: reason(reason), e(e) {};
	private:
		void store(state::exec& state) const override;
		uptr debug() const override {
			auto u = std::make_shared<update::invalidate_mem>(*this);
			u->is_debugged = true;
			return u;
		}
		uptr to_undef(const std::string& reason) const override {
			return shared_from_this();
		};
	};

	struct sat_strategy {
		struct result {
			bool sat;
			std::optional<sat_checker::model> model;
			std::optional<sat_checker::unsat_core> unsat_core;
			result(sat_checker::model model) :
				sat(true),
				model(model),
				unsat_core({}) {};
			result(sat_checker::unsat_core unsat_core) :
				sat(false),
				model({}),
				unsat_core(unsat_core) {};
		};

		sat_checker c = {};

		virtual result check_sat(const state::exec& state, const std::vector<sat_checker::assumption>& assumptions, bool minimize_unsat_prefix) =  0;

		class unsat_core;
		class incremental;
	};


	class sat_strategy::unsat_core : public sat_strategy {
		result check_sat(const state::exec& state, const std::vector<sat_checker::assumption>& assumptions, bool minimize_unsat_prefix) override;
	};

	class sat_strategy::incremental : public sat_strategy {
		std::shared_ptr<const struct expr::bvvariable<14>> minimize = nullptr;
		std::optional<sat_checker::model> model;
		std::shared_ptr<const class expr::defs> start_defs = std::make_shared<class expr::defs>();
		struct stack_t {
			sat_checker::assumption assumption;
			std::shared_ptr<const class expr::defs> defs;
			stack_t(sat_checker::assumption assumption, std::shared_ptr<const class expr::defs> defs)
				: assumption(assumption),
				  defs(defs) {}
		};
		std::vector<stack_t> stack = {};

		result check_sat(const state::exec& state, const std::vector<sat_checker::assumption>& assumptions, bool minimize_unsat_prefix) override;
	};

	class perf {
	public:
		class info {
			friend state;
		private:
			unsigned int sincecc = 0;
			unsigned int sincemem = 0;
			info(unsigned int sincecc, unsigned int sincemem);
		public:
			info() = default;
			static info max();
			info apply(const instr& n, bool branchtrue=false) const;
			info merge(const info& i) const;
		};

	protected:
		unsigned int summaxcycles = 0;
		double sumdramcycles = 0.0;
	public:
		perf() = default;
		perf(unsigned int cycles, double dram_cycles);
		static unsigned int cycles(const instr& n, const info& i, bool branchtrue=false);
		virtual void apply(const instr& n, const info& i, std::size_t loopdepth, bool branchtrue=false);
		unsigned int max_cycles() const;
		double dram_cycles() const;
	};

	class exec : public state::perf {
		friend class state::update;
		friend class state::sat_strategy;
	private:
		unsigned int sumcycles = 0;
		unsigned int lastmem = 0;
		unsigned int lastcc = 0;
		std::map<const std::string,expr::bvptr<32>> registers = {};
		std::map<const std::string,expr::bvptr<1>> flags = {};
		std::map<const std::string,expr::aptr<32,8>> mem8 = {};
		std::map<const std::string,expr::aptr<32,32>> mem32 = {};
		std::string mem_undef_reasons = {};
		std::vector<std::pair<unsigned int,uptr>> defered = {};
		std::shared_ptr<const struct expr::bvvariable<14>> minimize = nullptr;
		std::uint32_t min_value = 0;
		std::uint32_t max_value = std::numeric_limits<std::uint32_t>::max();
		std::vector<sat_checker::assumption> assumptions = {};
		std::optional<bool> sat = {};
		std::optional<sat_checker::model> model = {};
		std::optional<sat_checker::unsat_core> unsat_core = {};

		void assume(const sat_checker::assumption& a);
		static std::string assumption_name(const instr& n, std::size_t loopdepth, bool branchtrue);
	public:
		exec() = default;
		exec(unsigned int cycles, double dram_cycles, updates input, std::shared_ptr<const struct expr::bvvariable<14>> minimize, std::uint32_t min_value, std::uint32_t max_value, std::initializer_list<sat_checker::assumption> assumptions);
		void apply(const instr& n, const perf::info& i, std::size_t loopdepth, bool branchtrue=false) override;
		virtual state::exec static_merge(const state::exec& o) const;
		unsigned int cycles() const;
		expr::bvptr<32> operator[](const deposit::reg& d) const;
		expr::bvptr<1> operator[](const deposit::flag& d) const;
		expr::aptr<32,8> operator[](expr::avptr<32,8> a) const;
		expr::aptr<32,32> operator[](expr::avptr<32,32> a) const;
		bool is_decided() const;
		bool is_unsat() const;
	private:
		bool check_sat(const decltype(assumptions)& assumptions, bool minimize_unsat_prefix);
	public:
		bool check_sat(bool minimize_unsat_prefix);
		void partial_minimize();
		std::uint32_t minimum_value() const;
		std::optional<std::uint64_t> get_value(std::string name);
		std::optional<std::uint64_t> get_value(std::string name, std::uint64_t offset);
		std::map<std::uint64_t,std::uint64_t> get_values(std::string name);
		bool in_unsat_core(const instr& n, std::size_t loopdepth, bool branchtrue);
	};

};

