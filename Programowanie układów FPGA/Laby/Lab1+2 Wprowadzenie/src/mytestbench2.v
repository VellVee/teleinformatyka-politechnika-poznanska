										   								 
module mytestbenchmodule2();   
	
reg CLK;				   

initial CLK  <= 0;			 
	
always #50  CLK <= ~CLK;

initial
begin 
$monitor("CLK=%d", CLK);
end 						 


endmodule	
