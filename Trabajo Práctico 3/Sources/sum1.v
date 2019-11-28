`timescale 1ns / 1ps

module sum1
#( 
  //parametros
  parameter	                    N_BUS_IN 	= 11
)
(
  //	ENTRADAS:
  input       [N_BUS_IN-1:0]    i_pc,
  
  //	SALIDAS: 
  output      [N_BUS_IN-1:0]    o_sum1
);

  reg         [N_BUS_IN-1:0]    RegR;

  always @(*)
    begin
          RegR <= i_pc + 1;
    end

  assign o_sum1 = RegR;

endmodule
