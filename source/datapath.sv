/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "pc_if.vh"
`include "register_file_if.vh"
`include "fetch_if.vh"
`include "execute_if.vh"
`include "memory_if.vh"
`include "decode_if.vh"
`include "hazard_unit_if.vh"
`include "forwarding_unit_if.vh"
// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

//interfaces
  control_unit_if cuif();
  extender_if exif();
  register_file_if rfif();
  alu_file_if aluf();
  pc_if pcif();
  fetch_if fif();
  execute_if excif();
  memory_if memif();
  decode_if dcif();
  hazard_unit_if haz();
  forwarding_unit_if fwd();


//instances
control_unit CU(cuif);
extender EX(exif);
register_file RU(CLK,nRST,rfif);
alu_file RF(aluf);
pc PCS(CLK, nRST, pcif);
execute EXC(CLK,nRST,excif);
memory MMR(CLK, nRST, memif);
fetch FCH(CLK, nRST, fif);
decode DC(CLK, nRST, dcif);
hazard_unit HZ(CLK, nRST, haz);
forwarding_unit FW(CLK, nRST, fwd); //maybe wrong
logic halter;
logic hold;
opcode_t opcode;// = opcode_t'(dpif.imemload[31:26]);
//assignments
assign exif.inputimm = cuif.immOut;
assign rfif.rsel1 = cuif.rs;
assign rfif.rsel2 = cuif.rt;
assign exif.zero = cuif.zero;
assign exif.lui = cuif.lui;
assign cuif.pcAddrIn = fif.laddro;
assign dpif.imemaddr = pcif.ladd;
assign cuif.instr = fif.iloado;

//opcode assignments
assign opcode = opcode_t'(dpif.imemload[31:26]);
assign fif.fetch_opcodei = opcode;
assign dcif.decode_opcodei = fif.fetch_opcodeo;
assign excif.execute_opcodei = dcif.decode_opcodeo;
assign memif.memory_opcodei = excif.execute_opcodeo;
//assign aluf.input1 = dcif.rdat1o;
assign aluf.op = dcif.opo;
 //mux the input value for these things.
assign dpif.dmemaddr = excif.outputo;
assign pcif.beq = excif.beqo;
assign pcif.bne = excif.bneo;
assign pcif.jrsig = excif.jrsigo;
assign pcif.jsig = excif.jsigo;
assign pcif.jumpval = excif.pcAddrOuto;
assign pcif.jrval=  rfif.returner;
assign pcif.brval = excif.brvalo;
assign pcif.zero = excif.zeroo;
assign dpif.dmemstore = excif.wdato;
assign exif.shiftSig = cuif.shiftSig;
assign halter = excif.halto; //maybe...
assign dpif.dmemWEN = excif.dWENo;// && !haz.deassert; //use your memload memwrite and memread signals
assign dpif.dmemREN = excif.dRENo;// && !haz.deassert;
assign dpif.imemREN = 1'd1;
assign rfif.WEN = memif.reg_wro;
assign rfif.wsel = memif.wselo;
assign haz.dhit = dpif.dhit;
assign haz.ihit = dpif.ihit;
assign fif.fetch_en = haz.fetch_en;
/*assign excif.execute_en = haz.execute_en;
assign memif.memory_en = haz.memory_en;
assign dcif.decode_en = haz.decode_en;
*/assign haz.memWEN = 1'b0;
assign haz.memREN = cuif.memread;
assign pcif.pcenable = haz.fetch_en;
assign haz.read1 = cuif.rs;
assign haz.read2 = cuif.rt;
/*assign haz.write1 = excif.wseli;
assign haz.write3 = excif.wselo; //?
assign haz.write2 = memif.wselo;
*/

assign fwd.read1 = dcif.read1o;
assign fwd.read2 = dcif.read2o;
assign fwd.write1 = excif.wselo;
assign fwd.write2 = memif.wselo;
//assign fwd.write3 = excif.wseli;

//assigns to the inputs of the latches

//FETCH IN
assign fif.iloadi = dpif.imemload;
assign fif.laddri = pcif.ladd;
//DECODE IN
assign dcif.rdat1i = rfif.rdat1;
assign dcif.rdat2i = rfif.rdat2;
assign dcif.immi = exif.outputimm;
assign dcif.immSigi = cuif.immSig;
assign dcif.laddri = fif.laddro;  //?
assign dcif.beqi = cuif.beq;
assign dcif.bnei = cuif.bne;
assign dcif.jrsigi = cuif.jrsig;
assign dcif.pcAddrOuti = cuif.pcAddrOut;
assign dcif.dWENi = cuif.memwrite;
assign dcif.dRENi = cuif.memread;
assign dcif.write_sigi = cuif.write_sig; //output or dmem
assign dcif.reg_wri =cuif.reg_wr;
assign dcif.opi = cuif.outputop;
assign dcif.decode_en =haz.decode_en;
assign dcif.halti = cuif.halt;
assign dcif.jsigi = cuif.jump;
assign dcif.read1i = cuif.rs;
assign dcif.read2i = cuif.rt;


//assign dcif.beqi = cuif.beq;
//assign dcif.bnei = cuif.bne;

//EXECUTE IN
assign excif.outputi = aluf.output1;
assign excif.zeroi = aluf.zero;
//assign excif.wdati = dcif.rdat2o;
assign excif.dWENi = dcif.dWENo;
assign excif.dRENi = dcif.dRENo;
assign excif.wseli = dcif.wselo;
assign excif.write_sigi = dcif.write_sigo;
assign excif.reg_wri = dcif.reg_wro;
assign excif.execute_en = haz.execute_en;
assign excif.halti = dcif.halto;
assign excif.beqi = dcif.beqo;
assign excif.bnei = dcif.bneo;
assign excif.pcAddrOuti = dcif.pcAddrOuto;
assign excif.brvali = dcif.immo;
assign excif.jsigi = dcif.jsigo;
assign excif.jrsigi = dcif.jrsigo;
assign excif.laddri = dcif.laddro;
 //output or dmem
//MEMORY IN
assign memif.dloadi = dpif.dmemload;
assign memif.alui =   excif.outputo;
assign memif.reg_wri = excif.reg_wro;
assign memif.wseli = excif.wselo;
assign memif.write_sigi = excif.write_sigo;
assign memif.memory_en = haz.memory_en;
assign excif.flush = haz.edeassert;
assign memif.halti = excif.halto;
assign memif.dRENi = excif.dRENo;
//
//assign dpif.imemaddr = excif.imemaddro;
//BRANCH STUFF

assign  fif.flush = haz.fdeassert;
assign  dcif.flush = haz.ddeassert;
assign memif.flush = haz.mdeassert;
assign haz.beq = excif.beqo;
assign haz.bne = excif.bneo;
assign haz.j = excif.jsigo;
assign haz.jr = excif.jrsigo;
assign haz.zero = excif.zeroo;

logic hold2;

always_ff @(posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin
    dpif.halt <= 1'd0;
    hold <= 1'd0;
    hold2 <= 1'd0;
 end
 else
 begin
   if(hold == 1'd1)
   begin
    dpif.halt <= 1'd1;
   end
   else if(halter)
   begin
    dpif.halt <= halter;
    hold <= 1'd1;
   end
   else
   begin
   end
end
end

  // pc init
  parameter PC_INIT = 0;

always_comb
begin

  if(dcif.decode_opcodeo == SW || dcif.decode_opcodeo == LW)
  begin
      haz.dW = 1'd1;
  end
  else
  begin
      haz.dW = 1'd0;
  end

  /*if(fwd.forw_en3 && !fwd.forw_en1 && !fwd.forw_en2)
  begin
    aluf.input1 = excif.outputi;
  end
  else if(fwd.forw_en6 && !fwd.forw_en4 && !fwd.forw_en5)
  begin
    aluf.input2 = excif.outputi;
  end
*/

//sw case
  if(fwd.forw_en4 && dcif.dWENo)
  begin
    excif.wdati = excif.outputo;
  end
  else if(fwd.forw_en5 && dcif.dWENo)
  begin
    if(memif.write_sigo)
    begin
      excif.wdati = memif.dloado;
    end
    else
    begin
      excif.wdati = memif.aluo;
    end
  end
  else
  begin
    excif.wdati = dcif.rdat2o;
  end


//for write1
  if(fwd.forw_en1)
  begin
    aluf.input1 = excif.outputo;
  end
  else if(fwd.forw_en2)
  begin
    if(memif.write_sigo)
    begin
      aluf.input1 = memif.dloado;
    end
    else
    begin
      aluf.input1 = memif.aluo;
    end
  end
  else
  begin
    aluf.input1 = dcif.rdat1o;
  end

  if(dcif.immSigo)
  begin
    aluf.input2 = dcif.immo;
  end
  else
  begin
    if(fwd.forw_en4)
    begin
      aluf.input2 = excif.outputo;
    end
    else if(fwd.forw_en5)
    begin
       if(memif.write_sigo)
       begin
          aluf.input2 = memif.dloado;
       end
       else
       begin
          aluf.input2 = memif.aluo;
       end
    end
    else
    begin
      aluf.input2 = dcif.rdat2o;
    end
  end
/*
    `if(fwd.read1 == excif.wseli)
    begin
      aluf.input1 = excif.outputi;
    end
    else if(fwd.read2 == excif.wseli)
    begin
      aluf.input2 = excif.outputi;
    end*/
/*  if(cuif.regdst)
  begin
    rfif.wsel = cuif.rt;
  end
  else
  begin
    rfif.wsel = cuif.rd;
  end*/

  if((excif.beqo&&excif.zeroo)|(excif.bneo && !excif.zeroo))
  begin
    pcif.brstart = excif.laddro;
  end
  else
  begin
    pcif.brstart = pcif.ladd;
  end
/*  if(dcif.immSigo)
  begin
    aluf.input2 = dcif.immo;
  end
  else
  begin
    aluf.input2 = dcif.rdat2o;
  end*/
  if(memif.write_sigo)
  begin
    rfif.wdat = memif.dloado;
  end
  else
  begin
    rfif.wdat = memif.aluo;
  end
  if(cuif.regdst)
  begin
    dcif.wseli = cuif.rt;
  end
  else
  begin
    dcif.wseli = cuif.rd;
  end
end
endmodule
