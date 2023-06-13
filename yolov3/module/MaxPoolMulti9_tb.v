`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 23:25:01
// Design Name: 
// Module Name: MaxPoolMulti9_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MaxPoolMulti9_tb(

    );
    parameter DATA_WIDTH = 16;
    parameter D = 2;
    parameter H = 9;
    parameter W = 9;
    localparam s =9;
    
 reg reset,clk;
 reg [0:H*W*D*DATA_WIDTH-1] mpInput;
wire [0:(H/s)*(W/s)*D*DATA_WIDTH-1] mpOutput;
localparam PERIOD = 100;
always
	#(PERIOD/2) clk = ~clk;
	

initial begin
#0 mpInput<=2592'h400040004000400040004000400040004000400040004000400040004000400040004000400040004200400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000420040004000400040004000400040004000400040004000400040004000400040004000400040004500400040004000400040004200400040004000400042004200420042004200400040004000400040004000400040004000400040004000400040004000400040004000400040004200400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000420040004000400040004000400040004000400040004000400040004000400040004000400040004500400040004000400040004200400040004000400042004200420042004200;
clk = 1'b0;
reset = 1;
#(PERIOD)
	  reset = 0;

#200

$stop;
end
MaxPoolMulti9 UUT (clk, reset, mpInput, mpOutput);
endmodule
