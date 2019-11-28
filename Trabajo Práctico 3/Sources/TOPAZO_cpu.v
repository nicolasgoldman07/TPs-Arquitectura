`timescale 1ns / 1ps


module TOPAZO_cpu(
    input                   i_clk, i_reset,
    output      [15:0]      o_led
);

    wire        [10:0]      PC;
    wire        [10:0]      Addr;
    wire        [15:0]      instr;
    wire        [15:0]      In_Data;
    wire        [15:0]      Out_Data;
    wire                    WrRam;

    TOP_cpu TOP_cpu_top(.i_clk(i_clk),
        .i_reset(i_reset),
        .i_instr(instr),
        .i_Out_Data(Out_Data),
        .o_PC(PC),
        .o_Addr(Addr),
        .o_In_Data(In_Data),
        .o_WrRam(WrRam)
        );

    data_memory data_memory_top(.clka(~i_clk),
        .wea(WrRam),
        .addra(Addr),
        .dina(In_Data),
        .douta(Out_Data)
        );
    
    program_memory program_memory_top(.clka(i_clk),
        .wea(),
        .addra(PC),
        .dina(),
        .douta(instr)
        );

    assign o_led = In_Data;

endmodule
