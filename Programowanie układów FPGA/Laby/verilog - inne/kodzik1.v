module M1_ONP
(  
input  wire  [7:0] ZNAK,
output wire  [7:0] OUT,
input  wire       ISTB,
input wire       OACK,                          
input  wire    CLK,      
input  wire    RST,                      
output wire       IACK,
output wire       BUSY,
output wire    OSTB

);  
  
reg iack;
reg [1:0] stan;
reg [7:0] O_BUFER;
reg [7:0] out;
reg [7:0] znak;

wire push_stb;
wire pop_stb;
wire [31:0] push_dat;
wire [7:0] pop_dat;
/////////////////////////////////////////////////////////////
initial
begin
    stan <= 0;
    iack <= 0;
    
end    

///////////////////////////////////////////////////////////             
   
always @(negedge CLK or negedge RST) 
if (!RST) begin   
        if(stan == 0 && ISTB) // przyjmowanie danych przypisanie stanu przy odpowiednim wejsciu
            begin
                iack  = 1;
                znak <= ZNAK;
                case(ZNAK) 
                    "1","2","3","4","5","6","7","8","9","0":  
                        begin
                            stan <= 3; 
                            out <= ZNAK;
                        end    
                    "+","-": stan <= (pop_dat == "*" | pop_dat == "-" | pop_dat == "+") ? 2 : 1; //czyszczenie stosu
                    "*": stan <= (pop_dat == "*" ) ? 2 : 1; 
                    "(": stan <= 1; // ukladanie na stosie
                    ")", "=": stan <= 2; 
                    
                endcase
            end
else if(stan==1) 
    begin
        stan <= 0;
        iack <= 0;
    end
   else if(stan==2) 
        begin
            if(znak == ")" && O_BUFER == "(")
                begin
                stan <= 0;
                iack <= 0;
                end
            else 
                begin
                stan <= 3;
                out <= O_BUFER;
                end
        end
   else if(stan==3) 
        begin
        iack <= 0;
            if(znak == ")" && OACK) stan <= 2;
            else if(znak == "=" && pop_dat == 255 && OACK)
                begin
                    stan <= 3;
                    znak <= 255;
                    out <= "=";
                end
            else if((znak == "+" | znak == "-") && (pop_dat == "*" | pop_dat == "-" | pop_dat == "+") && OACK) begin 
            stan <= 2; 
            end
            else if((znak == "+" | znak == "-") && out!=znak && (pop_dat != "*" | pop_dat != "-" | pop_dat != "+") && OACK) begin
            stan <= 1; 
            end
            else if(( znak == "*") && (pop_dat == "*" ) && OACK) begin
            stan <= 2; 
            end
            else if(( znak == "*") && out!=znak && (pop_dat == "*") && OACK) begin 
            stan <= 1; 
            end
            else if(znak == "=" && pop_dat != 255 && OACK) begin
            stan <= 2;
            end
            else if (OACK) begin 
            stan <= 0;
            end
        end
end 

always @(negedge CLK or negedge RST) O_BUFER = pop_dat;

//////////////////////////////////////////////////////////

stack s1
(                            
    .CLK(CLK),
    .RST(RST),
    .POP_DAT(pop_dat),
    .PUSH_DAT(push_dat),
    .PUSH_STB(push_stb),
    .POP_STB(pop_stb)
); 

//////////////////////////////////////////////////////////

assign push_dat = (stan==1) ? znak : 0;
assign push_stb = (stan==1);
assign pop_stb = (stan==2);


assign OUT = out;
assign OSTB = (stan==3);
assign IACK = iack;
assign BUSY = !(stan==0);

endmodule