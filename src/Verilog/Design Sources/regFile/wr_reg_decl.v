reg pcs__i_rf_reset;

reg pcs__i_rf_loopback;

reg pcs__i_rf_idle_pattern_mode;

reg pcs__i_rf_enable_tx_am_insertion;

reg pcs__i_rf_enable_clock_comp;

reg encoder__i_rf_enable;

reg frame_gen__i_rf_enable;

reg tx_pc__i_rf_enable;

reg scrambler__i_rf_enable;

reg scrambler__i_rf_bypass;

reg deskew__i_rf_enable;

reg reorder__i_rf_enable;

reg reorder__i_rf_reset_order;

reg descrambler__i_rf_enable;

reg descrambler__i_rf_bypass;

reg decoder__i_rf_enable;
reg decoder__i_rf_cor_err_counter;

reg channel__i_rf_update_payload_base;
reg channel1__i_rf_update_payload;
reg channel2__i_rf_update_payload;
reg channel3__i_rf_update_payload;
reg channel4__i_rf_update_payload;
reg channel5__i_rf_update_payload;
reg channel6__i_rf_update_payload;
reg channel7__i_rf_update_payload;
reg channel8__i_rf_update_payload;
reg channel9__i_rf_update_payload;
reg channel10__i_rf_update_payload;
reg channel11__i_rf_update_payload;
reg channel12__i_rf_update_payload;
reg channel13__i_rf_update_payload;
reg channel14__i_rf_update_payload;
reg channel15__i_rf_update_payload;
reg channel16__i_rf_update_payload;
reg channel17__i_rf_update_payload;
reg channel18__i_rf_update_payload;
reg channel19__i_rf_update_payload;

reg [4-1 : 0] channel__i_rf_payload_mode;
reg [64-1 : 0] channel__i_rf_payload_err_mask;
reg [10-1 : 0]channel__i_rf_payload_err_burst;
reg [10-1 : 0]channel__i_rf_payload_err_period;
reg [2-1 : 0]channel__i_rf_payload_err_repeat;

reg channel__i_rf_update_shbreaker_base;
reg channel1__i_rf_update_shbreaker;
reg channel2__i_rf_update_shbreaker;
reg channel3__i_rf_update_shbreaker;
reg channel4__i_rf_update_shbreaker;
reg channel5__i_rf_update_shbreaker;
reg channel6__i_rf_update_shbreaker;
reg channel7__i_rf_update_shbreaker;
reg channel8__i_rf_update_shbreaker;
reg channel9__i_rf_update_shbreaker;
reg channel10__i_rf_update_shbreaker;
reg channel11__i_rf_update_shbreaker;
reg channel12__i_rf_update_shbreaker;
reg channel13__i_rf_update_shbreaker;
reg channel14__i_rf_update_shbreaker;
reg channel15__i_rf_update_shbreaker;
reg channel16__i_rf_update_shbreaker;
reg channel17__i_rf_update_shbreaker;
reg channel18__i_rf_update_shbreaker;
reg channel19__i_rf_update_shbreaker;

reg [4-1 : 0]channel__i_rf_shbreaker_mode;
reg [64-1 : 0]channel__i_rf_shbreaker_err_mask;
reg [10-1 : 0]channel__i_rf_shbreaker_err_burst;
reg [10-1 : 0]channel__i_rf_shbreaker_err_period;
reg [2-1 : 0]channel__i_rf_shbreaker_err_repeat;

reg channel__i_rf_update_bitskew_base;
reg channel1__i_rf_update_bitskew;
reg channel2__i_rf_update_bitskew;
reg channel3__i_rf_update_bitskew;
reg channel4__i_rf_update_bitskew;
reg channel5__i_rf_update_bitskew;
reg channel6__i_rf_update_bitskew;
reg channel7__i_rf_update_bitskew;
reg channel8__i_rf_update_bitskew;
reg channel9__i_rf_update_bitskew;
reg channel10__i_rf_update_bitskew;
reg channel11__i_rf_update_bitskew;
reg channel12__i_rf_update_bitskew;
reg channel13__i_rf_update_bitskew;
reg channel14__i_rf_update_bitskew;
reg channel15__i_rf_update_bitskew;
reg channel16__i_rf_update_bitskew;
reg channel17__i_rf_update_bitskew;
reg channel18__i_rf_update_bitskew;
reg channel19__i_rf_update_bitskew;

reg [66-1 : 0]channel__i_rf_bit_skew_index;

reg blksync__i_rf_enable;

reg aligner__i_rf_enable;

reg deskew__i_rf_cor_invalid_skew;

reg ptrncheck__i_rf_enable;
reg ptrncheck__i_rf_cor_mismatch_counter;

reg [12-1  : 0] blksync__i_rf_locked_timer_limit;
reg [12-1  : 0] blksync__i_rf_unlocked_timer_limit; 
reg [11-1 : 0] blksync__i_rf_sh_invalid_limit;
reg [3-1      : 0] aligner__i_rf_invalid_am_thr;
reg [5-1      : 0] aligner__i_rf_valid_am_thr;
reg [14-1   : 0]  aligner__i_rf_am_period;
reg [66-1 : 0] aligner__i_rf_am_compare_mask;

reg block_lock__i_rf_cor_sh_lock_base;
reg block_lock1__i_rf_cor_sh_lock;
reg block_lock2__i_rf_cor_sh_lock;
reg block_lock3__i_rf_cor_sh_lock;
reg block_lock4__i_rf_cor_sh_lock;
reg block_lock5__i_rf_cor_sh_lock;
reg block_lock6__i_rf_cor_sh_lock;
reg block_lock7__i_rf_cor_sh_lock;
reg block_lock8__i_rf_cor_sh_lock;
reg block_lock9__i_rf_cor_sh_lock;
reg block_lock10__i_rf_cor_sh_lock;
reg block_lock11__i_rf_cor_sh_lock;
reg block_lock12__i_rf_cor_sh_lock;
reg block_lock13__i_rf_cor_sh_lock;
reg block_lock14__i_rf_cor_sh_lock;
reg block_lock15__i_rf_cor_sh_lock;
reg block_lock16__i_rf_cor_sh_lock;
reg block_lock17__i_rf_cor_sh_lock;
reg block_lock18__i_rf_cor_sh_lock;
reg block_lock19__i_rf_cor_sh_lock;

reg bermonitor__i_rf_cor_hi_ber_base;
reg bermonitor1__i_rf_cor_hi_ber;
reg bermonitor2__i_rf_cor_hi_ber;
reg bermonitor3__i_rf_cor_hi_ber;
reg bermonitor4__i_rf_cor_hi_ber;
reg bermonitor5__i_rf_cor_hi_ber;
reg bermonitor6__i_rf_cor_hi_ber;
reg bermonitor7__i_rf_cor_hi_ber;
reg bermonitor8__i_rf_cor_hi_ber;
reg bermonitor9__i_rf_cor_hi_ber;
reg bermonitor10__i_rf_cor_hi_ber;
reg bermonitor11__i_rf_cor_hi_ber;
reg bermonitor12__i_rf_cor_hi_ber;
reg bermonitor13__i_rf_cor_hi_ber;
reg bermonitor14__i_rf_cor_hi_ber;
reg bermonitor15__i_rf_cor_hi_ber;
reg bermonitor16__i_rf_cor_hi_ber;
reg bermonitor17__i_rf_cor_hi_ber;
reg bermonitor18__i_rf_cor_hi_ber;
reg bermonitor19__i_rf_cor_hi_ber;

reg aligner__i_cor_bip_error_base;
reg aligner1__i_cor_bip_error;
reg aligner2__i_cor_bip_error;
reg aligner3__i_cor_bip_error;
reg aligner4__i_cor_bip_error;
reg aligner5__i_cor_bip_error;
reg aligner6__i_cor_bip_error;
reg aligner7__i_cor_bip_error;
reg aligner8__i_cor_bip_error;
reg aligner9__i_cor_bip_error;
reg aligner10__i_cor_bip_error;
reg aligner11__i_cor_bip_error;
reg aligner12__i_cor_bip_error;
reg aligner13__i_cor_bip_error;
reg aligner14__i_cor_bip_error;
reg aligner15__i_cor_bip_error;
reg aligner16__i_cor_bip_error;
reg aligner17__i_cor_bip_error;
reg aligner18__i_cor_bip_error;
reg aligner19__i_cor_bip_error;

reg aligner__i_cor_resync_counter_base;
reg aligner1__i_cor_resync_counter;
reg aligner2__i_cor_resync_counter;
reg aligner3__i_cor_resync_counter;
reg aligner4__i_cor_resync_counter;
reg aligner5__i_cor_resync_counter;
reg aligner6__i_cor_resync_counter;
reg aligner7__i_cor_resync_counter;
reg aligner8__i_cor_resync_counter;
reg aligner9__i_cor_resync_counter;
reg aligner10__i_cor_resync_counter;
reg aligner11__i_cor_resync_counter;
reg aligner12__i_cor_resync_counter;
reg aligner13__i_cor_resync_counter;
reg aligner14__i_cor_resync_counter;
reg aligner15__i_cor_resync_counter;
reg aligner16__i_cor_resync_counter;
reg aligner17__i_cor_resync_counter;
reg aligner18__i_cor_resync_counter;
reg aligner19__i_cor_resync_counter;

reg aligner__i_cor_am_lock_base;
reg aligner1__i_cor_am_lock;
reg aligner2__i_cor_am_lock;
reg aligner3__i_cor_am_lock;
reg aligner4__i_cor_am_lock;
reg aligner5__i_cor_am_lock;
reg aligner6__i_cor_am_lock;
reg aligner7__i_cor_am_lock;
reg aligner8__i_cor_am_lock;
reg aligner9__i_cor_am_lock;
reg aligner10__i_cor_am_lock;
reg aligner11__i_cor_am_lock;
reg aligner12__i_cor_am_lock;
reg aligner13__i_cor_am_lock;
reg aligner14__i_cor_am_lock;
reg aligner15__i_cor_am_lock;
reg aligner16__i_cor_am_lock;
reg aligner17__i_cor_am_lock;
reg aligner18__i_cor_am_lock;
reg aligner19__i_cor_am_lock;

reg aligner__i_cor_lanes_id_base;
reg aligner1__i_cor_lanes_id;
reg aligner2__i_cor_lanes_id;
reg aligner3__i_cor_lanes_id;
reg aligner4__i_cor_lanes_id;
reg aligner5__i_cor_lanes_id;
reg aligner6__i_cor_lanes_id;
reg aligner7__i_cor_lanes_id;
reg aligner8__i_cor_lanes_id;
reg aligner9__i_cor_lanes_id;
reg aligner10__i_cor_lanes_id;
reg aligner11__i_cor_lanes_id;
reg aligner12__i_cor_lanes_id;
reg aligner13__i_cor_lanes_id;
reg aligner14__i_cor_lanes_id;
reg aligner15__i_cor_lanes_id;
reg aligner16__i_cor_lanes_id;
reg aligner17__i_cor_lanes_id;
reg aligner18__i_cor_lanes_id;
reg aligner19__i_cor_lanes_id;


