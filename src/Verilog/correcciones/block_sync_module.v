

module block_sync_module
#( 
    parameter LEN_CODED_BLOCK    = 66,
    parameter MAX_INVALID_SH     = 6,
    parameter MAX_WINDOW         = 2048,
    parameter UNLOCKED_WINDOW    = 64,
    parameter LOCKED_WINDOW      = 1024;
    parameter NB_WINDOW_CNT      = $clog2(MAX_WINDOW),
    parameter NB_INVALID_CNT     = $clog2(MAX_INVALID_SH)

 )
 (
    input wire 						  i_clock,
    input wire 						  i_reset,
    input wire [LEN_CODED_BLOCK-1 : 0]i_data,
    input wire                        i_enable,
    input wire 						  i_valid, //valid signal from serial_to_parallel converter(means 66bit acumulation ready)
    input wire                        i_signal_ok,
    //input wire i_control                                          // por ahora no se usa,
                                                                    //indica escritura de param de control

    //input  wire [NB_WINDOW_CNT -1 : 0] i_unlocked_count_limit   , //controla parametros de fsm
    //input  wire [NB_WINDOW_CNT -1 : 0] i_locked_count_limit     , //controla parametros de fsm
    //input  wire [NB_INVALID_CNT-1 : 0] i_sh_invalid_limit       , //controla parametros de fsm

    

    output wire 					  o_data
 );

//LOCALPARAMS
localparam LEN_EXTENDED_BLOCK = LEN_CODED_BLOCK*2;
localparam LEN_INDEX = $clog2(LEN_CODED_BLOCK);

//INTERNAL SIGNALS

//FSM control
reg [NB_WINDOW_CNT -1 : 0] unlocked_count_limit;
reg [NB_WINDOW_CNT -1 : 0] locked_count_limit;
reg [NB_INVALID_CNT-1 : 0] sh_invalid_limit;

reg  [LEN_CODED_BLOCK-1 : 0]    data_prev;
wire [LEN_EXTENDED_BLOCK-1 : 0] data_ext;
wire [LEN_CODED_BLOCK-1 : 0]    data_shifted;
wire [LEN_INDEX-1 : 0]          index;
wire                            sh_valid;


assign data_ext     = {data_prev,i_data};
assign data_shifted = data_ext[(LEN_EXTENDED_BLOCK-1-index) -:LEN_CODED_BLOCK] ;
assign o_data       = data_shifted;
assign sh_valid     = ^(data_shifted[LEN_CODED_BLOCK-1 -: 2]);

//Update data
always @ (posedge i_clock)
begin
    if (i_enable && i_valid)
        data_prev <= i_data;
end

//Update control
always @ (posedge i_clock)
begin
    if(i_reset)
    begin
        sh_invalid_limit     <= MAX_INVALID_SH;
        locked_count_limit   <= LOCKED_WINDOW;
        unlocked_count_limit <= UNLOCKED_WINDOW
    end
    /***  POR AHORA LOS PARAMETROS DE CONTROL SON ESTATICOS
    else if(i_enable && i_control)
    begin
        sh_invalid_limit     <= i_sh_invalid_limit    ;
        locked_count_limit   <= i_locked_count_limit  ;
        unlocked_count_limit <= i_unlocked_count_limit;
    end
    */
end


//Instancias

block_sync_fsm
#(
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .MAX_INVALID_SH(MAX_INVALID_SH),
    .MAX_WINDOW(MAX_WINDOW),
    .NB_WINDOW_CNT(NB_WINDOW_CNT),
    .NB_INVALID_CNT(NB_INVALID_CNT)
 )
    u_block_sync_fsm
    (
        .i_clock                (i_clock),
        .i_reset                (i_reset),
        .i_enable               (i_enable),
        .i_valid                (i_valid),
        .i_signal_ok            (i_signal_ok),
        .i_sh_valid             (sh_valid),
        .i_unlocked_count_limit (unlocked_count_limit),
        .i_locked_count_limit   (locked_count_limit),
        .i_sh_invalid_limit     (sh_invalid_limit)

        .o_index                (index)
    );


endmodule
