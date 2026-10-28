module complex_mul
(                               
input  wire        CLK,         
input  wire        RST,         							
input  wire         I_STB,      
input  wire  [31:0] I_ARE,      
input  wire  [31:0] I_AIM,      
input  wire  [31:0] I_BRE,      
input  wire  [31:0] I_BIM, 

output reg         O_STB,  
output reg  [31:0] O_CRE,    
output reg  [31:0] O_CIM    
);

wire [31:0] M1;
wire [31:0] M2;
wire [31:0] M3;
wire [31:0] M4;
wire [31:0] A1;
wire [31:0] A2;
wire o_ack;

always @(posedge CLK or posedge RST) O_STB <= #200 (RST) ? 0 : I_STB;
//always @(posedge CLK or posedge RST) O_CRE <= (RST) ? 0 : I_ARE*I_BRE - I_AIM*I_BIM;
//always @(posedge CLK or posedge RST) O_CIM <= (RST) ? 0 : I_AIM*I_BRE + I_ARE*I_BIM;

assign O_CRE = A1;
assign O_CIM = A2;

multiplier
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
multiplier1 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(I_ARE), 
.I_DAT_B(I_BRE),
.I_STB(I_STB),
.I_ACK(),

.O_DAT(M1), 
.O_STB(),
.O_ACK(1)
);

multiplier
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
multiplier2 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(I_AIM), 
.I_DAT_B(I_BIM),
.I_STB(I_STB),
.I_ACK(),

.O_DAT(M2), 
.O_STB(),
.O_ACK(1)
);

multiplier
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
multiplier3 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(I_AIM), 
.I_DAT_B(I_BRE),
.I_STB(I_STB),
.I_ACK(),

.O_DAT(M3), 
.O_STB(),
.O_ACK(1)
);

multiplier
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
multiplier4 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(I_ARE), 
.I_DAT_B(I_BIM),
.I_STB(I_STB),
.I_ACK(o_ack),

.O_DAT(M4), 
.O_STB(),
.O_ACK(1)
);


adder
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
adder1 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(M1), 
.I_DAT_B( M2 - 2*M2 ),
.I_STB(1),
.I_ACK(),

.O_DAT(A1), 
.O_STB(),
.O_ACK(o_ack)
);

adder
#(
.A_WIDTH(32), 
.B_WIDTH(32)
)  
adder2 
(
.CLK(CLK),
.RST(RST),

.I_DAT_A(M3), 
.I_DAT_B(M4),
.I_STB(1),
.I_ACK(),

.O_DAT(A2), 
.O_STB(),
.O_ACK(o_ack)
);


endmodule      	
