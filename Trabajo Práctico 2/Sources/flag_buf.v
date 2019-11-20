`timescale 1ns / 1ps

module flag_buf
#(
  parameter W = 8 //#buffer bits
)
(
  input wire  clk, reset,
  input wire  clr_flag, set_flag,
  input wire  [W-1 : 0] dout 
);

//signal declaration
//reg [W-1 : 0] buf_reg, buf_next;
reg flag_reg, flag_next;
  
//body
//FF & register
always @ (posedge clk, posedge reset)
  if (reset)
    begin
      buf_reg   <=  0;
      flag_reg  <=  1'b0;
    end
  else
    begin
      buf_reg   <=  buf_next;
      flag_reg  <=  flag_next;     
    end

    