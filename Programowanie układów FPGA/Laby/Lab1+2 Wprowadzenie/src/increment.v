module increment(
	input wire RST,
	input wire CLK,
input wire B,
output wire [7:0] CNT
);	
reg [7:0] a;

always @(posedge CLK or posedge RST) 
if (RST) a <= 0; else a <= a + B;

assign CNT = a;

endmodule	
