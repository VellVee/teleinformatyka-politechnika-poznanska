module _7_mytestbenchmodule();
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

reg fi_stb;
reg [7:0]  fi_dat;	
wire fi_bsy;
wire fo_stb;
wire [7:0] fo_dat;
reg fo_ack;

initial 
begin		  
	fi_stb <= 0;   
	fo_ack <= 0; 
	fi_dat <= 0;
	#500;	  	 
	@(negedge CLK);		 
	fi_stb <= 1; @(negedge CLK);
	fi_dat <= 17; @(negedge CLK);
	fi_dat <= 11; @(negedge CLK);
	fi_dat <= 22; @(negedge CLK);
	fi_dat <= 33; @(negedge CLK);
	fi_dat <= 44; @(negedge CLK);
	fi_stb <= 0;
	#1000;		
	@(negedge CLK);	 
	fo_ack <= 1;
end	  
   
fifo	
#(								  
.WIDTH(8)
) 
f1
(                               
.CLK(CLK),         
.RST(RST),         								
.FI_STB(fi_stb),      
.FI_DAT(fi_dat),      
.FI_BSY(fi_bsy),                                  
.FO_STB(fo_stb),      
.FO_ACK(fo_ack),      
.FO_DAT(fo_dat)   
);          
endmodule
