`timescale 1ns/100ps

module tb_verification_top_level;
parameter               GPIO_LEN            = 32;
parameter               OPCODE_LEN          = 11;
parameter               DATA_LEN            = 20;
parameter               LEN_CODED_BLOCK     = 66;
parameter               LEN_TX_DATA         = 64;
parameter               LEN_TX_CTRL         = 8;
parameter               RAM_WIDTH_ENCODER   = 66;
parameter               RAM_WIDTH_TYPE      = 4;
parameter               RAM_ADDR_NBIT       = 5;
parameter				N_MODULES			= 3;	


reg 					tb_clock	;
reg 					tb_reset	;					
reg  		 			tb_enable	;
reg	[GPIO_LEN-1 : 0]	tb_gpio_in  ;	
reg [DATA_LEN-1 : 0]    counter     ;							


initial
begin
	tb_clock 	        = 1'b0;
	tb_reset 	        = 1'b0;
	tb_enable 	        = 1'b0;  
	counter             = 1'b0; 
	tb_gpio_in          = {GPIO_LEN{1'b0}};
end

always @(posedge tb_clock) begin
	
	counter = counter + 1;

	case(counter)
	10'D2:	tb_reset	= 1'b1;
	10'D3:	tb_reset	= 1'b0;
	10'D5: 	begin
			tb_gpio_in = 32'b10000000010000000000000000000000;		
	        end
	endcase
	
end

verification_top_level #()
    
u_verification_top_level
    (
        .i_clock(tb_clock),
        .i_reset(tb_reset),
        .i_gpio_in(tb_gpio_in)    
    );
    

always #2.5 tb_clock = ~tb_clock;

endmodule


