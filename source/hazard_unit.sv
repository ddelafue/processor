`include "hazard_unit_if.vh"

module hazard_unit (
  input CLK, nRST,
  hazard_unit_if.haz haz);

  logic [3:0]enable;

  assign {haz.decode_en, haz.execute_en, haz.fetch_en, haz.memory_en} = enable;



always_comb
begin
//  enable = 4'hf;
  haz.edeassert = 1'd0;
  haz.fdeassert = 1'd0;
  haz.ddeassert = 1'd0;
  haz.mdeassert = 1'd0;
 // haz.another = 1'd1;
  enable = 4'h0;

 if(((haz.read1 == haz.write1)||(haz.read2 == haz.write1))&& !(haz.read1 == 32'd0 &&
haz.read2 == 32'd0 && haz.write1 == 32'd0)&&(haz.write1 != 32'd0))
 begin
    enable = 4'h5;
    haz.ddeassert = 1'd1;
 end
 else if(((haz.read1 == haz.write2)||(haz.read2 == haz.write2))&& !(haz.read1 ==
32'd0 && haz.read2 == 32'd0 && haz.write2 == 32'd0)&&(haz.write2 != 32'd0))
 begin
    enable = 4'h5;
    haz.ddeassert = 1'd1;
 end

else if(((haz.read1 == haz.write3)||(haz.read2 == haz.write3)) && !(haz.read1 ==
32'd0 && haz.read2 == 32'd0 && haz.write3 == 32'd0)&&(haz.write3 != 32'd0))
begin
  enable = 4'h5;
  haz.ddeassert = 1'd1;
end

else
begin
  unique casez({haz.dhit, haz.ihit, haz.beq, haz.bne, haz.zero,haz.jr, haz.j})
  7'b0000000 : enable = 4'h0;
  7'b1000000 :  begin
                  enable = 4'h1;
                  haz.edeassert = 1'd1;
                end
  7'b0100000 : enable = 4'hF;
  7'b0100001 : begin
                enable = 4'h3;
                haz.fdeassert = 1'd1;
                haz.ddeassert = 1'd1;
                haz.edeassert = 1'd1;
              end
  7'b0100010 : begin
                enable = 4'h3;
                haz.fdeassert = 1'd1;
                haz.ddeassert = 1'd1;
                haz.edeassert = 1'd1;
               end
  7'b0100100 : enable = 4'hF;
  7'b0101000 : begin
                enable = 4'h3; //try 3
                haz.fdeassert = 1'd1;
                haz.ddeassert = 1'd1;
                haz.edeassert = 1'd1;
             end
  7'b0101100 : begin
              enable = 4'hF;
             end
  7'b0110000 : enable = 4'hF;
  7'b0110100 : begin
              enable = 4'h3;
              haz.fdeassert = 1'd1;
              haz.ddeassert = 1'd1;
              haz.edeassert = 1'd1;
             end

/*  unique casez ({haz.dhit, haz.ihit, haz.memWEN, haz.memREN})
  4'b0000 :  begin
              enable = 4'h0;
              //haz.deassert = 1'd1;
             end
  4'b0001 : enable = 4'h0;
  4'b0010 : enable = 4'h0;
  4'b0011 : enable = 4'h0;
  4'b0100 : enable = 4'hF;
  4'b0101 : enable = 4'h0;
  4'b0110 : enable = 4'h0;
  4'b0111 : enable = 4'h0;
  4'b1000 : begin
              enable = 4'h1;
              haz.deassert = 1'd1;
            end
  4'b1001 : enable = 4'h0;
  4'b1010 : enable = 4'h0;
  4'b1011 : enable = 4'h0;
  4'b1100 : enable = 4'hF;
  4'b1101 : enable = 4'h0;
  4'b1111 : enable = 4'h0;*/
  default : enable = 4'h0;
  endcase
end
end

endmodule

//next will involve making sure that we don't attempt to read anything that is
//in the process of being written. like addi 2, 2 ,2 then a addi 3,2,1,need to
//stop all the instructions from coming in and let the write happen first just happen so its
// like xx111, with the x meaning to set the values in that part of the pipeline
// to stay the same until we write so it has got to check at each stage every
// clock cycle until it reaches memory and then set the x's back to 1.  maybe
// have to add to datapath in order to do this.
