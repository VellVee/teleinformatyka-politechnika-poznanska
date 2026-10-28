module mytestbenchmodule();
reg CLK;
initial 
begin 
	$monitor("CLK=%d", CLK);
	CLK = 0;

	forever 
	begin 
		#50 CLK = ! CLK; 
	end 
end 
endmodule
