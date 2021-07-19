`timescale 1ns/100ps

module frame_generator_rx
#(
    parameter                                   AM_BLOCK_PERIOD     = 16383,
    parameter                                   FRAMES_PER_PERIOD   = 10,
    parameter                                   COUNTER_MAX_COUNT   = AM_BLOCK_PERIOD/FRAMES_PER_PERIOD,
    parameter                                   NB_COUNTER          = $clog2(COUNTER_MAX_COUNT),
    parameter                                   NB_DATA             = 66
)           
(           
    input   wire                                i_clock,
    input   wire                                i_reset,
    input   wire                                i_enable,
    input   wire                                i_valid,

    output  wire    [NB_DATA-1      :   0]      o_data    
);  

    localparam                                  N_FRAMES_TYPES      = 4; //start, data, terminate and idle.
    localparam                                  START_FRAME         = 0;
    localparam                                  DATA_FRAME          = 1;
    localparam                                  TERMINATE_FRAME     = 2;
    localparam                                  IDLE_FRAME          = 3;
    localparam                                  N_DATA_FRAMES       = 1000;
    //localparam                                  N_IDLE_FRAMES       = COUNTER_MAX_COUNT - 2 - N_DATA_FRAMES; 
    
    localparam                                  CTRL_SH             = 2'b10;
    localparam                                  DATA_SH             = 2'b01;
    localparam							        TERM0_TYPE		    = 8'h87;
    localparam							        IDLE_TYPE		    = 8'h1E;
    localparam                                  START_TYPE          = 8'hFB;
    localparam                                  DATA_CHAR           = 8'hFA;
    localparam                                  IDLE_CHAR           = 7'h00;


/* Internal signals */      
    reg             [NB_COUNTER-1   : 0]        counter;
    wire                                        reset_counter;
    reg             [NB_DATA-1      : 0]        frame_generated;

    wire            [N_FRAMES_TYPES - 1 : 0]    frame_mux;  
    
    

    always @ (posedge i_clock)
    begin
        if(i_reset || reset_counter)
            counter <= {NB_COUNTER{1'b0}};
        else if(i_enable && i_valid)
            counter <= counter + 1'b1;
    end

    assign  reset_counter   =   (counter == COUNTER_MAX_COUNT - 1) ? 1'b1 : 1'b0;

    assign  frame_mux       =   (counter == 0)                                                  ? START_FRAME    :
                                (counter > 0 && counter <= N_DATA_FRAMES)                       ? DATA_FRAME     :
                                (counter > N_DATA_FRAMES && counter < COUNTER_MAX_COUNT - 2)    ? IDLE_FRAME     :
                                                                                                  TERMINATE_FRAME;

    always @ (*)
    begin
            frame_generated = {NB_DATA{1'b0}};
    
            if(frame_mux == START_FRAME)
                frame_generated = {CTRL_SH, START_TYPE, {7{DATA_CHAR}}};
            else if(frame_mux == DATA_FRAME)
                frame_generated = {DATA_SH, {8{DATA_CHAR}}};
            else if(frame_mux == TERMINATE_FRAME)
                frame_generated = {CTRL_SH, TERM0_TYPE, {7{IDLE_CHAR}}};
            else if(frame_mux == IDLE_FRAME)
                frame_generated = {CTRL_SH, IDLE_TYPE, {7{IDLE_CHAR}}}; 
    end

    assign  o_data = frame_generated;

endmodule
