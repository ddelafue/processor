


`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"


interface request_unit_if;


  import cpu_types_pkg::*;

  logic ihiti, dhiti, ihito, dhito;
  logic dREN, dWEN, iREN;
  logic memread, memwrite, instrread, pcenable;
  logic halt;
  logic [31:0] instr;
  modport ru (
    input ihiti, dhiti, memread, memwrite, instrread, halt, instr,
    output ihito, dhito, dREN, dWEN, iREN,pcenable
  );

endinterface

`endif

