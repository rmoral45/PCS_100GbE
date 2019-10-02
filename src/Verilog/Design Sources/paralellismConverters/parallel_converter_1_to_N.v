`timescale 1ns/100ps

module parallel_converter_1_to_N
#(
    parameter LEN_CODED_BLOCK   = 66,
    parameter N_LANES           = 20,
    parameter NB_DATA_BUS       = LEN_CODED_BLOCK*N_LANES
 )
 (
    input wire                          i_clock,
    input wire                          i_reset,
    input wire                          i_enable,
    input wire                          i_valid,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_data,

    output wire                         o_valid,
    output wire [NB_DATA_BUS-1 : 0]     o_data

 );

localparam NB_INDEX = $clog2(N_LANES);

reg [NB_INDEX-1 : 0]                    index;
reg [NB_DATA_BUS-1 : 0]                 save_data;
reg [NB_DATA_BUS-1 : 0]                 output_data;
reg                                     output_valid;

///////////   PORT ASSIGMENT  ////////

assign o_data  = output_data;
assign o_valid = output_valid;

always @(posedge i_clock)
begin

    if(i_reset)
    begin
        index           <= N_LANES;
        output_valid    <= 1'b0;
        output_data     <= {NB_DATA_BUS{1'b0}};
        save_data       <= {NB_DATA_BUS{1'b0}};
    end
    else if(i_enable)
    begin
        save_data       <= i_data[(NB_DATA_BUS-N_LANES*index-1) -: LEN_CODED_BLOCK];
        index <= (index > 1) ? index - 1'b1 : N_LANES;
        
        if(i_valid)
        begin
            output_data <= save_data;
            output_valid <= 1'b1;
        end
    end


end

/*
always @ (posedge i_clock)
begin
    
    if (i_reset)
    begin
        index      <= 0;
        output_valid <= 0;
        output_data  <= {NB_DATA_BUS{1'b0}};
    end
    
    else if (i_enable)
    begin
        output_data [((N_LANES-index)*LEN_CODED_BLOCK)-1 -: LEN_CODED_BLOCK] <= i_data;

        if(index == N_LANES-1 && i_valid) begin
            index <= 0;
            output_valid <= 1'b1;
        end
        else begin
            index <= index+1;
            output_valid <= 1'b0;    
        end
    end

end
*/

endmodule
