module MaxPoolSingle9(mPoolIn,mPoolOut);
  
parameter DATA_WIDTH = 16;
parameter InputH = 9;
parameter InputW = 9;
localparam Depth = 1;
localparam s =9;

input [0:InputH*InputW*Depth*DATA_WIDTH-1] mPoolIn;
output [0:(InputH-s+1)*(InputW-s+1)*Depth*DATA_WIDTH-1] mPoolOut;

genvar i,j;

generate 
  for (i=0; i<(InputH-8); i=i+1) begin
    for (j=0; j<(InputW-8); j=j+1) begin
    MaxUnit9
     MU
    (
      .x({mPoolIn[(i*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+1)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+2)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+3)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+4)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+5)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+6)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+7)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH],mPoolIn[((i+8)*InputH+j)*DATA_WIDTH+:s*DATA_WIDTH]}),
      .MaxOut(mPoolOut[(i*(InputH-s+1)+j)*DATA_WIDTH+:DATA_WIDTH])
      );
    end
  end
endgenerate

endmodule
      