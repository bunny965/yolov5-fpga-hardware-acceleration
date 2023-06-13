`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 21:26:36
// Design Name: 
// Module Name: MaxPoolSingle13
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


module MaxPoolSingle13(mPoolIn,mPoolOut);
parameter DATA_WIDTH = 16;
parameter InputH = 13;
parameter InputW = 13;
localparam Depth = 1;
localparam s =13;
input [0:InputH*InputW*Depth*DATA_WIDTH-1] mPoolIn;
output [0:(InputH-s+1)*(InputW-s+1)*Depth*DATA_WIDTH-1] mPoolOut;

genvar i,j;

generate 
  for (i=0; i<(InputH-12); i=i+1) begin
    for (j=0; j<(InputW-12); j=j+1) begin
    MaxUnit13
     MU
    (
      .x({mPoolIn[(i*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+1)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+2)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+3)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+4)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+5)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+6)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+7)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+8)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+9)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+10)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+11)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+12)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH]}),
      .MaxOut(mPoolOut[(i*(InputH-s+1)+j)*DATA_WIDTH+:DATA_WIDTH])
      );
    end
  end
endgenerate

endmodule
