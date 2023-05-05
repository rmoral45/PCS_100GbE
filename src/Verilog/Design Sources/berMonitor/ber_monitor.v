`timescale 1ns/100ps

/*
        [CHECK] xus_timer window
*/
module ber_monitor
#(
        parameter                   HI_BER_VALUE        = 970,
        parameter                   XUS_TIMER_WINDOW    = 4096
 )
 (
        input wire                  i_clock,
        input wire                  i_reset,
        input wire                  i_valid_sh, //seria lo mismo que 'valid sh' --> FIX: es la xor entre los bits del sh
        input wire                  i_test_mode, //config para test de patron idle
        input wire                  i_deskew_done,
        input wire                  i_valid, //valid generado por block_sync

        output wire                 o_hi_ber
 );

        //States
        localparam                  N_STATES            = 3;
        localparam                  INIT                = 3'b001;
        localparam                  TEST                = 3'b010;
        localparam                  HI_BER              = 3'b100;

        //Internal params
        localparam                  NB_BER_CNT          = $clog2(XUS_TIMER_WINDOW)+ 1;
        localparam                  NB_XUS_TIMER        = $clog2(XUS_TIMER_WINDOW) + 1;


        //Internal Signals
        reg [N_STATES-1     : 0]    state, next_state;
        reg [NB_BER_CNT-1   : 0]    ber_cnt, next_ber_cnt;
        reg [NB_XUS_TIMER-1 : 0]    xus_timer;
        reg                         reset_timer;
        reg                         hi_ber, hi_ber_next;
        wire                        xus_timer_done;

        //Algorithm Begin

        always @ (posedge i_clock)
        begin
                if (i_reset  || ~i_deskew_done)
                        state <= INIT;
                else if (i_valid)
                        state <= next_state;
        end

        always @ (posedge i_clock)
        begin
                if (i_reset || ~i_deskew_done || xus_timer_done)
                        ber_cnt <= {NB_BER_CNT{1'b0}};
                else if (i_valid && !i_valid_sh)
                        ber_cnt <= ber_cnt + 1'b1;
        end

        always @ (posedge i_clock)
        begin
                if (i_reset || ~i_deskew_done || xus_timer_done || i_test_mode   || reset_timer)
                        xus_timer <= {NB_XUS_TIMER{1'b0}};
                else if (i_valid )
                        xus_timer <= xus_timer + 1'b1; 
        end
        assign xus_timer_done = ((xus_timer == XUS_TIMER_WINDOW) & i_valid) ? 1'b1 : 1'b0;

        
        always @ (posedge i_clock)
        begin
                if (i_reset  || ~i_deskew_done)
                        hi_ber <= 0;
                else
                        hi_ber <= hi_ber_next;
        end
        
        assign  o_hi_ber = hi_ber;

        always @ *
        begin
                next_state      = state;
                reset_timer     = 1'b0;
                hi_ber_next     = hi_ber;
                
                case(state)
                        INIT :
                        begin
                                next_state      = TEST;
                                reset_timer     = 1'b1;
                        end
                        TEST :
                        begin
                                if (ber_cnt >= HI_BER_VALUE)
                                        next_state = HI_BER;
                                else if (xus_timer_done)
                                        hi_ber_next = 0;
                        end
                        HI_BER:
                        begin
                                hi_ber_next = 1'b1;
                                if (xus_timer_done)
                                        next_state = INIT;
                        end
                        default:
                        begin
                            next_state = INIT;
                        end   
                endcase       
        end

endmodule
