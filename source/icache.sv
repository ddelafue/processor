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
//import icache_pkg::*;
//data space for icache. 512 bits which is 8 bytes which means
//there are 8 frames of one word each
logic [15:0] validarray;

word_t [15:0] cblocks; //ALL THE SPACE NEEDED for blocks
//the tag for the code should be the 32 - 3(size of index) - 2(byte offset bits)
//which is 27 bits
//tags [3:0] tagspace; //holds space for the corresponding blocks from 0-15
logic instrhit;
//assign cif.iaddr= icif.address;
//assign cif.iREN = icif.iREN;
always_ff @ (posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin
    icif.ihit <= 1'd0;
    //cblocks <= '{default:'0}; cannot be driven in a ff block and comb block
    //tagspace <= '{default:'0}; these are now not set to zero
  end
  else
  begin
    icif.ihit <= instrhit;
  end
  //checks for iREN here

end

//assign icif.ihit = instrhit;

always_comb
begin
  instrhit = 1'd0;
  if(!nRST)
  begin
   icif.memout = '{default:'0};
   validarray = '{default:'0};
   cblocks = '{default:'0};
   ivals = '{default:'0};
  end
  else
  begin
    if(icif.iREN && !icif.dREN && !icif.dWEN ) //add a condition to make sure dREN or dWEN isn't set from dcache??
    begin
      cif.iREN = 1'd0;
      cif.iaddr= 32'd0;
      //cif.iaddr = icif.address;
      if((icif.tag == ivals[icif.indx].tag) && validarray[icif.indx] == 1'd1)
      begin
        icif.memout = cblocks[icif.indx];
        instrhit = 1'd1;
      end

      else
      begin
        /// cif.iaddr = icif.address; //you can only do this in a 1 way path
        //cif.iREN = icif.iREN;
        //stop here
        cif.iREN = 1'd1;
        cif.iaddr = icif.address;
        if(cif.iwait == 1'd0)
        begin
          cblocks[icif.indx] = cif.iload;
          ivals[icif.indx].tag = icif.tag;
         //icif.memout = cif.iload; ??
          //instrhit = 1'd1;         ??
          validarray[icif.indx] = 1'd1;
          //miss situation, you need to make the datapath and everything wait while
          //the cif(the ram) to get the new data, store it in cblocks, replace the
          //tag and grab the block of data. The memory address
        end
      end
    end
  end
//TA said we need an else here for iaddr and iREN

  //job here is if iREN then to compare the tag coming in from cif to the tag
  //that we alre
end

endmodule
