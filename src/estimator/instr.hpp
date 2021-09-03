#pragma once

#include "estimator/expr.hpp"
#include "estimator/state.hpp"

#include <string>
#include <vector>
#include <memory>

class instr {
public:
	static std::shared_ptr<const instr> build_instr(std::string str);

	enum type{
		RTN,
		FIN, /*special instruction injected at the end of asm source
				Indicates the last instruction and as a link point to all branches, 
				that has jump lable out of asm code*/
		BRANCH,
		JUMP,
		MEM,
		OTHER   /*general sequential instruction*/
	};

	class src;
	class dst;

	class gpr;
	class lmindexed;
	class xfer;
	class xfer_in;
	class xfer_out;
	class hreg;
	class local_csr;
	class flag;

	class constant;
	class omitted;
	class alu_op;
	class mem_read_op;
	class mem_write_op;
	class shift_cntl;
	class mul_step_tok;

	class ordinary;
	class assign;
	class branch;
	class proper_branch;
	class alu_like;
	class immed_like;
	class ld_field_like;

	class fin;
	class alu;
	class alu_shf;
	class asr;
	class bcc;
	class bcs;
	class beq;
	class bge;
	class bgt;
	class ble;
	class blt;
	class bmi;
	class bne;
	class bpl;
	class bvc;
	class bvs;
	class br;
	class dbl_shf;
	class immed;
	class immed_w1;
	class ld_field;
	class ld_field_w_clr;
	class local_csr_wr;
	template <class O, class X> class mem;
	class mem_read;
	class mem_read_local;
	class mem_read_remote;
	class mem_write;
	class mem_write_local;
	class mem_write_remote;
	class mul_step;
	class mul_step_last;
	class nop;

	static const instr::flag N;
	static const instr::flag Z;
	static const instr::flag V;
	static const instr::flag C;
	static const instr::hreg PREV_ALU;
	static const instr::hreg PREV_A;
	static const std::vector<instr::local_csr> ActLMAddr;

private:
	const std::uint32_t id;

public:
	instr(std::uint32_t id);
	virtual ~instr() = default;
	std::uint32_t get_id() const;
	virtual std::string name() const = 0;
	virtual std::string str() const;
	virtual type type() const = 0;
	virtual bool waits() const = 0;
	virtual unsigned int cycles() const;
	virtual unsigned int max_cycles() const;
	virtual double dram_cycles() const = 0;
	virtual bool writescc() const = 0;
	virtual state::updates perform(const state::exec& state) const;
	virtual expr::lptr check(const state::exec& state) const;
};

class instr::dst {
public:
	virtual ~dst() = default;
	virtual std::string str() const = 0;
	virtual unsigned int cycles() const = 0;
	virtual state::uptr write(expr::bvptr<32>, const state::exec& state) const = 0;
};

class instr::src {
public:
	virtual ~src() = default;
	virtual std::string str() const = 0;
	virtual unsigned int cycles() const = 0;
	virtual expr::bvptr<32> read(const state::exec& state) const = 0;
};

class instr::gpr : public instr::dst, public instr::src, public virtual state::deposit::reg {
private:
	const char bank;
	const std::uint8_t number;
public:
	gpr(char bank, std::uint8_t number);
	std::string str() const override;
	std::string location() const override;
	unsigned int cycles() const override;
	instr::gpr* flip() const;
	expr::bvptr<32> read(const state::exec& state) const override;
	state::uptr write(expr::bvptr<32>, const state::exec& state) const override;
};

class instr::lmindexed : public instr::dst, public instr::src {
private:
	const std::uint8_t addr;
	const std::uint8_t offset;
public:
	lmindexed(std::uint8_t addr, std::uint8_t offset);
	std::string str() const override;
	std::string location() const;
	unsigned int cycles() const override;
	expr::bvptr<32> read(const state::exec& state) const override;
	state::uptr write(expr::bvptr<32>, const state::exec& state) const override;
};

class instr::xfer {
protected:
	const std::uint8_t number;
public:
	xfer(std::uint8_t number);
	virtual ~xfer() = default;
	virtual std::string str() const;
	virtual instr::xfer* next() const = 0;
};

class instr::xfer_in : public instr::xfer, public instr::src, public virtual state::deposit::reg {
public:
	using xfer::xfer;
	std::string str() const override { return xfer::str(); }
	std::string location() const override;
	unsigned int cycles() const override;
	instr::xfer_in* next() const override;
	expr::bvptr<32> read(const state::exec& state) const override;
};

class instr::xfer_out : public instr::xfer, public instr::dst, public virtual state::deposit::reg {
public:
	using xfer::xfer;
	std::string str() const override { return xfer::str(); }
	std::string location() const override;
	unsigned int cycles() const override;
	instr::xfer_out* next() const override;
	state::uptr write(expr::bvptr<32>, const state::exec& state) const override;
};

class instr::hreg : public virtual state::deposit::reg {
private:
	const std::string name;
public:
	hreg(const std::string name);
	virtual std::string str() const;
	std::string location() const override;
};

class instr::local_csr : public instr::hreg {
private:
	unsigned int write_latency;
public:
	local_csr(const std::string name, unsigned int write_latency);
	virtual state::uptr write(expr::bvptr<32> e) const;
};

class instr::flag : public virtual state::deposit::flag {
private:
	const std::string name;
public:
	flag(const std::string name);
	virtual std::string str() const;
	std::string location() const override;
};

class instr::constant : public instr::src {
private:
	const std::uint32_t value;
public:
	constant(std::uint32_t val);
	std::string str() const override;
	unsigned int cycles() const override;
	virtual expr::bvptr<16> e16() const;
	virtual expr::bvptr<32> e32() const;
	expr::bvptr<32> read(const state::exec& state) const override;
};

class instr::omitted : public instr::dst, public instr::src {
public:
	std::string str() const override;
	expr::bvptr<32> read(const state::exec& state) const override;
	virtual std::string location() const;
	unsigned int cycles() const override;
	state::uptr write(expr::bvptr<32>, const state::exec& state) const override;
};

class instr::ordinary : public instr {
public:
	using instr::instr;
	static const unsigned int COST = 1;
	enum instr::type type() const override;
	bool waits() const override;
	unsigned int cycles() const override;
	double dram_cycles() const override;
};

class instr::assign : public instr::ordinary {
protected:
	const instr::dst* dst;
	const instr::gpr* dst2;
	const bool gpr_wrboth;
public:
	assign(std::uint32_t id, const instr::dst* dst, bool gpr_wrboth);
	~assign();
	std::string str() const override;
	unsigned int cycles() const override;
	state::updates perform(const state::exec& state) const override;

	class result {
	public:
		expr::bvptr<32> dst;
		expr::bvptr<1> v;
		expr::bvptr<1> c;
		state::updates u;
		result(expr::bvptr<32> dst, expr::bvptr<1> v, expr::bvptr<1> c, state::updates u);
		result(expr::bvptr<32> dst, expr::bvptr<1> v, expr::bvptr<1> c);
		result(expr::bvptr<32> dst, state::updates u);
		result(expr::bvptr<32> dst);
	};
	virtual result calculate(const state::exec& state) const = 0;
};

class instr::shift_cntl {
public:
	class im;
	class aright;
	class leftim;
	class rightim;
	class rotleftim;
	class rotrightim;
	class leftindirect;
	class rightindirect;

	shift_cntl() = default;
	virtual ~shift_cntl() = default;
	virtual std::string str() const = 0;
	virtual expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const = 0;
	virtual expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const = 0;
};

class instr::shift_cntl::im {
protected:
	const std::uint8_t amount;
public:
	im(std::uint8_t amount);
};

class instr::shift_cntl::leftim : public instr::shift_cntl, public instr::shift_cntl::im {
public:
	using im::im;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
};

class instr::shift_cntl::aright : public instr::shift_cntl {
public:
	virtual expr::bvptr<33> calculate(expr::bvptr<33> e, const state::exec& state) const = 0;
};

class instr::shift_cntl::rightim : public instr::shift_cntl::aright, public instr::shift_cntl::im {
public:
	using im::im;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
	expr::bvptr<33> calculate(expr::bvptr<33> e, const state::exec& state) const override;
};

class instr::shift_cntl::rotleftim : public instr::shift_cntl, public instr::shift_cntl::im {
public:
	using im::im;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
};

class instr::shift_cntl::rotrightim : public instr::shift_cntl, public instr::shift_cntl::im {
public:
	using im::im;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
};

class instr::shift_cntl::leftindirect : public instr::shift_cntl {
public:
	using shift_cntl::shift_cntl;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
};

class instr::shift_cntl::rightindirect : public instr::shift_cntl::aright {
public:
	using aright::aright;
	std::string str() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> e, const state::exec& state) const override;
	expr::bvptr<64> calculate(expr::bvptr<64> e, const state::exec& state) const override;
	expr::bvptr<33> calculate(expr::bvptr<33> e, const state::exec& state) const override;
};

class instr::branch : public instr {
public:
	static const unsigned int COST_TRUE_EARLY  = 3;
	static const unsigned int COST_TRUE  = 4;
	static const unsigned int COST_FALSE = 1;
protected:
	const std::uint32_t target;
	const std::uint32_t defer;
public:
	branch(std::uint32_t id, std::uint32_t target, std::uint32_t defer);
	std::string str() const override;
	bool waits() const override;
	bool writescc() const override;
	double dram_cycles() const override;
	std::uint32_t br_target() const;
};

class instr::proper_branch : public instr::branch {
public:
	using instr::branch::branch;
	enum instr::type type() const override;
};

class instr::fin : public instr {
public:
	static std::shared_ptr<const instr::fin> build();

	static const std::uint32_t ID = 15000;

	fin();
	std::string name() const override;
	enum instr::type type() const override;
	bool waits() const override;
	bool writescc() const override;
	double dram_cycles() const override;
};

class instr::alu_op {
public:
	class plus;
	class plus16;
	class plus8;
	class plus_carry;
	class minus;
	class minus_carry;
	class neg_minus;
	class B;
	class invB;
	class op_and;
	class inv_and;
	class and_inv;
	class op_or;
	class op_xor;

	alu_op() = default;
	virtual ~alu_op() = default;
	virtual std::string str() const = 0;
	virtual bool writes_prev() const = 0;
	virtual instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const = 0;
};

class instr::alu_op::plus : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::plus16 : public instr::alu_op::plus {
public:
	std::string str() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::plus8 : public instr::alu_op::plus {
public:
	std::string str() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::plus_carry : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::minus_carry : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::minus : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::neg_minus : public instr::alu_op::minus {
public:
	std::string str() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::B : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::invB : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::op_and : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::inv_and : public instr::alu_op::op_and {
public:
	std::string str() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::and_inv : public instr::alu_op::op_and {
public:
	std::string str() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::op_or : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_op::op_xor : public instr::alu_op {
public:
	std::string str() const override;
	bool writes_prev() const override;
	instr::assign::result calculate(expr::bvptr<32> A, expr::bvptr<32> B, const state::exec& state) const override;
};

class instr::alu_like : public instr::assign {
protected:
	const instr::src* srcA;
	const instr::alu_op* op;
	const instr::src* srcB;
	const instr::shift_cntl* sc;
public:
	alu_like(std::uint32_t id, const instr::dst* dst, const instr::src* srcA, const instr::alu_op* op, const instr::src* srcB, const instr::shift_cntl* sc, bool gpr_wrboth);
	~alu_like();
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
	result calculate(const state::exec& state) const override;
};

class instr::alu : public instr::alu_like {
public:
	alu(std::uint32_t id, const instr::dst* dst, const instr::src* srcA, const instr::alu_op* op, const instr::src* srcB, bool gpr_wrboth);
	std::string name() const override;
};

class instr::alu_shf : public instr::alu_like {
public:
	using alu_like::alu_like;
	std::string name() const override;
};

class instr::asr : public instr::assign {
protected:
	const instr::src* src;
	const instr::shift_cntl::aright* sc;
public:
	asr(std::uint32_t id, const instr::dst* dst, const instr::src* src, const instr::shift_cntl::aright* sc, bool gpr_wrboth);
	~asr();
	std::string name() const override;
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
	result calculate(const state::exec& state) const override;
};

class instr::bcc : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bcs : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::beq : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bge : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bgt : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::ble : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::blt : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bmi : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bne : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bpl : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bvc : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::bvs : public instr::proper_branch {
public:
	using instr::proper_branch::proper_branch;
	std::string name() const override;
	expr::lptr check(const state::exec& state) const override;
};

class instr::br : public instr::branch {
public:
	br(std::uint32_t id, std::uint32_t target, std::uint32_t defer);
	std::string name() const override;
	enum instr::type type() const override;
	unsigned int cycles() const override;
};

class instr::dbl_shf : public instr::assign {
protected:
	const instr::src* srcA;
	const instr::src* srcB;
	const instr::shift_cntl* sc;
public:
	dbl_shf(std::uint32_t id, const instr::dst* dst, const instr::src* srcA, const instr::src* srcB, const instr::shift_cntl* sc, bool gpr_wrboth);
	~dbl_shf();
	std::string name() const override;
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
	result calculate(const state::exec& state) const override;
};

class instr::immed_like : public instr::assign {
protected:
	const instr::constant* im;
	const instr::shift_cntl* sc;
public:
	immed_like(std::uint32_t id, const instr::dst* dst, const instr::constant* im, const instr::shift_cntl* sc, bool gpr_wrboth);
	~immed_like();
	std::string str() const override;
	bool writescc() const override;
};

class instr::immed : public instr::immed_like {
public:
	using immed_like::immed_like;
	std::string name() const override;
	result calculate(const state::exec& state) const override;
};

class instr::immed_w1 : public instr::immed_like {
public:
	immed_w1(std::uint32_t id, const instr::dst* dst, const instr::constant* im, bool gpr_wrboth);
	std::string name() const override;
	result calculate(const state::exec& state) const override;
};

class instr::ld_field_like : public instr::assign {
protected:
	const std::uint32_t mask;
	const instr::src* src;
	const instr::shift_cntl* sc;
public:
	ld_field_like(std::uint32_t id, const instr::dst* dst, std::uint32_t mask, const instr::src* src, const instr::shift_cntl* sc, bool gpr_wrboth);
	~ld_field_like();
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
};

class instr::ld_field : public instr::ld_field_like {
public:
	using ld_field_like::ld_field_like;
	std::string name() const override;
	result calculate(const state::exec& state) const override;
};

class instr::ld_field_w_clr : public instr::ld_field_like {
public:
	using ld_field_like::ld_field_like;
	std::string name() const override;
	result calculate(const state::exec& state) const override;
};

class instr::local_csr_wr : public instr::ordinary {
private:
	const instr::local_csr* local_csr;
	const instr::src* src;
public:
	local_csr_wr(std::uint32_t id, const instr::local_csr* local_csr, const instr::src* src);
	~local_csr_wr();
	std::string name() const override;
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
	state::updates perform(const state::exec& state) const override;
};

template <class O, class X>
class instr::mem : public instr {
public:
	static const unsigned int COST_NOSWAP_MIN  = 1;
	static const unsigned int COST_SWAP_MIN  = 3;
	static const unsigned int COST_32BIT_MAX  = 16;
	static const unsigned int COST_40BIT_MAX  = 25;
protected:
	const O* op;
	const std::vector<const X*> xfers;
	const instr::src* src1;
	const instr::shift_cntl* sc1;
	const instr::src* src2;
	const instr::shift_cntl* sc2;
	const std::uint32_t ref_cnt;
	const bool indirect_ref;
	const std::uint32_t ctx_swap;
	static const std::uint32_t REF_CNT_MAX = 32;
public:
	mem(std::uint32_t id, const O* op, const X* xfer, const instr::src* src1, const instr::shift_cntl* sc1, const instr::src* src2, const instr::shift_cntl* sc2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap);
	~mem();
	std::string name() const override;
	std::string str() const override;
	enum instr::type type() const override;
	bool writescc() const override;
	bool waits() const override;
	unsigned int cycles() const override;
	unsigned int max_cycles() const override;
	double dram_cycles() const override;
};

class instr::mem_read_op {
public:
	class read32_swap;

	mem_read_op() = default;
	virtual ~mem_read_op() = default;
	virtual std::string str() const = 0;
	virtual double dram_cycles() const = 0;
	virtual std::uint32_t xfers(std::uint32_t ref_cnt) const = 0;
	virtual expr::bvptr<32> read(expr::bvptr<32> ptr, std::uint32_t& index, const state::exec& state) const = 0;
};

class instr::mem_read_op::read32_swap : public instr::mem_read_op {
public:
	using mem_read_op::mem_read_op;
	std::string str() const override;
	double dram_cycles() const override;
	std::uint32_t xfers(std::uint32_t ref_cnt) const override;
	expr::bvptr<32> read(expr::bvptr<32> ptr, std::uint32_t& index, const state::exec& state) const override;
};

class instr::mem_read : public instr::mem<instr::mem_read_op,instr::xfer_in> {
public:
	using mem<instr::mem_read_op,instr::xfer_in>::mem;
	state::updates perform(const state::exec& state) const override;
};

class instr::mem_read_local : public instr::mem_read {
public:
	mem_read_local(std::uint32_t id, const instr::mem_read_op* op, const instr::xfer_in* xfer, const instr::src* src1, const instr::src* src2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap);
};

class instr::mem_read_remote : public instr::mem_read {
public:
	using mem_read::mem_read;
};

class instr::mem_write_op {
public:
	class write8_swap;
	class write32_swap;
	class add_imm;

	mem_write_op() = default;
	virtual ~mem_write_op() = default;
	virtual std::string str() const = 0;
	virtual double dram_cycles() const = 0;
	virtual std::uint32_t xfers(std::uint32_t ref_cnt) const = 0;
	virtual expr::aptr<32,8> write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const = 0;
};

class instr::mem_write_op::write8_swap : public instr::mem_write_op {
public:
	using mem_write_op::mem_write_op;
	std::string str() const override;
	double dram_cycles() const override;
	std::uint32_t xfers(std::uint32_t ref_cnt) const override;
	expr::aptr<32,8> write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const override;
};

class instr::mem_write_op::write32_swap : public instr::mem_write_op {
public:
	using mem_write_op::mem_write_op;
	std::string str() const override;
	double dram_cycles() const override;
	std::uint32_t xfers(std::uint32_t ref_cnt) const override;
	expr::aptr<32,8> write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const override;
};

class instr::mem_write_op::add_imm : public instr::mem_write_op {
public:
	using mem_write_op::mem_write_op;
	std::string str() const override;
	double dram_cycles() const override;
	std::uint32_t xfers(std::uint32_t ref_cnt) const override;
	expr::aptr<32,8> write(expr::aptr<32,8> array, expr::bvptr<32> offset, expr::bvptr<32> value, std::uint32_t& index, expr::bvptr<32> ref) const override;
};

class instr::mem_write : public instr::mem<instr::mem_write_op,instr::xfer_out> {
public:
	using mem<instr::mem_write_op,instr::xfer_out>::mem;
	state::updates perform(const state::exec& state) const override;
};

class instr::mem_write_local : public instr::mem_write {
public:
	mem_write_local(std::uint32_t id, const instr::mem_write_op* op, const instr::xfer_out* xfer, const instr::src* src1, const instr::src* src2, std::uint32_t ref_cnt, bool indirect_ref, std::uint32_t ctx_swap);
};

class instr::mem_write_remote : public instr::mem_write {
public:
	using mem_write::mem_write;
};

class instr::mul_step_tok {
public:
	enum step {
		INVALID = 0,
		START,
		S16X16_STEP1,
		S16X16_STEP2,
		S16X16_LAST,
		S32X32_STEP1,
		S32X32_STEP2,
		S32X32_STEP3,
		S32X32_STEP4,
		S32X32_LAST,
		S32X32_LAST2,
	};


	class start;
	class s16x16_step1;
	class s16x16_step2;
	class s32x32_step1;
	class s32x32_step2;
	class s32x32_step3;
	class s32x32_step4;

	class last;
	class s16x16_last;
	class s32x32_last;
	class s32x32_last2;

	mul_step_tok() = default;
	virtual ~mul_step_tok() = default;
	virtual std::string str() const = 0;
	virtual bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const = 0;
	virtual expr::bvptr<32> next() const = 0;
};

class instr::mul_step_tok::start : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s16x16_step1 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s16x16_step2 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s32x32_step1 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s32x32_step2 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s32x32_step3 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::s32x32_step4 : public instr::mul_step_tok {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::mul_step_tok;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
};

class instr::mul_step_tok::last : public instr::mul_step_tok {
public:
	using instr::mul_step_tok::mul_step_tok;
	virtual expr::bvptr<32> calculate(expr::bvptr<32> A, expr::bvptr<32> B) const = 0;
};

class instr::mul_step_tok::s16x16_last : public instr::mul_step_tok::last {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::last::last;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> A, expr::bvptr<32> B) const override;
};

class instr::mul_step_tok::s32x32_last : public instr::mul_step_tok::last {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::last::last;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> A, expr::bvptr<32> B) const override;
};

class instr::mul_step_tok::s32x32_last2 : public instr::mul_step_tok::last {
public:
	class step_expr : public expr::undefined<32> {};
	using instr::mul_step_tok::last::last;
	std::string str() const override;
	bool check(expr::bvptr<32> mul_step, expr::bvptr<32> mulA, expr::bvptr<32> mulB, expr::bvptr<32> A, expr::bvptr<32> B) const override;
	expr::bvptr<32> next() const override;
	expr::bvptr<32> calculate(expr::bvptr<32> A, expr::bvptr<32> B) const override;
};

class instr::mul_step : public instr::ordinary {
public:
	static instr::hreg mulA;
	static instr::hreg mulB;
	static instr::hreg mul_state;
protected:
	const instr::src* srcA;
	const instr::src* srcB;
	const instr::mul_step_tok* tok;
public:
	mul_step(std::uint32_t id, const instr::src* srcA, const instr::src* srcB, const instr::mul_step_tok* tok);
	~mul_step();
	std::string name() const override;
	std::string str() const override;
	bool writescc() const override;
	unsigned int cycles() const override;
	state::updates perform(const state::exec& state) const override;
};

class instr::mul_step_last : public instr::assign {
protected:
	const instr::mul_step_tok::last* tok;
public:
	mul_step_last(std::uint32_t id, const instr::dst* dst,  const instr::mul_step_tok::last* tok, bool gpr_wrboth);
	~mul_step_last();
	std::string name() const override;
	std::string str() const override;
	bool writescc() const override;
	result calculate(const state::exec& state) const override;
};

class instr::nop : public instr::ordinary {
public:
	nop(std::uint32_t id);
	std::string name() const override;
	bool writescc() const override;
};

