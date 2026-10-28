module bcd_shl_1
(	
	input wire CLK,
	input wire RST,
	
	input wire       ADD1,
	output reg [3:0] DAT,
	output wire       OVERFLOW
);		 

always @(posedge CLK or posedge RST)
if (RST) begin
	DAT <= 0;		
end else begin	
	DAT <= 
		(DAT==0) ? {3'd0, ADD1} : // 0-1	   no overflow
		(DAT==1) ? {3'd1, ADD1} : // 2-3	   no overflow
		(DAT==2) ? {3'd2, ADD1} : // 4-5	   no overflow	 
		(DAT==3) ? {3'd3, ADD1} : // 6-7	   no overflow		 
		(DAT==4) ? {3'd4, ADD1} : // 8-9	   no overflow
		(DAT==5) ? {3'd0, ADD1} : // 0-1 
		(DAT==6) ? {3'd1, ADD1} : // 2-3	
		(DAT==7) ? {3'd2, ADD1} : // 4-5	
		(DAT==8) ? {3'd3, ADD1} : // 6-7	
		(DAT==9) ? {3'd4, ADD1} : // 8-9	
		{3'd7, ADD1};	 // when error
end	
assign OVERFLOW = ((DAT>=0) && (DAT<=4)) ? 1'b0 : 1'b1;
endmodule
