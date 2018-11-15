// Shift Leds

`define N_LEDS 4
`define NB_SEL 2
`define NB_COUNT 32
`define NB_SW 4

module shiftleds(
                 o_led  ,
                 o_led_b,
                 o_led_g,
                 i_sw   ,
                 ck_rst ,
                 CLK100MHZ
                 );

   // Parameters
   parameter N_LEDS    = `N_LEDS               ;
   parameter NB_SEL    = `NB_SEL               ;
   parameter NB_COUNT  = `NB_COUNT             ;
   parameter NB_SW     = `NB_SW                ;

   // Localparam
   localparam R0       = (2**(`NB_COUNT-10))-1 ;
   localparam R1       = (2**(`NB_COUNT-9))-1  ;
   localparam R2       = (2**(`NB_COUNT-8))-1  ;
   localparam R3       = (2**(`NB_COUNT-7))-1  ;

   localparam SEL0     = `NB_SEL'h0            ;
   localparam SEL1     = `NB_SEL'h1            ;
   localparam SEL2     = `NB_SEL'h2            ;
   localparam SEL3     = `NB_SEL'h3            ;

   // Ports
   output [N_LEDS - 1 : 0] o_led    ;
   output [N_LEDS - 1 : 0] o_led_b  ;
   output [N_LEDS - 1 : 0] o_led_g  ;
   input [NB_SW   - 1 : 0] i_sw     ;
   input                   CLK100MHZ;
   input                   ck_rst   ;

   // Vars
   wire                    clock     ;
   wire [NB_COUNT - 1 : 0] ref_limit ;
   reg [NB_COUNT  - 1 : 0] counter   ;
   reg [N_LEDS    - 1 : 0] shiftreg  ;
   wire                    init      ;
   wire                    reset     ;

   assign clock = CLK100MHZ;
   assign reset =  ~ck_rst;
   assign init      =  i_sw[0];
   assign ref_limit = (i_sw[(NB_SW-1)-1 -: NB_SEL]==SEL0) ? R0 :
                      (i_sw[(NB_SW-1)-1 -: NB_SEL]==SEL1) ? R1 :
                      (i_sw[(NB_SW-1)-1 -: NB_SEL]==SEL2) ? R2 : R3;

   always@(posedge clock or posedge reset) begin
      if(reset) begin
         counter  <= {NB_COUNT{1'b0}};
         shiftreg <= {{N_LEDS-1{1'b0}},{1'b1}};
      end
      else if(init) begin
         if(counter>=ref_limit)begin
            counter  <= {NB_COUNT{1'b0}};
            shiftreg <= {shiftreg[N_LEDS-2 -: N_LEDS-1],shiftreg[N_LEDS-1]};
         end
         else begin
            counter  <= counter + {{NB_COUNT-1{1'b0}},{1'b1}};
            shiftreg <= shiftreg;
         end
      end
      else begin
         counter  <= counter;
         shiftreg <= shiftreg;
         
      end // if (init)
   end // always@ (posedge clock or posedge reset)

   assign o_led   = shiftreg;
   assign o_led_b = (i_sw[3]==1'b0) ? shiftreg : {N_LEDS{1'b0}};
   assign o_led_g = (i_sw[3]==1'b1) ? shiftreg : {N_LEDS{1'b0}};

endmodule // shiftleds
