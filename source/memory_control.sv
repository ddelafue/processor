/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

assign ccif.iload = ccif.ramload;
assign ccif.dload = ccif.ramload;
always_comb
begin
  //ccif.ramstore = ccif.dstore;
  ccif.iwait = 1'd1;
  ccif.dwait = 1'd1;
  ccif.ramaddr = ccif.daddr;
  ccif.ramstore = ccif.dstore;
  if(ccif.dWEN)
  begin
    ccif.ramWEN = 1'd1;
    ccif.ramREN = 1'd0;
    ccif.ramaddr = ccif.daddr;
    ccif.ramstore = ccif.dstore;
  end
  else if(ccif.dREN)
  begin
    ccif.ramREN = 1'd1;
    ccif.ramWEN = 1'd0;
    ccif.ramaddr = ccif.daddr;
  end
  else if(ccif.iREN)
  begin
    ccif.ramWEN = 1'd0;
    ccif.ramREN = 1'd1;
    ccif.ramaddr = ccif.iaddr;

  end
  else
  begin
    ccif.ramWEN = 1'd0;
    ccif.ramREN = 1'd0;
    ccif.ramaddr = ccif.iaddr;
  end
  casez(ccif.ramstate)
      ACCESS : begin
               if(ccif.dREN)
               begin
                //ccif.iload = ccif.ramload;
                ccif.dwait = 1'd0;
               end
               else if(ccif.dWEN)
               begin
                //ccif.dload = ccif.ramload;
                ccif.dwait = 1'd0;
               end
               else if(ccif.iREN)
               begin
                 ccif.iwait = 1'd0;
               end
               else
               begin
               end

             end
    default: begin
             end

  endcase
end
endmodule
