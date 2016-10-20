`include "dcache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 1'b0;
  logic nRST = 1'b1;

  always #(PERIOD/2) CLK++;

  dcache_if dcif ();
  caches_if cif ();

  test PROG();

`ifndef MAPPED
  dcache DUT(.CLK(CLK), .nRST(nRST), .dcif(dcif), .cif(cif));
`else
`endif

initial
begin
  //RESET
  nRST = 1'b0;
  dcif.dREN = 1'b0;
  dcif.indx = 1'b0;
  dcif.tag = 1'b1;
  dcif.dWEN = 1'b0;
  cif.dwait = 1'b1;
  cif.dload = 32'h00000000;
  dcif.offset = 1'b0;

  #PERIOD;
  nRST = 1'b1;

  //EMPTY CACHE REPLACE FIRST FRAME FIRST SET
  dcif.dREN = 1'b1;
  cif.dload = 32'h00000001;
  #PERIOD;
  //cif.dload = 32'h00000002;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dload = 32'h00000003;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  //dcif.dREN = 1'b0;
  #PERIOD;
  dcif.dREN = 1'b0;
  #PERIOD;

  //ANOTHER READ
  dcif.dREN = 1'b1;
  dcif.indx = 1'b1;
  dcif.tag = 32'd2;
  dcif.offset = 1'b1;
  cif.dload = 32'd4;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  cif.dload = 32'd5;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  dcif.dREN = 1'b0;

  //WRITE
  #PERIOD;
  dcif.dWEN = 1'b1;
  dcif.dstore = 1'b0;
  #PERIOD;
  dcif.dWEN = 1'b0;
  #PERIOD;
  #PERIOD;
  #PERIOD;

  //Mecessaru read reqiored tp set ;ri back to dirty frame
  dcif.dREN = 1'b1;
  dcif.tag = 32'h8;
  cif.dload = 32'h12;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dload = 32'd32;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;

  dcif.dREN = 1'b0;
  #PERIOD;
//dirty case.
  dcif.dREN = 1'b1;
  dcif.tag = 32'h10;
  cif.dload = 32'h465;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dload = 32'd654;
  cif.dwait = 1'b1;
  #PERIOD;
  cif.dwait = 1'b0;
  #PERIOD;
  cif.dwait = 1'b1;
  #PERIOD;
  dcif.dREN = 1'b0;
//write new val to same frame., then send a halt signal
  #PERIOD;
  dcif.dWEN = 1'b1;
  dcif.dstore = 32'd9;
  #PERIOD;
  dcif.dWEN = 1'b0;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  dcif.halt = 1'b1;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  cif.dwait = 1'd0;
  #PERIOD;
  cif.dwait = 1'd1;
  #PERIOD;
  cif.dwait = 1'd0;
  #PERIOD;
  cif.dwait = 1'd1;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  #PERIOD;
  dcif.halt = 1'b0;
  #PERIOD;


  $finish;
end

endmodule

program test;
endprogram
