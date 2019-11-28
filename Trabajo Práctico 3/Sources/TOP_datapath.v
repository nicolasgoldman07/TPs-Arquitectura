`timescale 1ns / 1ps

module TOP_datapath
#( 
    //parametros
    parameter	                    N_BUS 	    = 16,
    parameter	                    N_BUS_IN    = 11,
    parameter	                    TAM 	    = 2
)
(
    //	ENTRADAS:
    input                         i_clk,
    input     [N_BUS_IN-1:0]      i_signal,
    input     [N_BUS-1:0]         i_Out_Data,
    input     [TAM-1:0]           i_selA,
    input                         i_selB,
    input                         i_WrAcc,
    input                         i_OP,  

    //	SALIDAS: 
    output    [N_BUS_IN-1:0]      o_Addr,
    output    [N_BUS-1:0]         o_In_Data
);

    wire     [N_BUS-1:0]         large_signal;
    wire     [N_BUS-1:0]         output_mul_b;
    wire     [N_BUS-1:0]         output_mul_a;
    wire     [N_BUS-1:0]         output_ACC;
    wire     [N_BUS-1:0]         output_res_arit;

    reg      [N_BUS_IN-1:0]      operand;
    reg      [N_BUS-1:0]         to_memory;

    always @(*)
    begin
        operand     <=  i_signal;
        to_memory   <=  output_ACC;
    end


    assign o_Addr = operand;
    assign o_In_Data = to_memory;


    signal_ext #(.N_BUS(N_BUS), .N_BUS_IN(N_BUS_IN)) 
        signal_ext_top(.i_signal(i_signal), .o_signal(large_signal));

    mult_A #(.N_BUS(N_BUS), .TAM(TAM))
        mult_A(.i_selA(i_selA), .i_DATA(i_Out_Data), .i_SIGNAL(large_signal), 
            .i_RES_ARIT(output_res_arit), 
            .o_MUL_A(output_mul_a));

    mult_B #(.N_BUS(N_BUS)) 
        mult_B_top(.i_selB(i_selB), .i_DATA(i_Out_Data), 
            .i_SIGNAL(large_signal), 
            .o_MUL_B(output_mul_b));

    ACC #(.N_BUS(N_BUS))
        ACC_top(.i_MUL_A(output_mul_a), .i_WrAcc(i_WrAcc), 
            .i_clk(i_clk), 
            .o_ACC(output_ACC));

    arit_unit #(.N_BUS(N_BUS))
        arit_unit_top(.i_ACC(output_ACC), .i_DATA(output_mul_b), 
            .i_OP(i_OP), 
            .o_RES(output_res_arit));

endmodule