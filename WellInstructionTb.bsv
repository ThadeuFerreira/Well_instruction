
package WellInstructionTb;

// Bluespec standard packages.
import StmtFSM::*;

// My packages.
import InstructionWell::*;
import RandomNumberGenerator::*;
import WellPRNG::*;
import WellInstruction::*;



// Expoents for the number of outputs to be generated (2^N).
typedef 41 N_DEFAULT;      // For fast human conference.
typedef 4 N_SMALL_CRUSH;  // TestU01 Small Crush Battery. Empirically determined.
typedef 41 N_CRUSH;        // TestU01 Crush Battery. TestU01 user guide fails! Empirically determined.
typedef 62 N_BIG_CRUSH;    // TestU01 Big Crush Battery. TestU01 user guide fails!
typedef 34 N_DIEHARD;      // Marsaglia's DIEHARD. Empirically determined.
typedef 10 N_NIST;         // NIST test. Empirically determined.



(* synthesize *)
module mkWellInstructionTb (Empty);
   
   
   IfcInstructionWell#(Int32WORD, Int32WORD) rng <- mkWellInstruction ();
   
   
   // Expoent of the number of outputs to be generated (2^N).
   Reg#(UInt#(32)) n <- mkReg (fromInteger (valueOf (N_DEFAULT)));
   
   // Output counter.
   Reg#(UInt#(64)) i <- mkReg (0);
   
   
   Stmt verify_stmt =
   seq
      
      // Get TestU01 test type and set N.
      action

	 
	 // Priority: Small Crush > Crush > Big Crush > DIEHARD > NIST.
	 n <= fromInteger (valueOf (N_SMALL_CRUSH));
	 Int32WORD x <- rng.get(1);
	 
      endaction
      
      // Initialize Mersenne Twister with default seed.

      
      // Generate 2^N outputs.
      // Format: <Output Number> <Output Value in C Style Hex>

	$display("#==================================================================");

		
      while (i < (1 << n))
	 action
	    $display ("Final %d", rng.get(0));
	    i <= i + 1;
	 endaction
      
   endseq;
   
   mkAutoFSM (verify_stmt);
   
endmodule: mkWellInstructionTb



endpackage: WellInstructionTb
