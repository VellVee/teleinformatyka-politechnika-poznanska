module random1
(	
	input  wire RST,
	input  wire CLK,
	input  wire [15:0] SEED_DAT,
	input  wire        SEED_STB,
	input  wire        ENABLE,
	output wire [15:0] RANDOM_WORD
);

reg [15:0] r;

wire [31:0] new_r = r * 214013 + 2531011;	  

always @(posedge CLK or posedge RST) 
if (RST) begin
	r <= 1; 
end	else if (SEED_STB) begin
	r <= SEED_DAT;
end else if (ENABLE) begin
	r <=  new_r[31:16];
end				

assign RANDOM_WORD = r;

endmodule	
