`ifndef ICACHE_IF_VH
`define ICACHE_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

//package icache_if;
interface icache_if;

  import cpu_types_pkg::*;
  logic [3:0] indx; //two frames in total to total the 512 bits
  logic [25:0] tag;
  logic [31:0] memout;
  logic ihit;
  logic [31:0] address;
  logic iREN;
  logic dREN;
  logic dWEN;

  modport icache(
    input address,indx, tag, iREN, dREN, dWEN,
    output memout, ihit
  );

endinterface
//endpackage
`endif


