`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 11:45:36
// Design Name: 
// Module Name: Silumulti_tb
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


module Silumulti_tb();
parameter DATA_WIDTH = 16;
parameter size = 4;

reg clk, reset;
reg [size*DATA_WIDTH-1:0]x;
wire Finished;
wire [size*DATA_WIDTH-1:0]OutputFinal;
localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;

initial begin
	#0 //starting the tanh 
	clk <= 1'b1;
	reset <= 1'b1;
	//2,1,-0.0038376,0.014->1.8,0.7314453125,-0.0019169,0.007061
	x<=64'b0100000000000000_0011110000000000_1001101111011100_0010001100101111;

	#(PERIOD)
	reset <= 1'b0;	
	
	#400
	// waiting for 4 clock cycles then checking the output with approx.(0.53685)
	
	   //-0.00008,0.00022,-0.06247,1->-0.0000401,0.000111,-0.0302887,0.7314453125
	    x<=64'b1000010101000011_0000101101000011_1010101111111111_0011110000000000;
	    //x<=16'b1000010101100100;
	    
		reset <= 1'b1;
		#(PERIOD)
		reset<=1'b0;
		#400
		// checking if the output is 1
	
	$stop;
end

Silumulti 
#(.DATA_WIDTH(16),.size(4))UUT
(
  .x(x),
	.clk(clk),
	.reset(reset),
	.product(OutputFinal),
	.Finished(Finished)	
);
endmodule
