//------------------------------
// Module name: multiple echo processor
// Function: Simply to pass input to output delayed by 0.8192ms, and attenuated
//------------------------------

module mult_echo (sysclk,valid, data_in, data_out);
	input 			valid; 
	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	output [9:0] 	data_out;	// 10-bit output data

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire [9:0]		x,y,q,z;

	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;

	wire FIFO_FULL;
	wire PLS;
	reg FIFO_FILLED;
	initial FIFO_FILLED = 1'b0;
	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	// This part should include your own processing hardware 
	// ... that takes x to produce y
	// ... In this case, it is ALL PASS.
	pulse_gen PULSE (.pulse(PLS), .in(valid), .clk(sysclk));
	// FIFO
	always @ (posedge sysclk) begin
		if (FIFO_FULL)
			FIFO_FILLED <= 1'b1;
	end
	
	FIFO fifo1 (
	.clock(sysclk),
	.data(y),
	.rdreq(FIFO_FILLED&PLS),
	.wrreq(1'b1),
	.full(FIFO_FULL),
	.q(z));
	
	assign y = x-{z[9],z[9:1]};
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (FIFO_FILLED)
			data_out <=  y + DAC_OFFSET;
		
endmodule
	