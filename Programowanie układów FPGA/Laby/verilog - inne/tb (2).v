module tb();

reg CLK;

initial 
CLK  <= 0;

always #50  CLK <= ~CLK;
		
reg RST;
wire ack;
wire [7:0] 	outputData;
wire [31:0] outputData2;
wire outputStb;
wire outputStb2;


initial 
begin
	RST <= 1;
	RST <= #100 0;
end	  	
   

m1_onp m1 
(
.CLK(CLK),      
.RST(RST),
.ACK(ack),
.OUTPUTDATA(outputData),
.OSTB(outputStb)  
);              
 
m2_alu m2
(
.CLK(CLK),      
.RST(RST),      
.INPUTDATA(outputData),
.ISTB(outputStb),
.ACK(ack),
.OUTPUTDATA(outputData2),
.OSTB(outputStb2)  
);



endmodule