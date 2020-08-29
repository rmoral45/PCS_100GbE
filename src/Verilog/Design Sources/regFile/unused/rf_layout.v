
PCS_CONTROL {padd,reset,loopback,testpatt[2],enable}
PCS_STATUS  {padd, status[4]}
PCS_HIBER   {padd[12],lane_x_hi[20]}
PCS_BLOCK   {padd[12],lane_x_lock[20]}
PCS_ALIGN   {padd[12],lane_x_align[20]}
PCS_BERCNT  {padd[12],bercntX}
.
.
. x20

PCS_BER_COMMON {padd[5],bersum[27]}
PCS_ERR_BLOCK  {errcounter[32]}
PCS_TST_PATERR {pad[16],counter[16]}
/*ver si es mas facil acomodarlas de la 19 -> 0 o de 0 ->19 para cuando se lea desde C*/
PCS_LANEMAP_A  {pad[3],laneID[19],pad[3],laneID[18],pad[3],laneID[17],pad[3],laneID[16]}
PCS_LANEMAP_B  {pad[3],laneID[15],pad[3],laneID[14],pad[3],laneID[13],pad[3],laneID[12]}
PCS_LANEMAP_C  {pad[3],laneID[11],pad[3],laneID[10],pad[3],laneID[9], pad[3],laneID[8]}
PCS_LANEMAP_D  {pad[3],laneID[7], pad[3],laneID[6], pad[3],laneID[5], pad[3],laneID[4]}
PCS_LANEMAP_E  {pad[3],laneID[3],pad[3], laneID[2], pad[3],laneID[1],pad[3] ,laneID[0]}

PCS_BIPERR_0   {lane_X_biperr[32]}
.
.
. x20

FCHK_
FCHK_
FCHK_

/* agregar ops de reset de contadores y modulos individuales ??? */

CHNL_UPDATE_SET         {pad[2],20}
CHNL_START_BREAK_SEQ    {pad[2],20}

CHNL_SHMODE             {mode[4]}
CHNL_SH_BURST           {22}
CHNL_SH_PERIOD          {22}
CHNL_SH_REPEAT          {pad[12],10}



