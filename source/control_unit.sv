/* this file right here will do cool stuff and make diego delafuente very angry
 * probably lmaoooo
 *this file is going to control signals from the majority of the other modules
 *through the datapath.sv file that I will connect everything to.I basically
 *am just going to check the signals to see if something changed with them
 *using case statements most likely, then set the outputs to the appropriate
 *values, which will in return most likely be set to something in the datapath
 */

`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
module control_unit (
   control_unit_if.cuif cuif
  /*interface is here. making one isn't hard so i should do that lmao*/
);


  import cpu_types_pkg::*;
 // logic [5:0] iinstrop;
  //logic [5:0] rinstrop;
  always_comb
  begin
    //cuif.halt = 1'd0;
   // if(cuif.dhit && cuif.ihit)
   // begin
     // $display("potato");
     // iinstrop = cuif.instr[31:26];
     // rinstrop = cuif.instr[5:0];
      cuif.regdst = 1'd0;
      cuif.reg_wr= 1'd0;
      cuif.rs = 5'd0;
      cuif.rt = 5'd0;
      cuif.rd = 5'd0;
    //  cuif.zero = 1'd0;
      cuif.shiftSig = 1'd0;
      cuif.immOut = 16'd0;
      cuif.immSig = 1'd0;
      cuif.beq = 1'd0;
      cuif.jrsig = 1'd0;
      cuif.bne = 1'd0;
      cuif.jump = 1'd0;
      cuif.memread = 1'd0;
      cuif.memwrite = 1'd0;
      cuif.instrread = 1'd0;
      cuif.zero = 1'd0;
      cuif.rs = 1'd0;
      cuif.rt = 1'd0;
      cuif.lui = 1'd0;
      cuif.write_sig = 1'd0;
      cuif.halt = 1'd0;
      cuif.pcAddrOut = 32'd0;
      cuif.outputop = ALU_ADD;
      cuif.shiftNum = 5'd0;
      cuif.halt = 1'd0;
     // cuif.reg_wr = 1'd1;
      //$display("%d", iinstrop);
      if(cuif.instr[31:26] == 6'd0)
      begin
        cuif.rs = cuif.instr[25:21];
        cuif.rt = cuif.instr[20:16];
        cuif.rd = cuif.instr[15:11];
        cuif.reg_wr = 1'd1;
        casez(cuif.instr[5:0])
          SLL : begin
                  cuif.outputop = ALU_SLL;
                  cuif.shiftNum = cuif.instr[10:6];
                  cuif.immOut = {11'd0, cuif.instr[10:6]};
                  cuif.immSig = 1'd1;
                  cuif.shiftSig = 1'd1;
                end
          SRL : begin
                  cuif.outputop = ALU_SRL;
                  cuif.shiftNum = cuif.instr[10:6];
                  cuif.immSig = 1'd1;
                  cuif.immOut = {11'd0,cuif.instr[10:6]};
                  cuif.shiftSig = 1'd1;

                end
          JR : begin
                cuif.jrsig = 1'd1;
                cuif.rs = 32'd31;
                cuif.rt = 32'd31;
                cuif.reg_wr = 1'd0;
                cuif.beq = 1'd0;
                cuif.bne = 1'd0;
                cuif.jump = 1'd0;
               end

          ADD : begin
                  cuif.outputop = ALU_ADD;
                end

          ADDU : begin
                  cuif.outputop = ALU_ADD;
                 end
          SUB : begin
                  cuif.outputop = ALU_SUB;
                end
          SUBU : begin
                  cuif.outputop = ALU_SUB;
                 end
          AND : begin
                  cuif.outputop = ALU_AND;
                end
          OR : begin
                  cuif.outputop = ALU_OR;
               end
          XOR : begin
                  cuif.outputop = ALU_XOR;
                end

          NOR : begin
                  cuif.outputop = ALU_NOR;
                end

          SLT : begin
                  cuif.outputop = ALU_SLT;
                end
          SLTU: begin
                  cuif.outputop = ALU_SLTU;
                end
          default : begin

                    end
        endcase
    end
    else
    begin
    //R-type above, I-type Below
          cuif.rs = cuif.instr[25:21];
          cuif.rt = cuif.instr[20:16];
          cuif.immOut = cuif.instr[15:0];
         // cuif.upper = cuif.instr[15:0]<<16;
          cuif.immSig = 1'd1;
          cuif.reg_wr = 1'd1;
          cuif.regdst = 1'd1;
          //insert immmediate signal here

          casez(cuif.instr[31:26])

            BEQ : begin
                    cuif.outputop = ALU_SUB;
                    cuif.beq = 1'd1;
                    cuif.reg_wr = 1'd0;
                    cuif.immSig = 1'd0;
                    cuif.zero = 1'd1;
                  end

            BNE : begin
                    cuif.outputop = ALU_SUB;
                    cuif.bne = 1'd1;
                    cuif.reg_wr = 1'd0;
                    cuif.immSig = 1'd0;
                    cuif.zero = 1'd1;
                  end

            ADDI : begin
                    cuif.outputop = ALU_ADD;
                 //cu.immSig = 1'd1;
                   end

            ADDIU : begin
                      cuif.outputop = ALU_ADD;
                   //   cu.immSig = 1'd1;
                    end

            SLTI : begin
                    cuif.outputop = ALU_SLT;
                   // cu.immSig = 1'd1;
                   end

            SLTIU : begin
                      cuif.outputop = ALU_SLTU;
                     // cu.immSig = 1'd1;
                    end

            ANDI : begin
                    cuif.outputop = ALU_AND;
                    cuif.zero = 1'd1;
                   // cu.immSig = 1'd1; maybe zero thing later idk tbh i could
                   // just check the opcode tbh
                   end

            ORI : begin
                    cuif.outputop = ALU_OR;
                    cuif.zero = 1'd1;
                    //$display("yes");
               //     cu.immSig = 1'd1;
                  end

            XORI : begin
                    cuif.outputop  = ALU_XOR;
                    cuif.zero = 1'd1;
                 //   cu.immSig = 1'd1;
                   end

            LUI : begin
                    cuif.lui = 1'd1;
                    cuif.rs = 1'd0;
                    cuif.outputop = ALU_OR;
                  end

            LW : begin
                  cuif.memread = 1'd1;
                  cuif.write_sig = 1'd1;
                  cuif.outputop = ALU_ADD;
                 end

            SW : begin
                  cuif.memwrite = 1'd1;
                  cuif.reg_wr = 1'd0;
                  cuif.outputop = ALU_ADD;
                 end
            HALT : begin
                    cuif.halt = 1'd1;
                   end
            J : begin
                  cuif.pcAddrOut = {cuif.pcAddrIn[31:28], cuif.instr[25:0], 2'b00};
                  cuif.jump = 1'd1;
                  //cuif.reg_wr = 1'd0;
                end

            JAL : begin
                    cuif.pcAddrOut = {cuif.pcAddrIn[31:28], cuif.instr[25:0], 2'b00};
                    cuif.jump = 1'd1;
                    cuif.immOut = cuif.pcAddrIn + 4;
                    cuif.zero = 1'd1;
                    cuif.outputop = ALU_OR;
                    cuif.rt = 32'd31;
                    cuif.reg_wr = 1'd1;
                    cuif.rs = 32'd0;

                  end

            default : begin

                      end

      endcase
    end
    if(!cuif.memread && !cuif.memwrite)
    begin
      cuif.instrread = 1'd1;
    end

end
endmodule




