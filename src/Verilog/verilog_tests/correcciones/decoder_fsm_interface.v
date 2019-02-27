/*
Este bloque tiene como entrada el r_type de un bloque
y como salida el r_type del bloque actual y del bloque previo, 
es decir, el r_type y el r_type_next
*/

module decoder_interface
#(
	parameter LEN_R_TYPE = 4
 )
 (
 	input wire  					i_clock,
 	input wire  					i_reset,
 	input wire  					i_enable,
 	input wire  [LEN_R_TYPE-1 : 0]	i_r_type,
 	output wire [LEN_R_TYPE-1 : 0] 	o_r_type,
 	output wire [LEN_R_TYPE-1 : 0] 	o_r_type_next
 );

 reg [LEN_R_TYPE-1 : 0]	r_type 	   ;
 reg [LEN_R_TYPE-1 : 0]	r_type_next;

 assign o_r_type	  =	r_type     ;
 assign o_r_type_next = r_type_next;

 always @(posedge i_clock or posedge i_reset)
 begin	

 	if(i_reset)
 	begin
 		r_type 		<= {LEN_R_TYPE{1'b0}};
 		r_type_next <= {LEN_R_TYPE{1'b0}};
 	end
 	else if(i_enable)
 	begin
 		r_type 		<= r_type_next;
 		r_type_next	<= i_r_type;
 	end
 end

endmodule
 