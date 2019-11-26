`timescale 1ns / 1ps

module mod_m_counter
#(
    parameter M = 326,  //mod-M163
    parameter N = 9     //8 bits in counter

)
(
	input wire clk,
	input wire reset,

	output wire max_tick,
	output wire [N-1:0] q
);

    reg 	[N-1:0] r_reg;
    wire 	[N-1:0] r_next;
        
    always@(posedge clk)
    begin
        if (reset) begin
            r_reg <= 0;
        end else begin
            r_reg <= r_next;
        end
    end
    
    //next-state logic
    assign r_next = (r_reg==(M-1)) ? 0 : r_reg + 1;
    
    //output
    assign q = r_reg;
    assign max_tick = (r_reg==(M-1)) ? 1'b1 : 1'b0;


endmodule
