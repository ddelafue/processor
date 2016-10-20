`ifndef DCACHE_IF_VH
`define DCACHE_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface dcache_if;

  import cpu_types_pkg::*;
  logic [2:0] indx;
  logic  offset;
  logic dREN;
  logic dhit;
  logic [25:0] tag;
  logic dWEN;
  logic [31:0] memout;
  logic halt;
  logic [31:0] dstore;
  logic flushed; //?
  logic datomic; //? no clue what these two do tbh
  //logic ccwait, ccinv, ccwrite, cctrans;
  //logic [31:0] ccaddr;

  modport dcache
  (
    input indx, halt, datomic, offset, tag, dREN, dWEN, dstore,
    output dhit, memout, flushed
  );

endinterface

`endif //DCACHE_IF_VH
