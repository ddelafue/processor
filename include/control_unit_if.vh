`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH


// types
`include "cpu_types_pkg.vh"

interface control_unit_if;

  import cpu_types_pkg::*;

  logic ihit, dhit; //signals telling the control unit that the data is ava.

//  word_t imemload, imem; //instruction info sent back to the thing

  logic [3:0] outputop; //sending op to the alu

  regbits_t rd, rt, rs; //set the location for the register files

  logic [31:0] instr; //instruction coming from the memory blooooccckk

  logic memread, memwrite, instrread;

  logic [15:0] immOut; //output signal to mux

  logic jrsig, zero; //do it with zero
  logic aluSig;
  logic regdst;
  logic [4:0] shiftNum;
  logic shiftSig;
  logic reg_wr;
  logic immSig;
  logic beq;
  logic bne;
  logic write_sig;
  logic lui;
  logic halt;
  logic jump;
  logic [31:0] pcAddrIn;
  logic [31:0] pcAddrOut;

  modport cuif (
    input ihit, dhit, instr, pcAddrIn,
    output rd, rt, rs, immOut, jrsig, zero, outputop,
           aluSig, shiftSig, shiftNum, reg_wr, immSig, beq, bne, write_sig, lui,
           halt, pcAddrOut, memread, memwrite, instrread, jump, regdst
    );


endinterface

`endif







