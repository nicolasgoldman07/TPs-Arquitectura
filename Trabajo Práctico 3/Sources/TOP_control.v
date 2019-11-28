`timescale 1ns / 1ps

module TOP_control
#( 
  //parametros
  parameter	                    N_BUS 	    = 16,
  parameter	                    N_BUS_OUT   = 11,
  parameter	                    N_OP 	    = 5,
  parameter	                    TAM 	    = 2
)
(
  //	ENTRADAS:
  input                           i_clk, i_reset,
  input       [N_BUS-1:0]         i_instr,

  //	SALIDAS: 
  output      [N_BUS_OUT-1:0]     o_PC,
  output      [N_BUS_OUT-1:0]     o_signal,
  output      [TAM-1:0]           o_selA,
  output                          o_selB,
  output                          o_WrAcc,
  output                          o_OP, 
  output                          o_WrRam, 
  output                          o_RdRam 
);

  wire                            instr_to_pc;
  wire        [10:0]              res_sum1;
  wire        [4:0]               opcode;
  reg         [10:0]              o_signal_reg;
  reg         [4:0]               opcode_reg;
  
  always@(posedge i_clk)
    begin
        o_signal_reg <= i_instr[10:0];
        opcode_reg <= i_instr[15:11];
    end
    

  assign o_signal = o_signal_reg;
  assign opcode   = opcode_reg;


  pc #(.N_BUS_IN(N_BUS_OUT)) 
    pc_top(.i_sum1(res_sum1), 
      .i_WrPC(instr_to_pc), .i_clk(i_clk), .i_reset(i_reset),
      .o_PC(o_PC));

  sum1 #(.N_BUS_IN(N_BUS_OUT))
    sum1_top(.i_pc(o_PC),
      .o_sum1(res_sum1));

  instr_deco #(.N_OP(N_OP), .TAM(TAM))
    instr_deco_1(.i_OPcode(opcode),
      .o_selA(o_selA),
      .o_selB(o_selB),
      .o_WrAcc(o_WrAcc),
      .o_OP(o_OP),
      .o_WrPC(instr_to_pc),
      .o_WrRam(o_WrRam),
      .o_RdRam(o_RdRam));

endmodule
