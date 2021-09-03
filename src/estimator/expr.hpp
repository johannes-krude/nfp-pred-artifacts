#pragma once

#include <memory>
#include <limits>
#include <string>
#include <set>
#include <map>
#include <vector>
#include <sstream>
#include <iomanip>
#include <iostream>
#include <algorithm>
#include <utility>
#include <type_traits>


struct expr {
private:
	struct h;
	class virtual_shared;
public:
	template<std::uint8_t B> struct undefined;
	template<std::uint8_t A, std::uint8_t V> struct undefined_array;
	template<class R, class E=std::shared_ptr<const R>> struct unary;
	template<class R, class A=std::shared_ptr<const R>, class B=A> struct binary;
	struct decl;
	struct def;
	class defs;

	struct lexpr;

	struct boolean;
	struct lunary;
	struct lbinary;
	struct negation;
	template<class T> struct equality;
	struct loring;
	struct landing;

	template<class T> struct ifthenelse;

	template<std::uint8_t B> struct bvexpr;
	template<std::uint8_t B> struct bvunary;
	template<std::uint8_t A, std::uint8_t B=A, std::uint8_t R=A> struct bvbinary;

	template<std::uint8_t B> struct bitvector;
	template<std::uint8_t B> struct bvvariable;
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B> struct extraction;

	template<std::uint8_t A, std::uint8_t V> struct bvarray;
	template<std::uint8_t A, std::uint8_t V> struct bvavariable;
	template<std::uint8_t A, std::uint8_t V> struct pointer;
	template<std::uint8_t A, std::uint8_t V, std::uint8_t E> struct pointer_ext;
	template<std::uint8_t A, std::uint8_t V> struct pointer_base;
	template<std::uint8_t A, std::uint8_t V> struct selection;
	template<std::uint8_t A, std::uint8_t V> struct storing;
	template<std::uint8_t A, std::uint8_t V> struct concrete_storing;

	template<std::uint8_t B> struct bvnegation;

	template<std::uint8_t A,std::uint8_t B> struct concatenation;
	template<std::uint8_t B> struct bvcomparison;
	template<std::uint8_t B> struct bvultcomparison;
	template<std::uint8_t B> struct bvulecomparison;
	template<std::uint8_t B> struct bvugtcomparison;
	template<std::uint8_t B> struct bvugecomparison;
	template<std::uint8_t B> struct bvanding;
	template<std::uint8_t B> struct bvoring;
	template<std::uint8_t B> struct bvxoring;
	template<std::uint8_t B> struct bvshiftl;
	template<std::uint8_t B> struct bvlshiftr;
	template<std::uint8_t B> struct bvashiftr;
	template<std::uint8_t B> struct bvrotationl;
	template<std::uint8_t B> struct bvrotationr;
	template<std::uint8_t B> struct bvaddition;
	template<std::uint8_t B> struct bvsubstraction;
	template<std::uint8_t B> struct bvaddition_carry;
	template<std::uint8_t B> struct bvsubstraction_carry;
	template<std::uint8_t B> struct bvmultiplication;

	using eptr = std::shared_ptr<const expr>;
	using lptr = std::shared_ptr<const expr::lexpr>;
	template<std::uint8_t B>
	using bvptr = std::shared_ptr<const expr::bvexpr<B>>;
	using dptr = std::shared_ptr<const expr::decl>;
	template<std::uint8_t A, std::uint8_t V>
	using aptr = std::shared_ptr<const expr::bvarray<A,V>>;
	template<std::uint8_t A, std::uint8_t V>
	using avptr = std::shared_ptr<const expr::bvavariable<A,V>>;

	struct cast {
		static auto lconstant(expr::lptr e) {
			return std::dynamic_pointer_cast<const expr::boolean>(e);
		}

		static auto isfalse(expr::lptr e) {
			return std::dynamic_pointer_cast<const expr::negation>(e);
		}

		template<class T>
		static auto eq(expr::lptr e) {
			return std::dynamic_pointer_cast<const expr::equality<T>>(e);
		}

		static auto lor(expr::lptr e) {
			return std::dynamic_pointer_cast<const expr::loring>(e);
		}

		static auto land(expr::lptr e) {
			return std::dynamic_pointer_cast<const expr::landing>(e);
		}

		template<class T>
		static auto ite(std::shared_ptr<const T> e) {
			return std::dynamic_pointer_cast<const expr::ifthenelse<T>>(e);
		}

		template<std::uint8_t B>
		static auto constant(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bitvector<B>>(e);
		}

		template<std::uint8_t B>
		static auto var(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvvariable<B>>(e);
		}

		template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
		static auto extract(expr::bvptr<S-E+1> e) {
			return std::dynamic_pointer_cast<const expr::extraction<S,E,B>>(e);
		}

		template<std::uint8_t A, std::uint8_t V>
		static auto ptr(expr::bvptr<A> e) {
			return std::dynamic_pointer_cast<const expr::pointer<A,V>>(e);
		}

		template<std::uint8_t A, std::uint8_t V, std::uint8_t E>
		static auto ptr_ext(expr::bvptr<A+E> e) {
			return std::dynamic_pointer_cast<const expr::pointer_ext<A,V,E>>(e);
		}

		template<std::uint8_t A, std::uint8_t V>
		static auto ptr_base(expr::bvptr<A> e) {
			return std::dynamic_pointer_cast<const expr::pointer_base<A,V>>(e);
		}

		template<std::uint8_t A, std::uint8_t V>
		static auto select(expr::bvptr<A> e) {
			return std::dynamic_pointer_cast<const expr::selection<A,V>>(e);
		}

		template<std::uint8_t A, std::uint8_t V>
		static auto store(expr::bvptr<A> e) {
			return std::dynamic_pointer_cast<const expr::storing<A,V>>(e);
		}

		template<std::uint8_t A, std::uint8_t V>
		static auto cstore(expr::bvptr<A> e) {
			return std::dynamic_pointer_cast<const expr::concrete_storing<A,V>>(e);
		}

		template<std::uint8_t B>
		static auto bvnot(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvnegation<B>>(e);
		}

		template<std::uint8_t A,std::uint8_t B>
		static auto concat(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::concatenation<A,B>>(e);
		}

		template<std::uint8_t B>
		static auto bvcomp(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvcomparison<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvult(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvultcomparison<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvule(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvulecomparison<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvugt(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvugtcomparison<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvuge(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvugecomparison<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvand(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvanding<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvor(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvoring<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvxor(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvxoring<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvshl(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvshiftl<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvlshr(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvlshiftr<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvashr(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvashiftr<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvrotl(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvrotationl<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvrotr(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvrotationr<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvadd(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvaddition<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvsub(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvsubstraction<B>>(e);
		}


		template<std::uint8_t B>
		static auto bvadd_carry(expr::bvptr<1> e) {
			return std::dynamic_pointer_cast<const expr::bvaddition_carry<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvsub_carry(expr::bvptr<1> e) {
			return std::dynamic_pointer_cast<const expr::bvsubstraction_carry<B>>(e);
		}

		template<std::uint8_t B>
		static auto bvmul(expr::bvptr<B> e) {
			return std::dynamic_pointer_cast<const expr::bvmultiplication<B>>(e);
		}
	};


	template<std::uint8_t B>
	static expr::bvptr<B> undef() {
		static std::shared_ptr<const struct expr::undefined<B>> undef = std::make_shared<const struct undefined<B>>();
		return undef;
	}

	template<std::uint8_t B>
	static expr::bvptr<B> undef(const std::string& name) {
		return std::make_shared<const struct expr::undefined<B>>(name);
	}

	template<std::uint8_t B>
	static expr::bvptr<B> undef(const std::string& name, expr::eptr e) {
		return std::make_shared<const struct expr::undefined<B>>(name, e);
	}

	template<std::uint8_t A, std::uint8_t V>
	static expr::aptr<A,V> undef_array() {
		static std::shared_ptr<const struct expr::undefined_array<A,V>> undef = std::make_shared<const struct undefined_array<A,V>>();
		return undef;
	}

	template<std::uint8_t A, std::uint8_t V>
	static expr::aptr<A,V> undef_array(const std::string& name) {
		return std::make_shared<const struct expr::undefined_array<A,V>>(name);
	}

	template<std::uint8_t A, std::uint8_t V>
	static expr::aptr<A,V> undef_array(const std::string& name, expr::eptr e) {
		return std::make_shared<const struct expr::undefined_array<A,V>>(name, e);
	}

	static std::shared_ptr<const struct expr::boolean> lconstant(bool value) {
		return std::make_shared<const struct expr::boolean>(value);
	}

	static lptr isfalse(lptr e);

	template<std::uint8_t B>
	static lptr eq(expr::bvptr<B> a, expr::bvptr<B> b);

	static expr::lptr lor(expr::lptr a, expr::lptr b);
	static expr::lptr land(expr::lptr a, expr::lptr b);

	template<class T>
	static std::shared_ptr<const T> ite(expr::lptr l, std::shared_ptr<const T> a, std::shared_ptr<const T> b);

	template<std::uint8_t B> 
	static bvptr<B> constant(std::uint64_t val) {
		return std::make_shared<const struct expr::bitvector<B>>(val);
	}

	template<std::uint8_t B>
	static std::shared_ptr<const struct expr::bvvariable<B>> var(std::string name) {
		return std::make_shared<const struct expr::bvvariable<B>>(name);
	}

	template<std::uint8_t A, std::uint8_t V>
	static std::shared_ptr<const struct expr::pointer<A,V>> ptr(std::string name) {
		return std::make_shared<const struct expr::pointer<A,V>>(name);
	}

	template<std::uint8_t A, std::uint8_t V>
	static std::shared_ptr<const struct expr::pointer<A,V>> ptr(expr::avptr<A,V> array, expr::bvptr<A> offset) {
		return std::make_shared<const struct expr::pointer<A,V>>(array, offset);
	}

	template<std::uint8_t A, std::uint8_t V, std::uint32_t E>
	static std::shared_ptr<const struct expr::pointer_ext<A,V,E>> ptr_ext(expr::avptr<A,V> array, expr::bvptr<A> offset, expr::bvptr<E> ext) {
		return std::make_shared<const struct expr::pointer_ext<A,V,E>>(array, offset,ext);
	}

	template<std::uint8_t A, std::uint8_t V>
	static std::shared_ptr<const struct expr::pointer_base<A,V>> ptr_base(std::string name, std::uint8_t shift) {
		return std::make_shared<const struct expr::pointer_base<A,V>>(name, shift);
	}
	template<std::uint8_t A, std::uint8_t V>
	static std::shared_ptr<const struct expr::pointer_base<A,V>> ptr_base(expr::avptr<A,V> array, std::uint8_t shift, expr::bvptr<A> offset) {
		return std::make_shared<const struct expr::pointer_base<A,V>>(array, shift, offset);
	}

	template<std::uint8_t A, std::uint8_t V>
	static bvptr<V> select(expr::aptr<A,V> array, expr::bvptr<A> offset);

	template<std::uint8_t A, std::uint8_t V>
	static aptr<A,V> store(expr::aptr<A,V> array, expr::bvptr<A> offset, expr::bvptr<V> value);

	template<std::uint8_t E, std::uint8_t B>
	static bvptr<E+B> extend(expr::bvptr<B> e) {
		return concat<E,B>(expr::constant<E>(0), e);
	}

	template<std::uint8_t S, std::uint8_t E=S, std::uint8_t B>
	static bvptr<S-E+1> extract(bvptr<B> e);

	template<std::uint8_t B>
	static bvptr<B> bvnot(bvptr<B> e);

	template<std::uint8_t A, std::uint8_t B>
	static bvptr<A+B> concat(bvptr<A> a, bvptr<B> b);
	template<std::uint8_t A, std::uint8_t B, std::uint8_t C>
	static bvptr<A+B+C> concat(bvptr<A> a, bvptr<B> b, bvptr<A> c) {
		return concat(a, concat<B,C>(b, c));
	}
	template<std::uint8_t A, std::uint8_t B, std::uint8_t C, std::uint8_t D>
	static bvptr<A+B+C+D> concat(bvptr<A> a, bvptr<B> b, bvptr<A> c, bvptr<B> d) {
		return concat(a, concat<B,C,D>(b, c, d));
	}

	template<std::uint8_t B>
	static bvptr<1> bvcomp(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static lptr bvult(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static lptr bvule(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static lptr bvugt(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static lptr bvuge(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvand(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvor(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvxor(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvshl(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvlshr(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvashr(bvptr<B> a, bvptr<B> b) {
		return std::make_shared<const struct expr::bvashiftr<B>>(a, b);
	}

	template<std::uint8_t B>
	static bvptr<B> bvrotl(bvptr<B> e, std::uint8_t i) {
		return std::make_shared<const struct expr::bvrotationl<B>>(e, i);
	}

	template<std::uint8_t B>
	static bvptr<B> bvrotr(bvptr<B> e, std::uint8_t i) {
		return std::make_shared<const struct expr::bvrotationr<B>>(e, i);
	}

	template<std::uint8_t B>
	static expr::bvptr<B> bvadd(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static bvptr<B> bvsub(bvptr<B> a, bvptr<B> b);

	template<std::uint8_t B>
	static expr::bvptr<1> bvadd_carry(bvptr<B> a, bvptr<B> b) {
		return std::make_shared<const struct expr::bvaddition_carry<B>>(a, b);
	}

	template<std::uint8_t B>
	static expr::bvptr<1> bvsub_carry(bvptr<B> a, bvptr<B> b) {
		return std::make_shared<const struct expr::bvsubstraction_carry<B>>(a, b);
	}

	template<std::uint8_t B>
	static bvptr<B> bvmul(bvptr<B> a, bvptr<B> b) {
		return std::make_shared<const struct expr::bvmultiplication<B>>(a, b);
	}

	expr() = default;
	virtual std::string str() const = 0;
	virtual void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const = 0;
	virtual std::string type() const = 0;
	virtual bool operator==(const expr& o) const = 0;
	virtual void defs(expr::defs& d) const = 0;

};

class expr::virtual_shared : public std::enable_shared_from_this<virtual_shared> {
public:
	virtual ~virtual_shared() = default;
};

struct expr::def {
	std::string p;
	unsigned int n;
	eptr e;

	def(std::string p, unsigned int n, eptr e)
		:p(p), n(n), e(e) {};

	virtual void define(std::ostream& out, const class expr::defs& d) const {
		out << "(define-fun " << p << std::to_string(this->n) << " () " << this->e->type() << " ";
		this->e->write(out, d, false);
		out << ")\n";
	}
};

class expr::defs {
public:
	class scoped;
private:
	std::string prefix = "f";
	std::map<eptr,std::pair<std::size_t,std::size_t>> expressions = {};
	std::set<dptr> declarations = {};
	std::set<eptr> undefined = {};
public:
	defs() = default;
	defs(std::string prefix)
		: prefix(prefix + "f") {};
	void add_expr(eptr e) {
		auto [i, inserted] = this->expressions.insert(std::make_pair(e, std::make_pair(this->expressions.size(), 0)));
		i->second.second++;
	}
	bool has_expr(eptr e) const {
		return this->expressions.find(e) != this->expressions.end();
	}
	virtual void add_decl(dptr d) {
		this->declarations.insert(d);
	}
	virtual bool has_decl(dptr d) const {
		return this->declarations.find(d) != this->declarations.end();
	}
	void add_undef(eptr e) {
		this->undefined.insert(e);
	}
	bool has_undef(eptr e) const {
		return this->undefined.find(e) != this->undefined.end();
	}
	std::optional<std::string> defines(eptr e) const {
		const auto& i = this->expressions.find(e);
		if (i == this->expressions.end() || i->second.second < 2)
			return {};
		return prefix + std::to_string(i->second.first);
	}
	const std::set<dptr>& decls() {
		return this->declarations;
	}
	const std::set<eptr>& undef() {
		return this->undefined;
	}
	std::vector<std::shared_ptr<const expr::def>> def() {
		std::size_t size = 0;
		for (const auto& i: this->expressions) {
			if (i.second.second >= 2)
				size += 1;
		}

		std::vector<std::shared_ptr<const expr::def>> r;
		r.reserve(size);
		for (const auto& i: this->expressions) {
			if (i.second.second >= 2)
				r.push_back(std::make_shared<const expr::def>(prefix, i.second.first, i.first));
		}
		std::sort(r.begin(), r.end(), [](std::shared_ptr<const expr::def>& a, std::shared_ptr<const expr::def>& b) {
			return a->n < b->n;
		});

		return r;
	}
};

class expr::defs::scoped : public expr::defs {
private:
	std::shared_ptr<const class expr::defs> parent;
public:
	scoped(std::string prefix, std::shared_ptr<const class expr::defs> parent)
		: defs(prefix),
		  parent(parent) {}
	void add_decl(dptr d) override {
		if (parent->has_decl(d)) {
			return;
		}
		defs::add_decl(d);
	}
	bool has_decl(dptr d) const override {
		return defs::has_decl(d) || parent->has_decl(d);
	}
};

template<class R, class E=std::shared_ptr<const R>>
struct expr::unary : public R {
	E e;

	unary(E e)
		: e(e) {}
	virtual std::string name() const = 0;
	std::string str() const override {
		return "(" + name() + " " + this->e->str() + ")";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "(" << name() << " ";
		this->e->write(out, d);
		out << ")";
	};
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::unary<R,E>* u = static_cast<const expr::unary<R,E>*>(&o);
		return *this->e == *u->e;
	}
	void defs(class expr::defs& d) const override {
		this->e->defs(d);
	}
};

template<class R, class A=std::shared_ptr<const R>, class B=A>
struct expr::binary : public R {
	A a;
	B b;

	binary(A a, B b)
		: a(a),
	  	  b(b) {}
	virtual std::string name() const = 0;
	std::string str() const override {
		return "(" + name() + " " + this->a->str() + " " + this->b->str() + ")";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		std::optional<std::string> s;
		if (use_f)
			s = d.defines(this->shared_expr_from_this());
		if (s) {
			out << *s;
			return;
		}
		out <<"(" << name() << " ";
		this->a->write(out, d);
		out << " ";
		this->b->write(out, d);
		out << ")";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::binary<R,A,B>* b = static_cast<const expr::binary<R,A,B>*>(&o);
		return *this->a == *b->a && *this->b == *b->b;
	}
	void defs(class expr::defs& d) const override {
		if (!d.has_expr(this->shared_expr_from_this())) {
			this->a->defs(d);
			this->b->defs(d);
		}
		d.add_expr(this->shared_expr_from_this());
	}
};

struct expr::lexpr : public expr, public virtual virtual_shared {
	eptr shared_expr_from_this() const {
		return std::dynamic_pointer_cast<const expr>(shared_from_this());
	}
	lptr shared_lexpr_from_this() const {
		return std::dynamic_pointer_cast<const lexpr>(shared_from_this());
	}
	using expr::expr;
	std::string type() const override {
		return "Bool";
	}
	virtual void assert(std::ostream& out, const class expr::defs& d) const {
		out << "(assert (! ";
		write(out, d);
		out << "))\n";
	}
	virtual void assert(std::ostream& out, std::string name, const class expr::defs& d) const {
		out << "(assert (! ";
		write(out, d);
		out << " :named " << name << "))\n";
	}

	virtual bool t_lor(expr::lptr& r, expr::lptr o) const {
		return false;
	}
	virtual bool t_land(expr::lptr& r, expr::lptr o) const {
		return false;
	}
};

struct expr::boolean : public expr::lexpr {
	bool value;
	boolean(bool value)
		: value(value) {}
	std::string str() const override {
		if (this->value) {
			return "true";
		} else {
			return "false";
		}
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << str();
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const struct expr::boolean* b = static_cast<const struct expr::boolean*>(&o);
		return this->value == b->value;
	}
	void defs(class expr::defs& d) const override {
	}

	bool t_lor(expr::lptr& r, expr::lptr o) const override {
		if (this->value) {
			r = shared_lexpr_from_this();
		} else {
			r = o;
		}
		return true;
	}
	bool t_land(expr::lptr& r, expr::lptr o) const override {
		if (this->value) {
			r = o;
		} else {
			r = shared_lexpr_from_this();
		}
		return true;
	}
};

struct expr::lunary : public unary<lexpr> {
	using unary<lexpr>::unary;
};

struct expr::lbinary : public binary<lexpr> {
	using binary<lexpr>::binary;
};

struct expr::negation : public lunary {
	using lunary::lunary;
	std::string name() const override {
		return "not";
	};
};

template<class T>
struct expr::equality : public binary<lexpr,T> {
	using binary<lexpr,T>::binary;
	std::string name() const override {
		return "=";
	}
};

struct expr::loring : public lbinary {
	using lbinary::lbinary;
	std::string name() const override {
		return "or";
	}
};

struct expr::landing : public lbinary {
	using lbinary::lbinary;
	std::string name() const override {
		return "and";
	}
};

template<class T>
struct expr::ifthenelse : public T {
	expr::lptr l;
	std::shared_ptr<const T> a;
	std::shared_ptr<const T> b;
	ifthenelse(expr::lptr l, std::shared_ptr<const T> a, std::shared_ptr<const T> b)
		: l(l),
		  a(a),
		  b(b) {}
	std::string str() const override {
		return "(ite " + this->l->str() + " " + this->a->str() + " " + this->b->str() + ")";
	}
	virtual void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		std::optional<std::string> s;
		if (use_f)
			s = d.defines(this->shared_expr_from_this());
		if (s) {
			out << *s;
			return;
		}
		out << "(ite ";
		this->l->write(out, d);
		out << " ";
		this->a->write(out, d);
		out << " ";
		this->b->write(out, d);
		out << ")";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::ifthenelse<T>* i = static_cast<const expr::ifthenelse<T>*>(&o);
		return *this->l == *i->l && *this->a == *i->a && *this->b == *i->b;
	}
	void defs(class expr::defs& d) const override {
		if (!d.has_expr(this->shared_expr_from_this())) {
			this->l->defs(d);
			this->a->defs(d);
			this->b->defs(d);
		}
		d.add_expr(this->shared_expr_from_this());
	}
};


template<std::uint8_t B>
struct expr::bvexpr : public expr, public virtual virtual_shared {
	bvptr<B> shared_bvexpr_from_this() const {
		return std::dynamic_pointer_cast<const bvexpr<B>>(shared_from_this());
	}
	eptr shared_expr_from_this() const {
		return std::dynamic_pointer_cast<const expr>(shared_from_this());
	}

	using expr::expr;
	std::string type() const override {
		return "(_ BitVec " + std::to_string(B) + ")";
	}
	virtual std::string minimize() const {
		return "(minimize " + this->str() + ")\n";
	}
	virtual expr::bvptr<B> static_merge(expr::bvptr<B> o) const {
		if (*this == *o)
			return this->shared_bvexpr_from_this();
		return undef<B>();
	}
};

template<std::uint8_t B>
struct expr::undefined : public bvexpr<B> {
	std::string name;
	expr::eptr e;
	undefined() :
		name(""), e(nullptr) {}
	undefined(const std::string& name)
		: name(name), e(nullptr) {}
	undefined(const std::string& name, expr::eptr e)
		: name(name), e(e) {}
	std::string str() const override {
		std::string str = "(undefined";
		if (!name.empty())
			str += " " + name;
		if (e)
			str += " " + e->str();
		str += ")";
		return str;
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "(undefined";
		if (!name.empty())
			out << " " << name;
		if (e) {
			out << " ";
			e->write(out, d);
		}
		out << ")";
	}
	bool operator==(const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		return false;
	}
	void defs(class expr::defs& d) const override {
		d.add_undef(this->shared_expr_from_this());
		if (e)
			e->defs(d);
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::undefined_array : public bvarray<A,V> {
	std::string name;
	expr::eptr e;
	undefined_array() :
		name(""), e(nullptr) {}
	undefined_array(const std::string& name)
		: name(name), e(nullptr) {}
	undefined_array(const std::string& name, expr::eptr e)
		: name(name), e(e) {}
	std::string str() const override {
		std::string str = "(undefined";
		if (!name.empty())
			str += " " + name;
		if (e)
			str += " " + e->str();
		str += ")";
		return str;
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "(undefined";
		if (!name.empty())
			out << " " << name;
		if (e) {
			out << " ";
			e->write(out, d);
		}
		out << ")";
	}
	bool operator==(const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		return false;
	}
	void defs(class expr::defs& d) const override {
		d.add_undef(this->shared_bvarray_from_this());
		if (e)
			e->defs(d);
	}
};

template<std::uint8_t B>
struct expr::bvunary : public unary<bvexpr<B>> {
	using unary<bvexpr<B>>::unary;
};

template<std::uint8_t A, std::uint8_t B=A, std::uint8_t R=A>
struct expr::bvbinary : public binary<bvexpr<R>,bvptr<A>,bvptr<B>> {
	using binary<bvexpr<R>,bvptr<A>,bvptr<B>>::binary;
};

template<std::uint8_t B>
struct expr::bitvector : public bvexpr<B> {
	static_assert(B <= 64);

	std::uint64_t value;
	bitvector(std::uint64_t value)
		: value(B < 64 ? value & ((1LU<<B)-1) : value) {}

	std::string str() const override;
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << str();
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::bitvector<B>* b = static_cast<const expr::bitvector<B>*>(&o);
		return this->value == b->value;
	}
	virtual bool operator< (const expr::bitvector<B>& b) const {
		return this->value < b.value;
	}
	void defs(class expr::defs& d) const override {
	}
};

template<>
struct expr::bitvector<65> : public bvexpr<65> {
	std::uint64_t valueH;
	std::uint64_t valueL;
	bitvector(std::uint64_t valueH, std::uint64_t valueL)
		: valueH(valueH & 1),
		  valueL(valueL) {}

	std::string str() const override;
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::bitvector<65>* b = static_cast<const expr::bitvector<65>*>(&o);
		return this->valueH == b->valueH && this->valueL == b->valueL;
	}
	virtual bool operator< (const expr::bitvector<65>& b) const {
		return this->valueH < b.valueH || (this->valueH == b.valueH && this->valueL < b.valueL);
	}
	void defs(class expr::defs& d) const override {
	}
};

template<> inline std::string expr::bitvector<1>::str() const {
	if (this->value) {
		return "#b1";
	} else {
		return "#b0";
	}
}

template<> inline std::string expr::bitvector<8>::str() const {
	std::stringstream s;
	s << std::string("#x") << std::setfill('0') << std::setw(2) << std::hex << this->value;
	return s.str();
}

template<> inline std::string expr::bitvector<16>::str() const {
	std::stringstream s;
	s << std::string("#x") << std::setfill('0') << std::setw(4) << std::hex << this->value;
	return s.str();
}

template<> inline std::string expr::bitvector<24>::str() const {
	std::stringstream s;
	s << std::string("#x") << std::setfill('0') << std::setw(6) << std::hex << this->value;
	return s.str();
}

template<> inline std::string expr::bitvector<32>::str() const {
	std::stringstream s;
	s << std::string("#x") << std::setfill('0') << std::setw(8) << std::hex << this->value;
	return s.str();
}

template<> inline std::string expr::bitvector<64>::str() const {
	std::stringstream s;
	s << std::string("#x") << std::setfill('0') << std::setw(16) << std::hex << this->value;
	return s.str();
}

//template<> inline std::string expr::bitvector<65>::str() const {
//	std::stringstream s;
//	s << std::string("#b") << std::setfill('0') << std::setw(65) << std::bin << this->value;
//	return s.str();
//}

template<std::uint8_t B> std::string expr::bitvector<B>::str() const {
	return "(_ bv" + std::to_string(value) + " " + std::to_string(B) + ")";
}

struct expr::decl : public virtual virtual_shared {
	const std::string declname;

	dptr shared_decl_from_this() const {
		return std::dynamic_pointer_cast<const decl>(shared_from_this());
	}

	decl(std::string name)
		: declname(name) {}
	virtual std::string str() const {
		return this->declname;
	}
	virtual std::string declare() const = 0;
	virtual void defs(class expr::defs& d) const {
		d.add_decl(shared_decl_from_this());
	}
};

template<std::uint8_t B>
struct expr::bvvariable : public decl, public bvexpr<B> {
	using decl::decl;
	std::string str() const override {
		return decl::str();
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << str();
	}
	std::string declare() const override {
		return "(declare-const " + this->declname + " " + this->type() + ")\n";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::bvvariable<B>* d = static_cast<const expr::bvvariable<B>*>(&o);
		return this->declname == d->declname;
	}
	void defs(class expr::defs& d) const override {
		decl::defs(d);
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::bvarray : public expr, public virtual virtual_shared {
	aptr<A,V> shared_bvarray_from_this() const {
		return std::dynamic_pointer_cast<const bvarray<A,V>>(shared_from_this());
	}
	eptr shared_expr_from_this() const {
		return std::dynamic_pointer_cast<const expr>(shared_from_this());
	}
	std::string type() const override {
		return "(Array (_ BitVec " + std::to_string(A) + ") (_ BitVec " + std::to_string(V) + "))";
	}
	virtual expr::aptr<A,V> static_merge(expr::aptr<A,V> o) const {
		if (*this == *o)
			return this->shared_bvarray_from_this();
		return undef_array<A,V>();
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::bvavariable : public decl, public bvarray<A,V> {
	using decl::decl;
	std::string str() const override {
		return decl::str();
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << str();
	}
	std::string declare() const override {
		return "(declare-const " + this->declname + " " + this->type() + ")\n";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::bvavariable<A,V>* d = static_cast<const expr::bvavariable<A,V>*>(&o);
		return this->declname == d->declname;
	}
	void defs(class expr::defs& d) const override {
		decl::defs(d);
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::pointer : public expr::bvexpr<A> {
	expr::avptr<A,V> array;
	expr::bvptr<A> offset;

	pointer(expr::avptr<A,V> array, expr::bvptr<A> offset)
		: array(array),
		  offset(offset) {}
	pointer(std::string name)
		: pointer(std::make_shared<const expr::bvavariable<A,V>>(name), expr::constant<A>(0)) {}
	std::string str() const override {
		return "&" + this->array->declname + "[" + this->offset->str() + "]";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "&" << this->array->declname << "[";
		this->offset->write(out, d);
		out << "]";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::pointer<A,V>* p = static_cast<const expr::pointer<A,V>*>(&o);
		return *this->array == *p->array && *offset == *p->offset;
	}
	void defs(class expr::defs& d) const override {
	}
};

template<std::uint8_t A, std::uint8_t V, std::uint8_t E>
struct expr::pointer_ext : public expr::bvexpr<A+E> {
	expr::avptr<A,V> array;
	expr::bvptr<A> offset;
	expr::bvptr<E> ext;

	pointer_ext(expr::avptr<A,V> array, expr::bvptr<A> offset, expr::bvptr<E> ext)
		: array(array),
		  offset(offset),
		  ext(ext) {}
	std::string str() const override {
		return "&" + this->array->declname + "[" + this->ext->str() + ", " + this->offset->str() + "]";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "&" << this->array->declname << "[";
		this->ext->write(out, d);
		out << ", ";
		this->offset->write(out, d);
		out << "]";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::pointer_ext<A,V,E>* p = static_cast<const expr::pointer_ext<A,V,E>*>(&o);
		return *this->array == *p->array && *offset == *p->offset && *ext == *p->ext;
	}
	void defs(class expr::defs& d) const override {
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::pointer_base : public expr::bvexpr<A> {
	expr::avptr<A,V> array;
	std::uint8_t shift;
	expr::bvptr<A> offset;

	pointer_base(expr::avptr<A,V> array, std::uint8_t shift, expr::bvptr<A> offset)
		: array(array),
		  shift(shift),
		  offset(offset) {}
	pointer_base(std::string name, std::uint8_t shift)
		: pointer_base(std::make_shared<const expr::bvavariable<A,V>>(name), shift, expr::constant<A>(0)) {}
	std::string str() const override {
		return "&" + this->array->declname + "[" + this->offset->str() + "]>>" + std::to_string(shift);
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override{
		out << str();
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::pointer_base<A,V>* p = static_cast<const expr::pointer_base<A,V>*>(&o);
		return *this->array == *p->array && this->shift == p->shift && *this->offset == *p->offset;
	}
	void defs(class expr::defs& d) const override {
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::selection : public expr::bvexpr<V> {
	expr::aptr<A,V> array;
	expr::bvptr<A> offset;
	selection(std::shared_ptr<const struct expr::bvarray<A,V>> array, expr::bvptr<A> offset)
		: array(array),
		  offset(offset) {}
	std::string str() const override {
		return "(select " + this->array->str() + " " + this->offset->str() + ")";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		std::optional<std::string> s;
		if (use_f)
			s = d.defines(this->shared_expr_from_this());
		if (s) {
			out << *s;
			return;
		}
		out << "(select ";
		this->array->write(out, d);
		out << " ";
		this->offset->write(out, d);
		out << ")";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::selection<A,V>* s = static_cast<const expr::selection<A,V>*>(&o);
		return *this->array == *s->array && *offset == *s->offset;
	}
	void defs(class expr::defs& d) const override {
		if (!d.has_expr(this->shared_expr_from_this())) {
			this->array->defs(d);
			this->offset->defs(d);
		}
		d.add_expr(this->shared_expr_from_this());
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::storing : public expr::bvarray<A,V> {
	expr::aptr<A,V> array;
	expr::bvptr<A> offset;
	expr::bvptr<V> value;
	storing(expr::aptr<A,V> array, expr::bvptr<A> offset, expr::bvptr<V> value)
		: array(array),
		  offset(offset),
		  value(value) {}
	std::string str() const override {
		return "(store " + this->array->str() + " " + this->offset->str() + " " + this->value->str() + ")";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		std::optional<std::string> s;
		if (use_f)
			s = d.defines(this->shared_bvarray_from_this());
		if (s) {
			out << *s;
			return;
		}
		out << "(store ";
		this->array->write(out, d);
		out << " ";
		this->offset->write(out, d);
		out << " ";
		this->value->write(out, d);
		out << ")";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::storing<A,V>* s = static_cast<const expr::storing<A,V>*>(&o);
		return *this->array == *s->array && *this->offset == *s->offset && *this->value == *s->value;
	}
	void defs(class expr::defs& d) const override {
		if (!d.has_expr(this->shared_bvarray_from_this())) {
			this->array->defs(d);
			this->offset->defs(d);
			this->value->defs(d);
		}
		d.add_expr(this->shared_bvarray_from_this());
	}
};

template<std::uint8_t A, std::uint8_t V>
struct expr::concrete_storing : public expr::bvarray<A,V> {
	expr::aptr<A,V> array;
	const std::map<const expr::bitvector<A>,expr::bvptr<V>> map;
	concrete_storing(expr::aptr<A,V> array, const expr::bitvector<A>& offset, expr::bvptr<V> value)
		: array(array),
		  map({std::make_pair(offset, value)}) {}
	concrete_storing(expr::aptr<A,V> array, const std::map<const expr::bitvector<A>,expr::bvptr<V>>& map)
		: array(array),
		  map(map) {}
	concrete_storing(std::shared_ptr<const expr::concrete_storing<A,V>> s, const expr::bitvector<A> offset, expr::bvptr<V> value)
		: array(s->array),
		  map([=] () -> std::map<const expr::bitvector<A>,expr::bvptr<V>> {
			std::map<const expr::bitvector<A>,expr::bvptr<V>> m = s->map;
			m[offset] = value;
			return m;
		  }()) {}
	std::string str() const override {
		std::string s = this->array->str();
		for (auto& m: this->map)
			s = "(store " + s + " " + m.first.str() + " " + m.second->str() + ")";
		return s;
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		std::optional<std::string> s;
		if (use_f)
			s = d.defines(this->shared_bvarray_from_this());
		if (s) {
			out << *s;
			return;
		}
		for (size_t i = 0; i < this->map.size(); i++)
			out << "(store ";
		this->array->write(out, d);
		for (auto& m: this->map) {
			m.first.write(out, d);
			out << " ";
			m.second->write(out, d);
			out << ")";
		}
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const expr::concrete_storing<A,V>* s = static_cast<const expr::concrete_storing<A,V>*>(&o);
		return
			*this->array == *s->array &&
			std::equal(this->map.begin(), this->map.end(), s->map.begin(), [](auto& a, auto& b) {
				return a.first.value == b.first.value && *a.second == *b.second;
			});
	}
	void defs(class expr::defs& d) const override {
		if (!d.has_expr(this->shared_bvarray_from_this())) {
			this->array->defs(d);
			for (auto& m: this->map)
				m.second->defs(d);
		}
		d.add_expr(this->shared_bvarray_from_this());
	}
	expr::aptr<A,V> static_merge(expr::aptr<A,V> o) const override {
		if (*this == *o)
			return this->shared_bvarray_from_this();
		std::shared_ptr<const expr::concrete_storing<A,V>> s = std::dynamic_pointer_cast<const expr::concrete_storing<A,V>>(o);
		if (!s)
			return undef_array<A,V>();
		expr::aptr<A,V> a = this->array->static_merge(s->array);
		std::map<const expr::bitvector<A>,expr::bvptr<V>> m;
		auto i = this->map.begin();
		auto j = s->map.begin();
		while (i != this->map.end() || j != s->map.end()) {
			if (i == this->map.end()) {
				m[j->first] = undef<V>();
				j++;
			} else if (j == s->map.end()) {
				m[i->first] = undef<V>();
				i++;
			} else if (i->first < j->first) {
				m[i->first] = undef<V>();
				i++;
			} else if (j->first < i->first) {
				m[j->first] = undef<V>();
				j++;
			} else {
				m[i->first] = i->second->static_merge(j->second);
				i++;
				j++;
			}
		}
		return std::make_shared<const expr::concrete_storing<A,V>>(a, m);
	}
};

template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
struct expr::extraction : public bvexpr<S-E+1> {
	static_assert(B >= S-E+1);

	expr::bvptr<B> e;

	extraction(expr::bvptr<B> e)
		: e(e) {}
	std::string str() const override {
		return "((_ extract " + std::to_string(S) + " " + std::to_string(E) + ") " + this->e->str() + ")";
	}
	void write(std::ostream& out, const class expr::defs& d, bool use_f=true) const override {
		out << "((_ extract " << std::to_string(S) << " " << std::to_string(E) << ") ";
		this->e->write(out, d);
		out << ")";
	}
	bool operator== (const expr& o) const override {
		if (this == &o)
			return true;
		if (typeid(*this) != typeid(o))
			return false;
		const struct expr::extraction<S,E,B>* e = static_cast<const struct expr::extraction<S,E,B>*>(&o);
		return *this->e == *e->e;
	}
	void defs(class expr::defs& d) const override {
		this->e->defs(d);
	}
};

template<std::uint8_t B>
struct expr::bvnegation : public bvunary<B> {
	using bvunary<B>::bvunary;
	std::string name() const override {
		return "bvnot";
	}
};

template<std::uint8_t A, std::uint8_t B>
struct expr::concatenation : public bvbinary<A,B,A+B> {
	using bvbinary<A,B,A+B>::bvbinary;
	std::string name() const override {
		return "concat";
	}
	expr::bvptr<A+B> static_merge(expr::bvptr<A+B> o) const override {
		if (*this == *o)
			return this->shared_bvexpr_from_this();
		std::shared_ptr<const concatenation<A,B>> c = std::dynamic_pointer_cast<const concatenation<A,B>>(o);
		if (!c)
			return undef<A+B>();
		return concat(this->a->static_merge(c->a), this->b->static_merge(c->b));
	}
};

template<std::uint8_t B>
struct expr::bvcomparison : public bvbinary<B,B,1> {
	using bvbinary<B,B,1>::bvbinary;
	std::string name() const override {
		return "bvcomp";
	}
};

template<std::uint8_t B>
struct expr::bvultcomparison : public binary<lexpr,bvptr<B>> {
	using binary<lexpr,bvptr<B>>::binary;
	std::string name() const override {
		return "bvult";
	}
};

template<std::uint8_t B>
struct expr::bvulecomparison : public binary<lexpr,bvptr<B>> {
	using binary<lexpr,bvptr<B>>::binary;
	std::string name() const override {
		return "bvule";
	}
};

template<std::uint8_t B>
struct expr::bvugtcomparison : public binary<lexpr,bvptr<B>> {
	using binary<lexpr,bvptr<B>>::binary;
	std::string name() const override {
		return "bvugt";
	}
};

template<std::uint8_t B>
struct expr::bvugecomparison : public binary<lexpr,bvptr<B>> {
	using binary<lexpr,bvptr<B>>::binary;
	std::string name() const override {
		return "bvuge";
	}
};

template<std::uint8_t B>
struct expr::bvanding : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvand";
	}
};

template<std::uint8_t B>
struct expr::bvoring : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvor";
	}
};

template<std::uint8_t B>
struct expr::bvxoring : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvxor";
	}
};

template<std::uint8_t B>
struct expr::bvshiftl : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvshl";
	}
};

template<std::uint8_t B>
struct expr::bvlshiftr : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvlshr";
	}
};

template<std::uint8_t B>
struct expr::bvashiftr : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvashr";
	}
};

template<std::uint8_t B>
struct expr::bvrotationl : public bvunary<B> {
	std::uint8_t i;
	bvrotationl(expr::bvptr<B> e, std::uint8_t i)
		: bvunary<B>(e),
		  i(i) {}
	std::string name() const override {
		return "(_ rotate_left "+std::to_string(this->i)+")";
	}
};

template<std::uint8_t B>
struct expr::bvrotationr : public bvunary<B> {
	std::uint8_t i;
	bvrotationr(expr::bvptr<B> e, std::uint8_t i)
		: bvunary<B>(e),
		  i(i) {}
	std::string name() const override {
		return "(_ rotate_right "+std::to_string(this->i)+")";
	}
};

template<std::uint8_t B>
struct expr::bvaddition : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvadd";
	}
};

template<std::uint8_t B>
struct expr::bvsubstraction : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvsub";
	}
};

template<std::uint8_t B>
struct expr::bvaddition_carry : public bvbinary<B,B,1> {
	using bvbinary<B,B,1>::bvbinary;
	std::string name() const override {
		return "bvadd_carry";
	}
};

template<std::uint8_t B>
struct expr::bvsubstraction_carry : public bvbinary<B,B,1> {
	using bvbinary<B,B,1>::bvbinary;
	std::string name() const override {
		return "bvsub_carry";
	}
};

template<std::uint8_t B>
struct expr::bvmultiplication : public bvbinary<B> {
	using bvbinary<B>::bvbinary;
	std::string name() const override {
		return "bvmul";
	}
};

struct expr::h {
	template<bool> struct Range;

	template<std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct BVUGEConcatConstant {
		static bool t(expr::lptr& r, expr::bvptr<B> a, std::shared_ptr<const expr::bitvector<B>> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X>
	struct BVUGEConcatConstant<B,X, Range<(X < B && ((B == 64 && X == 31) || (B == 33 && X == 19)))>> {
		static bool t(expr::lptr& r, expr::bvptr<B> a, std::shared_ptr<const expr::bitvector<B>> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			std::shared_ptr<const expr::bitvector<X>> ba;
			if (ca)
				ba = std::dynamic_pointer_cast<const expr::bitvector<X>>(ca->a);
			if (ba) {
				std::uint64_t vb = b->value >> (B-X);
				if (ba->value > vb) {
					r = expr::lconstant(true);
				} else if (ba->value < vb) {
					r = expr::lconstant(false);
				} else {
					r = expr::bvuge<B-X>(ca->b, expr::constant<B-X>(b->value & ((1UL<<(B-X))-1)));
				}
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct BVULTConcatConstant {
		static bool t(expr::lptr& r, expr::bvptr<B> a, std::shared_ptr<const expr::bitvector<B>> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X>
	struct BVULTConcatConstant<B,X, Range<(X < B && ((B == 64 && X == 31) || (B == 33 && X == 19)))>> {
		static bool t(expr::lptr& r, expr::bvptr<B> a, std::shared_ptr<const expr::bitvector<B>> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			std::shared_ptr<const expr::bitvector<X>> ba;
			if (ca)
				ba = std::dynamic_pointer_cast<const expr::bitvector<X>>(ca->a);
			if (ba) {
				std::uint64_t vb = b->value >> (B-X);
				if (ba->value < vb) {
					r = expr::lconstant(true);
				} else if (ba->value > vb) {
					r = expr::lconstant(false);
				} else {
					r = expr::bvult<B-X>(ca->b, expr::constant<B-X>(b->value & ((1UL<<(B-X))-1)));
				}
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, typename = Range<true>>
	struct ExtractConstant {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
	struct ExtractConstant<S,E,B, Range<B <= 64>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::bitvector<B>> ce = std::dynamic_pointer_cast<const expr::bitvector<B>>(e);
			if (ce) {
				r = expr::constant<S-E+1>(ce->value >> E);
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, typename = Range<true>>
	struct ExtractFull {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
	struct ExtractFull<S,E,B, Range<(S+1 == B && E == 0)>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			r = e;
			return true;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t V, typename = Range<true>>
	struct ExtractPointerExt {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t V>
	struct ExtractPointerExt<S,E,B,V, Range<B == 64 && E == 0 && S == 31>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			auto p = expr::cast::ptr_ext<S+1,V,B-S-1>(e);
			if (p) {
				r = expr::ptr<S+1,V>(p->array, p->offset);
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t V>
	struct ExtractPointerExt<S,E,B,V, Range<B == 64 && E == 32 && S == 63>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			auto p = expr::cast::ptr_ext<E,V,S-E+1>(e);
			if (p) {
				r = p->ext;
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O, typename = Range<true>>
	struct ExtractExtractLeft {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
	struct ExtractExtractLeft<S,E,B,O, Range<((std::numeric_limits<std::uint8_t>::max)()-B > O && (std::numeric_limits<std::uint8_t>::max)()+S > 0 && ((S==E && S == B-1 && B%32 == 1) || (B%8 == 0 && B <= 32)))>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::extraction<B+O-1,O,B+O>> ee = std::dynamic_pointer_cast<const expr::extraction<B+O-1,O,B+O>>(e);
			if (ee) {
				r = expr::extract<S+O,E+O,B+O>(ee->e);
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O, typename = Range<true>>
	struct ExtractExtractRight {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
	struct ExtractExtractRight<S,E,B,O, Range<((std::numeric_limits<std::uint8_t>::max)()-B > O && B%8 == 0 && B<=32)>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::extraction<B-1,0,B+O>> ee = std::dynamic_pointer_cast<const expr::extraction<B-1,0,B+O>>(e);
			if (ee) {
				r = expr::extract<S,E,B+O>(ee->e);
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O, typename = Range<true>>
	struct ExtractConcatLeft {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
	struct ExtractConcatLeft<S,E,B,O, Range<(B > O && E >= O && B%8 == 0 && B<=64)>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::concatenation<B-O,O>> c = std::dynamic_pointer_cast<const expr::concatenation<B-O,O>>(e);
			if (c) {
				r = extract<S-O,E-O,B-O>(c->a);
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
	struct ExtractConcatLeft<S,E,B,O, Range<(B > O && S >= O && E < O && ((B%8 == 0 && B<=64 && O%8 == 0) || (B==65 && E == 0)))>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::concatenation<B-O,O>> c = std::dynamic_pointer_cast<const expr::concatenation<B-O,O>>(e);
			if (c) {
				r = expr::concat(extract<S-O,0,B-O>(c->a), extract<O-1,E,O>(c->b));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O, typename = Range<true>>
	struct ExtractConcatRight {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
	struct ExtractConcatRight<S,E,B,O, Range<(B-S-1 >= O && B<=64)>> {
		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
			std::shared_ptr<const expr::concatenation<O,B-O>> c = std::dynamic_pointer_cast<const expr::concatenation<O,B-O>>(e);
			if (c) {
				r = extract<S,E,B-O>(c->b);
				return true;
			}
			return false;
		}
	};
//	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, std::uint8_t O>
//	struct ExtractConcatRight<S,E,B,O, Range<(B-S-1 < O && B<=64)>> {
//		static bool t(expr::bvptr<S-E+1>& r, expr::bvptr<B> e) {
//			std::shared_ptr<const expr::concatenation<O,B-O>> c = std::dynamic_pointer_cast<const expr::concatenation<O,B-O>>(e);
//			if (c) {
//				r = expr::concat<S-E+1-B+O,B-O>(expr::extract<S-B+O,0,O>(c->a), c->b);
//				return true;
//			}
//			return false;
//		}
//	};

	template<std::uint8_t A,std::uint8_t B, std::uint8_t V, typename = Range<true>>
	struct ConcatPointer {
		static bool t(expr::bvptr<A+B>& r, expr::bvptr<A> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t A, std::uint8_t B, std::uint8_t V>
	struct ConcatPointer<A,B,V,Range<(A == 32 && B == 32)>> {
		static bool t(expr::bvptr<A+B>& r, expr::bvptr<A> a, expr::bvptr<B> b) {
			auto pb = expr::cast::ptr<B,V>(b);
			if (pb) {
				r = expr::ptr_ext<B,V,A>(pb->array, pb->offset, a);
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t A,std::uint8_t B, typename = Range<true>>
	struct ConcatConstants {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, std::shared_ptr<const expr::bitvector<B>> cb) {
			return false;
		}
	};
	template<std::uint8_t A, std::uint8_t B>
	struct ConcatConstants<A,B, Range<(A+B <= 64 && A <= 64 && B <= 64)>> {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, std::shared_ptr<const expr::bitvector<B>> cb) {
			r = expr::constant<A+B>((ca->value<<B) + cb->value);
			return true;
		}
	};

	template<std::uint8_t A, std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct ConcatMergeConstants {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t A, std::uint8_t B, std::uint8_t X>
	struct ConcatMergeConstants<A,B,X, Range<(A+B <= 64 && B > X && A <= 64 && B <= 64 && (A+B)%8 >= 1 && ((A%8 == 0 && B%8 == 0 && A <= 32) || A == 1 || A == 31))>> {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> cxb = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(b);
			if (cxb) {
				std::shared_ptr<const expr::bitvector<X>> bca = std::dynamic_pointer_cast<const expr::bitvector<X>>(cxb->a);
				if (bca) {
					r = expr::concat<A+X, B-X>(expr::constant<A+X>((ca->value<<X) + bca->value), cxb->b);
					return true;
				}
			}
			return false;
		}
	};

	template<std::uint8_t A, std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct ConcatPullExtract {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t A, std::uint8_t B, std::uint8_t X>
	struct ConcatPullExtract<A,B,X, Range<(X+A+B <= 65 && X <= 65 && A <= 65 && B <= 65)>> {
		static bool t(expr::bvptr<A+B>& r, std::shared_ptr<const expr::bitvector<A>> ca, expr::bvptr<B> b) {
			std::shared_ptr<const expr::extraction<X+B-1,X,X+B>> eb = std::dynamic_pointer_cast<const expr::extraction<X+B-1,X,X+B>>(b);
			if (eb) {
				r = expr::extract<X+A+B-1,X,X+A+B>(expr::concat<A,X+B>(ca, eb->e));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t A, std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct ConcatPullConcat {
		static bool t(expr::bvptr<A+B>& r, expr::bvptr<A> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t A, std::uint8_t B, std::uint8_t X>
	struct ConcatPullConcat<A,B,X, Range<(A > X)>> {
		static bool t(expr::bvptr<A+B>& r, expr::bvptr<A> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,A-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,A-X>>(a);
			if (ca) {
				r = expr::concat(ca->a, expr::concat(ca->b, b));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t S, typename = Range<true>>
	struct BVShLPullConcat {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t S>
	struct BVShLPullConcat<B,S, Range<(B > S)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			std::shared_ptr<const expr::concatenation<S,B-S>> cxa = std::dynamic_pointer_cast<const expr::concatenation<S,B-S>>(a);
			if (cxa) {
				r = expr::concat<B-S,S>(cxa->b, expr::constant<S>(0));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t S, std::uint8_t X, typename = Range<true>>
	struct BVLShRPullConcat {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t S, std::uint8_t X>
	struct BVLShRPullConcat<B,S,X, Range<(X <= 64 && B == S + X && B > S && B > X)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			std::shared_ptr<const expr::concatenation<X,B-X>> cxa = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			if (cxa) {
				r = expr::extend<S>(cxa->a);
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t S, std::uint8_t X>
	struct BVLShRPullConcat<B,S,X, Range<(X <= 64 && B > S + X && B > S && B > X)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			std::shared_ptr<const expr::concatenation<X,B-X>> cxa = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			if (cxa) {
				r = expr::extend<S>(expr::concat<X,B-S-X>(cxa->a, expr::extract<B-X-S-1,0,B-X>(expr::bvlshr(cxa->b, expr::constant<B-X>(S)))));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t S, typename = Range<true>>
	struct BVShLConstant {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t S>
	struct BVShLConstant<B,S, Range<(S < B)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			r = expr::concat(expr::extract<B-S-1,0,B>(a), expr::constant<S>(0));
			return true;
		}
	};

	template<std::uint8_t B, std::uint8_t S, typename = Range<true>>
	struct BVLShRConstant {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t S>
	struct BVLShRConstant<B,S, Range<(S < B)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a) {
			r = expr::extend<S>(expr::extract<B-1,S,B>(a));
			return true;
		}
	};

	template<std::uint8_t S, std::uint8_t E, std::uint8_t B, typename = Range<true>>
	struct BVAndExtract {
		static bool t(expr::bvptr<B>& r, std::shared_ptr<const expr::bitvector<B>> ca, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
	struct BVAndExtract<S,E,B, Range<(B-1 > S && E == 0)>> {
		static bool t(expr::bvptr<B>& r, std::shared_ptr<const expr::bitvector<B>> ca, expr::bvptr<B> b) {
			if (ca->value == (2LU<<S)-1) {
				r = expr::extend<B-S-1>(expr::extract<S,E,B>(b));
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t S, std::uint8_t E, std::uint8_t B>
	struct BVAndExtract<S,E,B, Range<(B == S+1 && E > 0)>> {
		static bool t(expr::bvptr<B>& r, std::shared_ptr<const expr::bitvector<B>> ca, expr::bvptr<B> b) {
			if (ca->value == (((2LU<<S)-1) & ~((1LU<<E)-1))) {
				r = expr::concat(expr::extract<S,E,B>(b), expr::constant<E>(0));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct BVAndPullConcat {
		static bool t(expr::bvptr<B>& r, std::shared_ptr<const expr::bitvector<B>> ca, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X>
	struct BVAndPullConcat<B,X, Range<(B > X)>> {
		static bool t(expr::bvptr<B>& r, std::shared_ptr<const expr::bitvector<B>> ca, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> cxb = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(b);
			if (ca && !(ca->value & 0xffUL<<(B-X)) && cxb) {
				r = expr::extend<X>(expr::bvand(expr::constant<B-X>(ca->value), cxb->b));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t X, std::uint8_t Y=X, typename = Range<true>>
	struct BVOrConcats {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X, std::uint8_t Y>
	struct BVOrConcats<B,X,Y, Range<(B > X && X == Y)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			std::shared_ptr<const expr::concatenation<X,B-X>> cb = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(b);
			if (ca && cb) {
				r = expr::concat(expr::bvor(ca->a, cb->a), expr::bvor(ca->b, cb->b));
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X, std::uint8_t Y>
	struct BVOrConcats<B,X,Y, Range<(B > X && X > Y)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			std::shared_ptr<const expr::concatenation<Y,B-Y>> cb = std::dynamic_pointer_cast<const expr::concatenation<Y,B-Y>>(b);
			if (ca && cb) {
				r = expr::concat(expr::bvor(expr::extract<X-1,X-Y,X>(ca->a), cb->a), expr::concat(expr::bvor(expr::extract<X-Y-1,0,X>(ca->a), expr::extract<B-Y-1,B-X,B-Y>(cb->b)), expr::bvor(ca->b, expr::extract<B-X-1,0,B-Y>(cb->b))));
				return true;
			}
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X, std::uint8_t Y>
	struct BVOrConcats<B,X,Y, Range<(B > Y && Y > X)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::concatenation<X,B-X>> ca = std::dynamic_pointer_cast<const expr::concatenation<X,B-X>>(a);
			std::shared_ptr<const expr::concatenation<Y,B-Y>> cb = std::dynamic_pointer_cast<const expr::concatenation<Y,B-Y>>(b);
			if (ca && cb) {
				r = expr::concat(expr::bvor(ca->a, expr::extract<Y-1,Y-X,Y>(cb->a)), expr::concat(expr::bvor(expr::extract<B-X-1,B-Y,B-X>(ca->b), expr::extract<Y-X-1,0,Y>(cb->a)), expr::bvor(expr::extract<B-Y-1,0,B-X>(ca->b), cb->b)));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, typename = Range<true>>
	struct BVAddConstant {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B>
	struct BVAddConstant<B, Range<(B <= 64)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
			std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
			if (ca && cb) {
				r = expr::constant<B>(ca->value + cb->value);
				return true;
			}
			if (ca && !ca->value) {
				r = b;
				return true;
			}
			if (cb && !cb->value) {
				r = a;
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, typename = Range<true>>
	struct BVSubConstant {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B>
	struct BVSubConstant<B, Range<(B <= 64)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
			std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
			if (ca && cb) {
				r = expr::constant<B>(ca->value - cb->value);
				return true;
			}
			if (cb && !cb->value) {
				r = a;
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint32_t V, typename = Range<true>>
	struct BVAddPointer {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint32_t V>
	struct BVAddPointer<B,V,Range<(true)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			auto pa = expr::cast::ptr<B,V>(a);
			auto pb = expr::cast::ptr<B,V>(b);
			if (pa && !pb) {
				r = expr::ptr<B,V>(pa->array, expr::bvadd(pa->offset, b));
				return true;
			}
			if (!pa && pb) {
				r = expr::ptr<B,V>(pb->array, expr::bvadd(a, pb->offset));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint32_t V, std::uint32_t E, typename = Range<true>>
	struct BVAddPointerExt {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint32_t V, std::uint32_t E>
	struct BVAddPointerExt<B,V,E,Range<(B > E)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			auto pa = expr::cast::ptr_ext<B-E,V,E>(a);
			auto pb = expr::cast::ptr_ext<B-E,V,E>(b);
			if (pa && !pb) {
				r = expr::ptr_ext<B-E,V,E>(pa->array, expr::bvadd(pa->offset, expr::extract<B-E-1,0,B>(b)), expr::bvadd(pa->ext, expr::extract<B-1,B-E,B>(b)));
				return true;
			}
			if (!pa && pb) {
				r = expr::ptr_ext<B-E,V,E>(pb->array, expr::bvadd(expr::extract<B-E-1,0,B>(a), pb->offset), expr::bvadd(expr::extract<B-1,B-E,B>(a), pb->ext));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint32_t V, typename = Range<true>>
	struct BVAddPointerBase {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint32_t V>
	struct BVAddPointerBase<B,V,Range<(B == 32)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			auto pa = expr::cast::ptr_base<B,V>(a);
			auto pb = expr::cast::ptr_base<B,V>(b);
			if (pa && !pb) {
				r = expr::ptr_base<B,V>(pa->array, pa->shift, expr::bvadd(pa->offset, expr::bvshl(b, expr::constant<B>(pa->shift))));
				return true;
			}
			if (!pa && pb) {
				r = expr::ptr_base<B,V>(pb->array, pb->shift, expr::bvadd(expr::bvshl(a, expr::constant<B>(pb->shift)), pb->offset));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint8_t X, typename = Range<true>>
	struct BVAddPullExtract {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, std::shared_ptr<const expr::extraction<B+X-1,X,B+X>> eb) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint8_t X>
	struct BVAddPullExtract<B,X, Range<(B+X <= 65 && B <= 65 && X <= 65)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, std::shared_ptr<const expr::extraction<B+X-1,X,B+X>> eb) {
			r = expr::extract<B+X-1,X,B+X>(expr::bvadd<B+X>(expr::concat<B,X>(a, expr::constant<32>(0)), eb->e));
			return true;
		}
	};

	template<std::uint8_t B, std::uint32_t V, typename = Range<true>>
	struct BVSubPointer {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint32_t V>
	struct BVSubPointer<B,V,Range<(true)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			std::shared_ptr<const expr::pointer<B,V>> pa = std::dynamic_pointer_cast<const expr::pointer<B,V>>(a);
			std::shared_ptr<const expr::pointer<B,V>> pb = std::dynamic_pointer_cast<const expr::pointer<B,V>>(b);
			if (pa && pb) {
				r = expr::bvsub(pa->offset, pb->offset);
				return true;
			}
			if (pa && !pb) {
				r = expr::ptr<B,V>(pa->array, expr::bvsub(pa->offset, b));
				return true;
			}
			return false;
		}
	};

	template<std::uint8_t B, std::uint32_t V, std::uint32_t E, typename = Range<true>>
	struct BVSubPointerExt {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			return false;
		}
	};
	template<std::uint8_t B, std::uint32_t V, std::uint32_t E>
	struct BVSubPointerExt<B,V,E,Range<(B > E)>> {
		static bool t(expr::bvptr<B>& r, expr::bvptr<B> a, expr::bvptr<B> b) {
			auto pa = expr::cast::ptr_ext<B-E,V,E>(a);
			auto pb = expr::cast::ptr_ext<B-E,V,E>(b);
			if (pa && !pb) {
				r = expr::ptr_ext<B-E,V,E>(pa->array, expr::bvsub(pa->offset, expr::extract<B-E-1,0,B>(b)), expr::bvsub(pa->ext, expr::extract<B-1,B-E,B>(b)));
				return true;
			}
			return false;
		}
	};
};

inline expr::lptr expr::isfalse(expr::lptr e) {
	std::shared_ptr<const struct expr::boolean> le = std::dynamic_pointer_cast<const struct expr::boolean>(e);
	if (le)
		return expr::lconstant(!le->value);

	std::shared_ptr<const struct expr::bvultcomparison<14>> lt14 = std::dynamic_pointer_cast<const struct expr::bvultcomparison<14>>(e);
	if (lt14)
		return expr::bvuge(lt14->a, lt14->b);
	std::shared_ptr<const struct expr::bvultcomparison<32>> lt32 = std::dynamic_pointer_cast<const struct expr::bvultcomparison<32>>(e);
	if (lt32)
		return expr::bvuge(lt32->a, lt32->b);
	std::shared_ptr<const struct expr::bvultcomparison<64>> lt64 = std::dynamic_pointer_cast<const struct expr::bvultcomparison<64>>(e);
	if (lt64)
		return expr::bvuge(lt64->a, lt64->b);


	return std::make_shared<const struct expr::negation>(e);
}

template<std::uint8_t B>
expr::lptr expr::eq(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::lptr r;

	if (*a == *b)
		return expr::lconstant(true);

	return std::make_shared<const expr::equality<expr::bvptr<B>>>(a, b);
}

template<class T>
std::shared_ptr<const T> expr::ite(expr::lptr l, std::shared_ptr<const T> a, std::shared_ptr<const T> b) {
	std::shared_ptr<const struct expr::boolean> bl = std::dynamic_pointer_cast<const struct expr::boolean>(l);
	if (bl)
		return (bl->value ? a : b);

	return std::make_shared<const expr::ifthenelse<T>>(l, a, b);
}

template<std::uint8_t B>
expr::bvptr<1> expr::bvcomp(expr::bvptr<B> a, expr::bvptr<B> b) {
	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb) {
		if (ca->value == cb->value) {
			return expr::constant<1>(1);
		} else {
			return expr::constant<1>(0);
		}
	}

	std::shared_ptr<const expr::pointer<B,8>> pa = std::dynamic_pointer_cast<const expr::pointer<B,8>>(a);
	std::shared_ptr<const expr::pointer<B,8>> pb = std::dynamic_pointer_cast<const expr::pointer<B,8>>(b);
	if (ca && !ca->value && pb)
		return expr::constant<1>(0);
	if (cb && !cb->value && pa)
		return expr::constant<1>(0);
	std::shared_ptr<const expr::pointer_base<B,8>> pba = std::dynamic_pointer_cast<const expr::pointer_base<B,8>>(a);
	std::shared_ptr<const expr::pointer_base<B,8>> pbb = std::dynamic_pointer_cast<const expr::pointer_base<B,8>>(b);
	if (ca && !ca->value && pbb)
		return expr::constant<1>(0);
	if (cb && !cb->value && pba)
		return expr::constant<1>(0);

	std::shared_ptr<const expr::bvoring<B>> oa = std::dynamic_pointer_cast<const expr::bvoring<B>>(a);
	std::shared_ptr<const expr::bvoring<B>> ob = std::dynamic_pointer_cast<const expr::bvoring<B>>(b);
	if (ca && !ca->value && ob)
		return expr::bvand(expr::bvcomp<B>(ca, ob->a), expr::bvcomp<B>(ca, ob->b));
	if (cb && !cb->value && oa)
		return expr::bvand(expr::bvcomp<B>(oa->a, cb), expr::bvcomp<B>(oa->b, cb));

	return std::make_shared<const struct expr::bvcomparison<B>>(a, b);
}

template<std::uint8_t B>
expr::lptr expr::bvult(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::lptr r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::lconstant(ca->value < cb->value);

	if (cb && h::BVULTConcatConstant<B,19>::t(r, a, cb))
		return r;
	if (cb && h::BVULTConcatConstant<B,31>::t(r, a, cb))
		return r;

	return std::make_shared<const struct expr::bvultcomparison<B>>(a, b);
}

template<std::uint8_t B>
expr::lptr expr::bvule(expr::bvptr<B> a, expr::bvptr<B> b) {
	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::lconstant(ca->value <= cb->value);

	return std::make_shared<const struct expr::bvulecomparison<B>>(a, b);
}

template<std::uint8_t B>
expr::lptr expr::bvuge(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::lptr r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::lconstant(ca->value >= cb->value);

	if (cb && h::BVUGEConcatConstant<B,19>::t(r, a, cb))
		return r;
	if (cb && h::BVUGEConcatConstant<B,31>::t(r, a, cb))
		return r;

	return std::make_shared<const struct expr::bvugecomparison<B>>(a, b);
}

template<std::uint8_t B>
expr::lptr expr::bvugt(expr::bvptr<B> a, expr::bvptr<B> b) {
	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::lconstant(ca->value > cb->value);

	return std::make_shared<const struct expr::bvugtcomparison<B>>(a, b);
}

template<std::uint8_t A, std::uint8_t V>
expr::bvptr<V> expr::select(expr::aptr<A,V> array, expr::bvptr<A> offset) {
	std::shared_ptr<const expr::concrete_storing<A,V>> ca = std::dynamic_pointer_cast<const expr::concrete_storing<A,V>>(array);
	std::shared_ptr<const expr::bitvector<A>> co = std::dynamic_pointer_cast<const expr::bitvector<A>>(offset);
	if (ca && co) {
		auto i = ca->map.find(*co);
		if (i != ca->map.end())
			return i->second;
		return std::make_shared<const struct expr::selection<A,V>>(ca->array, offset);
	}

	return std::make_shared<const struct expr::selection<A,V>>(array, offset);
}

template<std::uint8_t A, std::uint8_t V>
expr::aptr<A,V> expr::store(expr::aptr<A,V> array, expr::bvptr<A> offset, expr::bvptr<V> value) {
	std::shared_ptr<const expr::bitvector<A>> co = std::dynamic_pointer_cast<const expr::bitvector<A>>(offset);
	if (!co)
		return std::make_shared<const struct expr::storing<A,V>>(array, offset, value);

	std::shared_ptr<const expr::concrete_storing<A,V>> ca = std::dynamic_pointer_cast<const expr::concrete_storing<A,V>>(array);
	if (!ca)
		return std::make_shared<const struct expr::concrete_storing<A,V>>(array, *co, value);

	return std::make_shared<const struct expr::concrete_storing<A,V>>(ca, *co, value);
}

template<std::uint8_t S, std::uint8_t E=S, std::uint8_t B>
expr::bvptr<S-E+1> expr::extract(expr::bvptr<B> e) {
	expr::bvptr<S-E+1> r;

	if (h::ExtractConstant<S,E,B>::t(r, e))
		return r;

	if (h::ExtractFull<S,E,B>::t(r, e))
		return r;

	if (h::ExtractPointerExt<S,E,B,32>::t(r, e))
		return r;
	if (h::ExtractPointerExt<S,E,B,8>::t(r, e))
		return r;

	std::shared_ptr<const expr::concatenation<B-E, E>> cl = std::dynamic_pointer_cast<const expr::concatenation<B-E, E>>(e);
	if (cl)
		return extract<S-E,0,B-E>(cl->a);
	std::shared_ptr<const expr::concatenation<B-S-1,S+1>> cr = std::dynamic_pointer_cast<const expr::concatenation<B-S-1,S+1>>(e);
	if (cr)
		return extract<S,E,S+1>(cr->b);

	if (h::ExtractConcatLeft<S,E,B,8>::t(r, e))
		return r;
	if (h::ExtractConcatLeft<S,E,B,16>::t(r, e))
		return r;
	if (h::ExtractConcatLeft<S,E,B,24>::t(r, e))
		return r;
	if (h::ExtractConcatLeft<S,E,B,33>::t(r, e))
		return r;
	if (h::ExtractConcatRight<S,E,B,8>::t(r, e))
		return r;
	if (h::ExtractConcatRight<S,E,B,16>::t(r, e))
		return r;
	if (h::ExtractConcatRight<S,E,B,24>::t(r, e))
		return r;

	if (h::ExtractExtractLeft<S,E,B,8>::t(r, e))
		return r;
	if (h::ExtractExtractLeft<S,E,B,16>::t(r, e))
		return r;
	if (h::ExtractExtractLeft<S,E,B,24>::t(r, e))
		return r;
	if (h::ExtractExtractLeft<S,E,B,32>::t(r, e))
		return r;
	if (h::ExtractExtractLeft<S,E,B,33>::t(r, e))
		return r;
	if (h::ExtractExtractRight<S,E,B,8>::t(r, e))
		return r;
	if (h::ExtractExtractRight<S,E,B,16>::t(r, e))
		return r;
	if (h::ExtractExtractRight<S,E,B,24>::t(r, e))
		return r;

	return std::make_shared<const struct expr::extraction<S,E,B>>(e);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvnot(expr::bvptr<B> e) {
	std::shared_ptr<const expr::bitvector<B>> ce = std::dynamic_pointer_cast<const expr::bitvector<B>>(e);
	if (ce)
		return expr::constant<B>(ce->value ^ ((1LU<<B)-1));

	return std::make_shared<const struct expr::bvnegation<B>>(e);
}

template<std::uint8_t A, std::uint8_t B>
expr::bvptr<A+B> expr::concat(expr::bvptr<A> a, expr::bvptr<B> b) {
	expr::bvptr<A+B> r;

	if (h::ConcatPointer<A,B,32>::t(r, a, b))
		return r;
	if (h::ConcatPointer<A,B,8>::t(r, a, b))
		return r;

	auto ca = expr::cast::constant<A>(a);
	auto cb = expr::cast::constant<B>(b);
	if (ca && cb && h::ConcatConstants<A,B>::t(r, ca, cb))
		return r;

	if (ca && b && h::ConcatMergeConstants<A,B,1>::t(r, ca, b))
		return r;
	if (ca && b && h::ConcatMergeConstants<A,B,8>::t(r, ca, b))
		return r;
	if (ca && b && h::ConcatMergeConstants<A,B,16>::t(r, ca, b))
		return r;
	if (ca && b && h::ConcatMergeConstants<A,B,18>::t(r, ca, b))
		return r;
	if (ca && b && h::ConcatMergeConstants<A,B,24>::t(r, ca, b))
		return r;

	if (ca && h::ConcatPullExtract<A,B,32>::t(r, ca, b))
		return r;

	if (h::ConcatPullConcat<A,B,8>::t(r, a, b))
		return r;

	return std::make_shared<const struct expr::concatenation<A,B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvand(bvptr<B> a, expr::bvptr<B> b) {
	expr::bvptr<B> r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::constant<B>(ca->value & cb->value);
	if (ca && ca->value == (1LU<<B)-1)
		return b;
	if (cb && cb->value == (1LU<<B)-1)
		return a;

	if (ca && h::BVAndExtract<13,0,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<7,0,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<15,0,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<15,8,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<23,0,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<23,8,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<23,16,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<31,0,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<31,8,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<31,16,B>::t(r, ca, b))
		return r;
	if (ca && h::BVAndExtract<31,24,B>::t(r, ca, b))
		return r;
	if (cb && h::BVAndExtract<7,0,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<15,0,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<15,8,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<23,0,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<23,8,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<23,16,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<31,0,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<31,8,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<31,16,B>::t(r, cb, a))
		return r;
	if (cb && h::BVAndExtract<31,24,B>::t(r, cb, a))
		return r;

	if (ca && h::BVAndPullConcat<B,8>::t(r, ca, b))
		return r;
	if (cb && h::BVAndPullConcat<B,8>::t(r, cb, a))
		return r;
	if (ca && h::BVAndPullConcat<B,16>::t(r, ca, b))
		return r;
	if (cb && h::BVAndPullConcat<B,16>::t(r, cb, a))
		return r;
	if (ca && h::BVAndPullConcat<B,24>::t(r, ca, b))
		return r;
	if (cb && h::BVAndPullConcat<B,24>::t(r, cb, a))
		return r;

	return std::make_shared<const struct expr::bvanding<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvor(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::bvptr<B> r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::constant<B>(ca->value | cb->value);
	if (ca && !ca->value)
		return b;
	if (cb && !cb->value)
		return a;

	if (h::BVOrConcats<B,8,8>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,8,16>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,8,24>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,16,8>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,16,16>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,16,24>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,24,8>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,24,16>::t(r, a, b))
		return r;
	if (h::BVOrConcats<B,24,24>::t(r, a, b))
		return r;

	return std::make_shared<const struct expr::bvoring<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvxor(expr::bvptr<B> a, expr::bvptr<B> b) {
	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::constant<B>(ca->value ^ cb->value);
	if (ca && !ca->value)
		return b;
	if (cb && !cb->value)
		return a;

	return std::make_shared<const struct expr::bvxoring<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvshl(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::bvptr<B> r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::constant<B>(ca->value << cb->value);

	std::shared_ptr<const expr::pointer_base<B,8>> pba = std::dynamic_pointer_cast<const expr::pointer_base<B,8>>(a);
	if (pba && cb && pba->shift == cb->value)
		return std::make_shared<const expr::pointer<B,8>>(pba->array, pba->offset);
	if (pba && cb && pba->shift > cb->value)
		return std::make_shared<const expr::pointer_base<B,8>>(pba->array, pba->shift - cb->value, pba->offset);

	if (cb && cb->value == 8 && h::BVShLPullConcat<B,8>::t(r, a))
		return r;
	if (cb && cb->value == 16 && h::BVShLPullConcat<B,16>::t(r, a))
		return r;
	if (cb && cb->value == 24 && h::BVShLPullConcat<B,24>::t(r, a))
		return r;

	if (cb && cb->value == 8 && h::BVShLConstant<B,8>::t(r, a))
		return r;
	if (cb && cb->value == 16 && h::BVShLConstant<B,16>::t(r, a))
		return r;
	if (cb && cb->value == 24 && h::BVShLConstant<B,24>::t(r, a))
		return r;

	return std::make_shared<const struct expr::bvshiftl<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvlshr(expr::bvptr<B> a, expr::bvptr<B> b) {
	expr::bvptr<B> r;

	std::shared_ptr<const expr::bitvector<B>> ca = std::dynamic_pointer_cast<const expr::bitvector<B>>(a);
	std::shared_ptr<const expr::bitvector<B>> cb = std::dynamic_pointer_cast<const expr::bitvector<B>>(b);
	if (ca && cb)
		return expr::constant<B>(ca->value >> cb->value);

	if (cb && cb->value == 8 && h::BVLShRPullConcat<B,8,8>::t(r, a))
		return r;
	if (cb && cb->value == 16 && h::BVLShRPullConcat<B,16,8>::t(r, a))
		return r;
	if (cb && cb->value == 24 && h::BVLShRPullConcat<B,24,8>::t(r, a))
		return r;

	if (cb && cb->value == 8 && h::BVLShRConstant<B,8>::t(r, a))
		return r;
	if (cb && cb->value == 16 && h::BVLShRConstant<B,16>::t(r, a))
		return r;
	if (cb && cb->value == 24 && h::BVLShRConstant<B,24>::t(r, a))
		return r;

	return std::make_shared<const struct expr::bvlshiftr<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvadd(bvptr<B> a, bvptr<B> b) {
	expr::bvptr<B> r;

	if (h::BVAddConstant<B>::t(r, a, b))
		return r;

	if (h::BVAddPointer<B,8>::t(r, a, b))
		return r;
	if (h::BVAddPointer<B,32>::t(r, a, b))
		return r;
	if (h::BVAddPointerExt<B,8,32>::t(r, a, b))
		return r;
	if (h::BVAddPointerExt<B,32,32>::t(r, a, b))
		return r;
	if (h::BVAddPointerBase<B,8>::t(r, a, b))
		return r;

	std::shared_ptr<const expr::extraction<B+32-1,32,B+32>> e32a = std::dynamic_pointer_cast<const expr::extraction<B+32-1,32,B+32>>(a);
	std::shared_ptr<const expr::extraction<B+32-1,32,B+32>> e32b = std::dynamic_pointer_cast<const expr::extraction<B+32-1,32,B+32>>(b);
	if (e32b && h::BVAddPullExtract<B,32>::t(r, a, e32b))
		return r;
	if (e32a && h::BVAddPullExtract<B,32>::t(r, b, e32a))
		return r;

	return std::make_shared<const struct expr::bvaddition<B>>(a, b);
}

template<std::uint8_t B>
expr::bvptr<B> expr::bvsub(bvptr<B> a, expr::bvptr<B> b) {
	expr::bvptr<B> r;

	if (h::BVSubConstant<B>::t(r, a, b))
		return r;

	if (h::BVSubPointer<B,8>::t(r, a, b))
		return r;
	if (h::BVSubPointer<B,32>::t(r, a, b))
		return r;

	return std::make_shared<const struct expr::bvsubstraction<B>>(a, b);
}

