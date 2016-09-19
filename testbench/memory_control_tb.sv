`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"

`timescale 1 ns / 1 ns

module memory_control_tb;
import cpu_types_pkg::*;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;



  always #(PERIOD/2) CLK++;

  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
  cpu_ram_if ramf();

  ram RAM (CLK,nRST, ramf);
  test PROG ();
    assign ccif.ramload = ramf.ramload;
    assign ccif.ramstate = ramf.ramstate;
    assign ramf.ramaddr = ccif.ramaddr;
    assign ramf.ramstore = ccif.ramstore;
    assign ramf.ramREN = ccif.ramREN;
    assign ramf.ramWEN = ccif.ramWEN;
    memory_control DUT(CLK, nRST, ccif);


  `ifndef MAPPED
   // ram DUT(CLK, nRST, ramf);
   // memory_control DUT(CLK, nRST, ccif);
/*
    assign ccif.ramload = ramf.ramload;
    assign ccif.ramstate = ramf.ramstate;
    assign ramf.ramaddr = ccif.ramaddr;assign ccif.ramload = ramf.ramload;
    assign ccif.ramstate = ramf.ramstate;
    assign ramf.ramaddr = ccif.ramaddr;
    assign ramf.ramstore = ccif.ramstore;
    assign ramf.ramREN = ccif.ramREN;
    assign ramf.ramWEN = ccif.ramWEN;

    assign ramf.ramstore = ccif.ramstore;
    assign ramf.ramREN = ccif.ramREN;
    assign ramf.ramWEN = ccif.ramWEN;
/*
    assign ramf.ramload = ccif.ramload;
    assign ramf.ramstate = ccif.ramstate;
    assign ccif.ramaddr = ramf.ramaddr;
    assign ccif.ramstore = ramf.ramstore;
    assign ccif.ramREN = ramf.ramREN;
    assign ccif.ramWEN = ramf.ramWEN;
*/


  `else
    /*memory_control DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ccif.iREN (cif0.iREN),
    .\ccif.ramstate  (ram.ramstate),
    .\ccif.ramload (ram.ramload),
    .\ccif.ramstore (ram.ramstore),
    .\ccif.ramaddr (ram.ramaddr),
    .\ccif.ramWEN (ram.ramWEN),
    .\ccif.ramREN (ram.ramREN),
    .\ccif.dREN (cif0.dREN),
    .\ccif.dWEN (cif0.dWEN),
    .\ccif.iaddr (cif0.iaddr),
    .\ccif.daddr (
    .\ccif.dstore
    ):
    ram DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    */
  `endif
   initial begin
      nRST = 1'd0;
      cif0.dstore = 32'd6;
      #PERIOD;
      #PERIOD;
      nRST = 1'd1;
      cif0.dWEN = 1'd0;
      cif0.dREN = 1'd0;
      cif0.iREN = 1'd0;
      #PERIOD;
      #PERIOD;
      cif0.daddr = 32'd4;
     // cif0.dstore = 32'd5;
      cif0.dWEN = 1'd1;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end
      cif0.dREN = 1'd0;
      cif0.dWEN = 1'd0;
      cif0.iREN = 1'd0;
      #PERIOD;
      #PERIOD;

      cif0.daddr = 32'd6;
     // cif0.dstore = 32'd5;
      cif0.dWEN = 1'd1;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end
      cif0.dREN = 1'd0;
      cif0.dWEN = 1'd0;
      cif0.iREN = 1'd0;
      #PERIOD;
      #PERIOD;
      cif0.dREN = 1'd1;
      cif0.dWEN = 1'd0;
      cif0.daddr = 32'd4;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end
     assert(cif0.dload == 32'd6)
     begin
      $display ("loaded then wrote the value ");
     end
     else
     begin
      $error("i done gooffed");
     end
     #PERIOD;
     #PERIOD;
     cif0.dREN = 1'd0;
     cif0.dWEN = 1'd0;
     cif0.iREN = 1'd0;
     #PERIOD;
     #PERIOD;
     cif0.dREN = 1'd1;
     cif0.dWEN = 1'd0;
     cif0.daddr = 32'd6;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end
     assert(cif0.dload == 32'd6)
     begin
      $display ("loaded then wrote the value  somewhere else");
     end
     else
     begin
      $error("i done gooffed");
     end
     #PERIOD;
     #PERIOD;
     cif0.dREN = 1'd0;
     cif0.dWEN = 1'd0;
     cif0.iREN = 1'd0;
     #PERIOD;
     #PERIOD;
     cif0.daddr = 32'd4;
     cif0.dstore = 32'd8;
 // cif0.dstore = 32'd5;
      cif0.dWEN = 1'd1;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end

    /* assert(cif0.dload == 32'd8)
     begin
      $display ("edited value secure");
     end
     else
     begin
      $error("i done gooffed");
     end
*/
      #PERIOD;
      #PERIOD;
      cif0.dREN = 1'd0;
      cif0.dWEN = 1'd0;
      cif0.iREN = 1'd0;
      #PERIOD;
      #PERIOD;
     cif0.dREN = 1'd1;
     cif0.dWEN = 1'd0;
     cif0.daddr = 32'd4;
      #PERIOD;
      #PERIOD;
      while(cif0.dwait == 1'd1)
      begin
        #PERIOD;
        #PERIOD;
      end
     assert(cif0.dload == 32'd8)
     begin
      $display ("edited value good brah");
     end
     else
     begin
      $error("i done gooffed");
     end
     #PERIOD;
     #PERIOD;
     dump_memory();
  end

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

   // syif.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (8) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //syif.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask


  endmodule





program test;
endprogram
