module block_sync_module
#( 
    parameter                               NB_DATA_CODED   = 66,
    parameter                               MAX_INDEX_VALUE = (NB_DATA_CODED - 2),
    parameter                               MAX_WINDOW      = 4096,
    parameter                               MAX_INVALID_SH  = (MAX_WINDOW/2), //FIX especificar correctamente
    parameter                               NB_WINDOW_CNT   = $clog2(MAX_WINDOW),
    parameter                               NB_INVALID_CNT  = $clog2(MAX_INVALID_SH),
    parameter                               NB_INDEX        = $clog2(NB_DATA_CODED)
 )
 (
    input wire 				                i_clock,
    input wire 				                i_reset,
    input wire  [NB_DATA_CODED-1 : 0]	    i_data,
    input wire                              i_rf_enable
    input wire 				                i_valid, //valid signal from serial_to_parallel converter(means 66bit acumulation ready)
    input wire                        	    i_signal_ok,
    input wire [NB_WINDOW_CNT-1 : 0] 	    i_rf_unlckd_thr,
    input wire [NB_WINDOW_CNT-1 : 0] 	    i_rf_lckd_thr,
    input wire [NB_INVALID_CNT-1 : 0]	    i_rf_sh_invalid_thr,

    output wire [NB_DATA_CODED-1 : 0]	    o_data,
    output wire                             o_block_lock
    //output wire [NB_INDEX-1 : 0]            o_dbg_search_index, //solo p debug, eliminar desp
    //output wire [NB_INDEX-1 : 0]            o_dbg_block_index //solo p debug, eliminar desp
 );

//LOCALPARAMS
localparam                                  NB_EXTENDED_BLOCK 	= NB_DATA_CODED*2;

//INTERNAL SIGNALS
reg             [NB_DATA_CODED-1 : 0]       data_prev;

wire            [NB_EXTENDED_BLOCK-1 : 0] 	data_ext;
wire            [NB_DATA_CODED-1 : 0]    	data_shifted;
wire            [NB_INDEX-1 : 0] 		    search_index;
wire            [NB_INDEX-1 : 0] 		    block_index;
wire                                        sh_valid;
wire                                        block_lock;


assign                                      data_ext 	    = {i_data,data_prev};

assign                                      sh_valid 	    = ^(data_ext[(NB_DATA_CODED-1-search_index) -: 2]);

assign                                      data_shifted    = data_ext[(NB_EXTENDED_BLOCK-1-block_index) -: NB_DATA_CODED];

//OUTPUT PORTS
assign                                      o_data 		    = data_shifted;

assign                                      o_block_lock    = block_lock;

//assign o_dbg_search_index = search_index;//solo p debug, eliminar desp

//assign o_dbg_block_index  = block_index;//solo p debug, eliminar desp


/*
 * Parametros de funcionamiento seteados desde REGISTER FILE.
 * 
 * i_unlocked_timer_limit : ventana de tiempo en la  cual se deben recibir
 * 			    todos sh validos para declarar LOCKED
 * 
 * i_locked_timer_limit   : Una vez en LOCKED es laventana de tiempo en la cual se cuentan sh
 * 			    invalidos, si al cumplirse el tiempo la cantidad
 * 			    de sh invalidos es >= i_sh_invalid_limit se
 * 			    declara UNLOCKED.
 * i_sh_invalid_limit     : cantidad maxima de sh invalidos en estado de
 * 			    LOCKED durante un periodo de tiempo
 * 			    i_locked_timer_limit 
 */


always @ (posedge i_clock)
begin

    if(i_reset || ~i_signal_ok)
        data_prev <= {NB_DATA_CODED{1'b0}};

    else if (i_valid)
        data_prev <= i_data;

    else
        data_prev <= data_prev;

end


//Instancias

block_sync_fsm
#(
        .NB_DATA_CODED          (NB_DATA_CODED),
        .MAX_INVALID_SH         (MAX_INVALID_SH),
        .MAX_WINDOW(MAX_WINDOW)
 )
    u_block_sync_fsm
    (
        .i_clock                (i_clock),
        .i_reset                (i_reset),
        .i_enable               (i_rf_enable),
        .i_valid                (i_valid),
        .i_signal_ok            (i_signal_ok),
        .i_sh_valid             (sh_valid),
        .i_unlocked_timer_limit (i_rf_unlckd_thr),
        .i_locked_timer_limit   (i_rf_lckd_thr),
        .i_sh_invalid_limit     (i_rf_sh_invalid_thr),

        .o_block_index          (block_index),
        .o_search_index         (search_index),
        .o_block_lock           (block_lock)
    );

endmodule
