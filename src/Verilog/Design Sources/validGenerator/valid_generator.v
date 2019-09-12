`timescale 1ns/100ps


module valid_generator
#(
        parameter COUNT_LIMIT = 10
 )
 (
        input  wire     i_clock,
        input  wire     i_reset,

        output wire     o_valid
 );


//Localparams

localparam NB_COUNTER = $clog2(COUNT_LIMIT);

//Internal signals

reg [NB_COUNTER-1 : 0] counter;

wire                   count_done;

//Ports

assign o_valid = count_done;

always @ (posedge i_clock)
begin
        if (i_reset || count_done)
                counter <= {NB_COUNTER{1'b0}};
        else 
                counter <= counter + 1'b1;
end

assign count_done = (counter == COUNT_LIMIT) ? 1'b1 : 1'b0;

endmodule
