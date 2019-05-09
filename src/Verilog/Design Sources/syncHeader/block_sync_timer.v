


module block_sync_timer
#(
	parameter MAX_WINDOW = 2048
 )
 (
 	input  wire i_clock,
 	input  wire i_reset,
 	input  wire i_reset_count,
 	input  wire i_enable,
 	input  wire i_valid,
 	input  wire i_unlocked_count_limit,
 	input  wire i_locked_count_limit,

 	output wire o_unlocked_count_done,
 	output wire o_locked_count_done

 );


localparam NB_CNT = $clog2(MAX_WINDOW);

//INTERNAL SIGNALS

reg [NB_CNT-1 : 0] counter;

always @ (posedge i_clock)
begin
	if(i_reset || i_reset_count)
		counter <= {NB_CNT{1'b0}};
	else if (i_enable && i_valid)
	begin
		if(count_done)
			counter <= {NB_CNT{1'b0}};
		else
			counter <= counter + 1'b1;
	end
end

assign o_unlocked_count_done = (counter == i_unlocked_count_limit);
assign o_locked_count_done   = (counter == i_locked_count_limit);


endmodule