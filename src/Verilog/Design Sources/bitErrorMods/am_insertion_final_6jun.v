`timescale 1ns/100ps


module am_insertion
#(
	parameter 							LEN_CODED_BLOCK  = 66,
	parameter 							AM_ENCODING_LOW  = 24'd0, //{M0,M1,M2} tabla 82-2
	parameter 							AM_ENCODING_HIGH = 24'd0,  //{M4,M5,M6} tabla 82-2
	parameter 							NB_BIP = 8
 )
 (
 	input  wire 						i_clock ,
 	input  wire 						i_reset ,
 	input  wire 						i_enable,
 	input  wire                         i_valid,
 	input  wire 						i_am_insert,
 	input  wire [LEN_CODED_BLOCK-1 : 0] i_data,
	
 	output wire [LEN_CODED_BLOCK-1 : 0]	o_data

 );

//LOCALPARAMS
localparam CTRL_SH = 2'b10;

//INTERNAL SIGNALS
reg  [LEN_CODED_BLOCK-1 : 0] data;
wire [NB_BIP-1 : 0] bip3, bip7;
wire static_start_of_lane = 1'b0; 


/*always @ *
begin

	data = {LEN_CODED_BLOCK{1'b0}};
	if (i_enable && ~i_am_insert)
		data = i_data;

	else if (i_enable && i_am_insert)
		data = {CTRL_SH,AM_ENCODING_LOW,bip3,AM_ENCODING_HIGH,bip7};
end*/

always @ *
begin
    
    data = i_data;
    
    if(i_am_insert)
        data = {CTRL_SH,AM_ENCODING_LOW,bip3,AM_ENCODING_HIGH,bip7};

end

//PORTS
assign o_data = data;

//instances
bip_calculator
#(
	.LEN_CODED_BLOCK(LEN_CODED_BLOCK)
 )
	u_bip_calculator
 	(
        .i_clock 		(i_clock)  ,
        .i_reset 		(i_reset)  ,
     	.i_data  		(data)     , 
        .i_enable 		(i_enable) ,
        .i_valid        (i_valid)  ,
		.i_am_insert	(i_am_insert),
		.i_start_of_lane(static_start_of_lane),
        .o_bip3			(bip3),
        .o_bip7			(bip7)
 	);

endmodule
