#include "estimator/instr.hpp"
#include "estimator/state.hpp"
#include "estimator/instr.lex.hpp"
#include "estimator/instr.tab.hpp"

#include <memory>
#include <iostream>
#include <string>
#include <vector>
#include <err.h>

std::shared_ptr<const instr> instr::build_instr(std::string str) {
	const instr* n = nullptr;

	YY_BUFFER_STATE buf = instr_scan_string(str.c_str());
	if(instr_parse(&n, str))
		errx(-1, "PARSER error: cannot accept string: %s\n", str.c_str());
	instr_delete_buffer(buf);

	return std::shared_ptr<const instr>(n);
}

const instr::flag instr::N("N");
const instr::flag instr::Z("Z");
const instr::flag instr::V("V");
const instr::flag instr::C("C");
const instr::hreg instr::PREV_ALU("PREV_ALU");
const instr::hreg instr::PREV_A("PREV_A");
const std::vector<instr::local_csr> instr::ActLMAddr = {
	instr::local_csr("ActLMAddr0", 3),
	instr::local_csr("ActLMAddr1", 3),
	instr::local_csr("ActLMAddr2", 3),
	instr::local_csr("ActLMAddr3", 3)};

instr::instr(std::uint32_t id)
	: id(id) {}

std::uint32_t instr::get_id() const
{
	return this->id;
}

std::string instr::str() const {
	std::string s = "." + std::to_string(this->id);
	while (s.length() < 6)
		s = " " + s;
	return s + "  " + name();
}

unsigned int instr::cycles() const {
	errx(-1, "no %s fixed cycles known", name().c_str());
	return 0;
}

unsigned int instr::max_cycles() const {
	return this->cycles();
}
 
state::updates instr::perform(const state::exec& state) const {
	return {};
}

expr::lptr instr::check(const state::exec& state) const {
	errx(-1, "no checking done in %s", name().c_str());
}

instr::gpr::gpr(char bank, std::uint8_t number)
	: bank(bank),
	  number(number) {}

std::string instr::gpr::str() const {
	return "gpr" + std::string(1, this->bank) + "_" + std::to_string(number);
}

std::string instr::gpr::location() const {
	return str();
}

unsigned int instr::gpr::cycles() const {
	return 0;
}

instr::gpr* instr::gpr::flip() const {
	return new instr::gpr(this->bank ^ ('A'^'B'), this->number);
}

expr::bvptr<32> instr::gpr::read(const state::exec& state) const {
	return state[*this];
}

state::uptr instr::gpr::write(expr::bvptr<32> e, const state::exec& state) const {
	return state::update(*this, e);
}

instr::lmindexed::lmindexed(std::uint8_t addr, std::uint8_t offset)
	: addr(addr),
	  offset(offset) {}

std::string instr::lmindexed::str() const {
	return "*l$index" + std::to_string(this->addr) +
	( this->offset ? "[" + std::to_string(this->offset) + "]" : "");
}

std::string instr::lmindexed::location() const {
	return str();
}

unsigned int instr::lmindexed::cycles() const {
// TODO: "the joy of micro c" states that an access to new local mem takes 2 extra cycles, whereas
// access to sequentially following locations take extra 1 cycle
// However, no extra cycles better match the measured performance, perhaps caused by all accesses
// hitting the same location
	return 0;
}

expr::bvptr<32> instr::lmindexed::read(const state::exec& state) const {
	auto addr = state[instr::ActLMAddr[this->addr]];
	auto ptr = expr::cast::ptr<32,32>(addr);
	if (!ptr)
		return expr::undef<32>("non_ptr_lmaddr_read", addr);
	auto b = expr::cast::constant<32>(ptr->offset);
	if (!b)
		return expr::undef<32>("non_constant_lmaddr_read", ptr->offset);
	if (b->value % 4)
		return expr::undef<32>("unaligned_lmaddr_read", b);
	auto o = expr::constant<32>(b->value/4+this->offset);

	return expr::select(state[ptr->array], o);
}

state::uptr instr::lmindexed::write(expr::bvptr<32> e, const state::exec& state) const {
	auto addr = state[instr::ActLMAddr[this->addr]];
	auto ptr = expr::cast::ptr<32,32>(addr);
	if (!ptr)
		return {state::invalidate_mem("non_ptr_lmaddr_write", addr)};
	auto b = expr::cast::constant<32>(ptr->offset);
	if (!b)
		return {state::invalidate_mem("non_constant_lmaddr_write", ptr->offset)};
	if (b->value % 4)
		return {state::invalidate_mem("unaligned_lmaddr_write", b)};
	auto o = expr::constant<32>(b->value/4+this->offset);

	return state::update(ptr->array, expr::store(state[ptr->array], o, e));
}

instr::xfer::xfer(std::uint8_t number)
	:number(number) {}

std::string instr::xfer::str() const {
	return "$xfer_" + std::to_string(number);
}

std::string instr::xfer_in::location() const {
	return "$xfer_in_" + std::to_string(number);
}

unsigned int instr::xfer_in::cycles() const {
	return 0;
}

instr::xfer_in* instr::xfer_in::next() const {
	return new xfer_in(this->number + 1);
}

expr::bvptr<32> instr::xfer_in::read(const state::exec& state) const {
	return state[*this];
}

std::string instr::xfer_out::location() const {
	return "$xfer_out_" + std::to_string(number);
}

unsigned int instr::xfer_out::cycles() const {
	return 0;
}

instr::xfer_out* instr::xfer_out::next() const {
	return new xfer_out(this->number + 1);
}

state::uptr instr::xfer_out::write(expr::bvptr<32> e, const state::exec& state) const {
	return state::update(*this, e);
}

instr::hreg::hreg(std::string name)
	: name(name) {}

std::string instr::hreg::str() const {
	return name;
}

std::string instr::hreg::location() const {
	return str();
}

instr::local_csr::local_csr(std::string name, unsigned int write_latency)
	: hreg(name),
	  write_latency(write_latency) {}

state::uptr instr::local_csr::write(expr::bvptr<32> e) const {
	return state::defer(this->write_latency, state::update(*this, e));
};

instr::flag::flag(std::string name)
	: name(name) {}

std::string instr::flag::str() const {
	return name;
}

std::string instr::flag::location() const {
	return str();
}

instr::constant::constant(std::uint32_t val)
	: value(val) {}

std::string instr::constant::str() const {
	return std::to_string(value);
}

unsigned int instr::constant::cycles() const {
	return 0;
}

expr::bvptr<16> instr::constant::e16() const {
	return expr::constant<16>(value);
}

expr::bvptr<32> instr::constant::e32() const {
	return expr::constant<32>(value);
}

expr::bvptr<32> instr::constant::read(const state::exec& state) const {
	return expr::constant<32>(value);
}

std::string instr::omitted::str() const {
	return "--";
}

std::string instr::omitted::location() const {
	return "";
}

unsigned int instr::omitted::cycles() const {
	return 0;
}

expr::bvptr<32> instr::omitted::read(const state::exec& state) const {
	return expr::undef<32>("omitted");
}

state::uptr instr::omitted::write(expr::bvptr<32> e, const state::exec& state) const {
	return state::update();
}

enum instr::type instr::ordinary::type() const {
	return instr::OTHER;
}

bool instr::ordinary::waits() const {
	return false;
}

unsigned int instr::ordinary::cycles() const {
	return instr::ordinary::COST;
}

double instr::ordinary::dram_cycles() const {
	return 0.0;
}

instr::branch::branch(std::uint32_t id, std::uint32_t target, std::uint32_t defer)
	: instr(id),
	  target(target),
	  defer(defer) {}

std::string instr::branch::str() const {
	return instr::str() + "[." + std::to_string(this->target) + "]" +
	(this->defer ? (", defer[" + std::to_string(this->defer) + "]") : "");
}

bool instr::branch::waits() const {
	return false;
}

bool instr::branch::writescc() const {
	return false;
}

double instr::branch::dram_cycles() const {
	return 0.0;
}

std::uint32_t instr::branch::br_target() const {
	return this->target;
}

enum instr::type instr::proper_branch::type() const {
	return instr::BRANCH;
}

instr::assign::assign(std::uint32_t id, const instr::dst *dst, bool gpr_wrboth)
	: ordinary(id),
	  dst(dst),
	  dst2(nullptr),
	  gpr_wrboth(gpr_wrboth) {
	if (gpr_wrboth) {
		const instr::gpr* g = dynamic_cast<const instr::gpr*>(this->dst);
		if (g) {
			this->dst2 = g->flip();
		}
	}
}

instr::assign::~assign() {
	delete this->dst;
	if (this->dst2)
		delete this->dst2;
}

std::string instr::assign::str() const {
	return instr::str() + "[" + this->dst->str() + ", ";
}

unsigned int instr::assign::cycles() const {
	return instr::ordinary::cycles() + this->dst->cycles();
}

state::updates instr::assign::perform(const state::exec& state) const {
	state::updates u;

	result r = calculate(state);
	u.reserve(5+r.u.size());
	u.push_back(this->dst->write(r.dst, state));

	if (this->dst2) {
		u.push_back(this->dst2->write(r.dst, state));
	}

	if (writescc()) {
		u.push_back(state::update(instr::N, expr::bvcomp(expr::extract<31>(r.dst), expr::constant<1>(1))));
		u.push_back(state::update(instr::Z, expr::bvcomp(r.dst, expr::constant<32>(0))));
		u.push_back(state::update(instr::V, r.v));
		u.push_back(state::update(instr::C, r.c));
	}

	u.insert(u.end(), r.u.begin(), r.u.end());

	return u;
}

instr::assign::result::result(expr::bvptr<32> dst, expr::bvptr<1> v, expr::bvptr<1> c, state::updates u)
	: dst(dst),
	  v(v),
	  c(c),
	  u(u) {}

instr::assign::result::result(expr::bvptr<32> dst, expr::bvptr<1> v, expr::bvptr<1> c)
	: result(dst, v, c, {}) {}

instr::assign::result::result(expr::bvptr<32> dst, state::updates u)
	: result(dst, expr::undef<1>(), expr::undef<1>(), u) {}

instr::assign::result::result(expr::bvptr<32> dst)
	: result(dst, expr::undef<1>(), expr::undef<1>()) {}

instr::assign::result instr::assign::calculate(const state::exec& state) const {
	return result(expr::undef<32>(name()), expr::undef<1>(name()), expr::undef<1>(name()));
}

instr::shift_cntl::im::im(std::uint8_t amount)
	: amount(amount) {}

std::string instr::shift_cntl::leftim::str() const {
	return "<<" + std::to_string(this->amount);
}

expr::bvptr<32> instr::shift_cntl::leftim::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvshl(e, expr::constant<32>(amount));
}

expr::bvptr<64> instr::shift_cntl::leftim::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvshl(e, expr::constant<64>(amount));
}

std::string instr::shift_cntl::rightim::str() const {
	return ">>" + std::to_string(this->amount);
}

expr::bvptr<32> instr::shift_cntl::rightim::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvlshr(e, expr::constant<32>(amount));
}

expr::bvptr<64> instr::shift_cntl::rightim::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvlshr(e, expr::constant<64>(amount));
}

expr::bvptr<33> instr::shift_cntl::rightim::calculate(expr::bvptr<33> e, const state::exec& state) const {
	return expr::bvashr(e, expr::constant<33>(amount));
}

std::string instr::shift_cntl::rotleftim::str() const {
	return "<<rot" + std::to_string(this->amount);
}

expr::bvptr<32> instr::shift_cntl::rotleftim::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvrotl(e, amount);
}

expr::bvptr<64> instr::shift_cntl::rotleftim::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvrotl(e, amount);
}

std::string instr::shift_cntl::rotrightim::str() const {
	return ">>rot" + std::to_string(this->amount);
}

expr::bvptr<32> instr::shift_cntl::rotrightim::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvrotr(e, amount);
}

expr::bvptr<64> instr::shift_cntl::rotrightim::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvrotr(e, amount);
}

std::string instr::shift_cntl::leftindirect::str() const {
	return "<<indirect";
}

expr::bvptr<32> instr::shift_cntl::leftindirect::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvshl(e, expr::bvand(state[instr::PREV_A], expr::constant<32>(0x1f)));
}

expr::bvptr<64> instr::shift_cntl::leftindirect::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvshl(e, expr::extend<32>(expr::bvand(state[instr::PREV_A], expr::constant<32>(0x1f))));
}

std::string instr::shift_cntl::rightindirect::str() const {
	return ">>indirect";
}

expr::bvptr<32> instr::shift_cntl::rightindirect::calculate(expr::bvptr<32> e, const state::exec& state) const {
	return expr::bvlshr(e, expr::bvand(state[instr::PREV_A], expr::constant<32>(0x1f)));
}

expr::bvptr<64> instr::shift_cntl::rightindirect::calculate(expr::bvptr<64> e, const state::exec& state) const {
	return expr::bvlshr(e, expr::extend<32>(expr::bvand(state[instr::PREV_A], expr::constant<32>(0x1f))));
}

expr::bvptr<33> instr::shift_cntl::rightindirect::calculate(expr::bvptr<33> e, const state::exec& state) const {
	return expr::bvashr(e, expr::extend<1>(expr::bvand(state[instr::PREV_A], expr::constant<32>(0x1f))));
}

std::shared_ptr<const instr::fin> instr::fin::build() {
	return std::make_shared<const instr::fin>();
}

instr::fin::fin()
	: instr(ID) {}

std::string instr::fin::name() const {
	return "fin";
}

enum instr::type instr::fin::type() const {
	return instr::FIN;
}

bool instr::fin::waits() const {
	return false;
}

bool instr::fin::writescc() const {
	return true;
}

double instr::fin::dram_cycles() const {
	return 0.0;
}

std::string instr::alu_op::plus::str() const {
	return "+";
}

bool instr::alu_op::plus::writes_prev() const {
	return false;
}

instr::assign::result instr::alu_op::plus::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	expr::bvptr<32> addition = expr::bvadd(A, B);
	expr::bvptr<33> extended = expr::bvadd<33>(expr::extend<1>(A), expr::extend<1>(B));
	expr::bvptr<1> carry = expr::bvadd_carry(A, B);

	expr::bvptr<1> carry30 = expr::extract<31>(addition);
	expr::bvptr<1> carry31 = expr::extract<32>(extended);
	return instr::assign::result(
		addition,
		expr::bvxor(carry31, carry30),
		carry);
}

std::string instr::alu_op::plus16::str() const {
	return "+16";
}

instr::assign::result instr::alu_op::plus16::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::alu_op::plus::calculate(A, expr::bvand(B, expr::constant<32>(0xffff)), state);
}

std::string instr::alu_op::plus8::str() const {
	return "+8";
}

instr::assign::result instr::alu_op::plus8::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::alu_op::plus::calculate(A, expr::bvand(B, expr::constant<32>(0xffff)), state);
}

std::string instr::alu_op::plus_carry::str() const {
	return "+carry";
}

bool instr::alu_op::plus_carry::writes_prev() const {
	return false;
}

instr::assign::result instr::alu_op::plus_carry::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	expr::bvptr<1> C = state[instr::C];
	expr::bvptr<32> e31C = expr::extend<31>(C);
	expr::bvptr<33> e32C = expr::extend<32>(C);
	expr::bvptr<32> addition = expr::bvadd(expr::bvadd(A, B), e31C);
	expr::bvptr<33> extended = expr::bvadd(expr::bvadd(expr::extend<1>(A), expr::extend<1>(B)),e32C);
	expr::bvptr<1> carry = expr::bvadd_carry(expr::bvadd(A, B), e31C);

	auto cC = expr::cast::bvadd_carry<32>(C);
	if (cC) {
		if (expr::cast::ptr_base<32,8>(A)) {
			expr::bvptr<1> addC = expr::extract<32>(expr::bvadd(expr::extend<1>(cC->a), expr::extend<1>(cC->b)));
			expr::bvptr<32> e31C = expr::extend<31>(addC);
			expr::bvptr<33> e32C = expr::extend<32>(addC);
			addition = expr::bvadd(expr::bvadd(A, B), e31C);
			extended = expr::bvadd(expr::bvadd(expr::extend<1>(A), expr::extend<1>(B)),e32C);
			carry = expr::extract<32>(extended);
		} else {
			expr::bvptr<64> fA = expr::concat(A, cC->a);
			expr::bvptr<64> fB = expr::concat(B, cC->b);
			addition = expr::extract<63,32>(expr::bvadd(fA, fB));
			extended = expr::extract<64,32>(expr::bvadd(expr::extend<1>(fA), expr::extend<1>(fB)));
			carry = expr::bvadd_carry(fA, fB);
		}
	}

	expr::bvptr<1> carry30 = expr::extract<31>(addition);
	expr::bvptr<1> carry31 = expr::extract<32>(extended);
	return instr::assign::result(
		addition,
		expr::bvxor(carry31, carry30),
		carry);
}

std::string instr::alu_op::minus::str() const {
	return "-";
}

bool instr::alu_op::minus::writes_prev() const {
	return false;
}

instr::assign::result instr::alu_op::minus::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	expr::bvptr<32> substrac = expr::bvsub(A, B);
	expr::bvptr<33> extended = expr::bvsub(expr::extend<1>(A), expr::extend<1>(B));
	expr::bvptr<1> s1 = expr::extract<31>(A);
	expr::bvptr<1> s2 = expr::extract<31>(B);
	expr::bvptr<1> carry = expr::bvsub_carry(A, B);

	expr::bvptr<1> carry30 = expr::extract<31>(substrac);
	expr::bvptr<1> carry31 = expr::extract<32>(extended);
	return instr::assign::result(
		substrac,
		expr::bvand(expr::bvxor(s1,s2), expr::bvnot(expr::bvxor(s2,carry30))),
		carry);
}

std::string instr::alu_op::minus_carry::str() const {
	return "-carry";
}

bool instr::alu_op::minus_carry::writes_prev() const {
	return false;
}

instr::assign::result instr::alu_op::minus_carry::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	expr::bvptr<1> C = state[instr::C];
	expr::bvptr<32> e31C = expr::extend<31>(C);
	expr::bvptr<33> e32C = expr::extend<32>(C);
	expr::bvptr<32> substrac = expr::bvsub(expr::bvsub(A, B), e31C);
	expr::bvptr<33> extended = expr::bvsub(expr::bvsub(expr::extend<1>(A), expr::extend<1>(B)), e32C);
	expr::bvptr<1> carry = expr::bvsub_carry(expr::bvsub(A, B), e31C);

	auto cC = expr::cast::bvsub_carry<32>(C);
	if (cC) {
		expr::bvptr<64> fA = expr::concat(A, cC->a);
		expr::bvptr<64> fB = expr::concat(B, cC->b);
		substrac = expr::extract<63,32>(expr::bvsub(fA, fB));
		extended = expr::extract<64,32>(expr::bvsub(expr::extend<1>(fA), expr::extend<1>(fB)));
		carry = expr::bvsub_carry(fA, fB);
	}

	expr::bvptr<1> s1 = expr::extract<31>(A);
	expr::bvptr<1> s2 = expr::extract<31>(B);
	expr::bvptr<1> carry30 = expr::extract<31>(substrac);
	expr::bvptr<1> carry31 = expr::extract<32>(extended);
	return instr::assign::result(
		substrac,
		expr::bvand(expr::bvxor(s1,s2), expr::bvnot(expr::bvxor(s2,carry30))),
		carry);
}

std::string instr::alu_op::neg_minus::str() const {
	return "B-A";
}

instr::assign::result instr::alu_op::neg_minus::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::alu_op::minus::calculate(B, A, state);
}

std::string instr::alu_op::B::str() const {
	return "B";
}

bool instr::alu_op::B::writes_prev() const {
	return true;
}

instr::assign::result instr::alu_op::B::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::assign::result(
		B,
		expr::constant<1>(0),
		expr::constant<1>(0));
}

std::string instr::alu_op::invB::str() const {
	return "~B";
}

bool instr::alu_op::invB::writes_prev() const {
	return true;
}

instr::assign::result instr::alu_op::invB::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::assign::result(
		expr::bvnot(B),
		expr::constant<1>(0),
		expr::constant<1>(0));
}

std::string instr::alu_op::op_and::str() const {
	return "AND";
}

bool instr::alu_op::op_and::writes_prev() const {
	return true;
}

instr::assign::result instr::alu_op::op_and::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::assign::result(
		expr::bvand(A, B),
		expr::constant<1>(0),
		expr::constant<1>(0));
}

std::string instr::alu_op::inv_and::str() const {
	return "~AND";
}

instr::assign::result instr::alu_op::inv_and::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return op_and::calculate(expr::bvnot(A), B, state);
}

std::string instr::alu_op::and_inv::str() const {
	return "AND~";
}

instr::assign::result instr::alu_op::and_inv::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return op_and::calculate(A, expr::bvnot(B), state);
}

std::string instr::alu_op::op_or::str() const {
	return "OR";
}

bool instr::alu_op::op_or::writes_prev() const {
	return true;
}

instr::assign::result instr::alu_op::op_or::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::assign::result(
		expr::bvor(A, B),
		expr::constant<1>(0),
		expr::constant<1>(0));
}

std::string instr::alu_op::op_xor::str() const {
	return "XOR";
}

bool instr::alu_op::op_xor::writes_prev() const {
	return true;
}

instr::assign::result instr::alu_op::op_xor::calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const {
	return instr::assign::result(
		expr::bvxor(A, B),
		expr::constant<1>(0),
		expr::constant<1>(0));
}

instr::alu_like::alu_like(std::uint32_t id, const instr::dst *dst, const instr::src *srcA, const instr::alu_op *op, const instr::src *srcB, const instr::shift_cntl* sc, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  srcA(srcA),
	  op(op),
	  srcB(srcB),
	  sc(sc) {}

instr::alu_like::~alu_like() {
	delete this->srcA;
	delete this->op;
	delete this->srcB;
	if (this->sc)
		delete this->sc;
}

std::string instr::alu_like::str() const {
	return assign::str() +
	this->srcA->str() + ", " +
	this->op->str() + ", " +
	this->srcB->str() +
	(this->sc ? ("," + this->sc->str()) : "") + "]" +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

bool instr::alu_like::writescc() const {
	return true;
}

unsigned int instr::alu_like::cycles() const {
	return instr::assign::cycles() + std::max(this->srcA->cycles(), this->srcB->cycles());
}

instr::assign::result instr::alu_like::calculate(const state::exec& state) const {
	expr::bvptr<32> A = this->srcA->read(state);
	expr::bvptr<32> B = this->srcB->read(state);
	if (this->sc)
		B = this->sc->calculate(B, state);
	instr::assign::result r = this->op->calculate(A, B, state);

	if (this->op->writes_prev()) {
		r.u.push_back(state::update(instr::PREV_A, A));
		r.u.push_back(state::update(instr::PREV_ALU, r.dst));
		r.u.push_back(state::defer(1, state::update(instr::PREV_A, expr::undef<32>())));
		r.u.push_back(state::defer(1, state::update(instr::PREV_ALU, expr::undef<32>())));
	}

	return r;
}

instr::alu::alu(std::uint32_t id, const instr::dst *dst, const instr::src *srcA, const instr::alu_op *op, const instr::src *srcB, bool gpr_wrboth)
	: alu_like(id, dst, srcA, op, srcB, nullptr, gpr_wrboth) {}

std::string instr::alu::name() const {
	return "alu";
}

std::string instr::alu_shf::name() const {
	return "alu_shf";
}

instr::asr::asr(std::uint32_t id, const instr::dst *dst, const instr::src *src, const instr::shift_cntl::aright* sc, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  src(src),
	  sc(sc) {}

instr::asr::~asr() {
	delete this->src;
	delete this->sc;
}

bool instr::asr::writescc() const {
	return true;
}

std::string instr::asr::name() const {
	return "asr";
}

std::string instr::asr::str() const {
	return assign::str() +
	this->src->str() + ", " +
	this->sc->str() + "]" +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

unsigned int instr::asr::cycles() const {
	return instr::assign::cycles() + this->src->cycles();
}

instr::assign::result instr::asr::calculate(const state::exec& state) const {
	expr::bvptr<32> prev_alu = state[instr::PREV_ALU];
	expr::bvptr<1> s = expr::extract<31,31,32>(prev_alu);
	return result(
		expr::extract<31,0,33>(this->sc->calculate(expr::concat<1,32>(s, this->src->read(state)), state)),
		expr::constant<1>(0),
		expr::constant<1>(0),
		{
			state::update(instr::PREV_ALU, prev_alu),
			state::defer(1, state::update(instr::PREV_ALU, expr::undef<32>())),
		});
}

std::string instr::bcc::name() const {
	return "bcc";
}

expr::lptr instr::bcc::check(const state::exec& state) const {
	expr::bvptr<1> C = state[instr::C];

	// carry is clear if borrow is set
	auto sub32 = expr::cast::bvsub_carry<32>(C);
	if (sub32) {
		auto pa = expr::cast::ptr<32,8>(sub32->a);
		auto pb = expr::cast::ptr<32,8>(sub32->b);
		if (pa && pb && *pa->array == *pb->array)
			return expr::bvult(pa->offset, pb->offset);
		return expr::bvult(sub32->a, sub32->b);
	}

	// carry is clear if borrow is set
	auto sub64 = expr::cast::bvsub_carry<64>(C);
	if (sub64) {
		auto pa = expr::cast::ptr_ext<32,8,32>(sub64->a);
		auto pb = expr::cast::ptr_ext<32,8,32>(sub64->b);
		if (pa && pb && *pa->array == *pb->array) {
			return expr::lor(
				expr::bvult(pa->ext, pb->ext),
				expr::land(
					expr::eq(pa->ext, pb->ext),
					expr::bvult(pa->offset, pb->offset)
				));
		}
		return expr::bvult(sub64->a, sub64->b);
	}

	auto add32 = expr::cast::bvadd_carry<32>(C);
	if (add32)
		C = expr::extract<32>(expr::bvadd(expr::extend<1>(add32->a), expr::extend<1>(add32->b)));
	auto add64 = expr::cast::bvadd_carry<64>(C);
	if (add64)
		C = expr::extract<64>(expr::bvadd(expr::extend<1>(add64->a), expr::extend<1>(add64->b)));

	return expr::eq(C, expr::constant<1>(0));
}

std::string instr::bcs::name() const {
	return "bcs";
}

expr::lptr instr::bcs::check(const state::exec& state) const {
	expr::bvptr<1> C = state[instr::C];

	// carry is set if borrow is clear
	auto sub32 = expr::cast::bvsub_carry<32>(C);
	if (sub32) {
		auto pa = expr::cast::ptr<32,8>(sub32->a);
		auto pb = expr::cast::ptr<32,8>(sub32->b);
		if (pa && pb && *pa->array == *pb->array)
			return expr::bvuge(pa->offset, pb->offset);
		return expr::bvuge(sub32->a, sub32->b);
	}

	// carry is set if borrow is clear
	auto sub64 = expr::cast::bvsub_carry<64>(C);
	if (sub64) {
		auto pa = expr::cast::ptr_ext<32,8,32>(sub64->a);
		auto pb = expr::cast::ptr_ext<32,8,32>(sub64->b);
		if (pa && pb && *pa->array == *pb->array) {
			return expr::lor(
				expr::bvugt(pa->ext, pb->ext),
				expr::land(
					expr::eq(pa->ext, pb->ext),
					expr::bvuge(pa->offset, pb->offset)
				));
		}
		return expr::bvuge(sub64->a, sub64->b);
	}

	auto add32 = expr::cast::bvadd_carry<32>(C);
	if (add32)
		C = expr::extract<32>(expr::bvadd(expr::extend<1>(add32->a), expr::extend<1>(add32->b)));
	auto add64 = expr::cast::bvadd_carry<64>(C);
	if (add64)
		C = expr::extract<64>(expr::bvadd(expr::extend<1>(add64->a), expr::extend<1>(add64->b)));

	return expr::eq(C, expr::constant<1>(1));
}

std::string instr::beq::name() const {
	return "beq";
}

expr::lptr instr::beq::check(const state::exec& state) const {
	return expr::eq(state[instr::Z], expr::constant<1>(1));
}

std::string instr::bge::name() const {
	return "bge";
}

expr::lptr instr::bge::check(const state::exec& state) const {
	return expr::eq(state[instr::N], state[instr::V]);
}

std::string instr::bgt::name() const {
	return "bgt";
}

expr::lptr instr::bgt::check(const state::exec& state) const {
	return expr::land(expr::eq(state[instr::Z], expr::constant<1>(0)), expr::eq(state[instr::N], state[instr::V]));
}

std::string instr::ble::name() const {
	return "ble";
}

expr::lptr instr::ble::check(const state::exec& state) const {
	return expr::lor(expr::eq(state[instr::Z], expr::constant<1>(1)), expr::isfalse(expr::eq(state[instr::N], state[instr::V])));
}

std::string instr::blt::name() const {
	return "blt";
}

expr::lptr instr::blt::check(const state::exec& state) const {
	return expr::isfalse(expr::eq(state[instr::N], state[instr::V]));
}

std::string instr::bmi::name() const {
	return "bmi";
}

expr::lptr instr::bmi::check(const state::exec& state) const {
	return expr::eq(state[instr::N], expr::constant<1>(1));
}

std::string instr::bne::name() const {
	return "bne";
}

expr::lptr instr::bne::check(const state::exec& state) const {
	return expr::eq(state[instr::Z], expr::constant<1>(0));
}

std::string instr::bpl::name() const {
	return "bpl";
}

expr::lptr instr::bpl::check(const state::exec& state) const {
	return expr::eq(state[instr::N], expr::constant<1>(0));
}

std::string instr::bvc::name() const {
	return "bvc";
}

expr::lptr instr::bvc::check(const state::exec& state) const {
	return expr::eq(state[instr::V], expr::constant<1>(0));
}

std::string instr::bvs::name() const {
	return "bvs";
}

expr::lptr instr::bvs::check(const state::exec& state) const {
	return expr::eq(state[instr::V], expr::constant<1>(1));
}

instr::br::br(std::uint32_t id, std::uint32_t target, std::uint32_t defer)
	: branch(id, target, defer) {}

std::string instr::br::name() const {
	return "br";
}

enum instr::type instr::br::type() const {
	return instr::JUMP;
}

unsigned int instr::br::cycles() const {
	// TODO: check these costs, documentation sounds more like 2 cycles
	return instr::br::COST_TRUE;
}

instr::dbl_shf::dbl_shf(std::uint32_t id, const instr::dst* dst, const instr::src* srcA, const instr::src* srcB, const instr::shift_cntl* sc, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  srcA(srcA),
	  srcB(srcB),
	  sc(sc) {}

instr::dbl_shf::~dbl_shf() {
	delete this->srcA;
	delete this->srcB;
	delete this->sc;
}

std::string instr::dbl_shf::name() const {
	return "dbl_shf";
}

std::string instr::dbl_shf::str() const {
	return assign::str() +
	this->srcA->str() + ", " +
	this->srcB->str() + "," +
	this->sc->str() + "]" +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

bool instr::dbl_shf::writescc() const {
	return true;
}

unsigned int instr::dbl_shf::cycles() const {
	return instr::assign::cycles() + std::max(this->srcA->cycles(), this->srcB->cycles());
}

instr::assign::result instr::dbl_shf::calculate(const state::exec& state) const {
	return result(
		expr::extract<31,0,64>(this->sc->calculate(expr::concat(this->srcA->read(state), this->srcB->read(state)), state)),
		expr::constant<1>(0),
		expr::constant<1>(0));
}

instr::immed_like::immed_like(std::uint32_t id, const instr::dst* dst, const instr::constant* im, const instr::shift_cntl* sc, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  im(im),
	  sc(sc) {}

instr::immed_like::~immed_like() {
	delete this->im;
	if (this->sc)
		delete this->sc;
}

std::string instr::immed_like::str() const {
	return assign::str() +
	this->im->str() +
	(this->sc ? (", " + this->sc->str()) : "") + "]" +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

bool instr::immed_like::writescc() const {
	return false;
}

std::string instr::immed::name() const {
	return "immed";
}

instr::assign::result instr::immed::calculate(const state::exec& state) const {
	expr::bvptr<64> i = expr::concat(this->im->e32(), this->im->e32());
	if (this->sc)
		i = this->sc->calculate(i, state);
	expr::bvptr<32> r = expr::extract<63,32,64>(i);
	return result(r, {state::update(instr::PREV_ALU, r)});
}

instr::immed_w1::immed_w1(std::uint32_t id, const instr::dst* dst, const instr::constant* im, bool gpr_wrboth)
	: immed_like(id, dst, im, nullptr, gpr_wrboth) {}

std::string instr::immed_w1::name() const {
	return "immed_w1";
}

instr::assign::result instr::immed_w1::calculate(const state::exec& state) const {
	const instr::src* s = dynamic_cast<const instr::src*>(this->dst);
	expr::bvptr<32> p;
	if (s) {
		p = s->read(state);
	} else {
		p = expr::undef<32>("immed_w1_no_src");
	}
	return result(expr::concat(this->im->e16(), expr::extract<15,0,32>(p)));
}

instr::ld_field_like::ld_field_like(std::uint32_t id, const instr::dst* dst, std::uint32_t mask, const instr::src* src, const instr::shift_cntl* sc, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  mask(mask),
	  src(src),
	  sc(sc) {}

instr::ld_field_like::~ld_field_like() {
	delete this->src;
	if (this->sc)
		delete this->sc;
}

std::string instr::ld_field_like::str() const {
	return assign::str() +
	std::to_string(this->mask) + ", " +
	this->src->str() +
	(this->sc ? (", " + this->sc->str()) : "") + "]" +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

bool instr::ld_field_like::writescc() const {
	return true;
}

unsigned int instr::ld_field_like::cycles() const {
	return instr::assign::cycles() + this->src->cycles();
}

std::string instr::ld_field::name() const {
	return "ld_field";
}

instr::assign::result instr::ld_field::calculate(const state::exec& state) const {
	expr::bvptr<32> e = this->src->read(state);
	if (this->sc)
		e = this->sc->calculate(e, state);

	if (this->mask == 1111) {
		return result(e);
	} else {
		const instr::src* s = dynamic_cast<const instr::src*>(this->dst);
		expr::bvptr<32> p;
		if (s) {
			p = s->read(state);
		} else {
			p = expr::undef<32>("ld_field_no_src");
		}
		std::uint32_t mask = 0;
		if (this->mask % 10)
			mask |= 0xff;
		if (this->mask / 10 % 10)
			mask |= 0xff00;
		if (this->mask / 100 % 10)
			mask |= 0xff0000;
		if (this->mask / 1000)
			mask |= 0xff000000;
		return result(expr::bvor(expr::bvand(p, expr::constant<32>(~mask)), expr::bvand(e, expr::constant<32>(mask))));
	}
}

std::string instr::ld_field_w_clr::name() const {
	return "ld_field_w_clr";
}

instr::assign::result instr::ld_field_w_clr::calculate(const state::exec& state) const {
	expr::bvptr<32> e = this->src->read(state);
	if (this->sc)
		e = this->sc->calculate(e, state);

	if (this->mask == 1111) {
		return result(e);
	} else {
		std::uint32_t mask = 0;
		if (this->mask % 10)
			mask |= 0xff;
		if (this->mask / 10 % 10)
			mask |= 0xff00;
		if (this->mask / 100 % 10)
			mask |= 0xff0000;
		if (this->mask / 1000)
			mask |= 0xff000000;
		return result(expr::bvand(e, expr::constant<32>(mask)));
	}
}

instr::local_csr_wr::local_csr_wr(std::uint32_t id, const instr::local_csr* local_csr, const instr::src* src)
	: ordinary(id),
	  local_csr(local_csr),
	  src(src) {}

instr::local_csr_wr::~local_csr_wr() {
	delete this->src;
}

std::string instr::local_csr_wr::name() const {
	return "local_csr_wr";
}

std::string instr::local_csr_wr::str() const {
	return instr::str() + "[" +
	this->local_csr->str() + ", " +
	this->src->str() + "]";
}

bool instr::local_csr_wr::writescc() const {
	return false;
}

unsigned int instr::local_csr_wr::cycles() const {
	return instr::ordinary::cycles() + this->src->cycles();
}

state::updates instr::local_csr_wr::perform(const state::exec& state) const {
	return {this->local_csr->write(src->read(state))};
}

template class instr::mem<instr::mem_read_op,instr::xfer_in>;
template class instr::mem<instr::mem_write_op,instr::xfer_out>;

template <class O, class X>
instr::mem<O,X>::mem(std::uint32_t id, const O* op, const X* xfer, const instr::src* src1, const instr::shift_cntl* sc1, const instr::src* src2, const instr::shift_cntl* sc2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap)
	: instr(id),
	  op(op),
	  xfers([&]{
		std::vector<const X*> xs = {xfer};
		const X* x = xfer;
		std::uint32_t max = op->xfers(indirect_ref ? REF_CNT_MAX : ref_cnt);
		for (std::uint32_t i = 1; i < max; i++) {
			x = x->next();
			xs.push_back(x);
		}
		return xs;
	  }()),
	  src1(src1),
	  sc1(sc1),
	  src2(src2),
	  sc2(sc2),
	  ref_cnt(ref_cnt),
	  indirect_ref(indirect_ref),
	  ctx_swap(ctx_swap) {}

template <class O, class X>
instr::mem<O,X>::~mem() {
	delete this->src1;
	if (this->sc1)
		delete this->sc1;
	delete this->src2;
	if (this->sc2)
		delete this->sc2;
	delete this->op;
	for (const instr::xfer* x: this->xfers)
		delete x;
}

template <class O, class X>
std::string instr::mem<O,X>::name() const {
	return "mem";
}

template <class O, class X>
std::string instr::mem<O,X>::str() const {
	return instr::str() + "[" +
	this->op->str() + ", " +
	this->xfers[0]->str() + ", " +
	this->src1->str() + ", " +
	(this->sc1 ? this->sc1->str() + ", " : "") +
	this->src2->str() + ", " +
	(this->sc2 ? this->sc2->str() + ", " : "") +
	std::to_string(this->ref_cnt) + "]" +
	(this->indirect_ref ? ", indirect_ref" : "") +
	(this->ctx_swap != (std::uint32_t) -1U ? (", ctx_swap[sig" + std::to_string(this->ctx_swap) + "]") : "");
}

template <class O, class X>
enum instr::type instr::mem<O,X>::type() const {
	return instr::MEM;
}

template <class O, class X>
bool instr::mem<O,X>::writescc() const {
	return false;
}

template <class O, class X>
bool instr::mem<O,X>::waits() const {
	return this->ctx_swap != -1U;
}

template <class O, class X>
unsigned int instr::mem<O,X>::cycles() const {
	unsigned int cycles = 0;
	if (this->ctx_swap == (std::uint32_t) -1U) {
		cycles += instr::mem<O,X>::COST_NOSWAP_MIN;
	} else {
		cycles += instr::mem<O,X>::COST_SWAP_MIN;
	}
	cycles += std::max(this->src1->cycles(), this->src2->cycles());
	return cycles;
}

template <class O, class X>
unsigned int instr::mem<O,X>::max_cycles() const {
	if (!this->sc1 && !this->sc2) {
		return instr::mem<O,X>::COST_32BIT_MAX;
	} else {
		return instr::mem<O,X>::COST_40BIT_MAX;
	}
}

template <class O, class X>
double instr::mem<O,X>::dram_cycles() const {
	if (!this->sc1 && !this->sc2) {
		return 0.0;
	} else {
		return this->op->dram_cycles();
	}
}

std::string instr::mem_read_op::read32_swap::str() const {
	return "read32_swap";
}

double instr::mem_read_op::read32_swap::dram_cycles() const {
	// measured at least 197410807.454384029 ops/s at 800 Mhz
	return 4.052463035413383;
}

std::uint32_t instr::mem_read_op::read32_swap::xfers(std::uint32_t ref_cnt) const {
	return ref_cnt;
}

expr::bvptr<32> instr::mem_read_op::read32_swap::read(expr::bvptr<32> ptr, std::uint32_t& index, const state::exec& state) const {
	expr::bvptr<32> o0 = expr::bvadd(ptr, expr::constant<32>(index*4+0));
	expr::bvptr<32> o1 = expr::bvadd(ptr, expr::constant<32>(index*4+1));
	expr::bvptr<32> o2 = expr::bvadd(ptr, expr::constant<32>(index*4+2));
	expr::bvptr<32> o3 = expr::bvadd(ptr, expr::constant<32>(index*4+3));
	auto p0 = expr::cast::ptr<32,8>(o0);
	auto p1 = expr::cast::ptr<32,8>(o1);
	auto p2 = expr::cast::ptr<32,8>(o2);
	auto p3 = expr::cast::ptr<32,8>(o3);
	if (!p0)
		return expr::undef<32>("non_ptr_mem_read32_swap", o0);
	if (!p0)
		return expr::undef<32>("non_ptr_mem_read32_swap", o1);
	if (!p0)
		return expr::undef<32>("non_ptr_mem_read32_swap", o2);
	if (!p0)
		return expr::undef<32>("non_ptr_mem_read32_swap", o3);
	expr::aptr<32,8> a = state[p0->array];
	expr::bvptr<8> s0 = expr::select(a, p0->offset);
	expr::bvptr<8> s1 = expr::select(a, p1->offset);
	expr::bvptr<8> s2 = expr::select(a, p2->offset);
	expr::bvptr<8> s3 = expr::select(a, p3->offset);
	index += 1;
	return expr::concat<8,8,8,8>(s3, s2, s1, s0);
}

state::updates instr::mem_read::perform(const state::exec& state) const {
	state::updates u;

	expr::bvptr<32> src1 = this->src1->read(state);
	expr::bvptr<32> src2 = this->src2->read(state);
	if (this->sc1)
		src1 = this->sc1->calculate(src1, state);
	if (this->sc2)
		src2 = this->sc2->calculate(src2, state);
	expr::bvptr<32> src = expr::bvadd(src1, src2);
	std::uint32_t i = 0;
	for (const xfer_in* x: this->xfers) {
		std::uint32_t pi = i;
		expr::bvptr<32> r = this->op->read(src, i, state);
		if (this->indirect_ref) {
			expr::bvptr<32> ref = expr::bvadd(expr::bvlshr(state[instr::PREV_ALU], expr::constant<32>(8)), expr::constant<32>(1));
			r = expr::ite(expr::bvugt(ref, expr::constant<32>(pi)), r, state[*x]);
		}
		u.push_back(state::update(*x, r));
	}
	return u;
}

std::string instr::mem_write_op::write8_swap::str() const {
	return "write8_swap";
}

double instr::mem_write_op::write8_swap::dram_cycles() const {
	errx(-1, "unknown DRAM cycles for %s", str().c_str());
}

std::uint32_t instr::mem_write_op::write8_swap::xfers(std::uint32_t ref_cnt) const {
	return (ref_cnt + 3)/4;
}

expr::aptr<32,8> instr::mem_write_op::write8_swap::write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const {
	expr::bvptr<32> o0 = expr::bvadd(offset, expr::constant<32>(index+0));
	expr::bvptr<32> o1 = expr::bvadd(offset, expr::constant<32>(index+1));
	expr::bvptr<32> o2 = expr::bvadd(offset, expr::constant<32>(index+2));
	expr::bvptr<32> o3 = expr::bvadd(offset, expr::constant<32>(index+3));
	expr::bvptr<8> b0 = expr::extract<7,0,32>(value);
	expr::bvptr<8> b1 = expr::extract<15,8,32>(value);
	expr::bvptr<8> b2 = expr::extract<23,16,32>(value);
	expr::bvptr<8> b3 = expr::extract<31,24,32>(value);
	array = expr::store(array, o0, b0);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+2)), expr::store(array, o1, b1), array);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+3)), expr::store(array, o2, b2), array);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+4)), expr::store(array, o3, b3), array);
	index += 4;
	return array;
}

std::string instr::mem_write_op::write32_swap::str() const {
	return "write32_swap";
}

double instr::mem_write_op::write32_swap::dram_cycles() const {
	errx(-1, "unknown DRAM cycles for %s", str().c_str());
}

std::uint32_t instr::mem_write_op::write32_swap::xfers(std::uint32_t ref_cnt) const {
	return ref_cnt;
}

expr::aptr<32,8> instr::mem_write_op::write32_swap::write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const {
	expr::bvptr<32> o0 = expr::bvadd(offset, expr::constant<32>(index+0));
	expr::bvptr<32> o1 = expr::bvadd(offset, expr::constant<32>(index+1));
	expr::bvptr<32> o2 = expr::bvadd(offset, expr::constant<32>(index+2));
	expr::bvptr<32> o3 = expr::bvadd(offset, expr::constant<32>(index+3));
	expr::bvptr<8> b0 = expr::extract<7,0,32>(value);
	expr::bvptr<8> b1 = expr::extract<15,8,32>(value);
	expr::bvptr<8> b2 = expr::extract<23,16,32>(value);
	expr::bvptr<8> b3 = expr::extract<31,24,32>(value);
	array = expr::store(array, o0, b0);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+2)), expr::store(array, o1, b1), array);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+3)), expr::store(array, o2, b2), array);
	array = expr::ite(expr::bvuge(ref, expr::constant<32>(index+4)), expr::store(array, o3, b3), array);
	index += 4;
	return array;
}

std::string instr::mem_write_op::add_imm::str() const {
	return "add_imm";
}

double instr::mem_write_op::add_imm::dram_cycles() const {
	// measured at least 248461177.051262408 ops/s at 800 Mhz
	return 3.219818925010342;
}

std::uint32_t instr::mem_write_op::add_imm::xfers(std::uint32_t ref_cnt) const {
	return 0;
}

expr::aptr<32,8> instr::mem_write_op::add_imm::write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const {
	expr::bvptr<32> o0 = expr::bvadd(offset, expr::constant<32>(0));
	expr::bvptr<32> o1 = expr::bvadd(offset, expr::constant<32>(1));
	expr::bvptr<32> o2 = expr::bvadd(offset, expr::constant<32>(2));
	expr::bvptr<32> o3 = expr::bvadd(offset, expr::constant<32>(3));
	auto p0 = expr::cast::ptr<32,8>(o0);
	auto p1 = expr::cast::ptr<32,8>(o1);
	auto p2 = expr::cast::ptr<32,8>(o2);
	auto p3 = expr::cast::ptr<32,8>(o3);
	if (!p0)
		return expr::undef_array<32,8>("non_ptr_mem_inc", o0);
	if (!p1)
		return expr::undef_array<32,8>("non_ptr_mem_inc", o1);
	if (!p2)
		return expr::undef_array<32,8>("non_ptr_mem_inc", o2);
	if (!p3)
		return expr::undef_array<32,8>("non_ptr_mem_inc", o3);
	expr::bvptr<8> s0 = expr::select(array, p0->offset);
	expr::bvptr<8> s1 = expr::select(array, p1->offset);
	expr::bvptr<8> s2 = expr::select(array, p2->offset);
	expr::bvptr<8> s3 = expr::select(array, p3->offset);
	expr::bvptr<32> res = expr::bvadd(expr::concat<8,8,8,8>(s3, s2, s1, s0), ref);
	expr::bvptr<8> b0 = expr::extract<7,0,32>(res);
	expr::bvptr<8> b1 = expr::extract<15,8,32>(res);
	expr::bvptr<8> b2 = expr::extract<23,16,32>(res);
	expr::bvptr<8> b3 = expr::extract<31,24,32>(res);
	array = expr::store(array, o0, b0);
	array = expr::store(array, o1, b1);
	array = expr::store(array, o2, b2);
	array = expr::store(array, o3, b3);
	return array;
}

state::updates instr::mem_write::perform(const state::exec& state) const {
	state::updates u;

	auto src1 = this->src1->read(state);
	auto src2 = this->src2->read(state);
	if (this->sc1)
		src1 = this->sc1->calculate(src1, state);
	if (this->sc2)
		src2 = this->sc2->calculate(src2, state);
	auto dst = expr::bvadd(src1, src2);
	auto ptr = expr::cast::ptr<32,8>(dst);
	if (!ptr)
		return {state::invalidate_mem("not_ptr_mem_write", dst)};
	auto array = state[ptr->array];

	auto ref = expr::constant<32>(this->ref_cnt);
	if (this->indirect_ref)
		ref = expr::bvadd(expr::bvlshr(state[instr::PREV_ALU], expr::constant<32>(8)), expr::constant<32>(1));

	std::uint32_t i = 0;
	for (const xfer_out* x: this->xfers)
		array = op->write(array, ptr->offset, state[*x], i, ref);
	return {state::update(ptr->array, array)};
}

instr::mem_read_local::mem_read_local(std::uint32_t id, const instr::mem_read_op* op, const instr::xfer_in* xfer, const instr::src* src1, const instr::src* src2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap) :
	mem_read(id, op, xfer, src1, nullptr, src2, nullptr, ref_cnt, indirect_ref, ctx_swap) {}

instr::mem_write_local::mem_write_local(std::uint32_t id, const instr::mem_write_op* op, const instr::xfer_out* xfer, const instr::src* src1, const instr::src* src2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap) :
	mem_write(id, op, xfer, src1, nullptr, src2, nullptr, ref_cnt, indirect_ref, ctx_swap) {}

std::string instr::mul_step_tok::start::str() const {
	return "start";
}

bool instr::mul_step_tok::start::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return true;
}

expr::bvptr<32> instr::mul_step_tok::start::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s16x16_step1::str() const {
	return "16x16_step1";
}

bool instr::mul_step_tok::s16x16_step1::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::start().next() && *mulA == *A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s16x16_step1::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s16x16_step2::str() const {
	return "16x16_step2";
}

bool instr::mul_step_tok::s16x16_step2::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s16x16_step1().next() && *mulA == *A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s16x16_step2::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s32x32_step1::str() const {
	return "32x32_step1";
}

bool instr::mul_step_tok::s32x32_step1::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::start().next() && *mulA == *A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s32x32_step1::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s32x32_step2::str() const {
	return "32x32_step2";
}

bool instr::mul_step_tok::s32x32_step2::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s32x32_step1().next() && *mulA == *A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s32x32_step2::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s32x32_step3::str() const {
	return "32x32_step3";
}

bool instr::mul_step_tok::s32x32_step3::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s32x32_step2().next() && *mulA ==* A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s32x32_step3::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s32x32_step4::str() const {
	return "32x32_step4";
}

bool instr::mul_step_tok::s32x32_step4::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s32x32_step3().next() && *mulA == *A && *mulB == *B;
}

expr::bvptr<32> instr::mul_step_tok::s32x32_step4::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s16x16_last::str() const {
	return "16x16_last";
}

bool instr::mul_step_tok::s16x16_last::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s16x16_step2().next();
}

expr::bvptr<32> instr::mul_step_tok::s16x16_last::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

expr::bvptr<32> instr::mul_step_tok::s16x16_last::calculate(expr::bvptr<32> A, expr::bvptr<32> B) const {
	// TODO: check for undefined behaviour where the upper 16 bits of A or B are not cleared
	return expr::bvmul(A, B);
}

std::string instr::mul_step_tok::s32x32_last::str() const {
	return "32x32_last";
}

bool instr::mul_step_tok::s32x32_last::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s32x32_step4().next();
}

expr::bvptr<32> instr::mul_step_tok::s32x32_last::calculate(expr::bvptr<32> A, expr::bvptr<32> B) const {
	return expr::bvmul(A, B);
}

expr::bvptr<32> instr::mul_step_tok::s32x32_last::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

std::string instr::mul_step_tok::s32x32_last2::str() const {
	return "32x32_last2";
}

bool instr::mul_step_tok::s32x32_last2::check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const {
	return mul_step == instr::mul_step_tok::s32x32_last().next();
}

expr::bvptr<32> instr::mul_step_tok::s32x32_last2::calculate(expr::bvptr<32> A, expr::bvptr<32> B) const {
	return expr::extract<63,32>(expr::bvmul(expr::extend<32>(A), expr::extend<32>(B)));
}

expr::bvptr<32> instr::mul_step_tok::s32x32_last2::next() const {
	static expr::bvptr<32> n = std::make_shared<const step_expr>();
	return n;
}

instr::hreg instr::mul_step::mulA("mulA");
instr::hreg instr::mul_step::mulB("mulB");
instr::hreg instr::mul_step::mul_state("mul_state");

instr::mul_step::mul_step(std::uint32_t id, const instr::src* srcA, const instr::src* srcB, const instr::mul_step_tok* tok)
	: ordinary(id),
	  srcA(srcA),
	  srcB(srcB),
	  tok(tok) {}

instr::mul_step::~mul_step() {
	delete(this->srcA);
	delete(this->srcB);
	delete(this->tok);
}

std::string instr::mul_step::name() const {
	return "mul_step";
}

std::string instr::mul_step::str() const {
	return instr::str() + "[" +
	this->srcA->str() + ", " +
	this->srcB->str() + "], " +
	this->tok->str();
}

bool instr::mul_step::writescc() const {
	return false;
}

unsigned int instr::mul_step::cycles() const {
	return instr::ordinary::cycles() + std::max(this->srcA->cycles(), this->srcB->cycles());
}

state::updates instr::mul_step::perform(const state::exec& state) const {
	expr::bvptr<32> step_state = state[instr::mul_step::mul_state];
	expr::bvptr<32> mulA = state[instr::mul_step::mulA];
	expr::bvptr<32> mulB = state[instr::mul_step::mulB];
	expr::bvptr<32> A = this->srcA->read(state);
	expr::bvptr<32> B = this->srcB->read(state);
	if (this->tok->check(step_state, mulA, mulB, A, B)) {
		return {
			state::update(instr::mul_step::mul_state, this->tok->next()),
			state::update(instr::mul_step::mulA, A),
			state::update(instr::mul_step::mulB, B),
		};
	} else {
		return {
			state::update(instr::mul_step::mul_state, expr::undef<32>("mul_step_sequence", step_state)),
			state::update(instr::mul_step::mulA,      expr::undef<32>("mul_step_sequence", step_state)),
			state::update(instr::mul_step::mulB,      expr::undef<32>("mul_step_sequence", step_state)),
		};
	}
}

instr::mul_step_last::mul_step_last(std::uint32_t id, const instr::dst* dst, const instr::mul_step_tok::last* tok, bool gpr_wrboth)
	: assign(id, dst, gpr_wrboth),
	  tok(tok) {}

instr::mul_step_last::~mul_step_last() {
	delete(this->tok);
}

std::string instr::mul_step_last::name() const {
	return "mul_step";
}

std::string instr::mul_step_last::str() const {
	return assign::str() + "--], " +
	this->tok->str() +
	(this->gpr_wrboth ? ", gpr_wrboth" : "");
}

bool instr::mul_step_last::writescc() const {
	return true;
}

instr::assign::result instr::mul_step_last::calculate(const state::exec& state) const {
	expr::bvptr<32> step_state = state[instr::mul_step::mul_state];
	expr::bvptr<32> mulA = state[instr::mul_step::mulA];
	expr::bvptr<32> mulB = state[instr::mul_step::mulB];
	if (this->tok->check(step_state, mulA, mulB, expr::undef<32>(), expr::undef<32>())) {
		return result(
			tok->calculate(mulA, mulB),
			expr::undef<1>(),
			expr::undef<1>(),
			{
			state::update(instr::mul_step::mul_state, this->tok->next()),
			}
		);
	} else {
		return result(
			expr::undef<32>("mul_step_sequence", step_state),
			expr::undef<1>("mul_step_sequence", step_state),
			expr::undef<1>("mul_step_sequence", step_state),
			{
			state::update(instr::mul_step::mul_state, expr::undef<32>("mul_step_sequence", step_state)),
			state::update(instr::mul_step::mulA,      expr::undef<32>("mul_step_sequence", step_state)),
			state::update(instr::mul_step::mulB,      expr::undef<32>("mul_step_sequence", step_state)),
			}
		);
	}
}

instr::nop::nop(unsigned int id)
	: instr::ordinary(id) {}

std::string instr::nop::name() const {
	return "nop";
}

bool instr::nop::writescc() const {
	return false;
}

