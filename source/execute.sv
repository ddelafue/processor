`include "execute_if.vh"

module execute (
  input logic CLK,
  input logic nRST,
  execute_if.excif exec);

always_ff @ (posedge CLK, negedge nRST)
begin
  if (!nRST|exec.flush)
  begin
    exec.outputo <= 'b0;
    exec.zeroo <= 1'b0;
    exec.wdato <= 'b0;
    exec.dWENo <= 'b0;
    exec.dRENo <= 'b0;
    exec.WENo <= 'b0;
    exec.wselo <= 'b0;
    exec.reg_wro <= 'b0;
    exec.write_sigo <= 'b0;
    exec.halto <= 'b0;
  end
  else
  begin
    if (exec.execute_en)
    begin
      exec.outputo <= exec.outputi;
      exec.zeroo <= exec.zeroi;
      exec.wdato <= exec.wdati;
      exec.dWENo <= exec.dWENi;
      exec.dRENo <= exec.dRENi;
      exec.WENo <= exec.WENi;
      exec.wselo <= exec.wseli;
      exec.reg_wro <= exec.reg_wri;
      exec.write_sigo <= exec.write_sigi;
      exec.halto <= exec.halti;
    end
    else
    begin
      exec.outputo <= exec.outputo;
      exec.zeroo <= exec.zeroo;
      exec.wdato <= exec.wdato;
      exec.dWENo <= exec.dWENo;
      exec.dRENo <= exec.dRENo;
      exec.WENo <= exec.WENo;
      exec.wselo <= exec.wselo;
      exec.reg_wro <= exec.reg_wro;
      exec.write_sigo <= exec.write_sigo;
      exec.halto <= exec.halto;
    end
  end
end

endmodule
