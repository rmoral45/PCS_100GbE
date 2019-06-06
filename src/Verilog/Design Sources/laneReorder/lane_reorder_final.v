/*
 * i_ID = [ID_LANE_0, ID_LANE_1, ..., ID_LANE_19]
 * 
 */

module lane_reorder_final
#(
	parameter N_LANES = 20,
	parameter NB_ID = $clog2(N_LANES),
	parameter NB_ID_BUS = N_LANES * NB_ID
 )
 (
	input wire 			i_clock;
	input wire 			i_reset;
	input wire 			i_enable;
	input wire 			i_valid;
	input wire 			i_deskew_done;
	input wire  [NB_ID_BUS-1 : 0] 	i_ID;

	output wire [NB_ID_BUS-1 : 0] 	o_reorder_mux_selector;
 );


//LOCALPARAMS
localparam NB_COUNTER = $clog2(N_LANES);
 

//INTERNAL SIGNALS
reg  [NB_ID_BUS-1 : 0] mux_selector ;
reg  [NB_COUNTER-1 : 0] counter ;
wire [NB_ID-1 : 0] wr_ptr;
wire  reorder_done;

//PORTS
assign o_reorder_mux_selector = mux_selector;


always @ (posedge i_clock)
begin
	if (i_reset || i_reset_order)
	begin
		mux_selector <= {NB_ID_BUS{1'b0}};
		counter <= 1'b0;
	end
	else if (i_deskew_done && !reorder_done)
	begin
		counter <= counter + 1'b1;
		mux_selector[wr_ptr -: NB_ID] <= counter;
	end
end

assign wr_ptr = i_ID[((NB_ID_BUS-1)-(counter*NB_ID))];

assign redorder_done = (counter < N_LANES) ? 1'b0 : 1'b1;

endmodule
