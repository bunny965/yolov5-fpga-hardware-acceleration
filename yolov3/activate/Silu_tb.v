`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 20:29:04
// Design Name: 
// Module Name: Silu_tb
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


module Silu_tb();
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 23:52:26
// Design Name: 
// Module Name: Sigmoid_tb
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


reg clk, reset;
reg [15:0]x;
wire Finished;
wire [15:0]OutputFinal;
localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;

initial begin
	#0 //starting the tanh 
	clk <= 1'b1;
	reset <= 1'b1;
	// trying a random input(0.600000023842)     where tanh(0.600000023842)=0.53704958
	x<=16'b0000000000000000;

	#(PERIOD)
	reset <= 1'b0;	
	
	#400
	// waiting for 4 clock cycles then checking the output with approx.(0.53685)
	
	    //trying another input which will be in the convergence region(3)  the output will be converged to 1    and reseting the function again
	    x<=16'b1011110000000000;
	    //x<=16'b1000010101100100;
	    
		reset <= 1'b1;
		#(PERIOD)
		reset<=1'b0;
		#400
		// checking if the output is 1
	
	$stop;
end

Silu UUT
(
  .x(x),
	.clk(clk),
	.reset(reset),
	.product(OutputFinal),
	.Finished(Finished)	
);




endmodule
