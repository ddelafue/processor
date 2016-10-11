`include "register_file_if.vh"
`include "cpu_types_pkg.vh"
module register_file
import cpu_types_pkg::*;
(
  input logic CLK, nRST,
  register_file_if.rf rfif
);

word_t [31:0] register;

assign rfif.returner = register[31];


always_ff @(negedge CLK, negedge nRST) //maybe?
begin
 if(!nRST)
 begin

  register <= '{default:'0};

 end
 else if (rfif.WEN && rfif.wsel != 0)
 begin
   register[rfif.wsel] <= rfif.wdat;
 end
end




always_comb
begin
  //i know about the zero thing. dont care till i get something to work
  if(rfif.rsel1 != 0)
  begin
    rfif.rdat1 = register[rfif.rsel1];
  end
  else
  begin
    rfif.rdat1 = 32'b0;
  end

  if(rfif.rsel2 != 0)
  begin
    rfif.rdat2 = register[rfif.rsel2];
  end
  else
  begin
    rfif.rdat2 = 32'b0;
  end
end

endmodule
