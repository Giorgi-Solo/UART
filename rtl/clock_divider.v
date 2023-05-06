`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// (counter_ceil+1) * 2 times increase the period
//////////////////////////////////////////////////////////////////////////////////
module clock_divider(
    input clk_in,rst,
    output clk_out
    );
parameter integer counter_ceil = 2603;
reg [25:0] counter;
reg clock;

assign clk_out = clock;

always @(posedge clk_in, negedge rst) begin
if(~rst) begin
	counter <= 0;
	clock <= 0;
end
else begin
	counter <= counter + 1;
	if(counter==counter_ceil) begin
		counter <= 0;
		clock <= ~clock;
	end
end
end

endmodule
