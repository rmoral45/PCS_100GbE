/*

	REVISAR LOGICA PARA EVITAR OVERFLOW
*/

module am_error_counter
    #(
        parameter                               NB_BIP              = 8,
        parameter                               NB_COUNTER          = 16
     )
     (
    
        input wire 			                    i_clock,
        input wire 			                    i_reset,
        input wire 			                    i_enable,
        input wire                              i_valid,
        input wire 			                    i_match,
        input wire			                    i_reset_count,
        input wire  [NB_BIP-1 : 0] 	            i_recived_bip,
        input wire  [NB_BIP-1 : 0] 	            i_calculated_bip,
    
        output wire [NB_COUNTER-1 : 0]          o_error_count,
        output wire 			                o_overflow_flag
     );
    
    //LOCALPARAM
    localparam                                  NB_CURRENT_ERROR    = $clog2(NB_BIP);
    
    //INTERNAL SIGANLS
    reg             [NB_COUNTER : 0] 		    error_counter;
    reg             [NB_CURRENT_ERROR-1 : 0]    error_counter_next;
    wire 			     	                    overflow_flag;
    
    assign                                      overflow_flag       = error_counter[NB_COUNTER]; 
    
    //Ports
    assign                                      o_error_count       = error_counter;

    //Update counter
     always @ (posedge i_clock)
     begin
    
         if(i_reset || i_reset_count)
         begin
             error_counter <= {NB_COUNTER{1'b0}};
         end 
    
         else if (i_enable && i_valid && i_match)
        begin
             if (overflow_flag)
                 error_counter <= {NB_COUNTER{1'b1}};
             else
                 error_counter <= (error_counter + error_counter_next);
        end
     end
    
    
    integer i;
     always @ *
     begin
         error_counter_next = 0;
         if(i_recived_bip != i_calculated_bip)
            error_counter_next  = error_counter_next + 1'b1;
     end
    
    endmodule
    
