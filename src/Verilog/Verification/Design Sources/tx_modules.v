module tx_modules
  #(
	parameter                           LEN_CODED_BLOCK    = 66,
    parameter                           LEN_TX_DATA        = 64,
    parameter                           LEN_TX_CTRL 	   = 8
	 )
	 (
	input wire                          i_clock,
  	input wire                          i_reset,

  	/*----ENCODER INPUTS & OUTPUTS----*/
  	input wire                          i_enable_cgmii,
  	input wire                          i_enable_encoder,
  	output wire [3:0]                   o_tx_type,
  	output wire [LEN_CODED_BLOCK-1 : 0] o_tx_coded
  	/*--------------------------------*/
	 );


/*-----CGMII INPUTS & OUTPUTS-----*/    //Generadas localmente.
wire  [3:0] debug_pulse;
wire  [LEN_TX_DATA-1 : 0] tx_data;
wire  [LEN_TX_CTRL-1 : 0] tx_ctrl;

assign debug_pulse = 2'h00;
/*--------------------------------*/



cgmii
    #()
    u_cgmii( 
      .i_clock(i_clock),
      .i_reset(i_reset),
      .i_enable(i_enable_cgmii),
      .i_debug_pulse(debug_pulse),
      .o_tx_data(tx_data),
      .o_tx_ctrl(tx_ctrl)
      );

encoder_comparator
    #(
      .LEN_CODED_BLOCK(LEN_CODED_BLOCK),
      .LEN_TX_DATA(LEN_TX_DATA),
      .LEN_TX_CTRL(LEN_TX_CTRL)
      )
    u_comparator(
      .i_clock(i_clock),
      .i_reset(i_reset),
      .i_tx_data(tx_data),
      .i_tx_ctrl(tx_ctrl),
      .i_enable(i_enable_encoder),
      .o_tx_type(o_tx_type),
      .o_tx_coded(o_tx_coded)
      );

endmodule

