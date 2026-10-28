module M2_ALU
(                            
input wire 			CLK,      
input wire 			RST,                      
input wire 	[7:0] 	OPER,
input wire 			ISTB,
output wire [7:0] 	OUT,
output wire    		OSTB,
output wire    		IACK
);  
  
// 0 - wprowadzanie danych
// 1 - na stos
// 2 - ze stosu
// 3 - na wyjscie  
  
reg [1:0] 	state; 
reg 		ostb;
reg 		iack;
reg 		reset_stack;
reg 		push_stb;
reg [7:0] 	a;
reg [7:0] 	b;
reg [7:0] 	oper;
reg [3:0] 	count;

wire 		pop_stb;
//wire 		push_stb;
wire [7:0] 	pop_dat;
wire [7:0] 	push_dat;

initial
begin
    ostb <= 0;    
    iack <= 0;
    state <= 0;
    count <= 0;
    push_stb <= 0;
end    
    
always @(posedge reset_stack or negedge RST) 
	count <= 0;
	
always @(negedge CLK or negedge RST) 
	iack <= (ISTB && state == 0);
	
always @(negedge ostb or negedge RST) 
begin 
    reset_stack <= 1;
    #100 reset_stack <= 0; 
end

always @(posedge CLK or posedge RST) 
	ostb <= (state == 3 && OPER == "=");
	
always @(negedge CLK or negedge RST) 
	begin
	if (push_stb) 
		push_stb <= 0;
	else 
		push_stb <= (state == 0 && ISTB && OPER>47 && OPER<58);
	end

always @(posedge CLK or posedge RST) 
	begin
	if(push_stb) 
		count <= count + 1;
	else if (pop_stb) 
		count <= count - 1;
	else 
		count <= count;
	end

always @(negedge CLK or negedge RST) 
if (!RST) 
begin   
    if(state == 0 && ISTB)
    begin
	oper <= OPER;
	a <= pop_dat;
	case (OPER)
		"=": state <= 0;
		"+": state <= 1;  
		"-": state <= 1;
		"*": state <= 1;
	endcase
    end
	
    else if(state == 1)
    begin
	b <= pop_dat;
	state <= 2;
    end
	
    else if(state == 2) 
		state <= 3;
    else if(state == 3) 
		state <= 0;
end

stos sss
(                            
    .CLK(CLK),
    .RST(RST | reset_stack),
    .POP_DAT(pop_dat),
    .PUSH_DAT(push_dat),
    .PUSH_STB(push_stb),
    .POP_STB(pop_stb)
); 

assign OUT = pop_dat;
assign OSTB = ostb;
assign IACK = iack;

assign pop_stb = (state == 1 | state == 2);
assign push_stb = (state == 3) | push_stb;

begin 
	if (oper == "*")
		assign push_dat = (b*a);
	else if (oper == "+")
		assign push_dat = (b+a);
	else if (oper == "-")
		assign push_dat = (b-a);
	else 
		assign push_dat = (oper-48);
end

endmodule







