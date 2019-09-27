`timescale 1ns/100ps


module tb_lane_mux;

localparam N_LANES = 20;
localparam NB_CODED_BLOCK = 66;
localparam IN_DATA_BUS = NB_CODED_BLOCK * N_LANES;

reg  [N_LANES-1 : 0]            tb_lane_id;
reg  [IN_DATA_BUS-1 : 0]        tb_in_data;
wire [NB_CODED_BLOCK-1 : 0]     tb_out_data;

initial
begin
        tb_lane_id = 20'h00001;
        tb_in_data = {
                        66'h2_1e00_0000_0000_0000 , 66'd1 , 66'd2 , 66'd3 , 66'd4,
                        66'd5 , 66'd6 , 66'd7 , 66'd8 , 66'd9, 
                        66'd10, 66'd11, 66'd12, 66'd13, 66'd14, 
                        66'd15, 66'd16, 66'd17, 66'd18, 66'd19  
                     };
        #10
                tb_lane_id = 20'h00002;
        #10
                tb_lane_id = 20'h00004;
        #10
                tb_lane_id = 20'h00008;
        #10
                tb_lane_id = 20'h00010;
        #10
                tb_lane_id = 20'h00020;
        #10
                tb_lane_id = 20'h00040;
        #10
                tb_lane_id = 20'h00080;
        #10
                tb_lane_id = 20'h00100;
        #10
                tb_lane_id = 20'h00200;
        #10
                tb_lane_id = 20'h00400;
        #10
                tb_lane_id = 20'h00800;
        #10
                tb_lane_id = 20'h01000;
        #10
                tb_lane_id = 20'h02000;
        #10
                tb_lane_id = 20'h04000;
        #10
                tb_lane_id = 20'h08000;
        #10
                tb_lane_id = 20'h10000;
        #10
                tb_lane_id = 20'h20000;
        #10
                tb_lane_id = 20'h40000;
        #10
                tb_lane_id = 20'h80000;
end


//Instances

_66_bit_nlanes_mux
#(
        .N_LANES        (N_LANES),
        .NB_CODED_BLOCK (NB_CODED_BLOCK)
 )
        u_lane_mux
        (
                .i_lane_id(tb_lane_id),
                .i_data(tb_in_data),

                .o_data(tb_out_data)        
        );


endmodule
