`timescale 1ns/100ps


module valid_generator
#(
        parameter               COUNT_SCALE             = 2,
        parameter               VALID_COUNT_LIMIT       = 10
 )
 (
        input  wire             i_clock,
        input  wire             i_reset,
        input  wire             i_enable,

        output wire             o_valid
 );


//Localparams
localparam                      NB_SYSTEM_COUNTER        = (COUNT_SCALE <= 2) ? COUNT_SCALE : $clog2(COUNT_SCALE);
localparam                      NB_VALID_COUNTER         = (VALID_COUNT_LIMIT <= 2) ? VALID_COUNT_LIMIT : $clog2(VALID_COUNT_LIMIT); 

//Internal signals
reg [NB_SYSTEM_COUNTER-1 : 0]   system_counter;
reg [NB_VALID_COUNTER-1 : 0]    valid_counter;

wire                            increment_sys_counter;
wire                            valid_count_done;

//Ports
assign                          o_valid = valid_count_done;

//always for counter register (para controlar cada cuantos clock de sistema aumento el contador)
always @ (posedge i_clock)
begin
        if(i_reset || increment_sys_counter)
                system_counter  <= {NB_SYSTEM_COUNTER{1'b0}};
        else
                system_counter  <= system_counter + 1;
end
assign  increment_sys_counter   = (system_counter == COUNT_SCALE) ? 1'b1 : 1'b0;

//always for valid signal
always @ (posedge i_clock)
begin
        if (i_reset || valid_count_done)
                valid_counter <= {NB_VALID_COUNTER{1'b0}};
        else if(increment_sys_counter)
                valid_counter <= valid_counter + 1'b1;
end
assign valid_count_done = (valid_counter == VALID_COUNT_LIMIT) ? 1'b1 : 1'b0;

/*
generate
if(COUNT_SCALE > 1)
assign  increment_sys_counter   = (system_counter == COUNT_SCALE-1) ? 1'b1 : 1'b0;
else
 assign  increment_sys_counter   =1;
endgenerate


generate
if(VALID_COUNT_LIMIT > 1)
assign  valid_count_done   = (valid_counter == VALID_COUNT_LIMIT-1) ? 1'b1 : 1'b0;
else
 assign valid_count_done = increment_sys_counter;
endgenerate
*/
endmodule
