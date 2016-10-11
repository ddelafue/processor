
`include "pc_if.vh"
`include "cpu_types_pkg.vh"
module pc(
  input logic CLK, nRST,
  pc_if.pcs pcif
);

logic [31:0] new_pc;
logic [31:0] length;
assign length = 32'd0;
always_ff @(posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin

    pcif.ladd <= length;
  end
  else
  begin
    pcif.ladd <= new_pc;
  end


end




always_comb
begin
  if(pcif.pcenable && nRST)
  begin
    //new_pc = pcif.ladd + 4;
    if(pcif.beq)
    begin
      if(pcif.zero)
      begin
        new_pc = /*pcif.ladd*/ pcif.brstart + (pcif.brval<<2) +4;
      end
      else
      begin
        new_pc = pcif.brstart + 4;
      end
    end
    else if(pcif.bne)
    begin
      if(!pcif.zero)
      begin
        new_pc = /*pcif.ladd*/ pcif.brstart + (pcif.brval<<2) +4;
      end
      else
      begin
        new_pc = pcif.brstart + 4;
      end
    end

    else if(pcif.jrsig)
    begin
      new_pc = pcif.jrval;
    end


    else if(pcif.jsig)
    begin
      new_pc = pcif.jumpval;
    end
    else
    begin
      new_pc = pcif.ladd +4;
    end
  end
  else
  begin
    new_pc = pcif.ladd;
  end
  /*else
  begin
    new_pc = pcif.ladd;
  end*/

end
endmodule
