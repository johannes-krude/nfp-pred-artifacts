#pragma once

#include "estimator/state.hpp"
#include "estimator/thread_pool.hpp"

#include <string>
#include <vector>
#include <deque>
#include <map>
#include <memory>
#include <ostream>
#include <chrono>
#include <cinttypes>


class cfg {
public:
	static unsigned int COST_FIRMWARE;
	static double DRAM_COST_FIRMWARE;
	static std::size_t PARALLELISM;
	static std::size_t UNROLL_LIMIT;
	static std::map<std::uint32_t,std::size_t> UNROLL_LIMITS;
	static std::uint32_t MIN_PACKETSIZE;
	static std::uint32_t MTU;
	static unsigned int NUM_WORKERS;
	static std::uint32_t PACKET_HEADROOM;

	struct DOT;
	struct LONGEST_PATH;
	struct MINIMAL_THROUGHPUT;

private:
	class node;
	using nptr = std::shared_ptr<node>;

public:
	class path;
	using pptr = std::shared_ptr<path>;
	class path {
	public:
		struct cycleratio {
			unsigned int cycles;
			std::uint32_t size;

			cycleratio(unsigned int cycles, std::uint32_t size)
				: cycles(cycles),
				  size(size) {}

			explicit operator double () const {
				return 1.0*this->cycles/this->size;
			}

			bool operator< (const cycleratio& o) const {
				return ((unsigned long) this->cycles) * ((unsigned long) o.size) < ((unsigned long) o.cycles) * ((unsigned long) this->size);
			}

			bool operator== (const cycleratio& o) const {
				return ((unsigned long) this->cycles) * ((unsigned long) o.size) == ((unsigned long) o.cycles) * ((unsigned long) this->size);
			}
		};

		virtual ~path() = default;

		virtual std::string str() const = 0;
		virtual unsigned int min_packetsize() const = 0;
		virtual unsigned int max_cycles() const = 0;
		virtual unsigned int max_cycles(bool branchtrue) const = 0;
		virtual double dram_cycles() const = 0;
		virtual double dram_cycles(bool branchtrue) const = 0;
		struct MAX_CYCLES {
			using value_type = unsigned int;
			static constexpr unsigned int MAX = std::numeric_limits<unsigned int>::max();
			static constexpr unsigned int MIN = std::numeric_limits<unsigned int>::min();
			unsigned int operator()(const pptr& p) {
				if (!p)
					return MIN;
				return p->max_cycles();
			}
			unsigned int operator()(const pptr& p, bool branchtrue) {
				if (!p)
					return MIN;
				return p->max_cycles(branchtrue);
			}
			cycleratio operator()(unsigned int cycles, std::uint32_t size) {
				return cycleratio(cycles, size);
			}
			cycleratio operator()(const pptr& p, std::uint32_t size) {
				if (!p)
					return cycleratio(MIN, -1);
				return cycleratio(p->max_cycles(), size);
			}
			static unsigned int normalize(const pptr& p) {
				if (!p)
					return MIN;
				return p->max_cycles();
			}
			static unsigned int normalize(unsigned v) {
				return v;
			}
			static std::string str() {
				return "CYCLES";
			}
		};
		struct DRAM_CYCLES {
			using value_type = double;
			static constexpr double MAX = std::numeric_limits<double>::max();
			static constexpr double MIN = -std::numeric_limits<double>::infinity();
			double operator()(const pptr& p) {
				if (!p)
					return MIN;
				return p->dram_cycles();
			}
			double operator()(const pptr& p, bool branchtrue) {
				if (!p)
					return MIN;
				return p->dram_cycles(branchtrue);
			}
			double operator()(double dram_cycles, std::uint32_t size) {
				return dram_cycles / size;
			}
			double operator()(const pptr& p, std::uint32_t size) {
				if (!p)
					return MIN/MAX;
				return p->dram_cycles() / size;
			}
			static double normalize(const pptr& p) {
				if (!p)
					return MIN;
				return NUM_WORKERS * p->dram_cycles();
			}
			static double normalize(double v) {
				return NUM_WORKERS * v;
			}
			static std::string str() {
				return "DRAM_CYCLES";
			}
		};

		virtual std::size_t size() const = 0;
		virtual bool is_none() const = 0;
		virtual bool is_decided() const = 0;
		virtual bool is_unsat() const = 0;
		virtual bool may_satcheck(bool branchtrue) const = 0;
		virtual pptr extend(bool branchtrue) = 0;
		virtual pptr check() = 0;
		virtual bool is_same(pptr o) const = 0;
		virtual pptr merge(pptr o) const = 0;

		class none;
		template<class S> class withstate;
		class impossible;
		class possible;
		using iptr = std::shared_ptr<path::impossible>;
	};

private:
	class pathq {
	public:
		class sizet {
		private:
			std::size_t val;
		public:
			static const sizet MAX;// = SIZE_MAX;
			constexpr sizet()
				: val(0) {}
			constexpr sizet(const std::size_t& val)
				: val(val) {}
			constexpr operator std::size_t () const {
				return this->val;
			};
			constexpr sizet operator + (const sizet& o) const {
				if (SIZE_MAX - this->val < o.val) {
					return MAX;
				} else {
					return this->val + o.val;
				}
			};
			constexpr sizet operator + (const std::size_t& o) const {
				return *this + sizet(o);
			};
			constexpr void operator += (const sizet& o) {
				*this = *this + o;
			};
			constexpr sizet operator - (const sizet& o) const {
				if (this->val == SIZE_MAX) {
					return MAX;
				} else if (this->val < o.val) {
					return 0;
				} else {
					return this->val - o.val;
				}
			};
			constexpr sizet operator - (const std::size_t& o) const {
				return *this - sizet(o);
			};
			constexpr void operator -= (const sizet& o) {
				*this = *this - o;
			};
			constexpr bool operator == (const sizet& o) const {
				return this->val == o.val;
			}
			constexpr bool operator < (const sizet& o) const{
				return this->val < o.val;
			}
			constexpr bool operator < (const std::size_t& o) const {
				return *this < sizet(o);
			}
		};
	private:
		std::deque<pptr> paths = {};
		sizet count = 0;
	public:
		pathq() = default;
		pathq(const pptr& p);
		pathq(std::initializer_list<pptr> l);
		void swap(pathq& o);
		sizet size() const;
		auto begin() const;
		auto end() const;
		void push(const pathq& q);
		void push(pathq&& q);
		pptr front() const;
		pptr back() const;
		pptr take();
	};

	class mpathq {
	public:
		class sizev {
			friend mpathq;
			class intersection;
			std::vector<std::pair<std::uint32_t,pathq::sizet>> sizes = {};
		public:
			sizev() = default;
			sizev(const std::pair<std::uint32_t,pathq::sizet>& p);
			void swap(sizev& o);
			std::string str() const;
			sizev& operator << (std::pair<std::uint32_t,pathq::sizet> p);
			std::uint32_t min_packetsize() const;
			std::uint32_t max_packetsize() const;
			const std::vector<std::pair<std::uint32_t,pathq::sizet>>::const_iterator begin() const;
			const std::vector<std::pair<std::uint32_t,pathq::sizet>>::const_iterator end() const;
			pathq::sizet operator [] (const std::uint32_t& s) const;
			sizev operator + (const sizev& o) const;
			sizev operator - (const sizev& o) const;
			sizev operator | (const sizev& o) const;
			sizev operator & (const sizev& o) const;
			sizev operator & (std::uint32_t m) const;
			bool operator < (const sizev& o) const;
			bool operator >= (const sizev& o) const;
		};
	private:
		std::uint32_t min = std::numeric_limits<std::uint32_t>::max();
		std::uint32_t max = 0;
		sizev v = {};
		std::vector<std::optional<pathq>> qs = {};
	public:
		mpathq(const sizev& v);
		mpathq() = default;
		const pathq& operator [] (std::uint32_t s) const;
		void swap(mpathq& o);
		pathq::sizet size(std::uint32_t s) const;
		sizev sizes() const;
		void push(const mpathq& mq);
		void push(mpathq&& mq);
		void push(const pathq& q);
		void push(const pathq& q, std::uint32_t s);
		void push(pathq&& q, std::uint32_t s);
		pptr front(std::uint32_t s) const;
		pptr take(std::uint32_t s);
	};

	template<typename S> class tratio;
	template<typename S> class tpathq;

	template<typename... S> class vmax;
	template<typename... S> class rmax;
	template<typename... S> class ipathq;
	template<typename... S> class itpathq;

	struct instr_data {
		std::shared_ptr<const instr> n;
		state::perf::info i = state::perf::info();
		instr_data(const std::shared_ptr<const instr>& n)
			: n(n) {}
		instr_data(const std::shared_ptr<const instr>& n, state::perf::info i)
			: n(n), i(i) {}
	};
	struct succ_data {
		nptr nd;
		std::vector<instr_data> instructions;
		bool sat_check = false;
		std::uint32_t min_packetsize = cfg::MIN_PACKETSIZE;
		mpathq::sizev sizes = {};
		succ_data()
			: nd(nullptr) {}
		succ_data(nptr nd)
			: nd(nd) {}
		operator bool() const {
			return this->nd != nullptr;
		}

		template<typename S> struct _d {
			pathq q = {};
			mpathq mq = mpathq();
		};
		template<typename S> auto& d() { return std::get<_d<S>>(this->td); };
		template<typename S> auto& q(const S&) { return d<S>().q; };
		template<typename S> auto& mq(const S&) { return d<S>().mq; };
		std::tuple<_d<path::MAX_CYCLES>,_d<path::DRAM_CYCLES>> td = {};
	};

	std::ostream& out;
	std::chrono::time_point<std::chrono::steady_clock> start_time = std::chrono::steady_clock::now();
	unsigned long index = 0;
	std::vector<nptr> nodes;
	succ_data start;
	nptr fin_nd;
	class thread_pool thread_pool;

	void init_nodes(std::string asm_listing);
	void create_edges(nptr nd, std::map<std::uint32_t,nptr> map);
	void remove_unreachable();
	void merge_edges();
	bool is_in_loop(nptr nd);
	std::set<nptr> loopfree_nodes();
	void unroll(std::size_t limit, const std::map<std::uint32_t,std::size_t>& limits);
	void topo_sort();
	void overestimate_cycles();
	template<typename... S> mpathq::sizev propagate_sizes();
	void link_nodes(nptr src, std::uint32_t dst, std::map<std::uint32_t,nptr>& map, bool branchtrue);
	void build_cfg(std::string asm_listing);
	state::exec initial_state();
	template<typename S> pathq next_k(std::size_t k);
	template<typename S> mpathq next_k(const mpathq::sizev& k);
	template<typename S> void push_impossible();
	template<typename S> void push_mimpossible();
	template<typename... S> void report_max(const vmax<S...>& max);
	template<typename... S> void report_max(const rmax<S...>& max);
	void report_path(const pptr p);
	template<typename S> auto underestimate_packetrate();
	template<typename S> auto underestimate_bitrate(const mpathq::sizev& sizes);
	template<typename... S> void enumerate_by_packetrate(std::size_t count);
	template<typename... S> void enumerate_by_bitrate(std::size_t count);

public:
	void enumerate_by_proc_packetrate(std::size_t count);
	void enumerate_by_dram_packetrate(std::size_t count);
	void enumerate_by_packetrate(std::size_t count);
	void enumerate_by_proc_bitrate(std::size_t count);
	void enumerate_by_dram_bitrate(std::size_t count);
	void enumerate_by_bitrate(std::size_t count);
	void save_dot_graph() const;
	void static_analysis(bool sat_check);
	void report_timeout();

	cfg(std::string nfp_asm_listing, std::ostream &out);
	~cfg();
};

