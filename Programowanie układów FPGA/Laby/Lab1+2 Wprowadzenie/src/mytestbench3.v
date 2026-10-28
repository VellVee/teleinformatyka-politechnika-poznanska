
module mytestbenchmodule3();

reg CLK;
initial CLK  <= 0;
always #50  CLK <= ~CLK;	   

reg [7:0] A;
initial A=0;
	
reg B;
initial B=1;
						
always @(posedge CLK) A <= A + B;
		
initial $monitor("clk=%d A=%d B=%d", CLK, A, B);
endmodule
