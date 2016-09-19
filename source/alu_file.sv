`include "alu_file_if.vh"
`include "cpu_types_pkg.vh"
module alu_file
import cpu_types_pkg::*;
(
  alu_file_if.rf aluf
);


always_comb
begin
    aluf.zero = 1'd0;
    aluf.overflow = 1'd0;
    aluf.negative = 1'd0;
    aluf.output1 = 1'd0;

  casez(aluf.op)
    ALU_SLL : begin
                aluf.output1 = aluf.input1 << aluf.input2;
              end
    ALU_SRL : begin
                aluf.output1 = aluf.input1 >> aluf.input2;
              end
    ALU_AND : begin
                aluf.output1 = aluf.input1 & aluf.input2;
              end
    ALU_OR :  begin
                aluf.output1 = aluf.input1 | aluf.input2;
              end
    ALU_XOR:  begin
                aluf.output1 = aluf.input1 ^ aluf.input2;
              end
    ALU_NOR:  begin
                aluf.output1 = ~(aluf.input1 | aluf.input2);
              end
    ALU_ADD:  begin
               aluf.output1 = aluf.input1 + aluf.input2;
               if((aluf.output1[31] == 1'd1 && aluf.input1[31] == 1'd0 &&
aluf.input2[31] == 1'd0) )
               begin
                aluf.overflow = 1'd1;
               end
              else if((aluf.output1[31] == 1'd0 && aluf.input1[31] == 1'd1 &&
aluf.input2[31] == 1'd1) )
               begin
                aluf.overflow = 1'd1;
               end
               else
               begin
                aluf.overflow = 1'd0;
               end
             end
    ALU_SUB:  begin
                aluf.output1 = aluf.input1 + (~(aluf.input2) + 1);
                if(aluf.output1[31] == 1'd1 && aluf.input1[31] == 1'd0 &&
aluf.input2[31]== 1'd1)
                begin
                  aluf.overflow = 1'd1;
                end
                else
                begin
                  aluf.overflow = 1'd0;
                end
              end
  ALU_SLTU:  begin
              if(aluf.input1 < aluf.input2)
              begin
                aluf.output1 = 32'd1;
              end
              else
              begin
                aluf.output1 = 32'd0;
              end
              end
  ALU_SLT:  begin
              if (aluf.input1[31] == 1'd1)
              begin
                  if (aluf.input2[31] == 1'd0)
                  begin
                    aluf.output1 = 1'd1;
                  end
                  else if (aluf.input1 < aluf.input2)
                  begin
                    aluf.output1 = 1'd1;
                  end
                  else
                  begin
                    aluf.output1 = 1'd0;
                  end
              end

              else
              begin
                if(aluf.input2[31] == 1'd1)
                begin
                  aluf.output1 = 1'd0;
                end
                else if (aluf.input1 < aluf.input2)
                begin
                  aluf.output1 = 1'd1;
                end
                else
                begin
                  aluf.output1 = 1'd0;
                end
              end

            end
  default: begin
            aluf.output1 = 1'd0;
           end

  endcase
  if(aluf.output1 == 32'd0)
  begin
    aluf.zero = 1'd1;
  end
  else
  begin
    aluf.zero = 1'd0;
  end
  if(aluf.output1[31] == 1'd1)
  begin
    aluf.negative = 1'd1;
  end
  else
  begin
    aluf.negative = 1'd0;
  end
end

endmodule



