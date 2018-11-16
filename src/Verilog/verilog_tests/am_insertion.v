

module am_insertion
#(
	parameter LEN_CODED_BLOCK  = 66,
	parameter AM_ENCODING_LOW  = 24'd0, //{M0,M1,M2} tabla 82-2
	parameter AM_ENCODING_HIGH = 24'd0  //{M4,M5,M6} tabla 82-2
 )
 (
 	input  wire 						i_clock ,
 	input  wire 						i_reset ,
 	input  wire 						i_enable,
 	input  wire 						i_am_insert,
 	input  wire [LEN_CODED_BLOCK-1 : 0] i_data,

 	output wire 						o_data

 );


//Internal signals


always @ (posedge i_clock)
begin

 	if(i_reset)
 		data <= {LEN_CODED_BLOCK{1'b0}};

 	else if (i_enable && ~i_am_insert)
 		data <= i_data

 	else if (i_enable && i_am_insert)
 		data <= {CTRL_SH,AM_ENCODING_LOW,bip3,AM_ENCODING_HIGH,bip7};

end

//instances

/*
 INSTANCIAR BIP CALCULATOR
*/

endmodule