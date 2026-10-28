module multiplier32
	
(
	input wire RST,
	input wire CLK,
	
	input  wire I_STB,		
	output wire I_ACK,
	input  wire [31:0] I_DAT_A,
	input  wire [31:0] I_DAT_B,	
	
	output reg  O_STB,
	output reg  [63 : 0] O_DAT,
	input  wire O_ACK
);	

assign I_ACK = I_STB & ~O_STB;

reg strop1; 
reg strop2;
reg strop3;
reg strop4;
reg strop5;
reg strop6;
reg strop7;

reg [15:0] A_H;
reg [15:0] A_L;
reg [15:0] B_H;
reg [15:0] B_L;

wire [31 : 0] out1;
wire [31 : 0] out2;
wire [31 : 0] out3;
wire [31 : 0] out4;
wire [31 : 0] out5;
wire [31 : 0] out6;
wire [31 : 0] out7;

always @(posedge CLK or posedge RST)
if (RST) O_DAT <= 0; else if (I_ACK) ;

always @(posedge CLK or posedge RST)
if (RST) O_STB <= 0; else if (O_ACK) O_STB <= 0; else if (I_ACK) O_STB <= 1;

always @(posedge CLK)
begin
	strop1 <= I_STB;
	strop2 <= strop1;
	strop3 <= strop2;
	strop4 <= strop3;
	strop5 <= strop4;
	strop6 <= strop5;
	strop7 <= strop6;
	A_H <= I_DAT_A [31 : 16];
	A_L <= I_DAT_A [15 : 0];
	B_H <= I_DAT_B [31 : 16];
	B_L <= I_DAT_B [15 : 0];
end


multiplier 
#(
.A_WIDTH(16), 
.B_WIDTH(16)
)  
multi1 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(B_L), 
.I_DAT_B(A_L),
.I_STB(strop1),
.I_ACK(),

.O_DAT(out1), 
.O_STB(),
.O_ACK(O_ACK)
);	

	
multiplier 
#(
.A_WIDTH(16), 
.B_WIDTH(16)
)  
multi2 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(B_L), 
.I_DAT_B(A_H),
.I_STB(strop2),
.I_ACK(),

.O_DAT(out2), 
.O_STB(),
.O_ACK(O_ACK)
);	

multiplier 
#(
.A_WIDTH(16), 
.B_WIDTH(16)
)  
multi3 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(B_H), 
.I_DAT_B(A_L),
.I_STB(strop3),
.I_ACK(),

.O_DAT(out3), 
.O_STB(),
.O_ACK(O_ACK)
);	

multiplier 
#(
.A_WIDTH(16), 
.B_WIDTH(16)
)  
multi4 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(B_H), 
.I_DAT_B(A_H),
.I_STB(strop4),
.I_ACK(),

.O_DAT(out4), 
.O_STB(),
.O_ACK(O_ACK)
);	


adder 
#(
.A_WIDTH(16), 
.B_WIDTH(32)
)  
add1
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(out1[31:16]), 
.I_DAT_B(out2),
.I_STB(strop5),
.I_ACK(),

.O_DAT(out5), 
.O_STB(),
.O_ACK(O_ACK)
);	


adder 
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
add2
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(out5), 
.I_DAT_B(out3),
.I_STB(strop6),
.I_ACK(),

.O_DAT(out6), 
.O_STB(),
.O_ACK(O_ACK)
);	


adder 
#(
.A_WIDTH(16), 
.B_WIDTH(32)
)  
add3
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(out6), 
.I_DAT_B(out4),
.I_STB(strop7),
.I_ACK(),

.O_DAT(out7), 
.O_STB(),
.O_ACK(O_ACK)
);	
endmodule
