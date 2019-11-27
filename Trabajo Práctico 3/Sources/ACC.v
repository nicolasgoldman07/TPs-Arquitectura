`timescale 1ns / 1ps

module ACC
#( 
  //parametros
  parameter	N_BUS 	= 16
)
(
  //	ENTRADAS:
  input     signed  [N_BUS-1:0] i_MUL_A,
  input                         i_WrAcc, i_clk,

  //	SALIDAS: 
  output    signed	[N_BUS-1:0] o_ACC
);

  reg       signed	[N_BUS-1:0] RegR;

  always @(posedge i_clk) 
    begin
      if (i_WrAcc) 
        begin
          RegR <= i_MUL_A;
        end
    end

  assign o_ACC = RegR;

endmodule
