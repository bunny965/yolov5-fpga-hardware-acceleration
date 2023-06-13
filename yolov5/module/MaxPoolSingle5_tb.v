`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 22:14:50
// Design Name: 
// Module Name: MaxPoolSingle5_tb
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


module MaxPoolSingle5_tb(

    );
parameter DATA_WIDTH = 16;
parameter InputH = 5;
parameter InputW = 5;
localparam Depth = 1;
localparam s =5;

reg [InputH*InputW*Depth*DATA_WIDTH-1:0] mPoolIn;
wire [(InputH/s)*(InputW/s)*Depth*DATA_WIDTH-1:0] mPoolOut;

initial begin
#0 mPoolIn<=400'h4000400040004000400040004000400040004000400040004000400040004000400040004000400042004000400040004000;
#300 mPoolIn<=400'hBC00C000C200C400C000C200C400C50044004200420042004200420042004200420042004200420042004200420042004500;
#200
$stop;
end
 MaxPoolSingle5 m (mPoolIn,mPoolOut);

endmodule
