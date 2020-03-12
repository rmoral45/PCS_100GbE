`timescale 1ns/100ps

module bit_skew_gen
#(
        parameter NB_DATA   = 66,
        parameter MAX_INDEX = (NB_DATA - 2),
        parameter NB_INDEX  = $clog2(MAX_INDEX)
 )
 (
        input  wire                     i_clock,
        input  wire                     i_reset,
        input  wire                     i_valid,
        input  wire [NB_DATA-1 : 0]     i_data,
        input  wire [NB_INDEX-1 : 0]    i_rf_skew_index,
        input  wire                     i_rf_update,

        output wire [NB_DATA-1 : 0]     o_data
 );

/*-------------------- localparam --------------------- */

localparam NB_EXTENDED_DATA = NB_DATA * 2;
localparam DATA_INIT_SEED   = 66'h3_A3_B2_C7_05_D0_23_78_38;

/*------------------- internal signals ---------------- */

reg [NB_DATA-1 : 0]             data_prev;
reg [NB_INDEX-1 : 0]            skew_index;

wire [NB_EXTENDED_DATA-1 : 0]   data_extended;
wire [NB_DATA-1 : 0]            data_shifted;

/*------------------ algorithm begin ----------------- */

always @ (posedge i_clock)
begin
        if (i_reset)
                data_prev <= DATA_INIT_SEED;
        else if (i_valid)
                data_prev <= i_data;
end

always @ (posedge i_clock)
begin
        if (i_reset)
                skew_index <= {NB_INDEX{1'b0}};
        else if (i_rf_update)
                skew_index <= i_rf_skew_index ;
                
end

assign data_extended = {i_data, data_prev};
assign o_data        = data_extended[(NB_DATA-1+skew_index) -: NB_DATA] ;


endmodule
