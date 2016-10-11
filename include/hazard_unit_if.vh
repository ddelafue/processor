`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

interface hazard_unit_if;

  //inputs
  logic dhit, ihit;
  logic memWEN, memREN;

  //outputs
  logic decode_en, execute_en, fetch_en, memory_en, edeassert, ddeassert,
fdeassert, mdeassert,beq,bne,zero, jr, j;
  logic [4:0] read1, read2;
  logic [4:0] write1, write2, write3;


  modport haz (
    input   dhit, ihit, memWEN, memREN,beq,bne,zero, jr, j, read1, read2,
write1, write2, write3,
    output  decode_en, execute_en, fetch_en, memory_en, edeassert, ddeassert,
fdeassert, mdeassert
 );

endinterface

`endif
