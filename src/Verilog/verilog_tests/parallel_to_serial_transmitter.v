

module parallel_to_serial_transmitter
#(
	parameter LEN_CODED_BLOCK = 66
 )
 (
 	input  wire 						i_clock 		 , //system clock
 	input  wire 						i_reset 		 ,
 	input  wire 						i_block_clock    , // latch block rate
 	input  wire 						i_transmit_clock , // bit transmit rate
 	input  wire [LEN_CODED_BLOCK-1 : 0] i_data 			 ,

 	//output wire 						o_IS_UNIT_DATA   , //pulso p indicar transmision de datos???
 	output wire 						o_tx_bit		 ,
 );

//LOCALPARAMS
localparam BYTE_0 = LEN_CODED_BLOCK-3; // resto 3 para empezar en la posicion 63
localparam BYTE_1 = LEN_CODED_BLOCK-3-8;
localparam BYTE_2 = LEN_CODED_BLOCK-3-16;
localparam BYTE_3 = LEN_CODED_BLOCK-3-24;
localparam BYTE_4 = LEN_CODED_BLOCK-3-32;
localparam BYTE_5 = LEN_CODED_BLOCK-3-40;
localparam BYTE_6 = LEN_CODED_BLOCK-3-48;
localparam BYTE_7 = LEN_CODED_BLOCK-3-56;



//INTERNAL SIGNALS
reg  [LEN_CODED_BLOCK-1 : 0] data, data_bit_reversed, tx_data; 
wire [LEN_CODED_BLOCK-1 : 0] tx_data_next;

reg [1:0] sh;

reg [7:0] reversed_byte_0;
reg [7:0] reversed_byte_1;
reg [7:0] reversed_byte_2;
reg [7:0] reversed_byte_3;
reg [7:0] reversed_byte_4;
reg [7:0] reversed_byte_5;
reg [7:0] reversed_byte_6;
reg [7:0] reversed_byte_7;



always @ (posedge i_clock)
begin
	if(i_reset)
		data <= {LEN_CODED_BLOCK{1'b0}};
	else if (i_block_clock)
		data <= data_bit_reversed; //same as i_data but bit reversed
end

always @ (posedge i_clock)
begin
	if(i_reset)
		tx_data <= {LEN_CODED_BLOCK{1'b0}};
	else if (i_transmit_clock)
		tx_data <= tx_data_next;
end

assign tx_data_next = tx_data << 1;

//PORTS
assign o_tx_bit = tx_data[LEN_CODED_BLOCK-1];

always @ *
begin //bit reversal
data_bit_reversed = {LEN_CODED_BLOCK{1'b0}};
sh 				  = i_data[LEN_CODED_BLOCK-1 -: 2];
reversed_byte_0   = i_data[BYTE_0 -: 8]; //se pude hacer directamente i_data[BYTE_0 +: 8] ??
reversed_byte_1   = i_data[BYTE_1 -: 8];
reversed_byte_2   = i_data[BYTE_2 -: 8];
reversed_byte_3   = i_data[BYTE_3 -: 8];
reversed_byte_4   = i_data[BYTE_4 -: 8];
reversed_byte_5   = i_data[BYTE_5 -: 8];
reversed_byte_6   = i_data[BYTE_6 -: 8];
reversed_byte_7   = i_data[BYTE_7 -: 8];

reversed_byte_0[0:7] = reversed_byte_0[7:0];
reversed_byte_1[0:7] = reversed_byte_1[7:0];
reversed_byte_2[0:7] = reversed_byte_2[7:0];
reversed_byte_3[0:7] = reversed_byte_3[7:0];
reversed_byte_4[0:7] = reversed_byte_4[7:0];
reversed_byte_5[0:7] = reversed_byte_5[7:0];
reversed_byte_6[0:7] = reversed_byte_6[7:0];
reversed_byte_7[0:7] = reversed_byte_7[7:0];

data_bit_reversed =
	{sh, reversed_byte_0, reversed_byte_1, reversed_byte_2, reversed_byte_3, reversed_byte_4, 
		 reversed_byte_5, reversed_byte_6, reversed_byte_7};
end

endmodule