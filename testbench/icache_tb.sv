//interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "icache_if.vh"

//cpu types
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  datapath_cache_if dcif ();
  caches_if cif ();
  icache_if icif ();

  test PROG();

`ifndef MAPPED
  icache DUT(.CLK(CLK), .nRST(nRST), .icif(icif), .cif(cif));
`else
`endif

initial
begin
  //RESET
  nRST = 1'b0;
  icif.iREN = 1'b0;
  icif.indx = 1'b0;
  icif.tag = 1'b1;
  icif.dREN = 1'b0;
  icif.dWEN = 1'b0;

  cif.iwait = 1'b1;
  cif.iload = 32'h0000;
  #PERIOD;
  nRST = 1'b1;

  //EMPTY CACHE INVALID READ
  icif.iREN = 1'b1;
  icif.address = 32'h0008;
  #PERIOD;
  cif.iload = 32'hABCD;
  cif.iwait = 1'b0;
  #PERIOD;
  cif.iwait = 1'b1;
  #PERIOD;

  //READ SAME INDEX VALID
  icif.tag = 26'd3;
  #PERIOD;

/*  //REPLACE WRONG TAG
  icif.address = 32'h01008;
  icif.tag = 26'h0100;
  cif.iload = 32'hDCBA;
  cif.iwait = 1'b0;
  #PERIOD;
  cif.iwait = 1'b1;
  #PERIOD; */

  //REPLACE WRONG TAG
  cif.iload = 32'd1010;
  icif.address = 32'd128;
  icif.tag = 26'd2;
  //cif.iwait = 1'b0;
  #PERIOD;
  cif.iwait = 1'b0;
  #PERIOD;
  cif.iwait = 1'b1;
  #PERIOD;
  $finish;
end

endmodule

program test;
endprogram
