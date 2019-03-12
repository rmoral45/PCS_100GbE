module rx_modules
	#(
    parameter                           NMODULES        = 2,    
	parameter                           LEN_CODED_BLOCK = 66,            
    parameter                           LEN_DATA_BLOCK  = 64,
    parameter                           LEN_CTRL_BLOCK  = 8,
    parameter                           LEN_TYPE        = 4,
    parameter                           SEED            = 58'd0
	)
	(
	input      							i_clock,
	input      							i_reset,
    input       [NMODULES-1 : 0]        i_enable,          //enable de 1 bit por modulo
	input      	[LEN_CODED_BLOCK-1 : 0]	i_scrambled_data,
	output wire	[LEN_DATA_BLOCK-1 : 0]	o_rx_raw_data,
	output wire	[LEN_CTRL_BLOCK-1 : 0]	o_rx_raw_ctrl
	);

    localparam                          DECODER_ENB     = 0;
    localparam                          DESCRAMBLER_ENB = 1;


	wire		[LEN_CODED_BLOCK-1 : 0]	o_descrambled_data;
	wire		[LEN_DATA_BLOCK-1 : 0]	o_rx_data;
	wire		[LEN_DATA_BLOCK-1 : 0]	o_rx_ctrl;
	wire		[LEN_TYPE-1 : 0]		o_rx_type;
	wire		[LEN_TYPE-1 : 0]		o_rx_type_fsm;
	wire		[LEN_TYPE-1 : 0]		o_rx_typenext_fsm;
	wire                                bypass;
	
	assign                              bypass = 1'b0;


descrambler
	#(
    .SEED(SEED) 
    )
u_descrambler
    (
    .i_clock (i_clock)           	      ,
    .i_reset (i_reset)           	      ,
    .i_enable(i_enable[DESCRAMBLER_ENB])  ,
    .i_bypass(bypass)          	          ,
    .i_data  (i_scrambled_data)  	      ,
    .o_data  (o_descrambled_data)
    );

decoder_comparator
	#(
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)  ,
    .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK)
    )
u_decoder_comparator
    (
    .i_clock    (i_clock)               ,
    .i_reset    (i_reset)               ,
    .i_enable   (i_enable[DECODER_ENB]) ,
    .i_rx_coded (o_descrambled_data)    ,
    .o_rx_data  (o_rx_data)             ,
    .o_rx_ctrl  (o_rx_ctrl)             ,  
    .o_rx_type  (o_rx_type)
    );

decoder_fsm_interface
	#(
    .LEN_TYPE(LEN_TYPE)
    )
u_decoder_fsm_interface
    (
    .i_clock        (i_clock)               ,
    .i_reset        (i_reset)               ,
    .i_enable       (i_enable[DECODER_ENB]) ,
    .i_r_type       (o_rx_type)             ,
    .o_r_type       (o_rx_type_fsm)         ,
    .o_r_type_next  (o_rx_typenext_fsm) 
    );
    
decoder_fsm
	#(
    .LEN_DATA_BLOCK(LEN_DATA_BLOCK),
    .LEN_CTRL_BLOCK(LEN_CTRL_BLOCK)
    )
u_decoder_fsm
    (
    .i_clock          (i_clock)                 ,
    .i_reset          (i_reset)                 ,
    .i_enable         (i_enable[DECODER_ENB])   ,
    .i_r_type         (o_rx_type_fsm)           ,
    .i_r_type_next    (o_rx_typenext_fsm)       ,
    .i_rx_data        (o_rx_data)               ,
    .i_rx_control     (o_rx_ctrl)               ,
    .o_rx_raw_data    (o_rx_raw_data)           ,
    .o_rx_raw_control (o_rx_raw_ctrl)
    );

endmodule