`include "fetch_if.vh"

module fetch (
  input logic CLK,
  input logic nRST,
  fetch_if.fif fet);

always_ff @ (posedge CLK, negedge nRST)
begin
  if (!nRST)
  begin
    fet.iloado <= 'b0;
    fet.laddro <= 'b0;
  end
  else if(fet.flush)
  begin
    fet.iloado <= 'b0;
    fet.laddro <= 'b0;
  end

  else
  begin
    if (fet.fetch_en)
    begin
      fet.iloado <= fet.iloadi;
      fet.laddro <= fet.laddri;
    end
    else
    begin
      fet.iloado <= fet.iloado;
      fet.laddro <= fet.laddro;
    end
  end
end

endmodule
