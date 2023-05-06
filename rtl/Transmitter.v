`timescale 1ns / 1ps

module Transmitter(
   // CLOCK /////////
      input              CLOCK_125_p, ///LVDS
      ///////// KEY ///////// 1.2 V ///////
      input       [2:0]  KEY,

      output      Tx,

      ///////// SW ///////// 1.2 V ///////
      input       [7:0]  SW);

reg [11:0] Register_for_input_data;		
reg [3:0] counter;
reg sent_data;
assign Tx=sent_data;

wire check_btn1; // check is 1 at posedge of Button 1
reg tmp_btn1;

always @(posedge CLOCK_125_p) begin // detect state transition button press
tmp_btn1<=KEY[1];
end

assign check_btn1=(tmp_btn1&(KEY[1]==0));

wire check_btn2; // check is 1 at posedge of Button 2
reg tmp_btn2;

always @(posedge CLOCK_125_p) begin // detect state transition button press
tmp_btn2<=KEY[2];
end

assign check_btn2=(tmp_btn2&(KEY[2]==0));


//st st [9:8:7:6:5:4:3:2] 1  0
//11 10			data			p  start
always @(posedge CLOCK_125_p, negedge KEY[0]) begin
if(~KEY[0]) begin
Register_for_input_data[9:1] <= 0; // set parity bit and data byte to 0
Register_for_input_data[0] <= 1; // set start bit to 1 - do not send
Register_for_input_data[11:10] <= 2'b11; // set stop bits to 11
counter <= 0;
sent_data <= 1; // do not send anything
end
else if(check_btn1) begin // set data byte to switch value and parity bit to xor SW
Register_for_input_data[8:1] <= SW;
Register_for_input_data[9] <= ^SW;
end
else if(check_btn2) begin
Register_for_input_data[0] <= 0;
Register_for_input_data[11:10] <= 2'b11;
end
else if(Register_for_input_data[0]==0) begin
sent_data <= Register_for_input_data[counter];
counter <= counter+1;
	if(counter==11)
	Register_for_input_data[0] <= 1;
end
else begin
counter <= 0;
end
end


endmodule
