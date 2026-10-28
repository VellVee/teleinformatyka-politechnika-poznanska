module random3
(
	input  wire RST,
	input  wire CLK,
	input  wire [15:0] SEED_DAT,
	input  wire        SEED_STB,
	input  wire        ENABLE,
	output wire [15:0] RANDOM_WORD
);	

reg [15:0] r;				  

wire a = r[11]^r[0];
wire b = r[13]^r[0];
wire c = r[14]^r[0];


always @(posedge CLK or posedge RST) 
if (RST) begin
	r <= 1; 
end	else if (SEED_STB) begin
	r <= SEED_DAT;
end else if (ENABLE) begin
	r <=  {r[0], r[15], c, b, r[12], a, r[10:1]};
end				

assign RANDOM_WORD = r;

endmodule	


