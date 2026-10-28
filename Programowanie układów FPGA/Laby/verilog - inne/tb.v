module m12_testbench();
reg CLK;
initial CLK  <= 0;
always #50  CLK <= ~CLK;
        
reg RST;
 
integer counter;
integer temp;
integer temp_test;
integer file_input;
integer file_output;
integer file_output_Alu;


reg  istb;
wire ostb;
reg  oack;
reg [7:0] tmp;


reg    [7:0] znak;
wire   ostb_alu;
wire   [7:0] out;
wire   [7:0] out_alu;
wire    w_toku;
wire     iack;

////////////////////////////////////////////////////

initial 
begin
    RST <= 1;
    RST <= #50 1;
    RST <= #500 0;
end     

////////////////////////////////////////////////////

initial
begin
    istb <= 0;
    oack <= 0;    
    file_input = $fopen("input_ONP.txt","r");
    file_output = $fopen("output_ONP.txt","r");    
    file_output_Alu = $fopen("output_ALU.txt","r");    
    
end                 
   

always @(posedge CLK or posedge RST) 
if ((!RST & !w_toku && !ostb && !istb && oack) || (!RST && !w_toku && !ostb)) begin   
    counter = $fscanf(file_input, "%c", temp);
    if(counter==1) 
    begin
        istb <= 1;
        znak <= temp;
    end else istb <= 0;
end

always @(posedge CLK or posedge RST)oack <= ostb;

always @(negedge ostb_alu) 
if(!RST) begin
    counter = $fscanf(file_output_Alu, " %d", tmp); 
end

always @(negedge ostb_alu or posedge RST) 
    if (out_alu!=tmp) begin
        $display("M2_ALU brak zgodnosi z plikiem %d!=%d", out_alu, tmp);
    end
    else if (counter==1) begin 
        $display("M2_ALU: OK, wynik poprawny %d==%d", out_alu, tmp);
    end
    
always @(posedge oack or posedge RST) 
if (ostb && !RST) begin
    counter = $fscanf(file_output, " %c", temp_test);
end

always @(negedge oack or posedge RST) 
if (counter==1 && out!=temp_test && out!="=") begin
    $display("M1_ONP brak zgodnosi z plikiem %c!=%c", out, temp_test);
 end    

//////////////////////////////////////////////////////////

M1_ONP m1
(                            
.CLK(CLK),      
.RST(RST),                      
.ISTB(istb && !w_toku),
.ZNAK(znak),
.OUT(out),
.OSTB(ostb),
.IACK(iack),
.BUSY(w_toku), 
.OACK(iack_alu)
); 

M2_ALU m2
(                            
.CLK(CLK),      
.RST(RST),                      
.ISTB(ostb),
.ZNAK(out),
.OUT(out_alu),
.OSTB(ostb_alu),
.IACK(iack_alu)
); 

endmodule