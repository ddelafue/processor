/*
  handles the communciation between the control unit and the memory control
*/


`include "request_unit_if.vh"




module request_unit (
  input logic CLK, nRST,
  request_unit_if.ru rui
);
  import cpu_types_pkg::*;
  logic dr, dw, ir;

  typedef enum bit[3:0]{
   /* FR,
    EMP1,
    EMP2,
    FW,
    DR,
    DW,
    IR,
    INT,
    HALT*/
    NORMAL,
    FRE
    //EMPTY
  }stateType;

  stateType state, nxtstate;
 // logic [31:0] old;
  assign rui.iREN = 1'd1;
  always_ff @(posedge CLK, negedge nRST)
  begin
    if(!nRST)
    begin
      state <= NORMAL;
    end

    else
    begin
      state <= nxtstate;
    end
  end



  always_comb
  begin
    rui.dWEN = 1'd0;
    rui.dREN = 1'd0;
    //old = 32'd0;
    casez(state)
      NORMAL : begin
                // old = 32'd0;
                 if((rui.memwrite | rui.memread) && rui.ihiti == 1'd1)
                 begin
                   nxtstate = FRE;
                 end
                else
                begin
                  nxtstate = NORMAL;
                end

               end

      FRE : begin
   //            old = rui.instr;
               if(rui.memwrite)
                begin
                  rui.dWEN = 1'd1;
                  rui.dREN = 1'd0;
                end
                else
                begin
                  rui.dREN = 1'd1;
                  rui.dWEN = 1'd0;
                end

               if(!rui.pcenable)
               begin
                nxtstate = FRE;
               end
               else
               begin
                nxtstate = NORMAL;
               end
             end
   /* EMPTY : begin
            if(old != rui.instr)
            begin
              nxtstate = FRE;
            end
            else
            begin
              nxtstate = EMPTY;
            end
            end*/
    endcase
end


  always_comb
  begin

   if(rui.memwrite | rui.memread)
   begin
      rui.pcenable = rui.dhiti;
   end
  else
  begin
    rui.pcenable = rui.ihiti;
  end




  end

endmodule
