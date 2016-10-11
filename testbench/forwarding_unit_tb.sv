`include "forwarding_unit_if.vh"

`timescale 1 ns / 1 ns

module forwarding_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  forwarding_unit_if fuf ();

  test PROG();

`ifndef MAPPED
  forwarding_unit DUT(.CLK(CLK), .nRST(nRST), .fuf(fuf));
`else
`endif

initial
begin
  fuf.read1 = 32'd0;
  fuf.read2 = 32'd0;
  fuf.write1 = 32'd0;
  fuf.write2 = 32'd0;
  fuf.write3 = 32'd0;
  #PERIOD;
  fuf.read1 = 32'd1;
  #PERIOD;
  fuf.write1 = 32'd1;
  #PERIOD;
  $finish;
end

endmodule

program test;
endprogram
