`timescale 1ns / 1ps

module Receiver(
   // CLOCK /////////
      input              CLOCK_125_p, ///LVDS
      ///////// KEY ///////// 1.2 V ///////

      ///////// LEDR ///////// 2.5 V ///////
      output     [7:0]  LEDR,
      output reg check_parity, // if 1, no error

      input      Rx);
		
reg [7:0] sent_data=0;
reg [3:0] counter=0;
reg [1:0] tmp=0;
wire check;

always @(posedge CLOCK_125_p) begin
tmp[0] <= Rx;
tmp[1] <= tmp[0];
end

assign check = (tmp==2'b11)&(Rx==0)&(counter==0);

assign LEDR[7:0]= (counter==0)?sent_data:0;

reg receive_enable = 0;

always @(posedge CLOCK_125_p, posedge check) begin
if(check) begin
sent_data <= 0;
counter <=0;
receive_enable <= 1;
end
else if(receive_enable) begin
counter <= counter+1;
	if(counter<8)
		sent_data[counter] <= Rx;
	else if(counter==8)
		check_parity = ((^sent_data)==Rx);
	else begin
		counter <= 0;
		receive_enable <= 0;
	end
end
end


endmodule
