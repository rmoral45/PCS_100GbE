`timescale 1ns/100ps


module tb_bit_mux;

localparam N_LANES = 20;

reg  [N_LANES-1 : 0]    tb_lane_id;
reg  [N_LANES-1 : 0]    tb_in_data;
wire                    tb_out_data;

initial
begin   
        //test LSB 
        tb_lane_id = 20'b_0000_0000_0000_0000_0001;
        tb_in_data    = 20'b_0000_0000_0000_0000_0001;

        #10
                tb_in_data    = 20'b_0000_0000_0000_0000_0000;

        //test MSB
        #10
                tb_lane_id = 20'b_1000_0000_0000_0000_0000;
                tb_in_data    = 20'b_1000_0000_0000_0000_0000;
        #10
                tb_in_data    = 20'b_0000_0000_0000_0000_0000;
        #10
                tb_in_data    = 20'b_0111_1111_1111_1111_1111;
        
end

//Instance

one_hot_20_to_1_mux
#(
        .N_LANES(N_LANES)
 )
        u_mux
        (
                .i_lane_id      (tb_lane_id),
                .i_data         (tb_in_data),
                
                .o_data         (tb_out_data)
        );

endmodule
