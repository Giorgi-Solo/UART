`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

module test_UART;

	// Inputs
	reg CLOCK_125_p;
	reg [2:0] KEY;
	reg [7:0] SW;
	

	// Outputs
	wire Tx;
	wire [7:0] LEDR;
	wire check_parity;

	// Instantiate the Unit Under Test (UUT)
	UART #(.counter_ceil_tr(2604),.counter_ceil_rec(2604))uut (
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY), 
		.SW(SW), 
		.Rx(Tx), 
		.Tx(Tx), 
		.LEDR(LEDR), 
		.check_parity(check_parity)
	);
wire clock_for_Transmitter, clock_for_Receiver;

assign clock_for_Transmitter=uut.clock_for_Transmitter;
assign clock_for_Receiver=uut.clock_for_Receiver;

always #1 CLOCK_125_p = ~CLOCK_125_p;
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

