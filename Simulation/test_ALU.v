// Code your testbench here
// or browse Examples
`timescale 1ns/100ps

//Módulo de Estímulo para el Circuito Sumador Completo
module test_ALU();
  reg [7:0]	i_A, i_B;
  reg [5:0] i_OP;
  wire [7:0] o_RES;
  ALU_TP1 alu1(i_A, i_B, i_OP, o_RES);
  initial
    begin
      $dumpfile("out.vcd");
      $dumpvars(1,test_ALU);

      //SUMA
      i_A = 8'b00000001; i_B = 8'b00000000; i_OP = 6'b100000;
      #25	i_A = 8'b10000000; i_B = 8'b11111111; i_OP = 6'b100000;
      #25	i_A = 8'b00000110; i_B = 8'b00000001; i_OP = 6'b100000;

      //RESTA
      #25	i_A = 8'b00001111; i_B = 8'b00000101; i_OP = 6'b100010;
      #25	i_A = 8'b00110000; i_B = 8'b10010110; i_OP = 6'b100010;
      //los resultados negativos los tira en complemento a 2

      //AND
      #25	i_A = 8'b10001111; i_B = 8'b10101010; i_OP = 6'b100100;
      #25	i_A = 8'b11111010; i_B = 8'b10110011; i_OP = 6'b100100;

    end
  initial
    #250 $finish; //Duración de la Simulación
endmodule