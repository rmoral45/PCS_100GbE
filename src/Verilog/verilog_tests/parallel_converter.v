

module parallel_converter
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter N_LANES = 20
 )
 (
    input wire  i_clock,
    input wire  i_reset,
    input wire  i_enable,// o i_data_ready
    input wire  [LEN_CODED_BLOCK-1 : 0] i_block,
    output wire o_pc_ready,
    output wire o_lane_0_data,
    output wire o_lane_1_data,
    output wire o_lane_2_data,
    output wire o_lane_3_data,
    output wire o_lane_4_data,
    output wire o_lane_5_data,
    output wire o_lane_6_data,
    output wire o_lane_7_data,
    output wire o_lane_8_data,
    output wire o_lane_9_data,
    output wire o_lane_10_data,
    output wire o_lane_11_data,
    output wire o_lane_12_data,
    output wire o_lane_13_data,
    output wire o_lane_14_data,
    output wire o_lane_15_data,
    output wire o_lane_16_data,
    output wire o_lane_17_data,
    output wire o_lane_18_data,
    output wire o_lane_19_data
 );

localparam LEN_COUNTER = $clog2(N_LANES);

reg [LEN_COUNTER-1 : 0] counter;
reg pc_ready;
reg [LEN_CODED_BLOCK-1 : 0] lane_data [N_LANES : 0];

//ports
assign o_pc_ready = pc_ready;

assign o_lane_0_data  = lane_data[0];
assign o_lane_1_data  = lane_data[1];
assign o_lane_2_data  = lane_data[2];
assign o_lane_3_data  = lane_data[3];
assign o_lane_4_data  = lane_data[4];
assign o_lane_5_data  = lane_data[5];
assign o_lane_6_data  = lane_data[6];
assign o_lane_7_data  = lane_data[7];
assign o_lane_8_data  = lane_data[8];
assign o_lane_9_data  = lane_data[9];
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
    if(i_reset)
    begin
        counter  <= 0;
        pc_ready <= 0;
        for(i=0 ; i < N_LANES ; i=i+1)
            lane_data[i] <= {LEN_CODED_BLOCK{1'b0}};
    end
    else if( i_enable )
    begin
        lane_data[counter] <= i_block;
        if(counter == N_LANES-1)
        begin
            counter <= 0;
            pc_ready <= 1'b1;
        end
        else
        begin
            counter <= counter + 1;
         end
    end

end


endmodule
