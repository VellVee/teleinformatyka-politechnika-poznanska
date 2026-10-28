module bin_to_bcd_simple
( 
input wire CLK,
input wire RST,

input wire  [31:0] I_DAT, 
input wire         I_STB,

output wire [39:0] O_DAT, 
output wire        O_STB
);

assign O_DAT[ 3: 0] = (I_DAT)%10;
assign O_DAT[ 7: 4] = (I_DAT/10)%10;
assign O_DAT[11: 8] = (I_DAT/100)%10;
assign O_DAT[15:12] = (I_DAT/1000)%10;
assign O_DAT[19:16] = (I_DAT/10000)%10;
assign O_DAT[23:20] = (I_DAT/100000)%10;	   
assign O_DAT[27:24] = (I_DAT/1000000)%10;
assign O_DAT[31:28] = (I_DAT/10000000)%10;
assign O_DAT[35:32] = (I_DAT/100000000)%10;
assign O_DAT[39:36] = (I_DAT/1000000000)%10;

assign O_STB = I_STB;

endmodule

