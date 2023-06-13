`timescale 1 ns / 10 ps

module MaxPoolMulti2(clk, reset, mpInput, mpOutput);

parameter DATA_WIDTH = 16;
parameter D = 6;
parameter H = 28;
parameter W = 28;

input reset,clk;
input [0:H*W*D*DATA_WIDTH-1] mpInput;
output reg [0:(H/2)*(W/2)*D*DATA_WIDTH-1] mpOutput;

reg [0:H*W*DATA_WIDTH-1] mpInput_s;
wire [0:(H/2)*(W/2)*DATA_WIDTH-1] mpOutput_s;
integer counter;


MaxPoolSingle2
  #(
      .DATA_WIDTH(DATA_WIDTH),
      .InputH(H),
      .InputW(W)
  ) maxPool
  (
      .mPoolIn(mpInput_s),
      .mPoolOut(mpOutput_s)
  );

always @ (posedge clk or posedge reset) begin
  if (reset == 1'b1) begin
    counter <= 0;
  end
  else if (counter<D) begin 
    counter <= counter+1;
  end
end

always @ (*) begin
  mpInput_s = mpInput[counter*H*W*DATA_WIDTH+:H*W*DATA_WIDTH];
  mpOutput[counter*(H/2)*(W/2)*DATA_WIDTH+:(H/2)*(W/2)*DATA_WIDTH] = mpOutput_s;
end

endmodule