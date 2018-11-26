

module parallel_converter
#(
    parameter LEN_CODED_BLOCK = 66,
    parameter N_LANES = 20
 )
 (
    input wire                          i_clock,
    input wire                          i_reset,
    input wire                          i_enable,
    input wire  [LEN_CODED_BLOCK-1 : 0] i_data,

    output wire                                     o_valid,
    output wire [(N_LANES*LEN_CODED_BLOCK)-1 : 0]   o_data

 );

localparam NB_COUNTER = $clog2(N_LANES);

reg [NB_COUNTER-1 : 0]                counter;
reg [(N_LANES*LEN_CODED_BLOCK)-1 : 0] output_data;
reg                                   output_valid;

///////////   PORT ASSIGMENT  ////////

assign o_data  = output_data;
assign o_valid = output_valid;


always @ (posedge i_clock)
begin
    
    if (i_reset)
    begin
        counter      <= 0;
        output_valid <= 0;
        output_data  <= {N_LANES*LEN_CODED_BLOCK{1'b0}};
    end
    
    else if (i_enable)
    begin
        output_data [((N_LANES-counter)*LEN_CODED_BLOCK)-1 -: LEN_CODED_BLOCK] <= i_data;

        if(counter == N_LANES-1)begin
            counter <= 0;
            output_valid <= 1'b1;
        end
        else begin
            counter <= counter+1;
            output_valid <= 1'b0;    
        end
    end

end

endmodule
