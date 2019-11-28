`timescale 1ns / 1ps

module arit_unit
#( 
  //parametros
  parameter	N_BUS 	= 16
)
(
  //	ENTRADAS:
  input     signed  [N_BUS-1:0] i_ACC,
  input     signed  [N_BUS-1:0]	i_DATA,
  input                         i_OP,

  //	SALIDAS: 
  output    signed	[N_BUS-1:0] o_RES
);

    
  reg   signed	[N_BUS-1:0] RegR;

  always @(*)
      begin
        if (i_OP)
          begin
            RegR 		<= 		i_ACC - i_DATA;
          end
        else
          begin
            RegR		<= 		i_ACC + i_DATA;
          end
      end

assign o_RES = RegR;

endmodule
