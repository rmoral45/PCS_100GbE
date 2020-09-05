module prog_fifo
#(
        parameter N_LANES           = 20,
        parameter NB_DATA           = 66,
        parameter FIFO_DEPTH        = 20,
	parameter NB_ADDR           = $clog2(FIFO_DEPTH),
        parameter MAX_SKEW          = 16,
        parameter NB_DELAY_COUNT    = $clog2(FIFO_DEPTH)
)   
(
 	input wire  				i_clock,
	input wire			        i_reset,
        input wire                              i_valid,
        input wire                              i_set_fifo_delay,
 	input wire  				i_write_enb,
 	input wire  		                i_read_enb, 
 	input wire  [NB_DELAY_COUNT-1 : 0]      i_read_addr,
 	input wire  [NB_DATA-1 : 0]             i_data,

 	output wire [NB_DATA-1 : 0]             o_data,
 	output wire                             o_overflow
);

//INTERNAL SIGNALS
reg [NB_ADDR-1 : 0]	   wr_ptr;
reg [NB_ADDR-1 : 0]        rd_ptr;                       


wire reset_wr_ptr;
assign reset_wr_ptr = ((wr_ptr == FIFO_DEPTH-1) && i_valid) ? 1'b1 : 1'b0;

wire reset_rd_ptr;
assign reset_rd_ptr = ((rd_ptr == FIFO_DEPTH-1) && i_valid) ? 1'b1 : 1'b0;

wire overflow;
assign overflow = ((wr_ptr - rd_ptr) < 1) ? 1'b1 : 1'b0;
assign o_overflow = overflow;

//update write pointer
always @ ( posedge i_clock )
begin

	if(i_reset || reset_wr_ptr)
		wr_ptr <= {NB_ADDR{1'b0}};

	else if(i_write_enb && i_valid)
		wr_ptr <= wr_ptr + 1'b1;
end

//update read pointer
always @ ( posedge i_clock )
begin
    
    if(i_reset || reset_rd_ptr)
        rd_ptr <= {NB_ADDR{1'b0}};
    
    else if(i_set_fifo_delay && i_valid)
        rd_ptr <= {1'b0,i_read_addr};
    
    else if(i_read_enb && i_valid)
        rd_ptr <= rd_ptr + 1;
        
end

bram
#(
    .NB_WORD_RAM(NB_DATA),
    .RAM_DEPTH(FIFO_DEPTH),
    .NB_ADDR_RAM(NB_ADDR)
)
u_bram
(
    .i_clock         (i_clock),
    .i_write_enable  (i_write_enb),
    .i_read_enable   (i_read_enb | i_reset),  //@FIXME
    .i_write_addr    (wr_ptr),
    .i_read_addr     (rd_ptr),
    .i_data          (i_data),
    .o_data          (o_data)
);

endmodule
