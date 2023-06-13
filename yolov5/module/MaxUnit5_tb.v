`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 21:52:05
// Design Name: 
// Module Name: MaxUnit5_tb
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


module MaxUnit5_tb();
parameter DATA_WIDTH = 16;
localparam size = 5;
reg [DATA_WIDTH*size*size-1:0] x;
wire [DATA_WIDTH-1:0] MaxOut;

initial begin
#0 x<=400'h4000400040004000400040004000400040004000400040004000400040004000400040004000400042004000400040004000;
#300 x<=400'hBC00C000C200C400C000C200C400C50044004200420042004200420042004200420042004200420042004200420042004500;
end
MaxUnit5 m (x,MaxOut);

endmodule
