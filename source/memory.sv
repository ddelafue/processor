`include "memory_if.vh"

module memory(
  input logic CLK,
  input logic nRST,
  memory_if.memif mem);

always_ff @ (posedge CLK, negedge nRST)
begin
  if (!nRST)
  begin
    mem.dloado <= 'b0;
    mem.aluo <= 'b0;
    mem.WENo <= 'b0;
    mem.reg_wro <= 'b0;
    mem.wselo <= 'b0;
    mem.write_sigo <= 'b0;
    mem.halto <= 'b0;
  end
  else
  begin
    if (mem.memory_en)
    begin
      mem.dloado <= mem.dloadi;
      mem.aluo <= mem.alui;
      mem.WENo <= mem.WENi;
      mem.reg_wro <= mem.reg_wri;
      mem.wselo <= mem.wseli;
      mem.write_sigo <= mem.write_sigi;
      mem.halto <= mem.halti;
    end
    else
    begin
      mem.dloado <= mem.dloado;
      mem.aluo <= mem.aluo;
      mem.WENo <= mem.WENo;
      mem.reg_wro <= mem.reg_wro;
      mem.wselo <= mem.wselo;
      mem.write_sigo <= mem.write_sigo;
      mem.halto <= mem.halto;
    end
  end
end

endmodule
