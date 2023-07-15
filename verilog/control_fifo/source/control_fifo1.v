module control_fifo1(
    input   	        clk        ,
    input           rst_n      ,
    input	[7:0]      dout       ,
    output  [255:0]     din        , //rd_data
    input             ready      ,      //rd_en   
    input             wrreq      ,      //wr_en 
    output	  [10:0] wr_water_level,
    output      almost_full,
    output	      almost_empty,
    output      full,
    output       empty
);
assign wrreq= ready&&~full;

fifo	fifo_inst (
	.rst        ( ~rst_n    ),     //复位信号取反
	.clk      ( clk       ),     //系统时钟  
	.wr_data        ( dout      ),     //写入数据  
	.rd_data           ( din        ),     //读出数据	   
	.rd_en       ( rd_en     ),     //读使能
	.wr_en       ( wrreq     ),     //写使能
	.rd_empty       ( empty     ),     //fifo为空信号
	.wr_full        ( full      ),     //fifo存满信号
                .almost_empty       (almost_empty) ,     //可用数据量
                .wr_water_level     (wr_water_level),
	.almost_full         (almost_full)
	);

endmodule 
