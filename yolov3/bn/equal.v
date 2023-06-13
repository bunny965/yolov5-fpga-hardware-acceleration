module equal(numA,numB,flag);
parameter DATA_WIDTH =16;
input [DATA_WIDTH-1:0] numA,numB;
output reg flag;
always @(numA or numB)
if(numA == numB)
flag<=1'b1;
else
flag <=1'b0;
endmodule