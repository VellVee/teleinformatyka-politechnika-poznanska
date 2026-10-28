module mytestbenchmodule5();
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
	
wire [7:0] cnt1, cnt2;
wire [8:0] cnt12;

increment my_increment1(
	.CLK(CLK),
	.RST(RST),
	.B(1),
	.CNT(cnt1)
);		

increment my_increment2(
	.CLK(CLK),
	.RST(RST),
	.B(cnt1[0]),
	.CNT(cnt2)
);			 

sum sum1(
.A(cnt1),
.B(cnt2),
.C(cnt12)
);

endmodule
