`timescale 1 ns / 10 ps

module MaxUnit2 (numA,numB,numC,numD,MaxOut);
  
parameter DATA_WIDTH = 16;
input [DATA_WIDTH-1:0] numA,numB,numC,numD;
output wire [DATA_WIDTH-1:0] MaxOut;
wire [DATA_WIDTH-1:0] out1,out2;

compare c1 (numA,numB,out1);

compare c2 (numC,numD,out2);

compare c3 (out1,out2,MaxOut);
endmodule