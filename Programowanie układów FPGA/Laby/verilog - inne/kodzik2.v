module M2_ALU
(                            
input wire CLK,      
input wire RST,                      
input wire [7:0] SIGN,
input wire ISTB,

output wire [7:0] OUT,
output wire    OSTB,
output wire    IACK
);  
  
reg [1:0] state; // stan 0 - przyjmowanie danych, stan 1 - wrzucanie na stos,
                 // stan 2 - sciaganie ze stosu,  stan 3 - przepis na wyjście
reg ostb;
reg iack;
reg reset_stack;
reg push_stb;
reg [7:0] a;
reg [7:0] b;
reg [7:0] sign;
reg [3:0] counter;

wire pop_stb;
//wire push_stb;
wire [7:0] pop_dat;
wire [7:0] push_dat;

initial
begin
    ostb <= 0;    
    iack <= 0;
    state <= 0;
    counter <= 0;
    push_stb <= 0;
end    
    
always @(posedge reset_stack or negedge RST) counter <= 0;

always @(negedge CLK or negedge RST) iack <= (ISTB && state == 0);
always @(negedge ostb or negedge RST) 
begin 
    reset_stack <= 1;
    #100 reset_stack <= 0; 
end
always @(posedge CLK or posedge RST) ostb <= (state == 3 && SIGN == "=");
         
always @(negedge CLK or negedge RST)  push_stb <= push_stb ? 0 : (state == 0 && ISTB && SIGN>47 && SIGN<58);

always @(posedge CLK or negedge RST) if((state == 1 && counter<2) || (state == 2 && counter<1)) $display("za malo wartosci %d", counter); 
always @(posedge CLK or posedge RST) if(SIGN == "=" && counter>1) $display("za duzo wartosci."); 

always @(posedge CLK or posedge RST) counter <= (push_stb) ? counter + 1 : (pop_stb) ? counter - 1 : counter;

always @(negedge CLK or negedge RST) 
if (!RST) 
begin   
    if(state == 0 && ISTB)
    begin
        sign <= SIGN;
        a <= pop_dat;
        case(SIGN)
            "=": state <= 0;
            "+", "-", "*": state <= 1;
        endcase
    end
    else if(state == 1)
    begin
        b <= pop_dat;
        state <= 2;
    end
    else if(state == 2) state <= 3;
    else if(state == 3) state <= 0;
end

stack stack
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
assign push_dat = (sign == "*") ? (b*a) : (sign == "+") ? (b+a) : (sign == "-") ? (b-a) : (sign-48); //wynik rownania lub liczba

endmodule