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
	
	#1051;	
	i_dat_a <= 55;	 
	i_dat_b <= 66;
	i_stb <= 1;
	#100;	  
	i_stb <= 0;
	
	//#400;
	//o_ack <= 1;	
	//
	//#800;	
	//i_dat_a <= 50;	 
	//i_dat_b <= 23;
	//i_stb <= 1;
	//#100;	  
	//i_stb <= 0;
	
	#1000;
	o_ack <= 1;
	
end	  

multiplier32
multi32 
( 
.CLK(CLK),
.RST(RST),

.I_DAT_A(i_dat_a), 
.I_DAT_B(i_dat_b),
.I_STB(i_stb),
.I_ACK(),

.O_DAT(), 
.O_STB(),
.O_ACK(o_ack)
);		

endmodule	
