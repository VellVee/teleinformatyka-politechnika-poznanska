module M1_ONP(
input  wire        CLK,        
input  wire        RST,                                                                 
input  wire        I_STB,      
input  wire [31:0] CHAR,      	
input  wire 		EMPTY,
output reg         O_STB,
output reg         BUSY,
);

reg 	   push_stb_stack;		//Wrzucanie do stosu
reg	[31:0] push_dat_stack;		//Dane 

reg 	   pop_stb_stack;		//Wyciąganie ze stosu
reg	[31:0] pop_dat_stack;		//Dane

reg 	   i_stb_fifo; 			//Wrzucanie do kolekjki
reg	[31:0] i_dat_fifo;			//Dane do kolejki

reg		   right_bracket;		//Prawy nawias ??		 

reg 	   read_all;			//Odczytuj pętli ze stosu
reg		   read_check;			//Wartość do sprawdzenia

wire[1:0]  prior_on_top;		//Priorytet na topie ??

reg [1:0] last_prior;
reg [1:0] current_prior;
								
wire[31:0] count;				//Licznik

always@(posedge RST or posedge CLK)	   
//RST	
if(RST) begin  
	
		//Jeśli reset
		push_stb_stack <= 0; // Nie niczego na stos wrzucamy
		push_dat_stack <= 0;  
		
		pop_stb_stack  <= 0; //Nie wyciągamy niczego ze stosu
		
		i_stb_fifo     <= 0; //Nie wrzucamy niczego do kolejki
		i_dat_fifo     <= 0; 
		
		right_bracket  <= 0;
		BUSY		   <= 0;

end	  
	else begin

	push_stb_stack <= 0; 	 
		
        if(right_bracket) begin
            if (CHAR!=40) begin
                //Odczytujemy wszystko ze stosu
                push_stb_stack <= 0; 
                //push_dat_stack <= CHAR;  
                pop_stb_stack  <= 1; 
                i_stb_fifo     <= 1; 
                i_dat_fifo     <= pop_dat_stack; 
                right_bracket  <= 1;
                BUSY		   <= 1;
            end else begin
                //Znaleziony nawias otwierający (
                push_stb_stack <= 0; 
                //push_dat_stack <= CHAR;  
                pop_stb_stack  <= 0; 
                i_stb_fifo     <= 0; 
                //i_dat_fifo     <= pop_dat_stack; 
                right_bracket  <= 0;
                BUSY		   <= 0;
            end
        end

		case(CHAR)
		// Nawias otwierający (
		40: begin						
			// Na stos
            push_stb_stack <= 1; 
            push_dat_stack <= CHAR;  
            pop_stb_stack  <= 0; 
            i_stb_fifo     <= 0; 
            //i_dat_fifo     <= 0; 
            right_bracket  <= 0;
            BUSY		   <= 0;
			
            // i_stb_fifo	   <= 0;	//Do kolejki nic
			// push_dat_stack <= CHAR;	//Nawias na stos
			// push_stb_stack <= 1;    
		end
		
		// Nawias zamykający )
		41: begin  
			//odczyt wszystiego aż do nawiasu otwierającego
			//odczyt ze stosu i przekazanie na kolejkę
            push_stb_stack <= 0; 
            //push_dat_stack <= CHAR;  
            pop_stb_stack  <= 0; 
            i_stb_fifo     <= 0; 
            //i_dat_fifo     <= 0; 
            right_bracket  <= 1;
            BUSY		   <= 1;
			
            // right_bracket  <= 1;
			// BUSY		   <= 1;
		end
		
		45: begin
			//Minus -
			
			/* if (current_prior > last_prior || empty) begin
				//dodaj na stos
			else begin
				//odczytaj * >= current_pior
			end	
			*/
			
			if(prior_on_top < 1) begin
				BUSY		   <= 0;
				i_stb_fifo	   <= 0;
				pop_stb_stack  <= 0;
				push_dat_stack <= CHAR;
				push_stb_stack <= 1; 
			end
			else begin
				BUSY		   <= 1;
				push_stb_stack <= 0;
				pop_stb_stack  <= 1;
				i_stb_fifo	   <= 1; 
				i_dat_fifo 	   <= pop_dat_stack;			
			end
		end	 

		
		43: begin		  
	   		//Plus +
			/* if (current_prior > last_prior || empty) begin
				//dodaj na stos
			else begin
				//odczytaj * >= current_pior
			end	
			*/
			
			//if(1 > prior_on_top) begin
			if(1 > current_prior) begin
				BUSY		   <= 0;
				i_stb_fifo	   <= 0;
				pop_stb_stack  <= 0;
				push_dat_stack <= CHAR;
				push_stb_stack <= 1; end
			else begin
				BUSY		   <= 1;
				push_stb_stack <= 0;
				pop_stb_stack  <= 1;
				i_stb_fifo	   <= 1; 
				i_dat_fifo 	   = pop_dat_stack; 
			end	
		end	  	  
		
		42: begin
			//Mnożenie *
			if(prior_on_top < 2) begin
				BUSY		   <= 0;
				i_stb_fifo	   <= 0;
				pop_stb_stack  <= 0;
				push_dat_stack <= CHAR;
				push_stb_stack <= 1; end
			else begin
				BUSY		   <= 1;
				push_stb_stack <= 0;
				pop_stb_stack  <= 1;
				i_stb_fifo	   <= 1; 
				i_dat_fifo 	   <= pop_dat_stack; 
			end	 
		end	
		
		61: begin
			//Znak równości
			BUSY		   <= 1;
			push_stb_stack <= 0;
			pop_stb_stack  <= 1;
			i_stb_fifo	   <= 1;
			i_dat_fifo 	   <= pop_dat_stack;
		end
			

		default: begin				   
			//Liczby
			//liczby od razu do kolejki
			BUSY		   <= 0;
			pop_stb_stack  <= 0;
			push_stb_stack <= 0;
			i_dat_fifo	   <= CHAR;
			i_stb_fifo	   <= 1;
		end
		
	endcase	end

//-----------------------------------------------------------------------
//stack
stack stack1
(
.CLK(CLK),      
.RST(RST),  
                    
.PUSH_STB(push_stb_stack), 
.PUSH_DAT(push_dat_stack), 
.PUSH_ACK(),  
                          
.POP_STB(pop_stb_stack),  
.POP_DAT(pop_dat_stack),
.PRIOR(prior_on_top),			  
.CURRENT_PRIOR(current_prior),
//.CURRENT_PRIOR(prior_on_top),
.POP_ACK() 
);

//fifo
fifo fifo1
(
.CLK(CLK),         
.RST(RST),

.FI_STB(i_stb_fifo),      
.FI_DAT(i_dat_fifo),      
.FI_BSY(),

.FO_STB(),      
.FO_ACK(),      
.FO_DAT()  
);
	
endmodule