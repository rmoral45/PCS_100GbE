///////////////////////////////////////////
// MEMORY RAM
///////////////////////////////////////////
`define NB_DATA_RAM_LOG     16
`define NB_ADDR_RAM_LOG     15
`define INIT_FILE           "/media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Verilog/Verification/MicroGPIO/files"
///////////////////////////////////////////
// PRBS
///////////////////////////////////////////
`define NB_PRBS            9
`define PRBS_LOW_ORDER     5 // PRBS31:28 - PRBS9:5
`define PRBS_HIGH_ORDER    9 // PRBS31:31 - PRBS9:9
`define PRBS_SEED_I        `NB_PRBS'h1AA
`define PRBS_SEED_Q        `NB_PRBS'h1FE


///////////////////////////////////////////
// BER COUNTER
///////////////////////////////////////////
`define NB_BER_ERROR        64
`define NB_BER_TXADDR       9 
`define BER_DEPTH_TXBUF     511 
`define NB_BER_ACCUM        10 
`define NB_BER_STATE        2
`define BER_RST             {`NB_BER_STATE'd0}
`define BER_CHECK_CORR      {`NB_BER_STATE'd1}
`define BER_DONE            {`NB_BER_STATE'd2}
`define NB_EI_COUNTER       16
`define APG_PATERN          32'h352EF853
`define NB_APG_PATERN_LEN   32
`define NB_BER_TXADDR_IDLES 5

///////////////////////////////////////////
// OUTPUT SAMPLE TO AFE
///////////////////////////////////////////
`define NBI_AFE_SAMPLE_DAC                  2
`define NBF_AFE_SAMPLE_DAC                  12

///////////////////////////////////////////
// SRRC TX
///////////////////////////////////////////
`define SRRC_TX_NUM_COEF                   512
`define SRRC_TX_DATA_BUFFER_LEN            8
`define NBI_SRRC_TX_COEF                   2
`define NBF_SRRC_TX_COEF                   12
`define NBI_SRRC_TX_OUT                    `NBI_AFE_SAMPLE_DAC
`define NBF_SRRC_TX_OUT                    `NBF_AFE_SAMPLE_DAC

///////////////////////////////////////////
// NOISE GENERATOR
///////////////////////////////////////////
`define NBI_AWGN_DATA       5
`define NBF_AWGN_DATA       11

`define NB_LEDS 16


///////////////////////////////////////////
// FCSG TX
///////////////////////////////////////////
`define NB_FCSGTX_PERIOD_COUNTER           10 
`define FCSGTX_LOG2_8MHZ                   2 // Log2(4)
`define FCSGTX_LOG2_1oTMHZ_BPSK            8 // Log2(256)
`define FCSGTX_LOG2_BITRATEMHZ_BPSK        8 // Log2(256)
`define FCSGTX_LOG2_1oTMHZ_QPSK            5 // Log2(32)
`define FCSGTX_LOG2_BITRATEMHZ_QPSK        4 // Log2(256)
`define FCSGTX_LIMIT_CODERATE12_QPSK       {`NB_FCSGTX_PERIOD_COUNTER'd33 }
`define FCSGTX_LIMIT_CODERATE45_QPSK       {`NB_FCSGTX_PERIOD_COUNTER'd21 }
`define FCSGTX_LIMIT_CODERATE12_BPSK       {`NB_FCSGTX_PERIOD_COUNTER'd528}
`define FCSGTX_LIMIT_CODERATE45_BPSK       {`NB_FCSGTX_PERIOD_COUNTER'd336}

`define NBI_AWGN_DATA       5
`define NBF_AWGN_DATA       11
`define NB_GPIOS            32
`define NB_ENABLE_RX        2
`define NB_ENABLE_TOTAL     `NB_ENABLE_RX + 2  // PRBS - GNG - RX
`define NB_BER_MODULES      1
`define NB_BER_CTRL         `NB_BER_MODULES + 2 // Enb - Read - Mod
`define NB_BETA                 4
`define NB_MU 	                4
`define NB_BER_ERROR        64
`define NB_GPIO_DATA        23
`define NB_GPIO_ADDRESS     8
`define NB_ADDR_RAM_LOG     15
`define NB_DEVICES          1
`define NB_LOG_READ_DEVICES `NB_ADDR_RAM_LOG + 1 + `NB_DEVICES//SelFFEupperdown - Device - Addr
