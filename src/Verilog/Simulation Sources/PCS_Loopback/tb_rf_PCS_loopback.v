`timescale 1ns/100ps

module tb_rf_PCS_loopback;
//Common parameters
    localparam           NB_DATA_RAW             = 64;
    localparam           NB_CTRL_RAW             = 8;
    localparam           NB_DATA_CODED           = 66;
    localparam           NB_DATA_TAGGED          = 67;
    localparam           N_LANES                 = 20;
    localparam           NB_DATA_BUS             = N_LANES * NB_DATA_CODED;

    //Channel Model
    localparam           NB_ERR_MASK             = NB_DATA_CODED-2;         //mascara, se romperan los bits cuya posicon en la mascara sea ;
    localparam           MAX_ERR_BURST           = 1024;                    //cantidad de bloques consecutivos que se rompera;
    localparam           MAX_ERR_PERIOD          = 1024;                    //cantidad de bloqus por periodo de error ver NOTAS;
    localparam           MAX_ERR_REPEAT          = 10;                      //cantidad de veces que se repite el mismo patron de erro;
    localparam           NB_BURST_CNT            = $clog2(MAX_ERR_BURST);
    localparam           NB_PERIOD_CNT           = $clog2(MAX_ERR_PERIOD);
    localparam           NB_REPEAT_CNT           = $clog2(MAX_ERR_REPEAT);
    localparam           N_MODES                 = 4;
    localparam           MAX_SKEW_INDEX          = (NB_DATA_RAW - 2);
    localparam           NB_SKEW_INDEX           = $clog2(MAX_SKEW_INDEX);
    
    //RX localparam;
    // block sync
    localparam           NB_SH                   = 2;
    localparam           NB_SH_VALID_BUS         = N_LANES;
    localparam           MAX_WINDOW              = 4096;
    localparam           NB_WINDOW_CNT           = $clog2(MAX_WINDOW);
    localparam           MAX_INV_SH              = (MAX_WINDOW/2);
    localparam           NB_INV_SH               = $clog2(MAX_WINDOW/2);
    // ber monitor
    localparam           HI_BER_VALUE            = 97;
    localparam           XUS_TIMER_WINDOW        = 1024;
    // aligment
    localparam           NB_ERROR_COUNTER        = 16;
    localparam           N_ALIGNER               = 20;
    localparam           NB_LANE_ID              = $clog2(N_ALIGNER);
    localparam           MAX_INV_AM              = 8;
    localparam           NB_INV_AM               = $clog2(MAX_INV_AM);
    localparam           MAX_VAL_AM              = 20;
    localparam           NB_VAL_AM               = $clog2(MAX_VAL_AM);
    localparam           NB_AM                   = 48;
    localparam           NB_AM_PERIOD            = 14;
    localparam           AM_PERIOD_BLOCKS        = 16383;
    localparam           NB_ID_BUS               = N_LANES * NB_LANE_ID;
    localparam           NB_ERR_BUS              = N_LANES * NB_ERROR_COUNTER;
    localparam           NB_RESYNC_COUNTER       = 8;
    localparam           NB_RESYNC_COUNTER_BUS   = NB_RESYNC_COUNTER * N_LANES;
    // deskew
    localparam           NB_FIFO_DATA            = 67; //incluye tag de SOL
    localparam           FIFO_DEPTH              = 20;
    localparam           MAX_SKEW                = 16;
    localparam           NB_FIFO_DATA_BUS        = N_LANES * NB_FIFO_DATA;

    //decoder
    localparam           NB_FSM_CONTROL          = 4;
    
    //test pattern checker
    localparam           NB_MISMATCH_COUNTER     = 32 ;

    //RF
    localparam           NB_GPIO_DATA            = 32;
    localparam           NB_ENABLE_RF            = 1;
    localparam           NB_ADDR_RF              = 9;
    localparam           NB_I_DATA_RF            = 22;

reg                         tb_clock;
reg                         tb_reset;
reg                         tb_signal_ok;
reg [NB_GPIO_DATA-1 : 0]    tb_rf_i_gpio_data;
wire [NB_GPIO_DATA-1 : 0]    tb_rf_o_gpio_data;

initial
begin
    tb_clock                                        = 1'b0;
    tb_reset                                        = 1'b0;
    tb_signal_ok                                    = 1'b0;
    tb_rf_i_gpio_data                               = {NB_GPIO_DATA{1'b0}};

    #10000   
    tb_reset                                        = 1'b1;
    tb_signal_ok                                    = 1'b1;
    #10     
    tb_reset                                        = 1'b0;
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
    
    #100                                                              
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd64;  //unlocked_timer
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd112;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd1024;  //locked_timer
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd111;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input    

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd65;  //sh invalid
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd113;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input        

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd4;  //invalid am thr
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd114;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input        

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd1;  //valid am thr
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd115;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input        

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]                     = 22'd16383;  //am period
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd116;
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input        
    

    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]           = 22'd1;     //PCS reset and enable modules bit
    
    #1000
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd1; //PCS reset through RF
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_I_DATA_RF-1 : 0]           = 22'd1;     //Enable of modules    
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd350; //encoder addr
       
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
    
    #1000
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd5; //scrambler addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
    
        
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd352; //PC addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
        
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd4; //AM insertion addr

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
        
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd353; //clock_comp addr     
   
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
    
    /*tx*/
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd349; //frame gen addr        
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;    //enable of RF input
       

    /*rx*/
    /* enables */
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd104; // block sync addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd105; // aligner addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd7; // deskewer addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd8; // lane_reorder addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd10; // descrambler addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd353; // clock comp addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd109; // test_pattern checker addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input   
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd12; // decoder addr
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #3000000
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd375; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd376; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd377; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd378; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd379; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd380; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd381; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd382; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd383; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd384; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd385; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd386; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd387; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd388; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd389; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd390; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd391; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd392; // decoder addr    
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd393; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd394; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    //========================================== COR
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd199; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd200; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd201; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input

    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd202; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input 
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd203; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input  
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd204; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input 
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd205; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input 
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd206; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd207; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input  
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd208; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd209; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input

    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd210; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd211; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd212; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd213; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd214; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd215; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd216; // decoder addr    
    
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd217; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input
    
    #100
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF - 1 -: NB_ADDR_RF] = 9'd218; // decoder addr    

    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b1;     //enable of RF input
    #10
    tb_rf_i_gpio_data[NB_GPIO_DATA - NB_ENABLE_RF]  = 1'b0;     //enable of RF input    
    
    #300000000 $finish;
end

always #1 tb_clock = ~tb_clock;

rf_toplevel
u_rf_toplevel
(
    .i_fpga_clock(tb_clock),
    .i_reset(tb_reset),
    .i_gpio_data(tb_rf_i_gpio_data),
    .o_gpio_data(tb_rf_o_gpio_data)
);

endmodule