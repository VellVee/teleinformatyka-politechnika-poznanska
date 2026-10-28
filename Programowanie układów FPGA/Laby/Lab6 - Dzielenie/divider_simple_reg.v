module divider_simple
(                               
input  wire         CLK,        
input  wire         RST,        
input  wire         RET_ACK,  
  
input  wire         DEV_STB,    
output wire         DEV_ACK,
input  wire [31:0]  DEV_A,      
input  wire [31:0]  DEV_B,      
                                
output wire          RET_STB,	
output wire  [31:0]  RET_DIV,   
output wire  [31:0]  RET_MOD    

);	

reg dev_stb;
reg dev_ack;

reg [31:0] dev_a;
reg [31:0] dev_b;
reg ret_stb;
reg [31:0] ret_div;
reg [31:0] ret_mod;


always @(posedge CLK) dev_stb <= DEV_STB;
always @(posedge CLK) dev_a <= DEV_A;
always @(posedge CLK) dev_b <= DEV_B;

always @(posedge CLK) 
begin
    if(RET_ACK != 1)
		begin
		 dev_ack <= dev_stb;
		 ret_stb <= dev_stb;
		 ret_div <= dev_a/dev_b;
		 ret_mod <= dev_a%dev_b;
		end
end
	
assign DEV_ACK = dev_ack;
assign RET_STB = ret_stb;
assign RET_DIV = ret_div;
assign RET_MOD = ret_mod;

endmodule
