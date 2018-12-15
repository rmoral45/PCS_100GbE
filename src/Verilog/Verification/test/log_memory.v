


module log_memory
#(
	parameter NB_DATA = 64,
	parameter DEPTH   = 1024,
	parameter NB_ADDR = $clog2(DEPTH)
 )
 (
 	input  wire 					i_clock,
 	input  wire 					i_reset,
 	input  wire 					i_run,
 	input  wire [NB_ADDR-1 : 0]		i_read_addr,
 	input  wire [NB_DATA-1 : 0]		i_data,


 	output wire 					o_full,
 	output wire [NB_DATA-1 : 0] 	o_data
 );

 reg 					run;
 reg [NB_ADDR-1 : 0] 	wr_ptr;
 reg 					start_write;
 reg 					mem_full;

 wire wr_enable;
 wire rd_enable;

//memory enable
 assign wr_enable = start_write;
 assign rd_enable = mem_full;


//PORTS
 assign o_full = mem_full ;

always @ (posedge i_clock)
begin
	run <= i_run;
	if(i_reset)
		start_write <= 0;
	else if ( (run == 1'b0) && (i_run == 1'b1) )
		start_write <= 1;
	else if (mem_full)
		start_write <= 0;
end

always @ (posedge i_clock)
begin
	if (i_reset)
	begin
		wr_ptr 	 <= {NB_ADDR{1'b0}};
		mem_full <= 0;
	end
	else if(start_write)
	begin
		if(wr_ptr < DEPTH-1)
		begin
			wr_ptr   <= wr_ptr + 1;
			mem_full <= 0;
		end
		else
		begin
			wr_ptr   <= wr_ptr;
			mem_full <= 1;
		end
	end
end


//instances

fifo_memory
#(
	.NB_DATA(NB_DATA),
	.NB_ADDR(NB_ADDR)
 )
	u_fifo_memory
	(
		.i_clock(i_clock),
		.i_write_enb(wr_enable),
		//.i_read_enb(mem_full),
		.i_data(i_data),
		.i_write_addr(wr_ptr),
		.i_read_addr(i_read_addr),

		.o_data(o_data)
	);

endmodule