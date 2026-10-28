module _8_mytestbenchmodule();
reg CLK;
initial CLK  <= 0;
always #50  CLK <= ~CLK;
		
reg RST;
initial 
begin
	RST <= 0;
	RST <= #50 1;
	RST <= #500 0;
end	  

integer fi,fo;
integer count;
reg error;
integer  f1, f2, f3, f4;


reg istb;
reg [31:0] vec_Are, vec_Aim, vec_Bre, vec_Bim, vec_Cre, vec_Cim;

wire ostb;														 
wire [31:0] Cre, Cim;

initial
begin
	fi = $fopen("input.txt","r");	
	fo = $fopen("output.txt","r");
	istb = 0;		
	error = 0;
end		   	  
   

always @(posedge CLK or posedge RST) 
if (!RST) begin    
	count = $fscanf(fi, "%d %d %d %d", f1,f2,f3,f4); // vec_Are, vec_Aim, vec_Bre, vec_Bim 
	if (count==4)
	begin
		istb <= 1;	
		vec_Are <= f1;
		vec_Aim	<= f2;
		vec_Bre <= f3;
		vec_Bim <= f4; 
	end else istb<=0;
end	  

always @(posedge CLK or posedge RST) 
if (!RST) begin    
	if (ostb)
	count = $fscanf(fo, "%d %d", vec_Cre, vec_Cim); 
	if (count==2)
	begin 		
		error = 0;
		if ((vec_Cre!=Cre) || (vec_Cim!=Cim)) 
		begin
			$display("error %d!=%d %d!=%d", vec_Cre,Cre,vec_Cim,Cim);
			error = 1;
		end
	end
end	  

complex_mul	cmul
(                               
.CLK(CLK),         
.RST(RST),         							
.I_STB(istb),      
.I_ARE(vec_Are),      
.I_AIM(vec_Aim),      
.I_BRE(vec_Bre),      
.I_BIM(vec_Bim), 

.O_STB(ostb),  
.O_CRE(Cre),    
.O_CIM(Cim)    
);

endmodule

