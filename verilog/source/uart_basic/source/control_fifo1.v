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
wire    rd_en/* synthesis syn_keep=1 */;
assign rd_en= ready&&~empty;

fifo	fifo_inst (
	.rst        ( ~rst_n    ),     //��λ�ź�ȡ��
	.clk      ( clk       ),     //ϵͳʱ��  
	.wr_data        ( dout      ),     //д������  
	.rd_data           ( din        ),     //��������	   
	.rd_en       ( rd_en     ),     //��ʹ��
	.wr_en       ( wrreq     ),     //дʹ��
	.rd_empty       ( empty     ),     //fifoΪ���ź�
	.wr_full        ( full      ),     //fifo�����ź�
                .almost_empty       (almost_empty) ,     //����������
                .wr_water_level     (wr_water_level),
	.almost_full         (almost_full)
	);

endmodule 