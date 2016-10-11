`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

interface forwarding_unit_if;

  //inputs
  logic [31:0] read1;
  logic [31:0] read2;
  logic [31:0] write1;
  logic [31:0] write2;
  logic [31:0] write3;

  //outputs
  logic [31:0] forward1;
  logic [31:0] forward2;
  logic forw_en1, forw_en2, forw_en3;
  logic forw_en4, forw_en5, forw_en6;

  modport fuf (
  input read1, read2,
  input write1, write2, write3,
  output forward1, forward2,
  output forw_en1, forw_en2, forw_en3,
  output forw_en4, forw_en5, forw_en6
  );

endinterface

`endif
