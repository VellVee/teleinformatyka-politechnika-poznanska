module _7_mytestbenchmodule2();
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

reg        push_stb;
reg [31:0] push_dat;	

wire [31:0] pop_dat;
reg         pop_stb;

initial 
begin		  
	push_stb <= 0;   
	push_dat <= 0; 
	pop_stb <= 0;
	#1000;	  		
	@(negedge CLK);	 
	push_stb <= 1;  
	
	push_dat <= 17; @(negedge CLK);		
	push_dat <= 11; @(negedge CLK);
	push_dat <= 22; @(negedge CLK);
	push_dat <= 33; @(negedge CLK);
	push_dat <= 44; @(negedge CLK);
	push_dat <= 55; @(negedge CLK);	 
	
	push_stb <= 0;  @(negedge CLK);
	#1000;		 	 
	@(negedge CLK);	 
	pop_stb <= 1;
end	  
   
stack s1 
(
.CLK(CLK),      
.RST(RST),      
.PUSH_STB(push_stb), 
.PUSH_DAT(push_dat), 
.POP_STB(pop_stb),  
.POP_DAT(pop_dat)  
);              
 
endmodule
