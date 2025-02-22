`timescale 1ns / 100ps    // Unit time is 1ns, resolution 100ps
//-----------------------------------------------------------
// Design Name: modulo_counter_16
// Function: a 16-bit divide clock frequency circuit with enable input, fixed modulo and sreset
//-----------------------------------------------------------

module modulo_counter_16(
	clock, // clock input
	enable, // high enable counting
	sreset, // Synchronous reset
	//modulo,
	tick // tick
);

//------- Declare ports -------//

	parameter BIT_SZ = 16;
	parameter MODULO = 50000;
	input clock;
	input enable;
	input sreset;
	output tick;
	
// count needs to be declared as a reg
	reg [BIT_SZ-1:0] count;
	reg tick;
//----- always initialise storage elements such as D-FF
	initial count = 0;
	initial tick = 0;
//----- Main body of the module
	
	always @ (posedge clock) begin
		if (sreset == 1'b1) begin
			count <= 1'b0;
		end
		
		if (enable == 1'b1) begin
			if (count == (MODULO-1)) begin
				tick <= 1'b1;
				count <= 1'b0;
			end
			else begin
				tick <= 1'b0;
				count <= count + 1'b1;
			end
		end
	end
endmodule
