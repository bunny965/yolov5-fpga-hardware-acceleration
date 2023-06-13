`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/29 17:17:45
// Design Name: 
// Module Name: bn_multi_tb
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


module bn_multi_tb();
parameter DATA_WIDTH = 16;
parameter size = 8;
parameter beta =16'b0000000000000000;//0
parameter gama = 16'b0011110000000000;//1
parameter quarter = 16'b0011010000000000;
parameter channel = 1;
parameter size_div_channel = size/channel;

reg clk, reset;
reg [DATA_WIDTH*size-1:0]x;
wire [DATA_WIDTH*size-1:0]Out;


localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;

initial begin
	#0 //starting the tanh 
	clk <= 1'b1;
	reset <= 1'b1;
    x<=128'b0100001000000000_0100001000000000_0100010000000000_0100010100000000_0100001000000000_0100001000000000_0100010000000000_0100010100000000 ;
	#(2*PERIOD)
	reset <= 1'b0;	
	#400
	    //x<=64'h3C00_4000_4200_4400;	
	    //x<=64'h9C00_8000_B200_A400;    

		#200
	
	$stop;
end
 bn_multi  UUT (x,Out,clk,reset);

endmodule
