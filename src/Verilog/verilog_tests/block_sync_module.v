

module block_sync_module
#( 
   parameter LEN_CODED_BLOCK = 66
 )
 (
    input wire i_clock,
    input wire i_reset,
    input wire [LEN_CODED_BLOCK-1 : 0]i_data,
    input wire i_valid,
    input wire [7:0] index,
    output wire o_data
 );

localparam LEN_EXTENDED_BLOCK = LEN_CODED_BLOCK*2;
localparam LEN_INDEX = $clog2(LEN_CODED_BLOCK);

//wire [LEN_INDEX-1 : 0] index;

reg  [LEN_CODED_BLOCK-1 : 0]    data_prev;
wire [LEN_EXTENDED_BLOCK-1 : 0] data_ext;
wire [LEN_EXTENDED_BLOCK-1 : 0] data_shifted;
assign data_ext = {data_prev,i_data};
assign data_shifted = data_ext[(LEN_EXTENDED_BLOCK-1-index) -:LEN_CODED_BLOCK] ;

assign o_data = data_shifted;


always @ (posedge i_clock)
begin
    if(i_reset)
        data_prev <= {LEN_CODED_BLOCK{1'b0}};
    else if (i_valid)
        data_prev <= i_data;
    else
        data_prev <= data_prev;
end


endmodule
