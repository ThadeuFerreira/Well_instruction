
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
 






  method ActionValue#(Int32WORD) get (Int32WORD s);
      Int32WORD v = 0;
      if (s != 0)
         rng.initialize(s);
      else
         v <- rng.get();
      return v;
  endmethod:get

   

endmodule: mkWellInstruction



endpackage: WellInstruction
