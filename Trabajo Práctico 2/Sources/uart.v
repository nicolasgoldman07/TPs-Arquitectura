`timescale 1ns/1ps

module uart
#(  // Default setting:
    // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
    parameter   DBIT        = 8,    // # data bits
    parameter   SB_TICK     = 16,   // # ticks for stop bits, 16 ticks = 1 bit
                                    
    parameter   DVSR        = 326,  // baud rate divisor - DVSR = 100M/(16* baud_rate)
                                    
    parameter   DVSR_BIT    = 9,    // # log2(DVSR)
    parameter   FIFO_W      = 2     // # addr bits of FIFO
                                    // # words in FIFO=2^FIFO_W
)
(
    input   wire            clk, reset,
    input   wire            rx,
    output  wire            tx,
    output  wire    [7:0]   led
);
    // signal declaration
    wire                    tick, rx_done_tick, tx_done_tick;
    wire                    tx_start;
    wire            [7:0]   tx_data, rx_data_out;
    reg             [7:0]   led_reg;
    
    // body
    mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
        (.clk(clk), .reset(reset), .q(), .max_tick(tick));

    uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
        (.clk(clk), .reset(reset), .rx(rx), .s_tick(tick),
        .rx_done_tick(rx_done_tick), .dout(rx_data_out));

    uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_tx_unit
        (.clk(clk), .reset(reset), .tx_start(tx_start), 
        .s_tick(tick), .din(tx_data), 
        .tx_done_tick(tx_done_tick), .tx(tx));

    // uart_test test1
    // (.clk(clk), .reset(reset), .rx_done_tick(rx_done_tick),
    // .rx_data(rx_data_out), .tx_start(tx_start), .tx_data(tx_data));

    uart_to_alu_to_uart uart_alu_2 (.clk(clk), .reset(reset), .rx_done_tick(rx_done_tick),
        .rx_data(rx_data_out), .tx_start(tx_start), .tx_data(tx_data));
    
    always@(posedge clk)
        begin
            led_reg <=  tx_data;
        end
        
    assign  led = led_reg;

endmodule
