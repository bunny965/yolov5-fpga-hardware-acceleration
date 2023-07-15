module control_fifo1(
    input   	        clk        ,
    input           rst_n      ,

    input	[7:0]      dout       ,
    input             dout_vld   ,

    input             ready      ,      //rd_en   
    output  [255:0]     din        , //rd_data
    output	           din_vld,
    output	  [10:0] wr_water_level,
    output      almost_full
);
wire     [7:0]     data ;
wire     	        rd_en;
wire             	wrreq;
wire            	empty;
wire          	    full ;
wire     [255:0]      q    ;
wire     [7:0]      usedw;
reg                 flag ;

assign data=dout;
assign wrreq=dout_vld&&~full;

assign din=q;

//flag
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        flag<=0;
    end
    else if(usedw>7) begin  //存满8个字节拉高flag
        flag<=1;
    end
    else if (empty) begin
        flag<=0;
    end
end

assign rd_en=flag&&ready&&~empty;  
assign din_vld=rd_en;   //每次将din_vld拉高一个周期，输出一字节数据

fifo	fifo_inst (
	.rst        ( ~rst_n    ),     //复位信号取反
	.clk      ( clk       ),     //系统时钟  
	.wr_data        ( data      ),     //写入数据     
	.rd_en       ( rd_en     ),     //读使能
	.wr_en       ( wrreq     ),     //写使能
	.rd_empty       ( empty     ),     //fifo为空信号
	.wr_full        ( full      ),     //fifo存满信号
	.rd_data           ( q         ),     //读出数据
	.almost_empty       ( usedw     ) ,     //可用数据量
  .wr_water_level     (wr_water_level),
	.almost_full         (almost_full)
	);

endmodule //control
