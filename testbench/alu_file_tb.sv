// mapped needs this
`include "alu_file_if.vh"
`include "cpu_types_pkg.vh"
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_file_tb;
import cpu_types_pkg::*;


  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  alu_file_if aluf ();
  test PROG ();
`ifndef MAPPED
    alu_file DUT(aluf);
`else
    alu_file DUT(
    .\aluf.input1 (aluf.input1),
    .\aluf.input2 (aluf.input2),
    .\aluf.output1 (aluf.output1),
    .\aluf.negative (aluf.negative),
    .\aluf.zero (aluf.zero),
    .\aluf.overflow (aluf.overflow),
    .\aluf.op (aluf.op)


  );
`endif
initial begin
  aluf.input1 = 32'd1;
  aluf.input2 = 32'd1;
  aluf.op = ALU_AND;
  #PERIOD;
  assert(aluf.output1 == 32'd1)
  begin
    $display ("AND operation worked");
  end
  else
  begin
    $error("AND failed");
  end
  aluf.input1 = 32'd2;
  aluf.input2 = 32'd2;
  aluf.op = ALU_ADD;
  #PERIOD;
  assert(aluf.output1 == 32'd4)
  begin
    $display ("ADD operation worked");
  end
  else
  begin
    $error("ADD failed");
  end
  aluf.input1 = 32'd1;
  aluf.input2 = 32'd1;
  aluf.op = ALU_SUB;
  #PERIOD;
  assert(aluf.output1 == 32'd0 && aluf.zero == 1'd1)
  begin
    $display ("Subtraction and zero works");
  end
  else
  begin
    $error("Subtraction and zero FAILED");
  end
  aluf.input1 = 32'd2147483647;
  aluf.input2 = 32'd1;
  aluf.op = ALU_ADD;
  #PERIOD;
  assert(aluf.output1 == 32'd2147483648 && aluf.overflow == 1'd1)
  begin
    $display ("Addition and overflow work");
  end
  else
  begin
    $error("Addition and overflow FAIL");
  end
  aluf.input1 = 32'd16;
  aluf.input2= -2147483647;
  aluf.op = ALU_SUB;
  #PERIOD;
  assert(aluf.overflow == 1'd1)
  begin
    $display ("overflow work and subtract works");
  end
  else
  begin
    $error("overflow FAIL");
  end

  aluf.input1 = 32'd0;
  aluf.input2 = 32'd1;
  aluf.op = ALU_SLTU;
  #PERIOD;
  assert(aluf.output1 == 1'd1)
  begin
    $display ("less than works");
  end
  else
  begin
    $error("less than failed bruh");
  end
  #PERIOD;
  aluf.input1 = 32'd1;
  aluf.input2 = 32'd0;
  aluf.op = ALU_OR;
  #PERIOD;
  assert(aluf.output1 == 32'd1)
  begin
    $display("or works");
    end
    else
    begin
     $error("or failed");
    end
  #PERIOD;
  aluf.input1 = 32'd1;
  aluf.input2 = 32'd1;
  aluf.op = ALU_NOR;
  #PERIOD
  assert(aluf.output1 == 32'hFFFFFFFE)
  begin
    $display("nor works");
  end
  else
  begin
    $error("nor doesn't work");
  end
  #PERIOD
  aluf.input1 = 32'h7FFFFFFF;
  aluf.input2 = 32'h7FFFFFFF;
  aluf.op = ALU_ADD;
  #PERIOD;
  assert(aluf.overflow == 1'd1)
  begin
    $display("overflow on adding two negitives worked");
    end
    else
    begin
     $error("overflow failed");
    end
  #PERIOD;
  #PERIOD;
  $finish;








end

endmodule

program test;
endprogram
