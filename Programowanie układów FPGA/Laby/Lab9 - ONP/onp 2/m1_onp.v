module m1_onp
(                            
input  wire        	CLK,      
input  wire        	RST,
input  wire			ACK,

output wire [11:0] 	OUTPUTDATA,
output wire    		OSTB  
); 

reg        push_stb;
reg [31:0] push_dat;	
wire [31:0] pop_dat;
reg         pop_stb;
integer fi, fo, scan_file=1;
reg [11:0] data;
reg [11:0] firstOnStack = 0;
reg [11:0] out;
reg [2:0] state;
reg ostb;

initial 
begin		  
	fi = $fopen("input.txt","r");	
	fo = $fopen("output.txt","w");	
	pop_stb <= 0;
	push_dat <= 0;
	state <= 0;
end	  

always @(posedge CLK) 
begin
	$display("out=",out);
	pop_stb <= 0;
	if(ACK == 0)
	begin
		ostb <= 1;
	end
	else ostb <= 0;
	
	if(state == 1)			//NA STOS
	begin
		$display("state=1");
		push_stb <= 1;  	//+ lub - do stosu
		push_dat <= firstOnStack;
		state <= 0;
	end
	else if(state == 2)		//Zabierz ze stosu do pojawienia się (
	begin
		$display("state=2");
		if(pop_dat == 40)
		begin
			state<=0;
		end
		else begin
			pop_stb <= 1;
		end
	end
	else if((scan_file==1 || !pop_stb) && ACK == 1)
	begin
		scan_file = $fscanf(fi, "%s", data);
		if(data == 40)			//(
		begin
			push_stb <= 1;
			push_dat <= data;
			firstOnStack <= data;
		end
		else if(data == 41)		//)
		begin
			pop_stb <= 1;
			state <= 2;
		end
		else if(data == 42)		//*
		begin
			push_stb <= 1;  
			push_dat <= data;
			firstOnStack <= data;
		end
		else if(data == 43)		//+
		begin
			if(firstOnStack != 40)
			begin
				pop_stb <= 1;	//do stosu z wyrzuceniem
				firstOnStack <= 43;	
				state <= 1;
			end		
			else begin
				push_stb <= 1;  	//+ do stosu bez wyrzucania
				firstOnStack <= 43;	
				push_dat <= data;
			end
		end
		else if(data == 45)		//- tak jak plus
		begin
			if(firstOnStack != 40)
			begin
				pop_stb <= 1;
				firstOnStack <= 45;	
				state <= 1;
			end		
			else begin
				push_stb <= 1;
				firstOnStack <= 45;	
				push_dat <= data;
			end
		end
		else if(data == 61)		//=
		begin
			push_stb <= 0;  
			pop_stb <= 1;
		end
		else
		begin
			$fwrite(fo,data-48);
			$fwrite(fo,"%c", 44);
			push_dat <= data;
			push_stb <= 0;
			out <= data-48;
			ostb <= 1;
		end
	end
end  

assign OUTPUTDATA = out;
assign OSTB = ostb;

always @(negedge pop_stb)
begin
	if(pop_dat && pop_dat!=40 )
	begin
		$fwrite(fo,"%c", pop_dat);
		$fwrite(fo,"%c", 44);
		out <= pop_dat;
		ostb <= 1;
	 end
end

always @(posedge CLK) 
if(pop_dat[0]===1'bX && ACK==0) 
begin
	state <= 3;
	out <= 61;		//Dopisz =
	ostb <= 1;
	$fwrite(fo,"%c", 61);
	$fclose(fo);  
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