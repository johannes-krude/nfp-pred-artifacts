%option nounput
%option noyywrap
%option prefix="instr"

%{
#include "estimator/instr.tab.hpp"
#include "estimator/instr.hpp"

#include <cstring>
%}


%%
alu            {return alu;}
alu_shf        {return alu_shf;}
asr            {return asr;}
bcc            {return bcc;}
bcs            {return bcs;}
beq            {return beq;}
bge            {return bge;}
bgt            {return bgt;}
ble            {return ble;}
blt            {return blt;}
bmi            {return bmi;}
bne            {return bne;}
bpl            {return bpl;}
bvc            {return bvc;}
bvs            {return bvs;}
br             {return br;}
dbl_shf        {return dbl_shf;}
immed          {return immed;}
immed_w1       {return immed_w1;}
ld_field       {return ld_field;}
ld_field_w_clr {return ld_field_w_clr;}
local_csr_wr   {return local_csr_wr;}
mem            {return mem;}
mul_step       {return mul_step;}
nop            {return nop;}

gpr_wrboth     {return gpr_wrboth;}
defer          {return defer;}
ctx_swap[[]sig {return ctx_swap;}
indirect_ref   {return indirect_ref;}

\+ {
	instr_lval.alu_op = new instr::alu_op::plus();
	return Alu_op;
}
\+16 {
	instr_lval.alu_op = new instr::alu_op::plus16();
	return Alu_op;
}
\+8 {
	instr_lval.alu_op = new instr::alu_op::plus8();
	return Alu_op;
}
\+carry {
	instr_lval.alu_op = new instr::alu_op::plus_carry();
	return Alu_op;
}
-carry {
	instr_lval.alu_op = new instr::alu_op::minus_carry();
	return Alu_op;
}
- {
	instr_lval.alu_op = new instr::alu_op::minus();
	return Alu_op;
}
B-A {
	instr_lval.alu_op = new instr::alu_op::neg_minus();
	return Alu_op;
}
B {
	instr_lval.alu_op = new instr::alu_op::B();
	return Alu_op;
}
~B {
	instr_lval.alu_op = new instr::alu_op::invB();
	return Alu_op;
}
AND {
	instr_lval.alu_op = new instr::alu_op::op_and();
	return Alu_op;
}
~AND {
	instr_lval.alu_op = new instr::alu_op::inv_and();
	return Alu_op;
}
AND~ {
	instr_lval.alu_op = new instr::alu_op::and_inv();
	return Alu_op;
}
OR {
	instr_lval.alu_op = new instr::alu_op::op_or();
	return Alu_op;
}
XOR {
	instr_lval.alu_op = new instr::alu_op::op_xor();
	return Alu_op;
}

read32_swap {
	instr_lval.mem_read_op = new instr::mem_read_op::read32_swap();
	return Mem_read_op;
}
write8_swap {
	instr_lval.mem_write_op = new instr::mem_write_op::write8_swap();
	return Mem_write_op;
}
write32_swap {
	instr_lval.mem_write_op = new instr::mem_write_op::write32_swap();
	return Mem_write_op;
}
add_imm {
	instr_lval.mem_write_op = new instr::mem_write_op::add_imm();
	return Mem_write_op;
}

\<\<[1-9][0-9]? {
	unsigned int amount;
	sscanf(yytext, "<<%u", &amount);
	instr_lval.shift_cntl = new instr::shift_cntl::leftim(amount);
	return Shift;
}
\>\>[1-9][0-9]? {
	unsigned int amount;
	sscanf(yytext, ">>%u", &amount);
	instr_lval.shift_cntl = new instr::shift_cntl::rightim(amount);
	return ShiftARight;
}
\<\<rot[1-9][0-9]? {
	unsigned int amount;
	sscanf(yytext, "<<rot%u", &amount);
	instr_lval.shift_cntl = new instr::shift_cntl::rotleftim(amount);
	return Shift;
}
\>\>rot[1-9][0-9]? {
	unsigned int amount;
	sscanf(yytext, ">>rot%u", &amount);
	instr_lval.shift_cntl = new instr::shift_cntl::rotrightim(amount);
	return Shift;
}
\<\<indirect {
	instr_lval.shift_cntl = new instr::shift_cntl::leftindirect();
	return Shift;
}
\>\>indirect {
	instr_lval.shift_cntl = new instr::shift_cntl::rightindirect();
	return ShiftARight;
}

start {
	instr_lval.mul_step_tok = new instr::mul_step_tok::start();
	return Mul_step_tok;
}
16x16_step1 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s16x16_step1();
	return Mul_step_tok;
}
16x16_step2 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s16x16_step2();
	return Mul_step_tok;
}
32x32_step1 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_step1();
	return Mul_step_tok;
}
32x32_step2 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_step2();
	return Mul_step_tok;
}
32x32_step3 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_step3();
	return Mul_step_tok;
}
32x32_step4 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_step4();
	return Mul_step_tok;
}
16x16_last {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s16x16_last();
	return Mul_step_last_tok;
}
32x32_last {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_last();
	return Mul_step_last_tok;
}
32x32_last2 {
	instr_lval.mul_step_tok = new instr::mul_step_tok::s32x32_last2();
	return Mul_step_last_tok;
}

[.](0|[1-9][0-9]*) {
	sscanf(yytext, ".%u", &instr_lval.uint);
	return Id;
}
[01][01][01][01] {
	sscanf(yytext, "%u", &instr_lval.uint);
	return Mask;
}
0|[1-9][0-9]* {
	sscanf(yytext, "%u", &instr_lval.uint);
	return UInt;
}
0x[0-9a-fA-F]+ {
	sscanf(yytext, "%x", &instr_lval.uint);
	return HexInt;
}
[0-9a-fA-F]+: {
	return Addr;
}
-- {
	instr_lval.omitted = new instr::omitted();
	return Omitted;
}
gpr[AB]_[1-9]?[0-9] {
	char bank;
	unsigned int number;
	sscanf(yytext, "gpr%c_%u", &bank, &number);
	instr_lval.gpr = new instr::gpr(bank, number);
	return Gpr;
}
\$xfer_[1-9]?[0-9] {
	sscanf(yytext, "$xfer_%u", &instr_lval.uint);
	return Xfer;
}
\*l\$index[0-3]\[[1-9]?[0-9]\] {
	unsigned int addr;
	uint32_t offset;
	sscanf(yytext, "*l$index%u[%u]", &addr, &offset);
	instr_lval.lmindexed = new instr::lmindexed(addr, offset);
	return Indexed;
}
\*l\$index[0-3] {
	unsigned int addr;
	sscanf(yytext, "*l$index%u", &addr);
	instr_lval.lmindexed = new instr::lmindexed(addr, 0);
	return Indexed;
}
ActLMAddr[0-3] {
	unsigned int addr;
	sscanf(yytext, "ActLMAddr%u", &addr);
	instr_lval.local_csr = &instr::ActLMAddr[addr];
	return Local_csr;
}

[\t\n ] {
}

. {
	return yytext[0];
};
%%
