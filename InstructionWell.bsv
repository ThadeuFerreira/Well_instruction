
package InstructionWell;



interface IfcInstructionWell#(
   type seed_type,  // Seed type.
   type out_type    // Output word type.
);

   // Get a number from RNG.
   method ActionValue#(out_type) get (seed_type s);

endinterface: IfcInstructionWell



endpackage: InstructionWell
