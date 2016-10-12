`include "decode_if.vh"
`include "cpu_types_pkg.vh"

module decode (
  input logic CLK,
  input logic nRST,
  decode_if.dcif dec);

  import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST)
begin
  if (!nRST)
  begin
    dec.rdat1o <= 'b0;
    dec.rdat2o <= 'b0;
    dec.immo <= 'b0;
    dec.laddro <= 'b0;
    dec.beqo <= 'b0;
    dec.bneo <= 'b0;
    dec.jrsigo <= 'b0;
    dec.pcAddrOuto <= 'b0;
    dec.reg_wro <= 'b0;
    dec.write_sigo <= 'b0;
    dec.opo <= 'b0;
    dec.immSigo <= 'b0;
    dec.dRENo <= 'b0;
    dec.dWENo <= 'b0;
    dec.wselo <= 'b0;
    dec.halto <= 'b0;
    dec.jsigo <= 'b0;
    dec.jrsigo <= 'b0;
    dec.read1o <= 'b0;
    dec.read2o <= 'b0;
    dec.decode_opcodeo <= opcode_t'('b0);
  end
  else if(dec.flush)
  begin
    dec.rdat1o <= 'b0;
    dec.rdat2o <= 'b0;
    dec.immo <= 'b0;
    dec.laddro <= 'b0;
    dec.beqo <= 'b0;
    dec.bneo <= 'b0;
    dec.jrsigo <= 'b0;
    dec.pcAddrOuto <= 'b0;
    dec.reg_wro <= 'b0;
    dec.write_sigo <= 'b0;
    dec.opo <= 'b0;
    dec.immSigo <= 'b0;
    dec.dRENo <= 'b0;
    dec.dWENo <= 'b0;
    dec.wselo <= 'b0;
    dec.halto <= 'b0;
    dec.jsigo <= 'b0;
    dec.jrsigo <= 'b0;
    dec.read1o <= 'b0;
    dec.read2o <= 'b0;
    dec.decode_opcodeo <= opcode_t'('b0);
  end

  else
  begin
    if (dec.decode_en)
    begin
      dec.rdat1o <= dec.rdat1i;
      dec.rdat2o <= dec.rdat2i;
      dec.immo <= dec.immi;
      dec.laddro <= dec.laddri;
      dec.beqo <= dec.beqi;
      dec.bneo <= dec.bnei;
      dec.jrsigo <= dec.jrsigi;
      dec.pcAddrOuto <= dec.pcAddrOuti;
      dec.reg_wro <= dec.reg_wri;
      dec.write_sigo <= dec.write_sigi;
      dec.opo <= dec.opi;
      dec.immSigo <= dec.immSigi;
      dec.dRENo <= dec.dRENi;
      dec.dWENo <= dec.dWENi;
      dec.wselo <= dec.wseli;
      dec.halto <= dec.halti;
      dec.jsigo <= dec.jsigi;
      dec.jrsigo <= dec.jrsigi;
      dec.read1o <= dec.read1i;
      dec.read2o <= dec.read2i;
      dec.decode_opcodeo <= dec.decode_opcodei;
   end
    else
    begin
      dec.rdat1o <= dec.rdat1o;
      dec.rdat2o <= dec.rdat2o;
      dec.immo <= dec.immo;
      dec.laddro <= dec.laddro;
      dec.beqo <= dec.beqo;
      dec.bneo <= dec.bneo;
      dec.jrsigo <= dec.jrsigo;
      dec.pcAddrOuto <= dec.pcAddrOuto;
      dec.reg_wro <= dec.reg_wro;
      dec.write_sigo <= dec.write_sigo;
      dec.opo <= dec.opo;
      dec.immSigo <= dec.immSigo;
      dec.dRENo <= dec.dRENo;
      dec.dWENo <= dec.dWENo;
      dec.wselo <= dec.wselo;
      dec.halto <= dec.halto;
      dec.jsigo <= dec.jsigo;
      dec.jrsigo <= dec.jrsigo;
      dec.read1o <= dec.read1o;
      dec.read2o <= dec.read2o;
      dec.decode_opcodeo <= dec.decode_opcodeo;
  end
  end
end

endmodule
