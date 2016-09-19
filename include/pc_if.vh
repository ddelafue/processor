`ifndef PC_IF_VH
`define PC_IF_VH


// types
`include "cpu_types_pkg.vh"

interface pc_if;

  import cpu_types_pkg::*;

  logic [31:0] ladd;
  logic beq;
  logic bne;
  logic jrsig;
  logic jsig;
  logic [31:0] jrval;
  logic [31:0] jumpval;
  logic zero;
  logic [31:0] brval;
  logic pcenable;

  modport pcs (
    input beq, bne, jrsig, jsig, jrval, jumpval,zero, brval, pcenable,
    output ladd
    );

endinterface
`endif




