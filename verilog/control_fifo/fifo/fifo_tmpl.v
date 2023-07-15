// Created by IP Generator (Version 2020.3-Lite build 71107)
// Instantiation Template
//
// Insert the following codes into your Verilog file.
//   * Change the_instance_name to your own instance name.
//   * Change the signal names in the port associations


fifo the_instance_name (
  .clk(clk),                          // input
  .rst(rst),                          // input
  .wr_en(wr_en),                      // input
  .wr_data(wr_data),                  // input [7:0]
  .wr_full(wr_full),                  // output
  .wr_water_level(wr_water_level),    // output [10:0]
  .almost_full(almost_full),          // output
  .rd_en(rd_en),                      // input
  .rd_data(rd_data),                  // output [255:0]
  .rd_empty(rd_empty),                // output
  .almost_empty(almost_empty)         // output
);
