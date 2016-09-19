
`ifndef EXTENDER_IF_VH
`define EXTENDER_IF_VH


// types
`include "cpu_types_pkg.vh"

interface extender_if;

  import cpu_types_pkg::*;

  logic [15:0] inputimm;
  logic aluop;
  logic [31:0] outputimm;
  logic zero;
  logic lui;
  logic shiftSig;

  modport ex (
    input inputimm, zero, lui, shiftSig,
    output outputimm
    );

endinterface

`endif
