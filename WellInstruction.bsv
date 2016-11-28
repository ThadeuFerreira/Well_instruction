
package WellInstruction;

// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import RandomNumberGenerator::*;
import InstructionWell::*;
import WellPRNG::*;


(* synthesize *)
module mkWellInstruction (IfcInstructionWell#(Int32WORD, Int32WORD));
   
   
   IfcRandomNumberGenerator#(Int32WORD, Int32WORD) rng <- mkWellPRNG ();
   
   
   Reg#(Int32WORD) v <- mkReg (0);
   Reg#(Int32WORD) test <- mkReg (0);
   Reg#(Int32WORD) test2 <- mkReg (0);
   Reg#(Int32WORD) cont <- mkReg (0);

    rule ruleget (test == 0 && test2 != 0);
      $display("Rule Get");
      Int32WORD valueReturned <- rng.get();
      $display("%d",valueReturned);
      v <= valueReturned;
     endrule

      rule ruleinitialize (test != 0);
        $display("Rule initialize");
        test <= 0;
        rng.initialize(test);
     endrule

     rule myrule;
        cont <= cont + 1;
        $display("test2 %d", test2);
        $display("cont %d", cont);
     endrule

  method ActionValue#(Int32WORD) get (Int32WORD s);
      test <= s;
      test2 <= 1;
      return v;
  endmethod:get
   

endmodule: mkWellInstruction



endpackage: WellInstruction
