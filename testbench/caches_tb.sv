// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "dcache_if.vh"
`include "icache_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module caches_tb;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  datapath_cache_if dcif ();
  caches_if cif ();
  dcache dcaif ();
  icache icaif ();

  test PROG();

`ifndef MAPPED
  caches DUT(.CLK(CLK), .nRST(nRST), .dcache(dcif), .cif(cif));
`else
`endif

initial
begin
  #PERIOD;
  $finish;
end

endmodule

program test;
endprogram
