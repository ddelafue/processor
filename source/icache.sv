`include "icache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
`include "icache_pkg.vh"

module icache
//import cpu_types_pkg::*;
//import icache_pkg::*;
(
  input CLK, nRST,
  icache_if.icache icif,
  caches_if.icache cif
);

import cpu_types_pkg::*;
icachef_t [15:0] ivals;
logic [15:0] validarray;
logic [25:0] test;
logic test2;
logic [31:0] nextmemout;
logic [15:0] nextvalidarray;
icachef_t [15:0] nextival;
logic nextiREN;
logic [31:0] nextiaddr;

word_t [15:0] cblocks;
word_t [15:0] nextcblock;

logic instrhit;
always_ff @ (posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin
    //icif.ihit <= 1'd0;
    //icif.memout <= 32'b0;
    cblocks <= '{default: '0};
    validarray <= '{default:'0};
    ivals <= '{default:'0};
    //cif.iREN <= 'd0;
    //cif.iaddr <= 32'd0;
  end
  else
  begin
    //icif.ihit <= instrhit;
    //icif.memout <= nextmemout;
    cblocks <= nextcblock;
    ivals <= nextival;
    validarray <= nextvalidarray;
   // cif.iREN <= nextiREN;
   // cif.iaddr <= nextiaddr;

  end
  //checks for iREN here

end

//assign icif.ihit = instrhit;

assign test = ivals[icif.indx].tag;
assign test2 = validarray[icif.indx];
assign icif.ihit = instrhit;
assign icif.memout = cblocks[icif.indx];
assign cif.iaddr = icif.address;
//assign cblocks = nextcblock;
assign cif.iREN = nextiREN;
always_comb
begin

  if(!nRST)
  begin
   //nextmemout = '{default:'0};
   nextvalidarray = '{default:'0};
   nextcblock = '{default:'0};
   nextival = '{default:'0};
   nextiREN = 1'd0;
   nextiaddr = 32'd0;
   instrhit = 1'd0;

  end
  else if((icif.iREN == 1'd1) && (icif.dREN == 1'd0) && (icif.dWEN == 1'd0)) //add a condition to make sure dREN or dWEN isn't set from dcache??
  begin
    nextvalidarray = validarray;
    nextcblock = cblocks;
    nextival = ivals;
    nextiREN = 1'd0;
    nextiaddr= 32'd0;
    instrhit = 1'd0;
      //$display("tag is %d , ivals is %d and valid array is %d",icif.tag,
//ivals[icif.indx].tag, validarray[icif.indx] );

    if((icif.tag == ivals[icif.indx].tag) && (validarray[icif.indx] == 1'd1))
    begin
       // $display("maybe");
       // nextmemout = cblocks[icif.indx];
      instrhit = 1'd1;
    end
    else
    begin
       // $display("hopefully not infinite");
      nextiREN = 1'd1;
        //nextiaddr = icif.address;
      if(cif.iwait == 1'd0)
      begin
        nextcblock[icif.indx] = cif.iload;
        nextival[icif.indx].tag = icif.tag;
        nextvalidarray[icif.indx] = 1'd1;
        instrhit = 1'd0;
      end
    end
  end
  else
  begin
    instrhit = 1'd0;
     // $display("dcache should take over atm");
    nextvalidarray = validarray;
    nextcblock = cblocks;
    nextival = ivals;
    nextiREN = 1'b0;
  end
end
endmodule
