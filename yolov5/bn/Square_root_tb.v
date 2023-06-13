`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/22 16:17:01
// Design Name: 
// Module Name: Square_root_tb
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


module Square_root_tb();
parameter DATA_WIDTH = 16;
wire [DATA_WIDTH*5-1:0] Coefficients ; 

reg clk, reset;
reg [15:0]x;
wire [15:0]OutputFinal,ans,ans_o,sub,yi;


localparam PERIOD = 20;

always
	#(PERIOD/2) clk = ~clk;

initial begin
	#0 //starting the tanh 
	clk <= 1'b1;
	reset <= 1'b1;
   // x<=16'h463c;
  // x<=16'b0100100010000000;
   x<=16'b0010010000000000;

	#(2*PERIOD)
	reset <= 1'b0;	
	
	#400
	// waiting for 4 clock cycles then checking the output with approx.(0.53685)
	
	    //trying another input which will be in the convergence region(3)  the output will be converged to 1    and reseting the function again
	   // x<=16'h4500;//5
	    x<=16'b0110100010000000;
	    
		reset <= 1'b1;
		#(PERIOD)
		reset<=1'b0;
		#200
            // waiting for 4 clock cycles then checking the output with approx.(0.53685)
            
                //trying another input which will be in the convergence region(3)  the output will be converged to 1    and reseting the function again
               //	x<=16'b0011110000000000;
                //x<=16'b1000010101100100;
                
                reset <= 1'b1;
                #(2*PERIOD)
                reset<=1'b0;
                #400
	
	$stop;
end

Square_root UUT
(
x,OutputFinal,clk,reset
);
assign ans = UUT.ans;
assign ans_o = UUT.ans_o;
//assign yi = UUT.yi_pai;
assign sub = UUT.sub;



endmodule
