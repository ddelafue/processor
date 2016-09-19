
`include "extender_if.vh"
`include "cpu_types_pkg.vh"
module extender (
  extender_if.ex exif
);


  import cpu_types_pkg::*;

  always_comb
  begin
    if(exif.zero)
    begin
      exif.outputimm = {16'b0000000000000000, exif.inputimm};
    end
    else if(exif.lui)
    begin
      exif.outputimm = {exif.inputimm, 16'b0000000000000000};
    end
    else if(exif.shiftSig)
    begin
      exif.outputimm = {27'b0000000000000000000000000000, exif.inputimm[4:0]};
     end
    else
    begin
      exif.outputimm = {{16{exif.inputimm[15]}}, exif.inputimm};
    end
  end

endmodule


