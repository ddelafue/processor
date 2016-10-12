`include "forwarding_unit_if.vh"

module forwarding_unit (
  input CLK, nRST,
  forwarding_unit_if.fuf fuf);

  logic zeros1, zeros2, zeros3;


  assign zeros1 = (fuf.read1 == 32'd0) && (fuf.read2 == 32'd0)
&& (fuf.write1 == 32'd0);
  assign zeros2 = (fuf.read1 == 32'd0) && (fuf.read2 == 32'd0)
&& (fuf.write2 == 32'd0);
  assign zeros3 = (fuf.read1 == 32'd0) && (fuf.read2 == 32'd0)
&& (fuf.write3 == 32'd0);

always_comb
begin
  if ((fuf.read1 == fuf.write1) && !zeros1)
  begin
//    fuf.forward1 = 1'b1;
    fuf.forw_en1 = 1'b1;
    //fix to the correct output
  end
  else
  begin
    fuf.forw_en1 = 1'b0;
  end

  if ((fuf.read1 == fuf.write2) && !zeros2)
  begin
    fuf.forw_en2 = 1'b1;
  end
  else
  begin
    fuf.forw_en2 = 1'b0;
  end

  if ((fuf.read1 == fuf.write3) && !zeros3)
  begin
    fuf.forw_en3 = 1'b1;
  end
  else
  begin
    fuf.forw_en3 = 1'b0;
  end

  if ((fuf.read2 == fuf.write1) && !zeros1)
  begin
    fuf.forw_en4 = 1'b1;
  end
  else
  begin
    fuf.forw_en4 = 1'b0;
  end

  if ((fuf.read2 == fuf.write2) && !zeros2)
  begin
    fuf.forw_en5 = 1'b1;
  end
  else
  begin
    fuf.forw_en5 = 1'b0;
  end

  if ((fuf.read2 == fuf.write2) && !zeros3)
  begin
    fuf.forw_en6 = 1'b0;
  end
  else
  begin
    fuf.forw_en6 = 1'b0;
  end
end

endmodule
