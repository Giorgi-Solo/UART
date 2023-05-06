`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:53:55 10/11/2020
// Design Name:   UART
// Module Name:   C:/Users/SOLO/Desktop/san diego/The Fourht Year/The Fall Semester/COMPE - 470 LAB/Lab 6/UART/test.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg CLOCK_125_p;
	reg [2:0] KEY;
	reg [7:0] SW_1;
	reg [7:0] SW_2;

	// Outputs
	wire Tx_1;
	wire [7:0] LEDR_1;
	wire check_parity_1;
	wire Tx_2;
	wire [7:0] LEDR_2;
	wire check_parity_2;

	// Instantiate the Unit Under Test (UUT)
	UART #(1,1) uut_1 (
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY), 
		.SW(SW_1), 
		.Rx(Tx_2), 
		.Tx(Tx_1), 
		.LEDR(LEDR_1), 
		.check_parity(check_parity_1)
	);
	
	UART #(1,1) uut_2 (
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY), 
		.SW(SW_2), 
		.Rx(Tx_1), 
		.Tx(Tx_2), 
		.LEDR(LEDR_2), 
		.check_parity(check_parity_2)
	);
wire clock_for_Transmitter, clock_for_Receiver;

assign clock_for_Transmitter=uut_1.clock_for_Transmitter;
assign clock_for_Receiver=uut_1.clock_for_Receiver;

wire [11:0] Register_for_input_data_1,Register_for_input_data_2;		

assign Register_for_input_data_1 = uut_1.Register_for_input_data;
assign Register_for_input_data_2 = uut_2.Register_for_input_data;

always #1 CLOCK_125_p = ~CLOCK_125_p;
	initial begin
		// Initialize Inputs
		CLOCK_125_p = 0;
		KEY = 7;
		SW_1 = 0;SW_2 = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		KEY[0] = 0;
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p); // reset everythin
		KEY[0]=1; 
		
		SW_1 = 8'b00001111; // set data byte
		SW_2 = 8'b11110000;
		@(posedge clock_for_Transmitter);@(posedge clock_for_Transmitter);

      KEY[1] = 1;
		@(posedge clock_for_Transmitter);@(posedge clock_for_Transmitter); // store data byte into sent register
		KEY[1]=0; 
		
		@(posedge clock_for_Transmitter);@(posedge clock_for_Transmitter);

      KEY[2] = 1;
		@(posedge clock_for_Transmitter);@(posedge clock_for_Transmitter); // start sending
		KEY[2]=0; 
		

	end
      
endmodule