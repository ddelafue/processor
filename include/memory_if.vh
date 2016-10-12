

`ifndef MEMORY_IF_VH
`define MEMORY_IF_VH

// types
`include "cpu_types_pkg.vh"


interface memory_if;


  import cpu_types_pkg::*;

  logic [31:0] dloadi;
  logic [31:0] dloado;
  logic [31:0] alui;
  logic [31:0] aluo;
  logic WENi;
  logic dRENi;
  logic WENo;
  logic reg_wri;
  logic reg_wro;
  logic [4:0] wseli;
  logic [4:0] wselo;
  logic write_sigi;
  logic write_sigo;
  logic memory_en;
  logic flush;
  logic halti;
  logic halto;
  opcode_t memory_opcodei;
  opcode_t memory_opcodeo;

    modport memif (
    input flush,dloadi,alui,WENi,reg_wri,wseli, memory_en,write_sigi,halti,
memory_opcodei, dRENi,
    output dloado, aluo,WENo,reg_wro,wselo, write_sigo,halto, memory_opcodeo
  );

endinterface

`endif
