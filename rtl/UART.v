`timescale 1ns / 1ps
///
//////////////////////////////////////////////////////////////////////////////////
module UART(
		input CLOCK_125_p, 
      input [2:0] KEY,
		input [7:0] SW,
		input Rx,
		output Tx,
      output [7:0] LEDR,
		output check_parity // if 1, no error
    );

wire clock_for_Transmitter, clock_for_Receiver;

wire [11:0] Register_for_input_data;
assign Register_for_input_data = Transmitter00.Register_for_input_data;

parameter integer counter_ceil_tr = 2604; 
parameter integer counter_ceil_rec = 2604; 

clock_divider #(counter_ceil_tr) clock_divider_for_transmitter(
	.clk_in(CLOCK_125_p),.rst(KEY[0]),.clk_out(clock_for_Transmitter)
);

clock_divider #(counter_ceil_rec) clock_divider_for_receiver(
	.clk_in(CLOCK_125_p),.rst(KEY[0]),.clk_out(clock_for_Receiver)
);

Transmitter Transmitter00(
	.CLOCK_125_p(clock_for_Transmitter),
	.KEY(KEY),.Tx(Tx),.SW(SW));
	
Receiver Receiver00(
	.CLOCK_125_p(clock_for_Receiver),
	.Rx(Rx),.LEDR(LEDR),.check_parity(check_parity)
);


endmodule
