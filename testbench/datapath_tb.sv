`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module datapath_tb;

  import cpu_types_pkg::*;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  datapath_cache_if dpif ();

  test PROG();

`ifndef MAPPED
  datapath DUT(.CLK(CLK), .nRST(nRST), .dpif(dpif));
`else
`endif

initial
begin
  nRST = 1'b0;
  dpif.imemload = 32'h00F0F024;
  dpif.dmemload = 32'hABCDABCD;
  dpif.ihit = 1'b1;
  dpif.dhit = 1'b1;
  #PERIOD;
  dpif.imemload = 32'h0C008000;
  #PERIOD;
  nRST = 1'b1;
  dpif.imemload = 32'h00000020;
  #PERIOD;
  dpif.imemload = 32'h8CF0F0F0;
  #PERIOD;
  dpif.imemload = 32'hAC0F0F0F;
  #PERIOD;
  dpif.imemload = 32'h10AFAFAF;
  #PERIOD;
  dpif.imemload = 32'h08ABCDEF;
  #PERIOD;
  dpif.imemload = 32'hFE000000;
  #PERIOD;
  $finish;
end

endmodule

program test;
endprogram
