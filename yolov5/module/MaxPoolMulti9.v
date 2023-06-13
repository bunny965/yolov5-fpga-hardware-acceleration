module MaxPoolMulti9(clk, reset, mpInput, mpOutput);

parameter DATA_WIDTH = 16;
parameter D = 2;
parameter H = 9;
parameter W = 9;
localparam s =9;

input reset,clk;
input [0:H*W*D*DATA_WIDTH-1] mpInput;
output reg [0:(H-s+1)*(W-s+1)*D*DATA_WIDTH-1] mpOutput;

reg [0:H*W*DATA_WIDTH-1] mpInput_s;
wire [0:(H-s+1)*(W-s+1)*DATA_WIDTH-1] mpOutput_s;
integer counter;
reg flag1;
reg [0:H*W*DATA_WIDTH-1] in;

MaxPoolSingle9
  #(
      .DATA_WIDTH(DATA_WIDTH),
      .InputH(H),
      .InputW(W)
  ) maxPool
  (
      .mPoolIn(mpInput_s),
      .mPoolOut(mpOutput_s)
  );
always@(mpInput or in) begin
  if(in==mpInput)
      flag1=1'b0;
  else 
      flag1=1'b1;
  end
  
  always @ (posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
      in <= 0;
    end
    else  begin 
      in <= mpInput;
    end
  end
  
  always @ (posedge clk or posedge reset or posedge flag1) begin
    if (reset == 1'b1 || flag1==1'b1) begin
      counter <= 0;
    end
    else if (counter<D) begin 
      counter <= counter+1;
    end
  end

always @ (*) begin
  mpInput_s = mpInput[counter*H*W*DATA_WIDTH+:H*W*DATA_WIDTH];
  mpOutput[counter*(H-s+1)*(W-s+1)*DATA_WIDTH+:(H-s+1)*(W-s+1)*DATA_WIDTH] = mpOutput_s;
end

endmodule