module MaxUnit9 (x,MaxOut);
  
parameter DATA_WIDTH = 16;
localparam size = 9;

input [0:DATA_WIDTH*size*size-1] x;
output [0:DATA_WIDTH-1] MaxOut;
wire [0:DATA_WIDTH-1] out1,out2,out3,out4,out5,out6,out_temp;


MaxUnit5 m1 (x[0*25*DATA_WIDTH+:25*DATA_WIDTH],out1);
MaxUnit5 m2 (x[1*25*DATA_WIDTH+:25*DATA_WIDTH],out2);
MaxUnit5 m3 (x[2*25*DATA_WIDTH+:25*DATA_WIDTH],out3);
MaxUnit2 m4 (out1,out2,out3,x[75*DATA_WIDTH+:DATA_WIDTH],out4);
MaxUnit2 m5 (x[76*DATA_WIDTH+:DATA_WIDTH],x[77*DATA_WIDTH+:DATA_WIDTH],x[78*DATA_WIDTH+:DATA_WIDTH],x[79*DATA_WIDTH+:DATA_WIDTH],out5);
compare c1 (x[79*DATA_WIDTH+:DATA_WIDTH],x[80*DATA_WIDTH+:DATA_WIDTH],out6);
compare c2 (out4,out5,out_temp);
compare c3 (out_temp,out6,MaxOut);

endmodule