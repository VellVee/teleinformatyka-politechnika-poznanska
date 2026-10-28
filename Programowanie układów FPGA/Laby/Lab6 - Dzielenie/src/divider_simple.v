module divider_simple
(                               
input  wire         CLK,        
input  wire         RST,        
                                
input  wire         DEV_STB,    
output wire         DEV_ACK,
input  wire [31:0]  DEV_A,      
input  wire [31:0]  DEV_B,      
                                
output wire          RET_STB,	
output wire  [31:0]  RET_DIV,   
output wire  [31:0]  RET_MOD    
                                							 
);	

assign DEV_ACK = DEV_STB;
assign RET_STB = DEV_STB;
assign RET_DIV = DEV_A/DEV_B;
assign RET_MOD = DEV_A%DEV_B;

endmodule
