module register_file
    #(
        parameter                       GPIO_LEN        = 32,
        parameter                       OPCODE_LEN      = 16,
        parameter                       DATA_LEN        = 15,
        parameter                       LEN_CODED_BLOCK = 66,
        parameter                       LEN_TX_DATA     = 64,
        parameter                       LEN_TX_CTRL     = 8
    )
    (
        input wire                      i_clock,
        input wire                      i_reset,
        input wire                      i_enable,
        input wire  [`GPIO_LEN-1 : 0]   i_gpio_in,


        output reg  [`GPIO_LEN-1 : 0]   o_gpio_out,
    );


    //--------------------------------------------------------------------------------LOCALPARAMS
    localparam                  ENABLE_ENCODER  = 16'h0001;
    
    //--------------------------------------------------------------------------------SIGNALS
    wire                        enable          = i_gpio_in[GPIO_LEN-1]              ;               //Enable en bit mas significativo
    wire    [OPCODE_LEN-1 : 0]  opcode          = i_gpio_in[GPIO_LEN-2 -: OPCODE_LEN];                       
    wire    [DATA_LEN-1 : 0]    data            = i_gpio_in[DATA_LEN-1 : 0]          ;
    
    //--------------------------------------------------------------------------------REGISTERS
    //reg     [DATA_LEN-1 : 0]    data_reg  ;                                             
    reg     [LEN_TX_DATA-1 : 0] tx_data     ;                  
    reg     [LEN_TX_CTRL-1 : 0] tx_ctrl     ;


    always@(posedge i_clock)
    begin
        if (i_reset) begin

            //data_reg <= {DATA_LEN{1'b0}};
            tx_data  <= {LEN_TX_DATA{1'b0}};
            tx_ctrl  <= {LEN_TX_CTRL{1'b0}};

        end
        else 
        begin
            if (i_enable) 
            begin
                case (opcode)

                    ENABLE_ENCODER:
                    begin
                        tx_ctrl =  64'hFEFEFEFEFEFEFEFE;
                        tx_data =  8'hFE;
                    end
                    

                    
                endcase
            end
        end
    end

endmodule