module common_counter
#(
    parameter                               MAX_COUNT       = 255,
    parameter                               NB_MAX_COUNT    = $clog2(MAX_COUNT) 
)
(
    input   wire                            i_clk,
    input   wire                            i_rst,
    input   wire                            i_rf_enable,
    input   wire                            i_valid,

    output  wire   [NB_MAX_COUNT-1   : 0]  o_counter

);

    reg     [NB_MAX_COUNT-1   : 0]          counter;
    wire    [NB_MAX_COUNT-1   : 0]          counter_next;
    wire                                    count_done;
    wire                                    run_counter;

    assign                                  run_counter     = (i_rf_enable || |counter);
    assign                                  count_done      = (counter == MAX_COUNT) && i_valid;
    assign                                  counter_next    = run_counter ? counter + NB_MAX_COUNT'(1'b1) : counter;

    always @(posedge i_clk) begin
        if(i_rst || count_done) begin
            counter <= {NB_MAX_COUNT{1'b0}};
        end
        else if(i_valid) begin
            counter <= counter_next;
        end
    end

    assign o_counter    = counter;

endmodule