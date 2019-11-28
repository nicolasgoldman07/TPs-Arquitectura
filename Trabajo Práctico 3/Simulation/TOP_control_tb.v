`timescale 1ns / 1ps

module TOP_control_tb();

    reg                 i_clk, i_reset;
    reg     [15:0]      i_instr;

    wire    [10:0]      o_PC;
    wire    [10:0]      o_signal;
    wire    [1:0]       o_selA;
    wire                o_selB, o_WrAcc, o_OP, o_WrRam, o_RdRam; 

    TOP_control TOP_control_tb(.i_clk(i_clk), .i_reset(i_reset), .i_instr(i_instr), 
        .o_PC(o_PC), .o_signal(o_signal), .o_selA(o_selA), .o_selB(o_selB), .o_WrAcc(o_WrAcc),
        .o_OP(o_OP), .o_WrRam(o_WrRam), .o_RdRam(o_RdRam));


    initial
        begin
            #0
            i_reset = 1'b1;
            i_clk = 1'b1;

            #2
            i_reset = 1'b0;

            #3
            i_instr = 16'b0001100000000000;

            #4
            i_instr = 16'b0010100000000101;

            #5
            i_instr = 16'b0000100000000001;

            #6
            i_instr = 16'b0001100000001000;

        end

        always 
            begin
                #1
                i_clk = ~i_clk;
            end

        initial
        #40 $finish;


endmodule
