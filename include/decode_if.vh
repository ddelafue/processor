

`ifndef DECODE_IF_VH
`define DECODE_IF_VH

// types
`include "cpu_types_pkg.vh"


interface decode_if;


  import cpu_types_pkg::*;

    logic [31:0] rdat1i;
    logic [31:0] rdat1o;
    logic [31:0] rdat2i;
    logic [31:0] rdat2o;
    logic [31:0] immi;
    logic [31:0] immo;
    logic [31:0] laddri;
    logic [31:0] laddro;
    logic [4:0] read1i;
    logic [4:0] read1o;
    logic [4:0] read2i;
    logic [4:0] read2o;
    logic beqi;
    logic beqo;
    logic bnei;
    logic bneo;
    logic jrsigi;
    logic jsigi;
    logic jsigo;
    logic jrsigo;
    logic [31:0] pcAddrOuto;
    logic [31:0] pcAddrOuti;
    logic dRENi;
    logic dWENi;
    logic dRENo;
    logic dWENo;
    logic write_sigi;
    logic write_sigo;
    logic reg_wri;
    logic reg_wro;
    logic [4:0] wseli;
    logic [4:0] wselo;
    logic [3:0] opi;
    logic [3:0] opo;
    logic immSigi;
    logic immSigo;
    logic halti;
    logic halto;
    logic flush;
    logic decode_en;
    opcode_t decode_opcodei;
    opcode_t decode_opcodeo;

    modport dcif (
    input rdat1i, flush, rdat2i, immi, laddri, beqi,halti,
bnei,jrsigi,pcAddrOuti,reg_wri,write_sigi, decode_en, jsigi,
opi,immSigi,dRENi,dWENi,wseli,read1i,read2i, decode_opcodei,
    output rdat1o, rdat2o, immo, laddro, beqo, bneo, jrsigo, pcAddrOuto,
reg_wro, write_sigo, opo, immSigo,dRENo,dWENo,wselo,halto,jsigo, read1o,
read2o, decode_opcodeo
  );

endinterface

`endif
