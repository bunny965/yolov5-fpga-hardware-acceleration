module test_rx(
    input   	        sys_clk        ,
    input            sys_rst_n, 
    input           uart_rxd,           //UART接收端口
    output          uart_txd           //UART发送端口
   );

//parameter define
parameter  CLK_FREQ = 50000000;         //定义系统时钟频率
parameter  UART_BPS = 115200;           //定义串口波特率
wire ready;
reg       uart_send_en;                //UART发送使能
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