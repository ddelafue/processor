`include "execute_if.vh"
`include "cpu_types_pkg.vh"

module execute (
  input logic CLK,
  input logic nRST,
  execute_if.excif execute);

  import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST)
begin
  if (!nRST)
  begin
    execute.outputo <= 'b0;
    execute.zeroo <= 'b0;
    execute.wdato <= 'b0;
    execute.dWENo <= 'b0;
    execute.dRENo <= 'b0;
    execute.WENo <= 'b0;
    execute.wselo <= 'b0;
    execute.reg_wro <= 'b0;
    execute.write_sigo <= 'b0;
    execute.halto <= 'b0;
    execute.brvalo <= 'b0;
    execute.beqo <= 'b0;
    execute.bneo <= 'b0;
    execute.jsigo <= 'b0;
    execute.jrsigo <= 'b0;
    execute.pcAddrOuto <= 'b0;
    execute.laddro <= 'b0;
    execute.execute_opcodeo <= opcode_t'('b0);
  end

/*  else if(execute.flush && (execute.execute_opcodeo == SW ||
execute.execute_opcodeo == LW))
  begin
/*    execute.outputo <= 'b0;
    execute.zeroo <= 'b0;
    execute.wdato <= 'b0;
    execute.dWENo <= 'b0;
    execute.dRENo <= 'b0;
    execute.WENo <= 'b0;
    execute.wselo <= 'b0;
    execute.reg_wro <= 'b0;
    execute.write_sigo <= 'b0;
    execute.halto <= 'b0;
    execute.brvalo <= 'b0;
    execute.beqo <= 'b0;
    execute.bneo <= 'b0;
    execute.jsigo <= 'b0;
    execute.jrsigo <= 'b0;
    execute.pcAddrOuto <= 'b0;
    execute.laddro <= 'b0;
    execute.execute_opcodeo <= opcode_t'('b0);


    execute.dRENo <= 'b0;
    execute.dWENo <= 'b0;
    execute.outputo <= execute.outputi;
  end*/

  else if(execute.flush)
  begin
    execute.outputo <= 'b0;
    execute.zeroo <= 'b0;
    execute.wdato <= 'b0;
    execute.dWENo <= 'b0;
    execute.dRENo <= 'b0;
    execute.WENo <= 'b0;
    execute.wselo <= 'b0;
    execute.reg_wro <= 'b0;
    execute.write_sigo <= 'b0;
    execute.halto <= 'b0;
    execute.brvalo <= 'b0;
    execute.beqo <= 'b0;
    execute.bneo <= 'b0;
    execute.jsigo <= 'b0;
    execute.jrsigo <= 'b0;
    execute.pcAddrOuto <= 'b0;
    execute.laddro <= 'b0;
    execute.execute_opcodeo <= opcode_t'('b0);
  end
  else
  begin
    if (execute.execute_en)
    begin
      execute.outputo <= execute.outputi;
      execute.zeroo <= execute.zeroi;
      execute.wdato <= execute.wdati;
      execute.dWENo <= execute.dWENi;
      execute.dRENo <= execute.dRENi;
      execute.WENo <= execute.WENi;
      execute.wselo <= execute.wseli;
      execute.reg_wro <= execute.reg_wri;
      execute.write_sigo <= execute.write_sigi;
      execute.halto <= execute.halti;
      execute.brvalo <= execute.brvali;
      execute.jsigo <= execute.jsigi;
      execute.jrsigo <= execute.jrsigi;
      execute.pcAddrOuto <= execute.pcAddrOuti;
      execute.beqo <= execute.beqi;
      execute.bneo <= execute.bnei;
      execute.laddro <= execute.laddri;
      execute.execute_opcodeo <= execute.execute_opcodei;
    end
    else
    begin
      execute.outputo <= execute.outputo;
      execute.zeroo <= execute.zeroo;
      execute.wdato <= execute.wdato;
      execute.dWENo <= execute.dWENo;
      execute.dRENo <= execute.dRENo;
      execute.WENo <= execute.WENo;
      execute.wselo <= execute.wselo;
      execute.reg_wro <= execute.reg_wro;
      execute.write_sigo <= execute.write_sigo;
      execute.halto <= execute.halto;
      execute.brvalo <= execute.brvalo;
      execute.jsigo <= execute.jsigo;
      execute.jrsigo <= execute.jrsigo;
      execute.pcAddrOuto <= execute.pcAddrOuto;
      execute.beqo <= execute.beqo;
      execute.bneo <= execute.bneo;
      execute.laddro <= execute.laddro;
      execute.execute_opcodeo <= execute.execute_opcodeo;
    end
  end
end

/*always_comb
begin
  //i need to bring all the things above to here and make copy of the signals...
  //lmao
*/
endmodule
