`timescale 1ns / 1ps


module TOP_cpu
#(
    //parametros
    parameter	                    N_BUS 	    = 16,
    parameter	                    N_BUS_IN 	= 11,
    parameter	                    N_OP 	    = 5,
    parameter	                    TAM 	    = 2
)
(
    //	ENTRADAS:
    input                           i_clk, i_reset,
    input       [N_BUS-1:0]         i_instr,
    input       [N_BUS-1:0]         i_Out_Data,

    //	SALIDAS: 
    output      [N_BUS_IN-1:0]      o_PC,
    output      [N_BUS_IN-1:0]      o_Addr,
    output      [N_BUS-1:0]         o_In_Data,
    output                          o_WrRam, 
    output                          o_RdRam 
);

    wire        [N_BUS_IN-1:0]      signal;
    wire        [TAM-1:0]           selA;
    wire                            selB;
    wire                            WrAcc;
    wire                            OP;


    TOP_control#(.N_BUS(N_BUS), .N_BUS_OUT(N_BUS_IN), 
        .N_OP(N_OP), .TAM(TAM)) 
        TOP_control_top(.i_clk(i_clk), .i_reset(i_reset),
            .i_instr(i_instr),
            .o_PC(o_PC),
            .o_signal(signal),
            .o_selA(selA),
            .o_selB(selB),
            .o_WrAcc(WrAcc),
            .o_OP(OP),
            .o_WrRam(o_WrRam),
            .o_RdRam(o_RdRam));

    
    TOP_datapath#(.N_BUS(N_BUS), .N_BUS_IN(N_BUS_IN), 
        .TAM(TAM)) 
        TOP_datapath_top(.i_clk(i_clk),
            .i_signal(signal),
            .i_Out_Data(i_Out_Data),
            .i_selA(selA),
            .i_selB(selB),
            .i_WrAcc(WrAcc),
            .i_OP(OP),
            .o_Addr(o_Addr), .o_In_Data(o_In_Data));


endmodule
