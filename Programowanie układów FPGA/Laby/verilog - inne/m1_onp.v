module m1_onp
(                            
input  wire        	CLK,      
input  wire        	RST,
input  wire			ACK,

output wire [11:0] 	OUTPUTDATA,
output wire    		OSTB  
); 


reg [31:0] push_dat;
reg        push_stb;
	
wire [31:0] pop_dat;
reg         pop_stb;

integer fi;
integer fo;
integer scan_file=1;

reg [2:0]  state;

reg [11:0] data;
reg [11:0] firstOnStack = 0;
reg [11:0] out;

reg ostb;

initial 
begin
	state <= 0;
	pop_stb <= 0;
	push_dat <= 0;

	fi = $fopen("input.txt","r");	
	fo = $fopen("output.txt","w");	
end	  

always @(posedge CLK) 
begin
	pop_stb <= 0;
	
	if(ACK == 0)
	begin
		ostb <= 1;
	end
	else ostb <= 0;
	
	// + lub -
	if(state == 1)
	begin
		state <= 0;
		push_stb <= 1;
		push_dat <= firstOnStack;
	end
	
	//poki nie (
	else if(state == 2)		
	begin
		if(pop_dat == 40)
		begin
			state <= 0;
		end
		else begin
			pop_stb <= 1;
		end
	end
	else if(ACK == 1 &&(scan_file==1 || !pop_stb))
	begin
		scan_file = $fscanf(fi, "%s", data);
		
		//40 = '('
		if(data == 40)
		begin
			push_stb <= 1;
			push_dat <= data;
			firstOnStack <= data;
		end
		
		//41 = ')'
		else if(data == 41)
		begin
			state <= 2;		
			pop_stb <= 1;
		end
		
		//42 = '*'
		else if(data == 42)
		begin
			push_stb <= 1;  
			push_dat <= data;
			firstOnStack <= data;
		end
		
		//43 = '+'
		else if(data == 43)
		begin
			//gdy pierwszy element na stacku to nie '('
			if(firstOnStack != 40)
			begin
			    state <= 1;
				pop_stb <= 1;
				firstOnStack <= 43;	
			end		
			else begin
				push_stb <= 1;
				firstOnStack <= 43;	
				push_dat <= data;
			end
		end
		
		//45 = '-'
		else if(data == 45)
		begin
			//gdy pierwszy element na stacku to nie '('
			if(firstOnStack != 40)
			begin
				state <= 1;
				pop_stb <= 1;
				firstOnStack <= 45;	
			end		
			else begin
				push_stb <= 1;
				firstOnStack <= 45;	
				push_dat <= data;
			end
		end
		
		//61 = '='
		else if(data == 61)
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
			ostb <= 1;		
			out <= data-48;
		end
	end
end  

assign OUTPUTDATA = out;
assign OSTB = ostb;

always @(negedge pop_stb)
begin
	if(pop_dat && pop_dat != 40 )
	begin
		$fwrite(fo,"%c", pop_dat);
		$fwrite(fo,"%c", 44);
		out <= pop_dat;
		ostb <= 1;
	 end
end

always @(posedge CLK) 
if(pop_dat[0] === 1'bX && ACK == 0) 
begin
	state <= 3;
	out <= 61;
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