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
    else if(usedw>7) begin  //����8���ֽ�����flag
        flag<=1;
    end
    else if (empty) begin
        flag<=0;
    end
end

assign rd_en=flag&&ready&&~empty;  
assign din_vld=rd_en;   //ÿ�ν�din_vld����һ�����ڣ����һ�ֽ�����

fifo	fifo_inst (
	.rst        ( ~rst_n    ),     //��λ�ź�ȡ��
	.clk      ( clk       ),     //ϵͳʱ��  
	.wr_data        ( data      ),     //д������     
	.rd_en       ( rd_en     ),     //��ʹ��
	.wr_en       ( wrreq     ),     //дʹ��
	.rd_empty       ( empty     ),     //fifoΪ���ź�
	.wr_full        ( full      ),     //fifo�����ź�
	.rd_data           ( q         ),     //��������
	.almost_empty       ( usedw     ) ,     //����������
  .wr_water_level     (wr_water_level),
	.almost_full         (almost_full)
	);

endmodule //control
