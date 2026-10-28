module bin_to_bcd
( 
input wire CLK,
input wire RST,

input wire  [31:0] I_DAT, 
input wire         I_STB,

output wire [39:0] O_DAT, 
output wire        O_STB
);	

reg [31:0] bin;
reg [32:0] bst;

always @(posedge CLK or posedge RST)
if (RST) begin
	bin <= 0;  
	bst <= 0;
end else begin	
	if (I_STB) 		 
	begin
		bin <= I_DAT;
		bst <= 1;
	end else begin	 
		bin <= (bin<<1);
		bst <= (bst<<1);
	end
end	   

wire [3:0] bcd9,bcd8,bcd7,bcd6,bcd5,bcd4,bcd3,bcd2,bcd1,bcd0;
wire [9:0] ovr;

bcd_shl_1 b0 (.CLK(CLK), .RST(RST), .ADD1(bin[31]), .DAT(bcd0), .OVERFLOW(ovr[0]) );
bcd_shl_1 b1 (.CLK(CLK), .RST(RST), .ADD1(ovr[0]), . DAT(bcd1), .OVERFLOW(ovr[1]) );
bcd_shl_1 b2 (.CLK(CLK), .RST(RST), .ADD1(ovr[1]), . DAT(bcd2), .OVERFLOW(ovr[2]) );
bcd_shl_1 b3 (.CLK(CLK), .RST(RST), .ADD1(ovr[2]), . DAT(bcd3), .OVERFLOW(ovr[3]) );
bcd_shl_1 b4 (.CLK(CLK), .RST(RST), .ADD1(ovr[3]), . DAT(bcd4), .OVERFLOW(ovr[4]) );
bcd_shl_1 b5 (.CLK(CLK), .RST(RST), .ADD1(ovr[4]), . DAT(bcd5), .OVERFLOW(ovr[5]) );
bcd_shl_1 b6 (.CLK(CLK), .RST(RST), .ADD1(ovr[5]), . DAT(bcd6), .OVERFLOW(ovr[6]) );
bcd_shl_1 b7 (.CLK(CLK), .RST(RST), .ADD1(ovr[6]), . DAT(bcd7), .OVERFLOW(ovr[7]) );
bcd_shl_1 b8 (.CLK(CLK), .RST(RST), .ADD1(ovr[7]), . DAT(bcd8), .OVERFLOW(ovr[8]) );
bcd_shl_1 b9 (.CLK(CLK), .RST(RST), .ADD1(ovr[8]), . DAT(bcd9), .OVERFLOW(ovr[9]) );

assign O_DAT = {bcd9,bcd8,bcd7,bcd6,bcd5,bcd4,bcd3,bcd2,bcd1,bcd0};
assign O_STB = bst[32];

endmodule
