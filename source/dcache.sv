`include "dcache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"
//`include "dcache_pkg.vh"


module dcache
import cpu_types_pkg::*;
(
  input CLK, nRST,
  dcache_if.dcache dcif,
  caches_if.dcache cif
);

typedef enum logic[3:0] {DEFAULT, DIRTY1, DIRTY2, REPLACE1,
REPLACE2,HALT,HALT1,HALT2} stype;
stype state;
stype nextstate;


//have to do something about the least frequently used that gets replaced  also
//other stuff
import cpu_types_pkg::*;
//import dcache_pkg::*;
dcachef_t [15:0] dvals;
dcachef_t [15:0] next_dvals;
logic dirty;
logic ddone;
logic ddone2;
logic replace;
logic rep1;
logic rep2;
logic halt;
logic finished;
logic [4:0] count;
logic [4:0] nextcount;
logic haltto;
logic haltnext;
logic haltback;
logic [15:0] dirtyarray; // 16 frames that are dirty
logic [15:0] next_dirtyarray;
logic [7:0] next_lastarray;
//logic next_replace;
//logic [31:0] next_memout;
int next_frame;
logic nextflushed;

//typedef logic [3:0] indexttype;

//indextype [15:0] indexarray;
//assign indexarray = [3'd0, 3'd0, 3'd1, 3'd1, 3'd2, 3'd2, 3'd3, 3'd3, 3'd4, 3'd4,
//3'd5, 3'd5, 3'd6, 3'd6, 3'd7, 3'd7];

word_t [31:0] cblocks; //all the space needed for blocks. in word_t so it
word_t [31:0] next_cblocks;                      //corresponds to 15 frames.

//dvals [15:0] tagspace; //holds space, should hold the tags of each frame even if
                     //the437lre in sets of two

//dvals[0].tag = whatever

//word_t [15:0] usedarray; //our least frequently used array, need validate one

logic[15:0] validarray;
logic[15:0] next_validarray;
logic[7:0] lastarray;
logic dahit;
logic [31:0] hitcounter;
logic [31:0] nexthitcounter;
logic valid;
logic nextvalid;
int frame;
//logic counter; //counts if we're at the first block or the second block in mem
               //operations



always_ff @ (posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin
    //dirty <= 1'd0;
    //ddone <= 1'd0;
    //ddone2 <= 1'd0;
    //replace <= 1'd0;
  //  usedarray <= '{default:'0};
    //dirtyarray <= '{default:'0};
    //cblocks <= '{default:'0};
    //dahit <= 1'd0;
    state <= DEFAULT;
    count <= 4'd0;
    lastarray <= 7'd0;
    cblocks <= '{default: '0};
    frame <= 'b0;
    //dcif.memout <= 32'd0;
    dvals <= '{default: '0};
    validarray <= '{default: '0};
    dirtyarray <= '{default: '0};
    dcif.flushed <= 1'd0;
    hitcounter <= 32'd0;
    valid <= 1'd0;
    //dcif.dhit <= 1'd0;
  end
  else
  begin
    state <= nextstate;
    //dcif.dhit <= dahit;
    count <= nextcount;
    lastarray <= next_lastarray;
    cblocks <= next_cblocks;
    frame <= next_frame;
//    dcif.memout <= next_memout;
    dvals <= next_dvals;
    validarray <= next_validarray;
    dirtyarray <= next_dirtyarray;
    dcif.flushed <= nextflushed;
    hitcounter <= nexthitcounter;
    valid <= nextvalid;
    //dcif.dhit <= dahit;
    //replace <= next_replace;
  end
end

assign dcif.dhit = dahit;


always_comb
begin
  nextstate = DEFAULT;
  casez(state)
  DEFAULT: begin
           //dahit = 1'd0;
           if(dirty)
           begin
             //dirty = 1'd0;
             nextstate = DIRTY1;
           end
           else if(replace)
           begin
             //replace = 1'd0;
             nextstate = REPLACE1;
           end
           else if(halt)
           begin
             nextstate = HALT;
           end
           else
           begin
             nextstate = DEFAULT;
           end

            //either goes to DIRTY1, REPLACE1, or DEFAULT

           end
  HALT: begin
           if(finished)
           begin
              nextstate = DEFAULT;
           end
           else if(haltto)
           begin
             nextstate = HALT1;
           end
           else
           begin
              nextstate = HALT;
           end

        end
  HALT1: begin
           if(haltnext)
           begin
              nextstate = HALT2;
           end
           else
           begin
              nextstate = HALT1;
           end
        end

  HALT2: begin
           if(haltback)
           begin
              nextstate = HALT;
           end
           else
           begin
              nextstate = HALT2;
           end
        end

  DIRTY1: begin
          if(ddone)
          begin
            nextstate = DIRTY2;
         //   ddone = 1'd0;
          end
          else
          begin
            nextstate = DIRTY1;
          end


          end

  DIRTY2: begin
          if(ddone2)
          begin
            nextstate = REPLACE1;
           // ddone2 = 1'd0;
          end
          else
          begin
            nextstate = DIRTY2;
          end

          end

  REPLACE1: begin
   //           replace= 1'd0;
              if(rep1)
              begin
             //   rep1 = 1'd0;
                nextstate = REPLACE2;
              end
              else
              begin
                nextstate = REPLACE1;
              end
            end



  REPLACE2: begin
              //replace = 1'b0;
              if(rep2)
              begin
               // rep2 = 1'd0;
                nextstate = DEFAULT;
              end
              else
              begin
                nextstate = REPLACE2;
              end
            end
  endcase


end
//need to add a state and stuff for the halt. lets get what we have done first
//done

assign dcif.memout = (dcif.tag == dvals[dcif.indx*2].tag &&
validarray[dcif.indx*2]) ? cblocks[(dcif.indx*2)*2 +dcif.offset] : cblocks[(dcif.indx*2 +1)*2 +dcif.offset];


always_comb
begin
  dirty = 1'd0;
  dahit = 1'd0;
  //replace = 1'd0;
  ddone = 1'd0;
  ddone2 = 1'd0;
  rep1 = 1'd0;
  rep2 = 1'd0;
  nextcount = 5'd0;
  haltto = 1'd0;
  haltnext = 1'd0;
  haltback = 1'd0;
  halt = 1'd0;
  next_dvals[0].idx = 3'd0;
  next_dvals[1].idx = 3'd0;
  next_dvals[2].idx = 3'd1;
  next_dvals[3].idx = 3'd1;
  next_dvals[4].idx = 3'd2;
  next_dvals[5].idx = 3'd2;
  next_dvals[6].idx = 3'd3;
  next_dvals[7].idx = 3'd3;
  next_dvals[8].idx = 3'd4;
  next_dvals[9].idx = 3'd4;
  next_dvals[10].idx = 3'd5;
  next_dvals[11].idx = 3'd5;
  next_dvals[12].idx = 3'd6;
  next_dvals[13].idx = 3'd6;
  next_dvals[14].idx = 3'd7;
  next_dvals[15].idx = 3'd7;
  finished = 1'd0;

  cif.dWEN = 1'd0;
  cif.dREN = 1'd0;
  cif.daddr = 32'd0;
  cif.dstore = 32'd0;
 // dcif.flushed = 1'd0;

  if(!nRST)
  begin
   //cif.dREN = 1'd0;
   replace = 1'd0;
   next_cblocks = '{default:'0};
   next_dirtyarray = '{default:'0};
   next_lastarray = '{default:'0};
   next_validarray = '{default:'0};
   next_dvals = '{default:'0};
//   next_memout = '{default: '0};
   next_frame = '{default: '0};
   nextflushed = 1'd0;
   nextvalid = 1'd0;
   nexthitcounter = 32'd0;
  end
  else
  begin
    nexthitcounter = hitcounter;
    replace = 1'b0;
    next_cblocks = cblocks;
    next_lastarray = lastarray;
    next_dirtyarray = dirtyarray;
    next_validarray = validarray;
    next_dvals = dvals;
    nextflushed = dcif.flushed;
    nextvalid = valid;
//    next_memout = dcif.memout;
    next_frame = frame;
    casez(state)
    DEFAULT: begin
      cif.dREN = 1'd0;
      cif.dWEN = 1'd0;
      if(dcif.halt)
      begin
        halt = 1'd1;
      end
      else if(dcif.dREN)
      begin
        //cif.dREN = dcif.dREN;
        if(dcif.tag == dvals[dcif.indx*2].tag && validarray[dcif.indx*2])
        begin
//          next_memout = cblocks[(dcif.indx*2)*2 + dcif.offset];
          next_lastarray[dcif.indx] = 1'd1;
          dahit = 1'd1;
          if(valid == 1'd0)
          begin
            nexthitcounter = hitcounter + 1;
          end
          else
          begin
            nextvalid = 1'd0;
          end
        end
        else if(dcif.tag == dvals[dcif.indx* 2 + 1].tag && validarray[dcif.indx*2
+1])
        begin
//          next_memout = cblocks[(dcif.indx*2 +1)*2 +dcif.offset];
          next_lastarray[dcif.indx] = 1'd0;
          dahit = 1'd1;
          if(valid == 1'd0)
          begin
            nexthitcounter = hitcounter + 1;
          end
          else
          begin
            nextvalid = 1'd0;
          end

        end
        else
        begin
          if(lastarray[dcif.indx] == 1'd0)
          begin
            next_frame = dcif.indx*2;
            if(dirtyarray[next_frame] == 1'd1)
            begin
              dirty = 1'd1;
              nextvalid = 1'd1;
              replace = 1'b0;
            end
            else
            begin
              nextvalid = 1'd1;
              replace = 1'd1;
            end
          end
        else
        begin
          next_frame = dcif.indx*2 + 1;
          if(dirtyarray[next_frame] == 1'd1)
          begin
            dirty = 1'd1;
            nextvalid = 1'd1;
          end
          else
          begin
            nextvalid = 1'd1;
            replace = 1'd1;
          end
        end
      end
    end




    else if(dcif.dWEN) //dwen
    begin
      if(dcif.tag == dvals[dcif.indx*2].tag && validarray[dcif.indx*2])
        begin
          $display("stuck?");
          next_cblocks[(dcif.indx*2)*2 + dcif.offset] = dcif.dstore;
          dahit = 1'd1;
          next_lastarray[dcif.indx] = 1'd1;
          next_dirtyarray[dcif.indx*2] = 1'd1;
          next_dvals[dcif.indx*2].tag = dcif.tag;
          next_dvals[dcif.indx*2].idx = dcif.indx;
          if(valid == 1'd0)
          begin
            nexthitcounter = hitcounter + 1;
          end
          else
          begin
            nextvalid = 1'd0;
          end


        end
      else if(dcif.tag == dvals[dcif.indx* 2 + 1].tag && validarray[dcif.indx*2
+1])
      begin
          next_cblocks[(dcif.indx*2 + 1)*2 + dcif.offset] = dcif.dstore;
          dahit = 1'd1;
          next_lastarray[dcif.indx] = 1'd0;
          next_dirtyarray[dcif.indx*2 + 1] = 1'd1;
          next_dvals[dcif.indx*2 + 1].tag = dcif.tag;
          next_dvals[dcif.indx*2 + 1].idx = dcif.indx;
          if(valid == 1'd0)
          begin
            nexthitcounter = hitcounter + 1;
          end
          else
          begin
            nextvalid = 1'd0;
          end
      end
      else
      begin

         if(lastarray[dcif.indx] == 1'd0)
          begin
            next_frame = dcif.indx*2;
            if(dirtyarray[next_frame] == 1'd1)
            begin
              dirty = 1'd1;
              nextvalid = 1'd1;
              replace = 1'b0;
            end
            else
            begin
              replace = 1'd1;
              nextvalid = 1'd1;
            end

        end
        else
        begin
          next_frame = dcif.indx*2 + 1;
          if(dirtyarray[next_frame] == 1'd1)
          begin
            dirty = 1'd1;
            replace = 1'b0;
            nextvalid = 1'd1;
          end
          else
          begin
            replace = 1'd1;
            nextvalid = 1'd1;
          end
        end

      end



    end
    end
    HALT: begin
    cif.dWEN = 1'd0;
    replace = 1'b0;
    if(dirtyarray[count] == 1'd1 && count != 5'd16)
    begin
      haltto = 1'd1;
      next_dirtyarray[count] = 1'd0;
      nextcount = count;
      //nextcount = count + 1;
    end
    else if(count != 5'd16)
    begin
      nextcount = count + 1;
    end
    else
    begin
      nextcount = count;
      cif.dWEN = 1'd1;
      cif.daddr = 32'h3100;
      cif.dstore = hitcounter;
      if(cif.dwait == 1'd0)
      begin
        finished = 1'd1;
        nextflushed = 1'd1;
      end
    end
  end

  HALT1: begin
           cif.dWEN = 1'd1;
           replace = 1'b0;
           cif.daddr = {dvals[count].tag, dvals[count].idx, 1'b0, 2'b0};
           cif.dstore = cblocks[count*2];
           nextcount = count;
           if(cif.dwait == 1'd0)
           begin
             haltnext = 1'd1;
            // cif.dWEN = 1'd0;
           end
          end
  HALT2: begin
           replace = 1'b0;
           cif.dWEN = 1'd1;
           cif.daddr = {dvals[count].tag, dvals[count].idx, 1'b1, 2'b0};
           cif.dstore = cblocks[count*2 + 1];
           nextcount = count;
           if(cif.dwait == 1'd0)
           begin
             haltback = 1'd1;
             //cif.dWEN = 1'd0;
             nextcount = count + 1;
           end
          end


  DIRTY1: begin
            //valid = 1'd1;
            replace = 1'b0;
            cif.dWEN = 1'd1;
            cif.daddr = {dvals[frame].tag, dvals[frame].idx, 1'b0, 2'b0};
            cif.dstore = cblocks[frame*2];
            if(cif.dwait == 1'd0)
            begin
              ddone = 1'd1;
             // cif.dWEN = 1'd0;
            end
          end

  DIRTY2: begin
            //valid = 1'd1;
            replace = 1'b0;
            cif.dWEN = 1'd1;
            cif.daddr = {dvals[frame].tag, dvals[frame].idx, 1'b1, 2'b0};
            cif.dstore = cblocks[frame*2 + 1];
            if(cif.dwait == 1'd0)
            begin
              ddone2 = 1'd1;
             // cif.dWEN = 1'd0;
              next_dirtyarray[frame] = 1'd0;
            end
          end

  REPLACE1: begin
              //valid = 1'd1;
              cif.dWEN = 1'd0;
              replace = 1'd0;
              cif.dREN = 1'd1;
              cif.daddr = {dcif.tag, dcif.indx, 1'b0, 2'b0};
              if(cif.dwait == 1'd0)
              begin
                next_cblocks[frame*2] = cif.dload;
                rep1 =  1'd1;
                //cif.dREN = 1'd0; //broken
                next_validarray[frame] = 1'd1;
              end

            end

  REPLACE2: begin
              //valid = 1'd1;
              replace = 1'b0;
              cif.dWEN = 1'd0;
              cif.dREN = 1'd1;
              cif.daddr = {dcif.tag, dcif.indx, 1'b1, 2'b0};
              if(cif.dwait == 1'd0)
              begin
                next_cblocks[frame*2 + 1] = cif.dload;
                next_validarray[frame] = 1'd1;
                rep2 = 1'd1;
                //cif.dREN = 1'd0;
                next_dvals[frame].tag = dcif.tag;
                next_dvals[frame].idx = dcif.indx;
              end
            end
  endcase
  end
end
endmodule




//
//
//
/*
        if(usedarray[dcif.indx*2] < usedarray[dcif.indx*2 +1])
        begin
          //check for dirty bit... later
          //if counter is zero
          if(counter == 1'd0) // this shit can use a state machine, fix ltr lmao...
          begin
            cif.daddr = {dcif.tag, dcif.indx, 1'b0, 2'b0};

            //CODE address twice, switching between the two blocks need
            //lfu[dcif.indx*2] = 32'd0;
            if(cif.dwait == 1'd0)
            begin
              cblocks[(dcif.indx * 4)] = cif.dload;
              countnext_er = 1'd1; //counter changes state... lmao
            end
          end


          else
          begin
            //else if counter is 1
            //set address to get next bit
            if(cif.dwait == 1'd0)
    logic [ITAG_W-1:0]  tag;
            begin
              cblocks[(dcif.indx*4)+1] = cif.dload;
              //set counter to zero
              tagspace[dcif.indx*2] = dcif.tag;
              if(dcif.offset = 1'd1)
              begin
                dcif.memout = cif.dload;
              end
              else
              begin
                dcif.memout = cblocks[(dcif.indx*4)];
              end
              //we might have to check in ff when this hit is high
              dahit = 1'd1;
              counter = 1'd0; //psuedo state change..
              usedarray[dcif.indx*2] = 32'd0; //now it's set back to 0
              end
          end
        else
        begin //if the least is the other

          if(counter == 1'd0) // this shit can use a state machine, fix ltr lmao...
          begin

            //CODE address twice, switching between the two blocks need
            //lfu[dcif.indx*2] = 32'd0;
            if(cif.dwait == 1'd0)
            begin
              cblocks[(dcif.indx*2 +1)*2] =  cif.dload;
              counter = 1'd1; //counter changes state... lmao
            end
          end
          else
          begin
            //else if counter is 1
            //set address to get next bit
            if(cif.dwait == 1'd0)
            begin
              cblocks[(dcif.indx*2 + 1)*2+1] = cif.dload;
              //set counter to zero
              tagspace[dcif.indx*2 + 1] = dcif.tag;
              if(dcif.offset = 1'd1)
              begin
                dcif.memout = cif.dload;
              end
              else
              begin
                dcif.memout = cblocks[(dcif.indx*2 + 1)*2];
              end
              //we might have to check in ff when this hit is high
              dahit = 1'd1;
              counter = 1'd0; //psuedo state change..
            end
          end
        end
    end
    else if(dcif.dWEN)
    begin
      if(dcif.tag == tagspace[dcif.indx*2])
      begin
          //set block to be the load
          //set frame dirty
      end
      else if(dcif.tag == tagspace[dcif.indx* 2 + 1])
      begin
          //set block to be the load
          //set the frame dirty
      end
      else
      begin
        if(usedarray[dcif.indx*2] < usedarray[dcif.indx*2 +1])
        begin

          //set address to first block of this frame
          //replace everything in the frame, THEN write
          //to it, and when you write, set it to be dirty.
        end

      end
    end
    else
    begin
      cif.dWEN = dcif.dWEN;
    end


  end



end

endmodule
*/
