`timescale 1ns / 1ps

module signal_ext
#(
    //parametros
    parameter	N_BUS 	    = 16,
    parameter	N_BUS_IN    = 11
)
(
    //	ENTRADAS:
    input     signed    [N_BUS_IN-1:0]  i_signal,

    //	SALIDAS: 
    output    signed    [N_BUS-1:0]     o_signal
);

    reg       signed	[N_BUS-1:0]     RegR;

    always @(*) 
        begin
            RegR = {5'b00000, i_signal};
        end

    assign o_signal = RegR;

endmodule
