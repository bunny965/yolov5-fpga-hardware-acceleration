`timescale 100 ns / 10 ps

module convLayerMulti(clk,reset,image,filters,outputConv,Finished);

localparam DATA_WIDTH = 16;
parameter D = 1; //Depth of image and filter
parameter H = 32; //Height of image
parameter W = 32; //Width of image
parameter F = 5; //Size of filter
parameter K = 6; //Number of filters applied
parameter s = 1;
input clk, reset;
input [0:D*H*W*DATA_WIDTH-1] image;
input [0:K*D*F*F*DATA_WIDTH-1] filters;
output reg [0:K*((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH-1] outputConv; //output of the whole module
output reg Finished;

reg [2*D*F*F*DATA_WIDTH-1:0] inputFilters; //the 2 selected filters that are inputs to the 2 instances of conv layer single filter
wire [2*((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH-1:0] outputSingleLayers; //The output of the 2 instances of conv layer single filter

reg internalReset; // to control the 2 instances of conv layer single filter

//filterSet: counter to index and select the 2 filters to be sent to the 2 instances of conv layer single filter
//counter: counts the clock cycles need for the 2 instances of conv layer single filter to finish the convolution process
// outputCounter: to connect the output of the 2 instances of conv layer single filter to the output of the whole module
integer filterSet, counter, outputCounter;

genvar i_i_i;

generate // we generate 2 instances of conv layer single filter
	for (i_i_i = 0; i_i_i < 2; i_i_i = i_i_i + 1) begin 
		convLayerSingle #(
		  .D(D),
		  .H(H),
		  .W(W),
		  .F(F),
		  .s(s)
		) UUT 
		(
			.clk(clk),
	     		.reset(internalReset),
	     		.image(image),
	    		.filter(inputFilters[i_i_i*D*F*F*DATA_WIDTH+:D*F*F*DATA_WIDTH]),
	     		.outputConv(outputSingleLayers[i_i_i*((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH+:((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH])
      		);
  	end
endgenerate

always @ (posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		internalReset <= 1'b1;
		filterSet <= 0;
		counter <= 0;
		outputCounter <= 0;	
		Finished<=1'b0;	
	end else if (filterSet < K/2) begin
		if (counter == (((((H-F)/s+1)*((W-F)/s+1))/(((H-F)/s+1)/2))*(D*F*F+3)+1)) begin //the number of clock cycles need for the 2 instances of conv layer single filter to finish the convolution process on the input filters
			outputCounter <= outputCounter + 1;
			counter <= 0;
			internalReset <= 1'b1;
			filterSet <= filterSet + 1;
			Finished<=1'b1;
		end else begin
			internalReset <= 0;
			counter <= counter + 1;
			Finished<=1'b0;
		end
	end
end

always @ (*) begin
	// connecting the selected filters with the 2 instances of conv layer single filter 
	inputFilters <= filters[filterSet*2*D*F*F*DATA_WIDTH+:2*D*F*F*DATA_WIDTH];
	// connecting the output of the 2 instances of conv layer single filter with the output of the whole module
	outputConv[outputCounter*2*((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH+:2*((H-F)/s+1)*((W-F)/s+1)*DATA_WIDTH] = outputSingleLayers;
end


endmodule
