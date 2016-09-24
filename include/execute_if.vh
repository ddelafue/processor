

`ifndef EXECUTE_IF_VH
`define EXECUTE_IF_VH

// types
`include "cpu_types_pkg.vh"


interface execute_if;


  import cpu_types_pkg::*;
  logic [31:0] outputi;
  logic [31:0] outputo;
  logic zeroi;
  logic zeroo;
  //maybe an instr thing here
  logic [31:0] wdati;
  logic [31:0] wdato;
  logic dWENi;
  logic dRENi;
  logic dWENo;
  logic dRENo;
  logic WENi;
  logic WENo;
  logic [31:0] wseli;
  logic [31:0] wselo;
  logic reg_wri; //wen
  logic reg_wro;
  logic write_sigi; //which thing is written
  logic write_sigo;
  logic flush;
  logic execute_en;
  logic halti;
  logic halto;


    modport excif (
    input flush,outputi, zeroi, wdati, dWENi,dRENi,WENi,wseli,reg_wri,
write_sigi, execute_en,halti,
    output outputo, zeroo, wdato, dWENo, dRENo,WENo,wselo, reg_wro,
write_sigo,halto
  );

endinterface

`endif
