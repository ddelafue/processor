`include "hazard_unit_if.vh"

`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  hazard_unit_if haz ();

  test PROG();

`ifndef MAPPED
  hazard_unit DUT(.CLK(CLK), .nRST(nRST), .hazard(haz));
`else
`endif

initial
begin
  haz.dhit = 1'b1;
  haz.ihit = 1'b0;
  haz.beq = 1'b0;
  haz.bne = 1'b0;
  haz.zero = 1'b0;
  haz.jr = 1'b0;
  haz.j = 1'b0;
  haz.read1 = 1'b1;
  haz.read2 = 2'd2;
  haz.write1 = 2'd3;
  haz.write2 = 3'd4;
  #PERIOD;
  haz.dhit = 1'b0;
  haz.ihit = 1'b1;
  #PERIOD;
  haz.j = 1'b1;
  #PERIOD;
  haz.j = 1'b0;
  haz.jr = 1'b1;
  #PERIOD;
  haz.jr = 1'b0;
  haz.zero = 1'b1;
  #PERIOD;
  haz.zero = 1'b0;
  haz.bne = 1'b1;
  #PERIOD;
  haz.bne = 1'b0;
  haz.beq = 1'b1;
  #PERIOD;
  haz.bne = 1'b1;
  haz.beq = 1'b0;
  haz.zero = 1'b1;
  #PERIOD;
  haz.bne = 1'b0;
  haz.beq = 1'b1;
  #PERIOD;
  haz.beq = 1'b0;
  haz.zero = 1'b0;
  #PERIOD;
  haz.read1 = 1'b1;
  haz.write1 = 1'b1;
  #PERIOD;
  haz.read2 = 1'b1;
  haz.read1 = 1'b0;
  #PERIOD
//test raw

  $finish;
end

endmodule

program test;
endprogram
