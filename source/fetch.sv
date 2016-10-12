`include "fetch_if.vh"
`include "cpu_types_pkg.vh"

module fetch (
  input logic CLK,
  input logic nRST,
  fetch_if.fif fet);

  import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST)
begin
  if (!nRST)
  begin
    fet.iloado <= 'b0;
    fet.laddro <= 'b0;
    fet.fetch_opcodeo <= opcode_t'('b0);
  end
  else if(fet.flush)
  begin
    fet.iloado <= 'b0;
    fet.laddro <= 'b0;
    fet.fetch_opcodeo <= opcode_t'('b0);
  end

  else
  begin
    if (fet.fetch_en)
    begin
      fet.iloado <= fet.iloadi;
      fet.laddro <= fet.laddri;
      fet.fetch_opcodeo <= fet.fetch_opcodei;
    end
    else
    begin
      fet.iloado <= fet.iloado;
      fet.laddro <= fet.laddro;
      fet.fetch_opcodeo <= fet.fetch_opcodeo;
    end
  end
end

endmodule
