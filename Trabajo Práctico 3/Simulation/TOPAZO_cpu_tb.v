`timescale 1ns / 1ps

module TOPAZO_cpu_tb
(
);
    reg                 i_clk;
    reg                 i_reset;

    TOPAZO_cpu TOPAZO_cpu_tb(.i_clk(i_clk), .i_reset(i_reset));

    initial
        begin
            #0
            i_reset = 1'b0;
            i_clk = 1'b1;
            
            #1
            i_reset = 1'b1;
            
            #3
            i_reset = 1'b0;
        end
    
    always 
        begin
            #1
            i_clk = ~i_clk;
        end

endmodule
