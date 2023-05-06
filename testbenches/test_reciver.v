`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:57:34 10/11/2020
// Design Name:   Receiver
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 470 LAB/Lab 6/UART/test_reciver.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_reciver;

	// Inputs
	reg CLOCK_125_p;
	reg SW;

	// Outputs
	wire [7:0] LEDR;
	wire check_parity;

	// Instantiate the Unit Under Test (UUT)
	Receiver uut (
		.CLOCK_125_p(CLOCK_125_p), 
		.LEDR(LEDR), 
		.check_parity(check_parity), 
		.SW(SW)
	);

	initial begin
		// Initialize Inputs
		CLOCK_125_p = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

