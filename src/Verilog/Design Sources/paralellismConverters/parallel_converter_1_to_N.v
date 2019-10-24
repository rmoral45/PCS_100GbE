`timescale 1ns/100ps

module parallel_converter_1_to_N
#(
    parameter LEN_TAGGED_BLOCK  = 67,
    parameter LEN_CODED_BLOCK   = 66,
    parameter N_LANES           = 20,
    parameter NB_DATA_BUS       = LEN_TAGGED_BLOCK*N_LANES
 )
 (
    input wire                              i_clock,
    input wire                              i_reset,
    input wire                              i_enable,
    input wire                              i_valid,
    input wire                              i_set_shadow,
    input wire  [LEN_TAGGED_BLOCK-1 : 0]    i_data,

    output wire                             o_valid,
    output wire [NB_DATA_BUS-1 : 0]         o_data

 );

localparam NB_INDEX = $clog2(N_LANES);

reg [NB_INDEX-1 : 0]                    index;
reg [NB_DATA_BUS-1 : 0]                 output_data;
reg [NB_DATA_BUS-1 : 0]                 shadow_output_data;
reg                                     output_valid;
reg                                     aux_output_valid;
wire count_done;
///////////   PORT ASSIGMENT  ////////

//assign o_data  = {output_data[NB_DATA_BUS-1 : LEN_TAGGED_BLOCK], i_data};
assign o_data  = shadow_output_data;
//assign o_valid = output_valid;

always @ (posedge i_clock)
begin
    
    if (i_reset)
    begin
        output_data  <= {NB_DATA_BUS{1'b0}};
    end
    
    else if (i_enable && i_valid)
    begin
        output_data [NB_DATA_BUS-(LEN_TAGGED_BLOCK*index)-1 -: LEN_TAGGED_BLOCK] <= i_data;
    end
end

always @ (posedge i_clock)
begin
    if (i_reset || count_done)
        index        <= 0;

    else if (i_enable && i_valid)
        index <= index +1;
end

always @ (posedge i_clock)
begin
    if (i_reset)
        shadow_output_data <= {NB_DATA_BUS{1'b0}};

    else if(i_set_shadow)
        shadow_output_data <= {output_data[NB_DATA_BUS-1 -: LEN_TAGGED_BLOCK*(N_LANES-1)], i_data};    
        //shadow_output_data <= output_data;                                                 
end

assign count_done = ((index == (N_LANES-1)) && i_valid);
assign o_valid    = count_done;

endmodule
