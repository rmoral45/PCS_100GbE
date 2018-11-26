

module block_sync_module
#( 
   parameter LEN_CODED_BLOCK = 66
 )
 (
    input wire 						  i_clock,
    input wire 						  i_reset,
    input wire [LEN_CODED_BLOCK-1 : 0]i_data,
    input wire 						  i_valid, //valid signal from serial_to_parallel converter(means 66bit acumulation ready)
    input wire                        i_signal_ok,

    output wire 					  o_data
 );

//LOCALPARAMS
localparam LEN_EXTENDED_BLOCK = LEN_CODED_BLOCK*2;
localparam LEN_INDEX = $clog2(LEN_CODED_BLOCK);

//INTERNAL SIGNALS
reg  [LEN_CODED_BLOCK-1 : 0]    data_prev;
wire [LEN_INDEX-1 : 0] index;
wire [LEN_EXTENDED_BLOCK-1 : 0] data_ext;
wire [LEN_CODED_BLOCK-1 : 0]    data_shifted;
wire                            sh_valid;
assign data_ext = {data_prev,i_data};
assign data_shifted = data_ext[(LEN_EXTENDED_BLOCK-1-index) -:LEN_CODED_BLOCK] ;
assign o_data = data_shifted;
assign sh_valid = ^(data_shifted[LEN_CODED_BLOCK-1 -: 2]);

always @ (posedge i_clock)
begin
    if(i_reset)
        data_prev <= {LEN_CODED_BLOCK{1'b0}};
    else if (i_valid)
        data_prev <= i_data;
        test_sh <= 1;
    else
        data_prev <= data_prev;
        test_sh <= 0;
end



//Instancias

block_sync_fsm
#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
    u_block_sync_fsm
    (
        .i_clock(i_clock),
        .i_reset(i_reset),
        .i_signal_ok(i_signal_ok),
        .i_test_sh(test_am),
        .i_sh_valid(sh_valid),
        .o_index(index)
    )



endmodule
