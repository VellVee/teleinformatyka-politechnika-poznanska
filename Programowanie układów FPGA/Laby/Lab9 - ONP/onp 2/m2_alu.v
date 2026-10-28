module m2_alu
(                            
input  wire        	CLK,      
input  wire        	RST,                      
input wire [7:0] 	INPUTDATA,
input wire 			ISTB,

output  wire			ACK,
output wire [31:0] 	OUTPUTDATA,
output wire    		OSTB
);                           

reg        push_stb;
reg [31:0] push_dat;	
wire [31:0] pop_dat;
reg         pop_stb;
reg [7:0] data1;
reg [7:0] operator;
reg [2:0] state;
reg ack;
reg ostb;
reg [31:0] outputData;

initial
begin
	ack <= 1;
	state <= 0;
	pop_stb <= 0;
    push_stb <= 0;
end   


always@(posedge CLK)
begin
	push_stb <= 0;
	pop_stb <=0;
	if(ISTB && state==0)
	begin
		if(INPUTDATA < 10)			//liczba
		begin
			push_stb <= 1;
			push_dat <= INPUTDATA;
			ack <= 1;
		end
		else	
		begin
			state <= 1;				//operator
			operator <= INPUTDATA;
			ack <= 0;
			pop_stb <= 1;
		end
	end
	else if(state == 1)
	begin
		pop_stb <= 1;
		state <=2;
	end
	else if(state == 2)
	begin
		state <=3;
		data1 <=pop_dat;
		
	end
	else if(state == 3)
	begin
		state <=0;
		case(operator)
			42 : push_dat <=pop_dat*data1;
			43 : push_dat <=pop_dat+data1;
			45 : push_dat <=pop_dat-data1;
			61 : begin ostb <= 1; outputData <= data1; end
		endcase
		push_stb <= 1;
		ack <= 1;
	end
	
end	  

assign ACK = ack;
assign OSTB = ostb;
assign OUTPUTDATA = outputData;

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