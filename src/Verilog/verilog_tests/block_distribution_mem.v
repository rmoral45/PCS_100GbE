

module block_distribution_mem
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter N_LANES = 20
 )
 (
    input wire  i_clock,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_data,
    input wire  [$clog2(N_LANES)-1 : 0] i_addr,
    input wire  i_enable,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_0_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_1_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_2_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_3_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_4_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_5_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_6_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_7_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_8_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_9_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_10_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_11_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_12_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_13_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_14_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_15_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_16_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_17_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_18_data,
    output wire [LEN_CODED_BLOCK-1 : 0] o_lane_19_data
    
    
 );

reg [LEN_CODED_BLOCK-1 : 0] lane_data [N_LANES-1 : 0];

assign o_lane_0_data = lane_data[0];
assign o_lane_1_data = lane_data[1];
assign o_lane_2_data = lane_data[2];
assign o_lane_3_data = lane_data[3];
assign o_lane_4_data = lane_data[4];
assign o_lane_5_data = lane_data[5];
assign o_lane_6_data = lane_data[6];
assign o_lane_7_data = lane_data[7];
assign o_lane_8_data = lane_data[8];
assign o_lane_9_data = lane_data[9];
assign o_lane_10_data = lane_data[10];
assign o_lane_11_data = lane_data[11];
assign o_lane_12_data = lane_data[12];
assign o_lane_13_data = lane_data[13];
assign o_lane_14_data = lane_data[14];
assign o_lane_15_data = lane_data[15];
assign o_lane_16_data = lane_data[16];
assign o_lane_17_data = lane_data[17];
assign o_lane_18_data = lane_data[18];
assign o_lane_19_data = lane_data[19];




integer i;


always @ (posedge i_clock)
begin

    if (i_enable)
    begin
        lane_data[i_addr] <= i_data;
    end
    else
    begin
        for(i=0 ; i < N_LANES ; i=i+1)
            lane_data[i] <= lane_data[i];
            
    end

end



always @ clock
    
if( enable)
    case(counter)
        5'd0:
            lane_0_reg <= i_data;
            counter <= counter + 1;






















endmodule
