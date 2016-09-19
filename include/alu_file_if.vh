/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/

`ifndef ALU_FILE_IF_VH
`define ALU_FILE_IF_VH

`include "cpu_types_pkg.vh"

interface alu_file_if;
  import cpu_types_pkg::*;
  logic [3:0] op;
  word_t input1,input2, output1;
  logic zero, overflow, negative;



  modport rf (
    input op, input1, input2,
    output zero, overflow, negative, output1
  );
  modport tb (
    input zero, overflow, negative, output1,
    output op, input1, input2
  );

endinterface

`endif

