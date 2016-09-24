

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
  logic WENo;
  logic reg_wri;
  logic reg_wro;
  logic [31:0] wseli;
  logic [31:0] wselo;
  logic write_sigi;
  logic write_sigo;
  logic memory_en;
  logic flush;
  logic halti;
  logic halto;
    modport memif (
    input flush,dloadi,alui,WENi,reg_wri,wseli, memory_en,write_sigi,halti,
    output dloado, aluo,WENo,reg_wro,wselo, write_sigo,halto
  );

endinterface

`endif
