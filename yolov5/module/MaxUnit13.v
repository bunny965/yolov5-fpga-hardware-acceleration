module MaxUnit13 (x,MaxOut);
  
parameter DATA_WIDTH = 16;
localparam size = 13;

input [0:DATA_WIDTH*size*size-1] x;
output [0:DATA_WIDTH-1] MaxOut;
wire [0:DATA_WIDTH-1] out1,out2,out3,out4,out5,out6,out_temp;

MaxUnit9 m91 (x[0*81*DATA_WIDTH+:81*DATA_WIDTH],out1);
MaxUnit9 m92 (x[1*81*DATA_WIDTH+:81*DATA_WIDTH],out2);
MaxUnit2 m21 (x[162*DATA_WIDTH+:DATA_WIDTH],x[163*DATA_WIDTH+:DATA_WIDTH],x[164*DATA_WIDTH+:DATA_WIDTH],x[165*DATA_WIDTH+:DATA_WIDTH],out3);
MaxUnit2 m22 (x[166*DATA_WIDTH+:DATA_WIDTH],x[167*DATA_WIDTH+:DATA_WIDTH],x[168*DATA_WIDTH+:DATA_WIDTH],out1,out4);
compare c1 (out2,out3,out_temp);
compare c2 (out_temp,out4,MaxOut);



endmodule
      