/*
Eric Villasenor
  evillase@gmail.com

  this block holds the i and d cache
*/


// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "dcache_if.vh"
`include "icache_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module caches
import cpu_types_pkg::*;
(
  input logic CLK, nRST,
  datapath_cache_if.cache dcif,
  caches_if cif
);

  //I basically made this file into a cache-datapath datapath. The
  //cache-controller functionality will happen in icache and dcache
  dcache_if dcaif();
  icache_if icaif();

  word_t instr;
  word_t daddr;

  // icache
  icache  ICACHE(CLK, nRST,icaif,cif);
  // dcache
  dcache  DCACHE(CLK, nRST,dcaif,cif);


  assign dcaif.indx = dcif.dmemaddr[5:3];
  assign dcaif.halt = dcif.halt;
  assign dcaif.offset = dcif.dmemaddr[2];
  assign dcaif.tag = dcif.dmemaddr[31:6];
  assign dcaif.dREN = dcif.dmemREN;
  assign dcaif.dWEN = dcif.dmemWEN;
  assign dcaif.datomic = dcif.datomic;
  assign dcaif.dstore = dcif.dmemstore;


  assign icaif.indx = dcif.imemaddr[5:2];
  assign icaif.tag = dcif.imemaddr[31:6];
  assign icaif.iREN = dcif.imemREN;
  assign icaif.dREN = dcif.dmemREN;
  assign icaif.dWEN = dcif.dmemWEN;
  assign icaif.address = dcif.imemaddr;//  incomplete at the moment

  assign dcif.ihit = icaif.ihit;
  assign dcif.dhit = dcaif.dhit;
  assign dcif.dmemload = dcaif.memout;
  assign dcif.imemload = icaif.memout;


//to norm work will have to comment out to run pipeline w/o cache and uncomment
//beloowww. Everything below this for now it wrong until I assign the outputs
//correctly to the memcontrol


  // single cycle instr saver (for memory ops)

/*
  always_ff @(posedge CLK)
  begin
    if (!nRST)
    begin
      instr <= '0;
      daddr <= '0;
    end
    else
    if (dcif.ihit)
    begin
      instr <= cif.iload;
      daddr <= dcif.dmemaddr;
    end
  end
  // dcache invalidate before halt
  assign dcif.flushed = dcif.halt;

  //singlecycle
  assign dcif.ihit = (dcif.imemREN) ? ~cif.iwait : 0;
  assign dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~cif.dwait : 0;
  assign dcif.imemload = cif.iload;
  assign dcif.dmemload = cif.dload;


  assign cif.iREN = dcif.imemREN;
  assign cif.dREN = dcif.dmemREN;
  assign cif.dWEN = dcif.dmemWEN;
  assign cif.dstore = dcif.dmemstore;
  assign cif.iaddr = dcif.imemaddr;
  assign cif.daddr = dcif.dmemaddr;
*/
endmodule
