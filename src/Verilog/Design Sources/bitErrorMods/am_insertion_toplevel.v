`timescale 1ns/100ps

module am_insertion_toplevel
#(
	parameter 							            NB_DATA_TAGGED     = 67,
    parameter                                       NB_DATA_CODED      = 66,
    parameter                                       N_LANES             = 20,
	parameter 							            NB_BIP              = 8
)
(
    input wire                                      i_clock,
    input wire                                      i_reset,
    input wire                                      i_valid,
    input wire                                      i_enable,
    input wire  [(NB_DATA_TAGGED*N_LANES)-1 : 0]  i_data,

    output wire [(NB_DATA_CODED*N_LANES)-1 : 0]   o_data,
    output wire                                     o_valid
);
    
    localparam NB_AM_ENCODING           = 24;

    //LANE_MARKERS'S MATRIX
    localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_LOW    = { 24'hC1_68_21, 
                                                                       24'h9D_71_8E, 
                                                                       24'h59_4B_E8, 
                                                                       24'h4D_95_7B, 
                                                                       24'hF5_07_09,
                                                                       24'hDD_14_C2, 
                                                                       24'h9A_4A_26, 
                                                                       24'h7B_45_66, 
                                                                       24'hA0_24_76, 
                                                                       24'h68_C9_FB,
                                                                       24'hFD_6C_99, 
                                                                       24'hB9_91_55, 
                                                                       24'h5C_B9_B2, 
                                                                       24'h1A_F8_BD, 
                                                                       24'h83_C7_CA,
                                                                       24'h35_36_CD, 
                                                                       24'hC4_31_4C, 
                                                                       24'hAD_D6_B7, 
                                                                       24'h5F_66_2A, 
                                                                       24'hC0_F0_E5}; 
    localparam [(NB_AM_ENCODING*N_LANES)-1 : 0] AM_ENCODING_HIGH    = {24'h3E_97_DE,
                                                                       24'h62_8E_71, 
                                                                       24'hA6_B4_17, 
                                                                       24'hB2_6A_84, 
                                                                       24'h0A_F8_F6, 
                                                                       24'h22_EB_3D, 
                                                                       24'h65_B5_D9, 
                                                                       24'h84_BA_99, 
                                                                       24'h5F_DB_89, 
                                                                       24'h97_36_04, 
                                                                       24'h02_93_66, 
                                                                       24'h46_6E_AA, 
                                                                       24'hA3_46_4D, 
                                                                       24'hE5_07_42, 
                                                                       24'h7C_38_35, 
                                                                       24'hCA_C9_32, 
                                                                       24'h3B_CE_B3, 
                                                                       24'h52_29_48, 
                                                                       24'hA0_99_D5, 
                                                                       24'h3F_0F_1A};                                                                                                                

    //Vector que almacena los tags de cada lane
    wire        [(NB_DATA_CODED*N_LANES)-1 : 0]     out_data;  
    assign                                          o_data = out_data;
    
    reg         [(NB_DATA_TAGGED*N_LANES)-1 : 0]    data_input_d;
    reg                                             valid_d;
    assign                                          o_valid = valid_d;    
    
    always @(posedge i_clock)
    begin
        if(i_reset)
        begin
            data_input_d <= {NB_DATA_TAGGED*N_LANES{1'b0}};
            valid_d <= 1'b0;
        end
        else if(i_enable)
        begin
            if(i_valid)
            begin
                valid_d <= i_valid;
                data_input_d <= i_data;
            end
            else
            begin
                valid_d <= 1'b0;
                data_input_d <= data_input_d;
            end
        end
    end


    genvar i;
    //generate

    for (i=0; i<N_LANES; i=i+1)
    begin :ger_block
        am_insertion
        #(
            .NB_DATA_CODED    (NB_DATA_CODED),
            .AM_ENCODING_LOW    (AM_ENCODING_LOW [(NB_AM_ENCODING*N_LANES)-1 - i*NB_AM_ENCODING -: NB_AM_ENCODING]),
            .AM_ENCODING_HIGH   (AM_ENCODING_HIGH[(NB_AM_ENCODING*N_LANES)-1 - i*NB_AM_ENCODING -: NB_AM_ENCODING]),
            .NB_BIP             (NB_BIP)
        )
        u_am_insertion
        (
            .i_clock            (i_clock),
            .i_reset            (i_reset),
            .i_enable           (i_enable && i_valid),
            .i_valid            (valid_d),
            .i_am_insert        (data_input_d[(NB_DATA_TAGGED*N_LANES)-1 - i*NB_DATA_TAGGED]),
            .i_data             (data_input_d[(NB_DATA_TAGGED*N_LANES)-2 -(i*NB_DATA_TAGGED) -: NB_DATA_CODED]),
            .o_data             (out_data[((NB_DATA_CODED*N_LANES)-1) -(i*NB_DATA_CODED) -: NB_DATA_CODED])
        );
        
    end

endmodule