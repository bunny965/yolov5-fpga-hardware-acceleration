module test_rx(
    input   	        sys_clk        ,
    input            sys_rst_n, 
    input           uart_rxd,           //UART���ն˿�
    output          uart_txd           //UART���Ͷ˿�
   );

//parameter define
parameter  CLK_FREQ = 50000000;         //����ϵͳʱ��Ƶ��
parameter  UART_BPS = 115200;           //���崮�ڲ�����
wire ready;
reg       uart_send_en;                //UART����ʹ��
wire      [255:0]   din;
wire din_vld;
assign ready = 1'b0;

rx_top u_rx_top(
    .sys_clk        (sys_clk),             
    .sys_rst_n      (sys_rst_n),       
    .uart_rxd        (uart_rxd),             
    .ready     (ready),      
    .din         (din),
    .din_vld         (din_vld) 
);
always @(posedge sys_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n) begin
        uart_send_en   <= 1'b0;
   end
end
assign uart_send_data = din;


tx_top u_tx_top(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
    .dout_vld         (din_vld),
    .uart_en        (uart_send_en),
    .dout       (uart_send_data),
    .uart_txd       (uart_txd)
    );



endmodule