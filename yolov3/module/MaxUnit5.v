module MaxUnit5 (x,MaxOut);
  
parameter DATA_WIDTH = 16;
localparam size = 5;

input [0:DATA_WIDTH*size*size-1] x;
output [0:DATA_WIDTH-1] MaxOut;
wire [0:DATA_WIDTH*12-1] out1;
wire [0:DATA_WIDTH*6-1] out2;
wire [0:DATA_WIDTH*3-1] out3;

genvar i;
generate
    for(i=0;i<12;i=i+1) begin
        compare c1 (x[2*i*DATA_WIDTH+:DATA_WIDTH],x[(2*i+1)*DATA_WIDTH+:DATA_WIDTH],out1[i*DATA_WIDTH+:DATA_WIDTH]);
    end
    for(i=0;i<6;i=i+1) begin
            compare c2 (out1[2*i*DATA_WIDTH+:DATA_WIDTH],out1[(2*i+1)*DATA_WIDTH+:DATA_WIDTH],out2[i*DATA_WIDTH+:DATA_WIDTH]);
    end
    for(i=0;i<3;i=i+1) begin
                compare c3 (out2[2*i*DATA_WIDTH+:DATA_WIDTH],out2[(2*i+1)*DATA_WIDTH+:DATA_WIDTH],out3[i*DATA_WIDTH+:DATA_WIDTH]);
    end       
endgenerate
MaxUnit2 m1 (out3[0*DATA_WIDTH+:DATA_WIDTH],out3[1*DATA_WIDTH+:DATA_WIDTH],out3[2*DATA_WIDTH+:DATA_WIDTH],x[24*DATA_WIDTH+:DATA_WIDTH],MaxOut);
endmodule