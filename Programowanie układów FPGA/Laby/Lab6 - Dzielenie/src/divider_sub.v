module divider_sub
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

reg [31:0] counter;
always @(posedge CLK or posedge RST) counter <= (RST) ? 0 : counter+1; 

//----------------------------------------------------------------------------------------

reg        st0_stb;
reg [31:0] st0_div;
reg [31:0] st0_mod;
reg [31:0] st0_sub;

//----------------------------------------------------------------------------------------

reg        st1_stb;
reg [31:0] st1_div;
reg [31:0] st1_div1;
reg [31:0] st1_mod;
reg [33:0] st1_modsub; // !!!!!!!!!!!!!!!!!!!
reg [31:0] st1_sub;

//----------------------------------------------------------------------------------------

reg        st2_stb;
reg        st2_out;
reg [31:0] st2_div;
reg [31:0] st2_mod;
reg [31:0] st2_sub;

//----------------------------------------------------------------------------------------

assign DEV_ACK = DEV_STB && ~st2_stb;

//----------------------------------------------------------------------------------------

always @(posedge CLK or posedge RST) st0_stb <= (RST) ? 0 : st2_stb | DEV_STB; 
always @(posedge CLK or posedge RST) st0_div <= (RST) ? 0 : st2_stb ? st2_div : 0;  
always @(posedge CLK or posedge RST) st0_mod <= (RST) ? 0 : st2_stb ? st2_mod : DEV_A;
always @(posedge CLK or posedge RST) st0_sub <= (RST) ? 0 : st2_stb ? st2_sub : DEV_B;
	
//----------------------------------------------------------------------------------------

always @(posedge CLK or posedge RST) st1_stb     <= (RST) ? 0 : st0_stb; 
always @(posedge CLK or posedge RST) st1_div     <= (RST) ? 0 : st0_div;  
always @(posedge CLK or posedge RST) st1_div1    <= (RST) ? 0 : (st0_div+1);
always @(posedge CLK or posedge RST) st1_mod     <= (RST) ? 0 : st0_mod;  
always @(posedge CLK or posedge RST) st1_modsub  <= (RST) ? 0 : {1'b0,st0_mod}-{1'b0,st0_sub};  
always @(posedge CLK or posedge RST) st1_sub     <= (RST) ? 0 : st0_sub; 	
//----------------------------------------------------------------------------------------
 
always @(posedge CLK or posedge RST) st2_stb <= (RST) ? 0 : st1_stb && ~ st1_modsub[33];
always @(posedge CLK or posedge RST) st2_out <= (RST) ? 0 : st1_stb &&   st1_modsub[33];
always @(posedge CLK or posedge RST) st2_div <= (RST) ? 0 : st1_modsub[33] ? st1_div : st1_div1;  
always @(posedge CLK or posedge RST) st2_mod <= (RST) ? 0 : st1_modsub[33] ? st1_mod : st1_modsub;  	
always @(posedge CLK or posedge RST) st2_sub <= (RST) ? 0 : st1_sub;  	

//----------------------------------------------------------------------------------------
	
assign RET_STB = st2_out;
assign RET_DIV = st2_div;
assign RET_MOD = st2_mod;

//----------------------------------------------------------------------------------------
endmodule
