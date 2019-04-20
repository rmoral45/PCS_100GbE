/*
    AGREGAR ENABLE
*/

module block_sync_module
#( 
   parameter NB_CODED_BLOCK = 66
 )
 (
    input wire 						  	i_clock,
    input wire 						  	i_reset,
    input wire  [NB_CODED_BLOCK-1 : 0]	i_data,
    input wire 						  	i_valid, //valid signal from serial_to_parallel converter(means 66bit acumulation ready)
    input wire                        	i_signal_ok,

    output wire [NB_CODED_BLOCK-1 : 0]	o_data
 );

//LOCALPARAMS
localparam NB_EXTENDED_BLOCK 	= NB_CODED_BLOCK*2;
localparam NB_INDEX 			= $clog2(NB_CODED_BLOCK);

//INTERNAL SIGNALS
reg  [NB_CODED_BLOCK-1 : 0]    	data_prev;

wire [NB_EXTENDED_BLOCK-1 : 0] 	data_ext;
wire [NB_CODED_BLOCK-1 : 0]    	data_shifted;
wire [NB_INDEX-1 : 0] 			search_index;
wire [NB_INDEX-1 : 0] 			block_index;
wire                            sh_valid;

assign data_ext 	= {data_prev,i_data};

assign sh_valid 	= ^(data_ext[(NB_CODED_BLOCK-1-search_index) -: 2]);

assign data_shifted = data_ext[(NB_EXTENDED_BLOCK-1-block_index) -: NB_CODED_BLOCK];

assign o_data 		= data_shifted;


always @ (posedge i_clock)
begin

    if(i_reset || ~i_signal_ok)
        data_prev <= {NB_CODED_BLOCK{1'b0}};

    else if (i_valid)
        data_prev <= i_data;

    else
        data_prev <= data_prev;

end



//Instancias

block_sync_fsm
#(
    .NB_CODED_BLOCK(NB_CODED_BLOCK)
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
