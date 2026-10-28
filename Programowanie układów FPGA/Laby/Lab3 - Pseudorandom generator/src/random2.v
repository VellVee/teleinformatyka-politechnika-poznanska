module random2
(
	input  wire RST,
	input  wire CLK,
	input  wire [15:0] SEED_DAT,
	input  wire        SEED_STB,
	input  wire        ENABLE,
	output wire [15:0] RANDOM_WORD
);	

reg [15:0] r;				  

wire b = r[0] ^ r[2] ^ r[3] ^ r[5];

always @(posedge CLK or posedge RST) 
if (RST) begin
	r <= 1; 
end	else if (SEED_STB) begin
	r <= SEED_DAT;
end else if (ENABLE) begin
	r <=  {b, r[15:1]};
end				

assign RANDOM_WORD = r;

endmodule	
