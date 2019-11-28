`timescale 1ns / 1ps

module pc
#( 
  //parametros
  parameter	                    N_BUS_IN 	= 11
)
(
  //	ENTRADAS:
  input       [N_BUS_IN-1:0]    i_sum1,
  input                         i_WrPC, i_clk, i_reset,
  //	SALIDAS: 
  output      [N_BUS_IN-1:0]    o_PC
);

  reg         [N_BUS_IN-1:0]    RegR;

  always @(negedge i_clk) 
    begin
      if (i_reset)
        begin
          RegR <= 11'b00000000000;
        end
      else if (i_WrPC)
        begin
          RegR <= i_sum1;
        end
    end

  assign o_PC = RegR;

endmodule
