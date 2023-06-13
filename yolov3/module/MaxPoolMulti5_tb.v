`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 22:37:04
// Design Name: 
// Module Name: MaxPoolMulti5_tb
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


module MaxPoolMulti5_tb(

    );
parameter DATA_WIDTH = 16;
    parameter D = 1;
    parameter H = 6;
    parameter W = 6;
    localparam s =5;
    
 reg reset,clk;
 reg [0:H*W*D*DATA_WIDTH-1] mpInput;
wire [0:(H-s+1)*(W-s+1)*D*DATA_WIDTH-1] mpOutput;
localparam PERIOD = 100;
always
	#(PERIOD/2) clk = ~clk;
	

initial begin
#0 mpInput<=576'hBC00BC00BC00BC00BD00BC00C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200C200;
clk = 1'b0;
reset = 1;
#(PERIOD)
	  reset = 0;

#200
//mpInput<=800'hBC00C000C200C400C000C200C400C500440042004200420042004200420042004200420042004200420042004200420045004000400040004000400040004000400040004000400040004000400040004000400040004000400042004000400040004000;
//reset = 1;
#(PERIOD)
	 // reset = 0;
	  #200
$stop;
end
MaxPoolMulti5 UUT (clk, reset, mpInput, mpOutput);
endmodule
