

/*
 * 
 * i_ID = [ID_LANE_0, ID_LANE_1, ..., ID_LANE_19]
 *
 */

module lane_reorder
#(
        parameter N_LANES = 20,
        parameter NB_ID = $clog2(N_LANES),
        parameter NB_ID_BUS = N_LANES * NB_ID
 )
 (
        input wire                      i_clock,
        input wire                      i_reset,
        input wire                      i_reset_order,  
        input wire                      i_enable,
        input wire                      i_valid,
        input wire                      i_deskew_done,
        input wire  [NB_ID_BUS-1 : 0]   i_logical_rx_ID,

        output wire [NB_ID_BUS-1 : 0]   o_reorder_mux_selector,
        output wire                     o_update_selectors
);


//LOCALPARAMS
localparam NB_COUNTER = $clog2(N_LANES);
localparam NB_POINTER = $clog2(NB_ID_BUS);
                                                                                          
//INTERNAL SIGNALS
reg  [NB_ID_BUS-1  : 0]         mux_selector ;
reg  [NB_COUNTER-1 : 0]         counter ;
reg  [N_LANES-1    : 0]         id_present;
reg                             update_sel;
wire [NB_POINTER   : 0]         wr_ptr;
wire [NB_POINTER   : 0]         aux_wr_ptr;
wire                            reorder_done;
wire                            all_lanes_present;
wire [NB_ID_BUS-1  : 0]         default_lane_select;

assign default_lane_select = {5'd0 , 5'd1, 5'd2 , 5'd3 , 5'd4 , 5'd5 , 5'd6 , 5'd7 , 5'd8 , 5'd9,
                              5'd10, 5'd11,5'd12, 5'd13, 5'd14, 5'd15, 5'd16, 5'd17, 5'd18, 5'd19};

//PORTS
assign o_reorder_mux_selector =  
       (reorder_done && all_lanes_present) ? mux_selector : default_lane_select;

//Reorder
always @ (posedge i_clock)
begin
        if (i_reset || i_reset_order)
        begin
                mux_selector <= {NB_ID_BUS{1'b0}};
                counter <= 1'b0;
        end
        else if (i_enable && i_valid && i_deskew_done && !reorder_done)
        begin
                counter <= counter + 1'b1;
                mux_selector[((NB_ID_BUS-1) - (wr_ptr*NB_ID)) -: NB_ID] <= counter;
        end
end

//Two step assigment to ensure ids isnt out of range
assign aux_wr_ptr = (reorder_done) ? {NB_POINTER{1'b0}} : i_logical_rx_ID[((NB_ID_BUS)-(counter*NB_ID))-1 -: NB_ID];
assign wr_ptr     = (aux_wr_ptr < N_LANES) ? aux_wr_ptr : {NB_POINTER{1'b0}};

assign reorder_done = (counter == N_LANES) ? 1'b1 : 1'b0;


//Check if any ID is repeated
always @ (posedge i_clock)
begin
	if (i_reset || i_reset_order)
		id_present <=  {N_LANES{1'b0}};

        else if (i_enable && i_valid && i_deskew_done && !reorder_done)
		id_present[wr_ptr] <= 1'b1;
end

assign all_lanes_present = &id_present;

//Update conditions pulse generator
always @ (posedge i_clock)
begin
        if (i_reset)
                update_sel <= 0;
        else if (i_enable && i_valid)
                update_sel <= all_lanes_present & reorder_done;        
end

assign o_update_selectors = ~update_sel & (all_lanes_present & reorder_done);

endmodule


