module uart_rx
#(
parameter DBIT = 8, // # data bits
SB-TICK = 16 // # ticks for stop bits
5 1
(
input wire clk, reset,
input wire rx, s-tick,
output reg rx-done-tick,
10 output wire [7:01 dout
1;
// symbolic state declaration
localparam [I : 01
IS idle = 2'b00,
start = 2' b01,
data = 2'b10,
stop = 2'bll;
zo // signal declaration
reg [I: 01 state-reg , state-next ;
reg [3:0] s-reg , s-next ;
reg [2:0] n-reg , n-next ;
reg [7:0] b-reg , b-next ;
2s
// bod,v
// FSMD state & data registers
always Q( posedge clk , posedge reset)
if (reset)
30 begin
state-reg <= idle;
s-reg <= 0;
n-reg <= 0;
b-reg <= 0;
end
else
begin
state-reg <= state-next ;
s-reg <= s-next;
n-reg <= n-next;
b-reg <= b-next;
end
// FSMD next-state logic
15 always Q*
begin
state-next = state-reg ;
rx-done-tick = l'bO;
s-next = s-reg; 
50 n-next = n-reg;
b-next = b-reg;
case (state-reg)
idle :
if (-rx)
begin
state-next = start;
s-next = 0;
end
start :
if (s-tick)
if (s_reg==7)
begin
state-next = data;
s-next = 0;
n-next = 0;
end
else
s-next = s-reg + 1;
data :
if (s-tick)
if (s_reg==15)
begin
s-next = 0;
b-next = (rx , b-reg [7 : 11 1 ;
if (n-reg==(DBIT-1))
state-next = stop ;
else
n-next = n-reg + 1;
end
else
s-next = s-reg + 1;
stop:
if (s-tick)
if (s-reg==(SB-TICK-1))
begin
state-next = idle;
rx-done-tick =l'bl;
end
else
s-next = s-reg + 1;
endcase
end
// output
assign dout = b-reg;
95
endmodule 