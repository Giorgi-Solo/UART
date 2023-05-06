`timescale 1ns / 1ps


module test_clk;

	// Inputs
	reg clk_in;
	reg rst;
	// Outputs
	wire clk_out;
	wire [31:0] counter;
	assign counter =uut.counter;
	// Instantiate the Unit Under Test (UUT)
	clock_divider #(1) uut(
		.clk_in(clk_in),.rst(rst), 
		.clk_out(clk_out)
	);

	initial begin
		clk_in = 0;
		rst = 1;
		#1; rst =0; #1; rst =1;
	end
	always #1 clk_in = ~clk_in;
      
endmodule

