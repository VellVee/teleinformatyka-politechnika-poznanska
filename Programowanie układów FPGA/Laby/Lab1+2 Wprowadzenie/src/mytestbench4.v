module mytestbenchmodule4();
	
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

increment my_increment1(
	.CLK(CLK),
	.RST(RST),
	.B(1),
	.CNT()
);
endmodule

