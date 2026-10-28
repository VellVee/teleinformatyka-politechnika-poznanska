module M1_ONP
(  
input  	wire  [7:0] CHAR,
output 	wire  [7:0] OUT,
input  	wire       	ISTB,
input 	wire       	OACK,                          
input  	wire    	CLK,      
input  	wire    	RST,                      
output 	wire      	IACK,
output 	wire      	BUSY,
output 	wire    	OSTB
);  
  
reg 		iack;
reg [1:0] 	state;
reg [7:0] 	O_BUFER;
reg [7:0] 	out;
reg [7:0] 	char;

wire 		push_stb;
wire 		pop_stb;
wire [31:0] push_dat;
wire [7:0] 	pop_dat;


initial
begin
	iack <= 0;
    state <= 0;
end    

// 0 - wprowadzanie danych
// 1 - na stos
// 2 - ze stosu
// 3 - na wyjscie  
   
always @(negedge CLK or negedge RST) 
if (!RST) 
begin   
        if (state == 0 && ISTB)
            begin
                iack  = 1;
                char <= CHAR;
                case (CHAR) 
                    "0":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end
					"1":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  
						
					"2":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  						

					"3":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  
					"4":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  

					"5":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  	

					"6":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  

					"7":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  

					"8":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  

					"9":  
                        begin
                            state <= 3; 
                            out <= CHAR;
                        end  						
						
                    "+": 
						if(pop_dat == "*" | pop_dat == "-" | pop_dat == "+") state <= 2;
						else state <= 1;
						
                    "*":
						begin
							if(pop_dat == "*" ) state <= 2;
							else state <= 1; 
						
						end

                    "(": 
						state <= 1;
						
                    ")":
						state <= 2; 
						
					"=": 
						state <= 2; 

                endcase
            end
			
else if (state==1) 
    begin
        state <= 0;
        iack <= 0;
    end
	
   else if (state==2) 
        begin
            if(char == ")" && O_BUFER == "(")
                begin
                state <= 0;
                iack <= 0;
                end
            else 
                begin
                state <= 3;
                out <= O_BUFER;
                end
        end
		
   else if (state==3) 
        begin
        iack <= 0;
		
		if (char == ")" && OACK) 
			state <= 2;
			
		else if (char == "=" && pop_dat == 255 && OACK)
			begin
			state <= 3;
			char <= 255;
			out <= "=";
			end
			
		else if ((char == "+" | char == "-") && (pop_dat == "*" | pop_dat == "-" | pop_dat == "+") && OACK)  
			state <= 2; 
			
		else if ((char == "+" | char == "-") && out!=char && (pop_dat != "*" | pop_dat != "-" | pop_dat != "+") && OACK) 
			state <= 1; 
			
		else if (( char == "*") && (pop_dat == "*" ) && OACK) 
			state <= 2; 
			
		else if (( char == "*") && out!=char && (pop_dat == "*") && OACK) 
			state <= 1; 
			
		else if (char == "=" && pop_dat != 255 && OACK) 
			state <= 2;
			
		else if (OACK) 
			state <= 0;
        end
end 

always @(negedge CLK or negedge RST) 
	O_BUFER = pop_dat;

stos ss
(                            
    .CLK(CLK),
    .RST(RST),
    .POP_DAT(pop_dat),
    .PUSH_DAT(push_dat),
    .PUSH_STB(push_stb),
    .POP_STB(pop_stb)
); 

if (state==1)
	assign push_dat = char;
else
	assign push_dat = 0;

assign push_stb = (state==1);
assign pop_stb = (state==2);

assign OUT  = out;
assign OSTB = (state==3);
assign IACK = iack;
assign BUSY = !(state==0);

endmodule