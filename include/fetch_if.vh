


`ifndef FETCH_IF_VH
`define FETCH_IF_VH

// types
`include "cpu_types_pkg.vh"


interface  fetch_if;



  import cpu_types_pkg::*;

  logic [31:0] iloadi;
  logic [31:0] iloado;
  logic [31:0] laddri;
  logic [31:0] laddro;
  logic flush;
  logic fetch_en;
  opcode_t fetch_opcodei;
  opcode_t fetch_opcodeo;

  modport fif (
    input iloadi, laddri, fetch_en, flush, fetch_opcodei,
    output iloado, laddro, fetch_opcodeo
  );

endinterface

`endif

