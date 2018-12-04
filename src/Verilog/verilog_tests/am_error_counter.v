
/*

	REVISAR LOGICA PARA EVITAR OVERFLOW
*/

module am_error_counter
#(
	parameter NB_BIP = 8,
	parameter NB_COUNTER = 32
 )
 (
 	input wire 						i_clock,
 	input wire 						i_reset,
 	input wire 						i_enable,
 	input wire 						i_match,
 	input wire [NB_BIP-1 : 0] 		i_recived_bip,
 	input wire [NB_BIP-1 : 0] 		i_calculated_bip,

 	output wire [NB_COUNTER-1 : 0] 	o_error_count,
 	output wire 				  	o_overflow_flag

 );
//LOCALPARAM

localparam NB_CURRENT_ERROR = $clog2(NB_BIP);


//INTERNAL SIGANLS

reg [NB_CURRENT_ERROR-1 : 0] error_counter,error_counter_next;
reg 						 overflow_flag;


//Update counter
 always @ (posedge i_clock)
 begin

 	if(i_reset) // se deberia agregar una condicion p resetear contador i_reset_count
 	begin
 		error_counter <= {NB_COUNTER{1'b0}};
 		overflow_flag <= 1'b0;
 	end

 	else if (i_enable && i_match)

 		if(error_counter[NB_COUNTER-1 : NB_CURRENT_ERROR] == {NB_COUNTER-NB_CURRENT_ERROR{1'b1}})//** check
 		begin//evitar overflow
 			error_counter <= {NB_COUNTER{1'b1}};
 			overflow_flag <= 1'b1;
 		end
 		else
 		begin
 			error_counter <= error_counter + error_counter_next;
 			overflow_flag <= 1'b0;
 		end
 end


 always @ *
 begin
 	error_counter_next = 0;
 	for(integer i=0; i<NB_BIP; i=i+1)
 	begin
 		if(i_recibed_bip[i] != i_calculated_bip[i])
 			error_counter_next  = error_counter_next + 1'b1;
 	end

 end