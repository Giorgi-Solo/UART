`timescale 1ns / 1ps


module test_transmitter;

	// Inputs
	reg CLOCK_125_p;
	reg [2:0] KEY;
	reg [7:0] SW;

	// Outputs
	wire Tx;
wire check_btn2, check_btn1;
wire [11:0] Register_for_input_data;		
wire [3:0] counter;

assign counter = uut.counter;
assign Register_for_input_data = uut.Register_for_input_data;
assign check_btn2 = uut.check_btn2;
assign check_btn1 = uut.check_btn1;

	// Instantiate the Unit Under Test (UUT)
	Transmitter uut (
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY), 
		.Tx(Tx), 
		.SW(SW)
	);
	
	// Outputs
	wire [7:0] LEDR;
	wire check_parity;

	// Instantiate the Unit Under Test (UUT)
	Receiver uut1 (
		.CLOCK_125_p(CLOCK_125_p), 
		.LEDR(LEDR), 
		.check_parity(check_parity), 
		.Rx(Tx)
	);
	always #5 CLOCK_125_p = ~CLOCK_125_p;
	initial begin
		// Initialize Inputs
		CLOCK_125_p = 0;
		KEY = 7;
		SW = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		KEY[0] = 0;
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p); // reset everythin
		KEY[0]=1; 
		
		SW = 8'b 10110011; // set data byte
		
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p);

      KEY[1] = 1;
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p); // store data byte into sent register
		KEY[1]=0; 
		
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p);

      KEY[2] = 1;
		@(posedge CLOCK_125_p);@(posedge CLOCK_125_p); // start sending
		KEY[2]=0; 
		

	end
      
endmodule

