module mytestbenchmodule();
	
reg CLK;
initial CLK  <= 0;
always #50  CLK <= ~CLK;
	
reg RST;
initial 
begin
	RST <= 0;
	RST <= #100 1;
	RST <= #500 0;
end	  

reg [31:0] i_dat_a;	  
reg [31:0] i_dat_b;
reg i_stb;	 
reg o_ack;

initial 
begin		  
	o_ack <= 0;
	i_stb <= 0;
	#1000;	
	i_dat_a <= 9;	 
	i_dat_b <= 2;
	i_stb <= 1;
	#100;	  
	i_stb <= 0;
	#4050;
	o_ack <= 1;
	
	i_dat_a <= 11;	 
	i_dat_b <= 3;
	i_stb <= 1;
	#100;	  
	i_stb <= 0;
	#4050;
	o_ack <= 1;	
	
end	  
   
divider_sub div
( 
.CLK(CLK),
.RST(RST),


.DEV_A(i_dat_a), 
.DEV_B(i_dat_b),
.DEV_STB(i_stb),
.DEV_ACK(),

.RET_DIV(),
.RET_MOD(), 
.RET_STB()
);		
 
endmodule	
