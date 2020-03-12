`timescale 1ns/100ps

module parallel_converter_1_to_N
#(
    parameter NB_DATA_TAGGED  = 67,
    parameter NB_DATA_CODED   = 66,
    parameter N_LANES           = 20,
    parameter NB_DATA_BUS       = NB_DATA_TAGGED*N_LANES
 )
 (
    input wire                              i_clock,
    input wire                              i_reset,
    input wire                              i_enable,
    input wire                              i_valid,
    input wire                              i_set_shadow,
    input wire  [NB_DATA_TAGGED-1 : 0]    i_data,

    output wire                             o_valid,
    output wire [NB_DATA_BUS-1 : 0]         o_data

 );

localparam NB_INDEX = $clog2(N_LANES);
localparam NB_OUT_REG = NB_DATA_BUS;

reg [NB_INDEX-1 : 0]                    index;
reg [NB_OUT_REG-1 : 0]                  output_data;
reg [NB_DATA_BUS-1 : 0]                 shadow_output_data;
reg                                     output_valid;
reg                                     aux_output_valid;
wire count_done;
///////////   PORT ASSIGMENT  ////////

assign o_data  = shadow_output_data;

always @ (posedge i_clock)
begin
    
    if (i_reset)
    begin
        output_data  <= {NB_DATA_BUS{1'b0}};
    end
    
    else if (i_enable && i_valid )
    begin
        output_data <= {output_data[NB_OUT_REG-1-NB_DATA_TAGGED : 0], i_data};
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
    
     else if(o_valid)
        shadow_output_data <= output_data;                                                 
        
end

assign count_done = ((index == (N_LANES-1)) && i_valid);
assign o_valid    = index == 0;

wire [NB_DATA_TAGGED-1 : 0] tb_o_pc_per_lane [N_LANES-1 : 0];
genvar i;
for(i=0; i<N_LANES; i=i+1)
begin: ger_block2
    assign tb_o_pc_per_lane[i] = shadow_output_data[((NB_DATA_TAGGED*(N_LANES))-1) - i*NB_DATA_TAGGED -: NB_DATA_TAGGED];
end
//endgenera

endmodule
