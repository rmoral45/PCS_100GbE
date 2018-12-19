/*
	Cambiar nombre de archivo y modulo a serial_transmitter
*/

module serial_transmitter
#(
	parameter LEN_CODED_BLOCK = 66
 )
 (
 	input  wire 						i_clock 		 , //system clock
 	input  wire 						i_reset 		 ,
 	input  wire 						i_transmit_clock , // bit transmit rate
 	input  wire [LEN_CODED_BLOCK-1 : 0] i_data 			 ,

 	//output wire 						o_IS_UNIT_DATA   , //pulso p indicar transmision de datos???
 	output wire 						o_tx_bit		 
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
//states
localparam WAIT_DATA = 2'b01;
localparam SEND_DATA = 2'b10;

localparam NB_COUNTER = $clog2(LEN_CODED_BLOCK);




//INTERNAL SIGNALS
reg  [NB_COUNTER-1 : 0] 	 data_counter;
reg  [LEN_CODED_BLOCK-1 : 0] data_reg, data_bit_reversed, tx_data_next; 
reg  [1 : 0]				 state, state_next;

//aux registers
reg [1:0] sh;
reg [0:7] reversed_byte_0;
reg [0:7] reversed_byte_1;
reg [0:7] reversed_byte_2;
reg [0:7] reversed_byte_3;
reg [0:7] reversed_byte_4;
reg [0:7] reversed_byte_5;
reg [0:7] reversed_byte_6;
reg [0:7] reversed_byte_7;

assign o_tx_bit = data_reg[LEN_CODED_BLOCK-1];

always @(posedge i_clock)begin

    if(i_reset)
    begin
        data_counter <= 0;
        state 		 <= WAIT_DATA;
        data_reg 	 <= {LEN_CODED_BLOCK{1'b0}};
    end
    else
    begin
        data_counter <= data_counter_next;
        state 		 <= state_next;
        data_reg 	 <= tx_data_next;
    end

end

always @ * begin


   state_next = state;
   tx_data_next = data_reg;
   data_counter_next = data_counter;

   case (state)

        WAIT_DATA:
        begin
            if(i_transmit_clock)
            begin
                state_next = SEND_DATA;
                data_counter_next = 0; //verificar 0 o 1
                tx_data_next = data_bit_reversed; 
            end
        end
        
     
        SEND_DATA:
        begin
            if(i_transmit_clock)  
            begin   
                    tx_data_next = data_reg << 1;
                    if(data_counter == (LEN_CODED_BLOCK - 1)) 
                    begin
                        state_next = WAIT_DATA;
                        data_counter_next = 0;
                    end
                    else
                    begin
                        data_counter_next = data_counter + 1;
                    end
            end
        end
        default:
        begin
            state_next = WAIT_DATA;
            tx_clock_counter_next = 0;
            data_counter_next = 0;
            tx_data_next = 0;
            tx_next = 1'b1;
        end

   endcase

end



always @ *
begin //bit reversal

data_bit_reversed = {LEN_CODED_BLOCK{1'b0}};
sh 				  = i_data[LEN_CODED_BLOCK-1 -: 2];

reverse_byte( i_data[BYTE_0 -: 8], reversed_byte_0 );
reverse_byte( i_data[BYTE_1 -: 8], reversed_byte_1 );
reverse_byte( i_data[BYTE_2 -: 8], reversed_byte_2 );
reverse_byte( i_data[BYTE_3 -: 8], reversed_byte_3 );
reverse_byte( i_data[BYTE_4 -: 8], reversed_byte_4 );
reverse_byte( i_data[BYTE_5 -: 8], reversed_byte_5 );
reverse_byte( i_data[BYTE_6 -: 8], reversed_byte_6 );
reverse_byte( i_data[BYTE_7 -: 8], reversed_byte_7 );

data_bit_reversed =
	{sh, reversed_byte_0, reversed_byte_1, reversed_byte_2, reversed_byte_3,
	 	 reversed_byte_4, reversed_byte_5, reversed_byte_6, reversed_byte_7 };
end

//task para hacer el reverso de un byte
task automatic reverse_byte;

input  [7:0] byte_in;
output [7:0] byte_out; 
integer i;
begin
	for(i=0; i < 8; i=i+1)
		byte_out[i] = byte_in[7-i];
end
endtask


endmodule