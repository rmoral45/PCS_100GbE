-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Fri Dec  7 10:58:56 2018
-- Host        : Kyrie running 64-bit Ubuntu 16.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /media/ramiro/1C3A84E93A84C16E/Fundacion/PPS/src/Verilog/Verification/MicroGPIO/MicroGPIO/MicroGPIO/ip/MicroGPIO_axi_gpio_0_0/MicroGPIO_axi_gpio_0_0_sim_netlist.vhdl
-- Design      : MicroGPIO_axi_gpio_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_address_decoder is
  port (
    \MEM_DECODE_GEN[0].cs_out_i_reg[0]_0\ : out STD_LOGIC;
    p_75_in : out STD_LOGIC;
    p_73_in : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \Not_Dual.gpio_Data_Out_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Q : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    \bus2ip_addr_i_reg[8]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    bus2ip_rnw_i_reg : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    GPIO_xferAck_i : in STD_LOGIC;
    gpio_xferAck_Reg : in STD_LOGIC;
    ip2bus_rdack_i_D1 : in STD_LOGIC;
    is_read_reg : in STD_LOGIC;
    \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ip2bus_wrack_i_D1 : in STD_LOGIC;
    is_write_reg : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_address_decoder : entity is "address_decoder";
end MicroGPIO_axi_gpio_0_0_address_decoder;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_address_decoder is
  signal Bus_RNW_reg : STD_LOGIC;
  signal Bus_RNW_reg_i_1_n_0 : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\ : STD_LOGIC;
  signal \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \^mem_decode_gen[0].cs_out_i_reg[0]_0\ : STD_LOGIC;
  signal ce_expnd_i_0 : STD_LOGIC;
  signal ce_expnd_i_1 : STD_LOGIC;
  signal ce_expnd_i_2 : STD_LOGIC;
  signal ce_expnd_i_3 : STD_LOGIC;
  signal cs_ce_clr : STD_LOGIC;
  signal \ip2bus_data_i_D1[0]_i_2_n_0\ : STD_LOGIC;
  signal \ip2bus_data_i_D1[0]_i_3_n_0\ : STD_LOGIC;
  signal \ip2bus_data_i_D1[0]_i_4_n_0\ : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \GEN_BKEND_CE_REGISTERS[1].ce_out_i[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \GEN_BKEND_CE_REGISTERS[2].ce_out_i[2]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \GEN_BKEND_CE_REGISTERS[3].ce_out_i[3]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_3\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_4\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \Not_Dual.gpio_Data_Out[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \Not_Dual.gpio_OE[0]_i_1\ : label is "soft_lutpair0";
begin
  \MEM_DECODE_GEN[0].cs_out_i_reg[0]_0\ <= \^mem_decode_gen[0].cs_out_i_reg[0]_0\;
  s_axi_arready <= \^s_axi_arready\;
  s_axi_wready <= \^s_axi_wready\;
Bus_RNW_reg_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => bus2ip_rnw_i_reg,
      I1 => Q,
      I2 => Bus_RNW_reg,
      O => Bus_RNW_reg_i_1_n_0
    );
Bus_RNW_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => Bus_RNW_reg_i_1_n_0,
      Q => Bus_RNW_reg,
      R => '0'
    );
\GEN_BKEND_CE_REGISTERS[0].ce_out_i[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(0),
      I1 => \bus2ip_addr_i_reg[8]\(1),
      O => ce_expnd_i_3
    );
\GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_3,
      Q => \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[1].ce_out_i[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(0),
      I1 => \bus2ip_addr_i_reg[8]\(1),
      O => ce_expnd_i_2
    );
\GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_2,
      Q => \GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[2].ce_out_i[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(1),
      I1 => \bus2ip_addr_i_reg[8]\(0),
      O => ce_expnd_i_1
    );
\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_1,
      Q => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[3].ce_out_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => \^s_axi_arready\,
      I2 => s_axi_aresetn,
      O => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[3].ce_out_i[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(1),
      I1 => \bus2ip_addr_i_reg[8]\(0),
      O => ce_expnd_i_0
    );
\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_0,
      Q => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      R => cs_ce_clr
    );
\MEM_DECODE_GEN[0].cs_out_i[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000E0"
    )
        port map (
      I0 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      I1 => Q,
      I2 => s_axi_aresetn,
      I3 => \^s_axi_arready\,
      I4 => \^s_axi_wready\,
      O => \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\
    );
\MEM_DECODE_GEN[0].cs_out_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\,
      Q => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      R => '0'
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FDFF"
    )
        port map (
      I0 => bus2ip_rnw_i_reg,
      I1 => GPIO_xferAck_i,
      I2 => gpio_xferAck_Reg,
      I3 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(2),
      I1 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      I2 => \bus2ip_addr_i_reg[8]\(1),
      I3 => \bus2ip_addr_i_reg[8]\(0),
      O => p_73_in
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \bus2ip_addr_i_reg[8]\(2),
      I1 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      I2 => \bus2ip_addr_i_reg[8]\(0),
      I3 => \bus2ip_addr_i_reg[8]\(1),
      O => p_75_in
    );
\Not_Dual.gpio_Data_Out[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => bus2ip_rnw_i_reg,
      I1 => \bus2ip_addr_i_reg[8]\(2),
      I2 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      I3 => \bus2ip_addr_i_reg[8]\(0),
      I4 => \bus2ip_addr_i_reg[8]\(1),
      O => \Not_Dual.gpio_Data_Out_reg[0]\(0)
    );
\Not_Dual.gpio_OE[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00100000"
    )
        port map (
      I0 => bus2ip_rnw_i_reg,
      I1 => \bus2ip_addr_i_reg[8]\(2),
      I2 => \^mem_decode_gen[0].cs_out_i_reg[0]_0\,
      I3 => \bus2ip_addr_i_reg[8]\(1),
      I4 => \bus2ip_addr_i_reg[8]\(0),
      O => E(0)
    );
\ip2bus_data_i_D1[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(31)
    );
\ip2bus_data_i_D1[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000400"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      O => \ip2bus_data_i_D1[0]_i_2_n_0\
    );
\ip2bus_data_i_D1[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00040000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg\,
      O => \ip2bus_data_i_D1[0]_i_3_n_0\
    );
\ip2bus_data_i_D1[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000400"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[1].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[0].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      O => \ip2bus_data_i_D1[0]_i_4_n_0\
    );
\ip2bus_data_i_D1[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(21)
    );
\ip2bus_data_i_D1[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(20)
    );
\ip2bus_data_i_D1[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(19)
    );
\ip2bus_data_i_D1[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(18)
    );
\ip2bus_data_i_D1[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(17)
    );
\ip2bus_data_i_D1[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(16)
    );
\ip2bus_data_i_D1[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(15)
    );
\ip2bus_data_i_D1[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(14)
    );
\ip2bus_data_i_D1[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(13)
    );
\ip2bus_data_i_D1[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(12)
    );
\ip2bus_data_i_D1[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(30)
    );
\ip2bus_data_i_D1[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(11)
    );
\ip2bus_data_i_D1[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(10)
    );
\ip2bus_data_i_D1[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(9)
    );
\ip2bus_data_i_D1[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(8)
    );
\ip2bus_data_i_D1[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(7)
    );
\ip2bus_data_i_D1[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(6)
    );
\ip2bus_data_i_D1[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(5)
    );
\ip2bus_data_i_D1[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(4)
    );
\ip2bus_data_i_D1[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(3)
    );
\ip2bus_data_i_D1[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(2)
    );
\ip2bus_data_i_D1[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(29)
    );
\ip2bus_data_i_D1[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(1)
    );
\ip2bus_data_i_D1[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(0)
    );
\ip2bus_data_i_D1[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(28)
    );
\ip2bus_data_i_D1[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(27)
    );
\ip2bus_data_i_D1[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(26)
    );
\ip2bus_data_i_D1[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(25)
    );
\ip2bus_data_i_D1[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(24)
    );
\ip2bus_data_i_D1[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(23)
    );
\ip2bus_data_i_D1[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEAEAEA"
    )
        port map (
      I0 => \ip2bus_data_i_D1[0]_i_2_n_0\,
      I1 => \ip2bus_data_i_D1[0]_i_3_n_0\,
      I2 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      I3 => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\,
      I4 => \ip2bus_data_i_D1[0]_i_4_n_0\,
      O => D(22)
    );
s_axi_arready_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAEAAAA"
    )
        port map (
      I0 => ip2bus_rdack_i_D1,
      I1 => is_read_reg,
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(2),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(1),
      I4 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(3),
      I5 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(0),
      O => \^s_axi_arready\
    );
s_axi_wready_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAAAAEAAAA"
    )
        port map (
      I0 => ip2bus_wrack_i_D1,
      I1 => is_write_reg,
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(2),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(1),
      I4 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(3),
      I5 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(0),
      O => \^s_axi_wready\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_cdc_sync is
  port (
    scndry_vect_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_cdc_sync : entity is "cdc_sync";
end MicroGPIO_axi_gpio_0_0_cdc_sync;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_cdc_sync is
  signal s_level_out_bus_d1_cdc_to_0 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_1 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_10 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_11 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_12 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_13 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_14 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_15 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_16 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_17 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_18 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_19 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_2 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_20 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_21 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_22 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_23 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_24 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_25 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_26 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_27 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_28 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_29 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_3 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_30 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_31 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_4 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_5 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_6 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_7 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_8 : STD_LOGIC;
  signal s_level_out_bus_d1_cdc_to_9 : STD_LOGIC;
  signal s_level_out_bus_d2_0 : STD_LOGIC;
  signal s_level_out_bus_d2_1 : STD_LOGIC;
  signal s_level_out_bus_d2_10 : STD_LOGIC;
  signal s_level_out_bus_d2_11 : STD_LOGIC;
  signal s_level_out_bus_d2_12 : STD_LOGIC;
  signal s_level_out_bus_d2_13 : STD_LOGIC;
  signal s_level_out_bus_d2_14 : STD_LOGIC;
  signal s_level_out_bus_d2_15 : STD_LOGIC;
  signal s_level_out_bus_d2_16 : STD_LOGIC;
  signal s_level_out_bus_d2_17 : STD_LOGIC;
  signal s_level_out_bus_d2_18 : STD_LOGIC;
  signal s_level_out_bus_d2_19 : STD_LOGIC;
  signal s_level_out_bus_d2_2 : STD_LOGIC;
  signal s_level_out_bus_d2_20 : STD_LOGIC;
  signal s_level_out_bus_d2_21 : STD_LOGIC;
  signal s_level_out_bus_d2_22 : STD_LOGIC;
  signal s_level_out_bus_d2_23 : STD_LOGIC;
  signal s_level_out_bus_d2_24 : STD_LOGIC;
  signal s_level_out_bus_d2_25 : STD_LOGIC;
  signal s_level_out_bus_d2_26 : STD_LOGIC;
  signal s_level_out_bus_d2_27 : STD_LOGIC;
  signal s_level_out_bus_d2_28 : STD_LOGIC;
  signal s_level_out_bus_d2_29 : STD_LOGIC;
  signal s_level_out_bus_d2_3 : STD_LOGIC;
  signal s_level_out_bus_d2_30 : STD_LOGIC;
  signal s_level_out_bus_d2_31 : STD_LOGIC;
  signal s_level_out_bus_d2_4 : STD_LOGIC;
  signal s_level_out_bus_d2_5 : STD_LOGIC;
  signal s_level_out_bus_d2_6 : STD_LOGIC;
  signal s_level_out_bus_d2_7 : STD_LOGIC;
  signal s_level_out_bus_d2_8 : STD_LOGIC;
  signal s_level_out_bus_d2_9 : STD_LOGIC;
  signal s_level_out_bus_d3_0 : STD_LOGIC;
  signal s_level_out_bus_d3_1 : STD_LOGIC;
  signal s_level_out_bus_d3_10 : STD_LOGIC;
  signal s_level_out_bus_d3_11 : STD_LOGIC;
  signal s_level_out_bus_d3_12 : STD_LOGIC;
  signal s_level_out_bus_d3_13 : STD_LOGIC;
  signal s_level_out_bus_d3_14 : STD_LOGIC;
  signal s_level_out_bus_d3_15 : STD_LOGIC;
  signal s_level_out_bus_d3_16 : STD_LOGIC;
  signal s_level_out_bus_d3_17 : STD_LOGIC;
  signal s_level_out_bus_d3_18 : STD_LOGIC;
  signal s_level_out_bus_d3_19 : STD_LOGIC;
  signal s_level_out_bus_d3_2 : STD_LOGIC;
  signal s_level_out_bus_d3_20 : STD_LOGIC;
  signal s_level_out_bus_d3_21 : STD_LOGIC;
  signal s_level_out_bus_d3_22 : STD_LOGIC;
  signal s_level_out_bus_d3_23 : STD_LOGIC;
  signal s_level_out_bus_d3_24 : STD_LOGIC;
  signal s_level_out_bus_d3_25 : STD_LOGIC;
  signal s_level_out_bus_d3_26 : STD_LOGIC;
  signal s_level_out_bus_d3_27 : STD_LOGIC;
  signal s_level_out_bus_d3_28 : STD_LOGIC;
  signal s_level_out_bus_d3_29 : STD_LOGIC;
  signal s_level_out_bus_d3_3 : STD_LOGIC;
  signal s_level_out_bus_d3_30 : STD_LOGIC;
  signal s_level_out_bus_d3_31 : STD_LOGIC;
  signal s_level_out_bus_d3_4 : STD_LOGIC;
  signal s_level_out_bus_d3_5 : STD_LOGIC;
  signal s_level_out_bus_d3_6 : STD_LOGIC;
  signal s_level_out_bus_d3_7 : STD_LOGIC;
  signal s_level_out_bus_d3_8 : STD_LOGIC;
  signal s_level_out_bus_d3_9 : STD_LOGIC;
  attribute ASYNC_REG : boolean;
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type : string;
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[0].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[0].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[0].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[10].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[10].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[10].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[11].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[11].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[11].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[12].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[12].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[12].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[13].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[13].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[13].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[14].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[14].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[14].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[15].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[15].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[15].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[16].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[16].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[16].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[17].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[17].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[17].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[18].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[18].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[18].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[19].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[19].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[19].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[1].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[1].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[1].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[20].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[20].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[20].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[21].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[21].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[21].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[22].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[22].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[22].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[23].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[23].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[23].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[24].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[24].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[24].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[25].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[25].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[25].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[26].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[26].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[26].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[27].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[27].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[27].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[28].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[28].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[28].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[29].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[29].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[29].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[2].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[2].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[2].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[30].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[30].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[30].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[31].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[31].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[31].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[3].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[3].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[3].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[4].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[4].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[4].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[5].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[5].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[5].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[6].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[6].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[6].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[7].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[7].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[7].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[8].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[8].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[8].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
  attribute ASYNC_REG of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[9].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is std.standard.true;
  attribute XILINX_LEGACY_PRIM of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[9].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "FDR";
  attribute box_type of \GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[9].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\ : label is "PRIMITIVE";
begin
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_0,
      Q => s_level_out_bus_d2_0,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_10,
      Q => s_level_out_bus_d2_10,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_11,
      Q => s_level_out_bus_d2_11,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_12,
      Q => s_level_out_bus_d2_12,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_13,
      Q => s_level_out_bus_d2_13,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_14,
      Q => s_level_out_bus_d2_14,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_15,
      Q => s_level_out_bus_d2_15,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_16,
      Q => s_level_out_bus_d2_16,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_17,
      Q => s_level_out_bus_d2_17,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_18,
      Q => s_level_out_bus_d2_18,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_19,
      Q => s_level_out_bus_d2_19,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_1,
      Q => s_level_out_bus_d2_1,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_20,
      Q => s_level_out_bus_d2_20,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_21,
      Q => s_level_out_bus_d2_21,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_22,
      Q => s_level_out_bus_d2_22,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_23,
      Q => s_level_out_bus_d2_23,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_24,
      Q => s_level_out_bus_d2_24,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_25,
      Q => s_level_out_bus_d2_25,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_26,
      Q => s_level_out_bus_d2_26,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_27,
      Q => s_level_out_bus_d2_27,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_28,
      Q => s_level_out_bus_d2_28,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_29,
      Q => s_level_out_bus_d2_29,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_2,
      Q => s_level_out_bus_d2_2,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_30,
      Q => s_level_out_bus_d2_30,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_31,
      Q => s_level_out_bus_d2_31,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_3,
      Q => s_level_out_bus_d2_3,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_4,
      Q => s_level_out_bus_d2_4,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_5,
      Q => s_level_out_bus_d2_5,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_6,
      Q => s_level_out_bus_d2_6,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_7,
      Q => s_level_out_bus_d2_7,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_8,
      Q => s_level_out_bus_d2_8,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d2[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d2\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d1_cdc_to_9,
      Q => s_level_out_bus_d2_9,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_0,
      Q => s_level_out_bus_d3_0,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_10,
      Q => s_level_out_bus_d3_10,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_11,
      Q => s_level_out_bus_d3_11,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_12,
      Q => s_level_out_bus_d3_12,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_13,
      Q => s_level_out_bus_d3_13,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_14,
      Q => s_level_out_bus_d3_14,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_15,
      Q => s_level_out_bus_d3_15,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_16,
      Q => s_level_out_bus_d3_16,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_17,
      Q => s_level_out_bus_d3_17,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_18,
      Q => s_level_out_bus_d3_18,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_19,
      Q => s_level_out_bus_d3_19,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_1,
      Q => s_level_out_bus_d3_1,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_20,
      Q => s_level_out_bus_d3_20,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_21,
      Q => s_level_out_bus_d3_21,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_22,
      Q => s_level_out_bus_d3_22,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_23,
      Q => s_level_out_bus_d3_23,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_24,
      Q => s_level_out_bus_d3_24,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_25,
      Q => s_level_out_bus_d3_25,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_26,
      Q => s_level_out_bus_d3_26,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_27,
      Q => s_level_out_bus_d3_27,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_28,
      Q => s_level_out_bus_d3_28,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_29,
      Q => s_level_out_bus_d3_29,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_2,
      Q => s_level_out_bus_d3_2,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_30,
      Q => s_level_out_bus_d3_30,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_31,
      Q => s_level_out_bus_d3_31,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_3,
      Q => s_level_out_bus_d3_3,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_4,
      Q => s_level_out_bus_d3_4,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_5,
      Q => s_level_out_bus_d3_5,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_6,
      Q => s_level_out_bus_d3_6,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_7,
      Q => s_level_out_bus_d3_7,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_8,
      Q => s_level_out_bus_d3_8,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d3[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d3\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d2_9,
      Q => s_level_out_bus_d3_9,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_0,
      Q => scndry_vect_out(0),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_10,
      Q => scndry_vect_out(10),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_11,
      Q => scndry_vect_out(11),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_12,
      Q => scndry_vect_out(12),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_13,
      Q => scndry_vect_out(13),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_14,
      Q => scndry_vect_out(14),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_15,
      Q => scndry_vect_out(15),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_16,
      Q => scndry_vect_out(16),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_17,
      Q => scndry_vect_out(17),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_18,
      Q => scndry_vect_out(18),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_19,
      Q => scndry_vect_out(19),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_1,
      Q => scndry_vect_out(1),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_20,
      Q => scndry_vect_out(20),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_21,
      Q => scndry_vect_out(21),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_22,
      Q => scndry_vect_out(22),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_23,
      Q => scndry_vect_out(23),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_24,
      Q => scndry_vect_out(24),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_25,
      Q => scndry_vect_out(25),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_26,
      Q => scndry_vect_out(26),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_27,
      Q => scndry_vect_out(27),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_28,
      Q => scndry_vect_out(28),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_29,
      Q => scndry_vect_out(29),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_2,
      Q => scndry_vect_out(2),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_30,
      Q => scndry_vect_out(30),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_31,
      Q => scndry_vect_out(31),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_3,
      Q => scndry_vect_out(3),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_4,
      Q => scndry_vect_out(4),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_5,
      Q => scndry_vect_out(5),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_6,
      Q => scndry_vect_out(6),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_7,
      Q => scndry_vect_out(7),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_8,
      Q => scndry_vect_out(8),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d4[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d4\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_level_out_bus_d3_9,
      Q => scndry_vect_out(9),
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[0].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(0),
      Q => s_level_out_bus_d1_cdc_to_0,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[10].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(10),
      Q => s_level_out_bus_d1_cdc_to_10,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[11].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(11),
      Q => s_level_out_bus_d1_cdc_to_11,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[12].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(12),
      Q => s_level_out_bus_d1_cdc_to_12,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[13].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(13),
      Q => s_level_out_bus_d1_cdc_to_13,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[14].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(14),
      Q => s_level_out_bus_d1_cdc_to_14,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[15].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(15),
      Q => s_level_out_bus_d1_cdc_to_15,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[16].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(16),
      Q => s_level_out_bus_d1_cdc_to_16,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[17].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(17),
      Q => s_level_out_bus_d1_cdc_to_17,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[18].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(18),
      Q => s_level_out_bus_d1_cdc_to_18,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[19].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(19),
      Q => s_level_out_bus_d1_cdc_to_19,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[1].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(1),
      Q => s_level_out_bus_d1_cdc_to_1,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[20].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(20),
      Q => s_level_out_bus_d1_cdc_to_20,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[21].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(21),
      Q => s_level_out_bus_d1_cdc_to_21,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[22].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(22),
      Q => s_level_out_bus_d1_cdc_to_22,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[23].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(23),
      Q => s_level_out_bus_d1_cdc_to_23,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[24].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(24),
      Q => s_level_out_bus_d1_cdc_to_24,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[25].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(25),
      Q => s_level_out_bus_d1_cdc_to_25,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[26].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(26),
      Q => s_level_out_bus_d1_cdc_to_26,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[27].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(27),
      Q => s_level_out_bus_d1_cdc_to_27,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[28].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(28),
      Q => s_level_out_bus_d1_cdc_to_28,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[29].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(29),
      Q => s_level_out_bus_d1_cdc_to_29,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[2].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(2),
      Q => s_level_out_bus_d1_cdc_to_2,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[30].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(30),
      Q => s_level_out_bus_d1_cdc_to_30,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[31].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(31),
      Q => s_level_out_bus_d1_cdc_to_31,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[3].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(3),
      Q => s_level_out_bus_d1_cdc_to_3,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[4].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(4),
      Q => s_level_out_bus_d1_cdc_to_4,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[5].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(5),
      Q => s_level_out_bus_d1_cdc_to_5,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[6].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(6),
      Q => s_level_out_bus_d1_cdc_to_6,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[7].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(7),
      Q => s_level_out_bus_d1_cdc_to_7,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[8].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(8),
      Q => s_level_out_bus_d1_cdc_to_8,
      R => '0'
    );
\GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[9].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i(9),
      Q => s_level_out_bus_d1_cdc_to_9,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_GPIO_Core is
  port (
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ : out STD_LOGIC;
    GPIO_xferAck_i : out STD_LOGIC;
    gpio_xferAck_Reg : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ : out STD_LOGIC;
    gpio_io_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_t : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ip2bus_wrack_i : out STD_LOGIC;
    ip2bus_rdack_i : out STD_LOGIC;
    bus2ip_rnw_i_reg : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    p_73_in : in STD_LOGIC;
    p_75_in : in STD_LOGIC;
    bus2ip_rnw : in STD_LOGIC;
    bus2ip_cs : in STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    bus2ip_rnw_i_reg_0 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_GPIO_Core : entity is "GPIO_Core";
end MicroGPIO_axi_gpio_0_0_GPIO_Core;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_GPIO_Core is
  signal \^gpio_xferack_i\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1[0]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2[0]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1[10]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2[10]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[10].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1[11]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2[11]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[11].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1[12]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2[12]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[12].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1[13]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2[13]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[13].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1[14]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2[14]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[14].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1[15]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2[15]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[15].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1[16]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2[16]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[16].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1[17]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2[17]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[17].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1[18]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2[18]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[18].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1[19]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2[19]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[19].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1[1]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2[1]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[1].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1[20]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2[20]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[20].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1[21]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2[21]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[21].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1[22]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2[22]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[22].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1[23]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2[23]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[23].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1[24]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2[24]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[24].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1[25]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2[25]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[25].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1[26]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2[26]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[26].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1[27]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2[27]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[27].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1[28]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2[28]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[28].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1[29]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2[29]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[29].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1[2]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2[2]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[2].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1[30]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2[30]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[30].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_2_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2[31]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[31].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1[3]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2[3]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[3].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1[4]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2[4]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[4].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1[5]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2[5]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[5].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1[6]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2[6]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[6].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1[7]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2[7]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[7].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1[8]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2[8]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[8].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1[9]_i_1_n_0\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2[9]_i_1_n_0\ : STD_LOGIC;
  signal \^not_dual.allout0_nd.read_reg_gen[9].reg2_reg\ : STD_LOGIC;
  signal gpio_Data_In : STD_LOGIC_VECTOR ( 0 to 31 );
  signal gpio_io_i_d2 : STD_LOGIC_VECTOR ( 0 to 31 );
  signal \^gpio_io_o\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^gpio_io_t\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^gpio_xferack_reg\ : STD_LOGIC;
  signal iGPIO_xferAck : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of iGPIO_xferAck_i_1 : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of ip2bus_wrack_i_D1_i_1 : label is "soft_lutpair8";
begin
  GPIO_xferAck_i <= \^gpio_xferack_i\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[10].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[11].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[12].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[13].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[14].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[15].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[16].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[17].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[18].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[19].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[1].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[20].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[21].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[22].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[23].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[24].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[25].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[26].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[27].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[28].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[29].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[2].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[30].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[31].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[3].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[4].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[5].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[6].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[7].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[8].reg2_reg\;
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ <= \^not_dual.allout0_nd.read_reg_gen[9].reg2_reg\;
  gpio_io_o(31 downto 0) <= \^gpio_io_o\(31 downto 0);
  gpio_io_t(31 downto 0) <= \^gpio_io_t\(31 downto 0);
  gpio_xferAck_Reg <= \^gpio_xferack_reg\;
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(31),
      I1 => \^gpio_io_t\(31),
      I2 => p_73_in,
      I3 => gpio_Data_In(0),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1[0]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1[0]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg\,
      I1 => \^gpio_io_t\(31),
      I2 => p_73_in,
      I3 => gpio_Data_In(0),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2[0]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2[0]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(21),
      I1 => \^gpio_io_t\(21),
      I2 => p_73_in,
      I3 => gpio_Data_In(10),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1[10]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1[10]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[10].reg2_reg\,
      I1 => \^gpio_io_t\(21),
      I2 => p_73_in,
      I3 => gpio_Data_In(10),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2[10]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2[10]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[10].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(20),
      I1 => \^gpio_io_t\(20),
      I2 => p_73_in,
      I3 => gpio_Data_In(11),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1[11]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1[11]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[11].reg2_reg\,
      I1 => \^gpio_io_t\(20),
      I2 => p_73_in,
      I3 => gpio_Data_In(11),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2[11]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2[11]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[11].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(19),
      I1 => \^gpio_io_t\(19),
      I2 => p_73_in,
      I3 => gpio_Data_In(12),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1[12]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1[12]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[12].reg2_reg\,
      I1 => \^gpio_io_t\(19),
      I2 => p_73_in,
      I3 => gpio_Data_In(12),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2[12]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2[12]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[12].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(18),
      I1 => \^gpio_io_t\(18),
      I2 => p_73_in,
      I3 => gpio_Data_In(13),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1[13]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1[13]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[13].reg2_reg\,
      I1 => \^gpio_io_t\(18),
      I2 => p_73_in,
      I3 => gpio_Data_In(13),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2[13]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2[13]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[13].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(17),
      I1 => \^gpio_io_t\(17),
      I2 => p_73_in,
      I3 => gpio_Data_In(14),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1[14]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1[14]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[14].reg2_reg\,
      I1 => \^gpio_io_t\(17),
      I2 => p_73_in,
      I3 => gpio_Data_In(14),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2[14]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2[14]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[14].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(16),
      I1 => \^gpio_io_t\(16),
      I2 => p_73_in,
      I3 => gpio_Data_In(15),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1[15]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1[15]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[15].reg2_reg\,
      I1 => \^gpio_io_t\(16),
      I2 => p_73_in,
      I3 => gpio_Data_In(15),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2[15]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2[15]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[15].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(15),
      I1 => \^gpio_io_t\(15),
      I2 => p_73_in,
      I3 => gpio_Data_In(16),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1[16]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1[16]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[16].reg2_reg\,
      I1 => \^gpio_io_t\(15),
      I2 => p_73_in,
      I3 => gpio_Data_In(16),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2[16]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2[16]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[16].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(14),
      I1 => \^gpio_io_t\(14),
      I2 => p_73_in,
      I3 => gpio_Data_In(17),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1[17]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1[17]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[17].reg2_reg\,
      I1 => \^gpio_io_t\(14),
      I2 => p_73_in,
      I3 => gpio_Data_In(17),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2[17]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2[17]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[17].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(13),
      I1 => \^gpio_io_t\(13),
      I2 => p_73_in,
      I3 => gpio_Data_In(18),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1[18]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1[18]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[18].reg2_reg\,
      I1 => \^gpio_io_t\(13),
      I2 => p_73_in,
      I3 => gpio_Data_In(18),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2[18]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2[18]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[18].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(12),
      I1 => \^gpio_io_t\(12),
      I2 => p_73_in,
      I3 => gpio_Data_In(19),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1[19]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1[19]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[19].reg2_reg\,
      I1 => \^gpio_io_t\(12),
      I2 => p_73_in,
      I3 => gpio_Data_In(19),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2[19]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2[19]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[19].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(30),
      I1 => \^gpio_io_t\(30),
      I2 => p_73_in,
      I3 => gpio_Data_In(1),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1[1]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1[1]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[1].reg2_reg\,
      I1 => \^gpio_io_t\(30),
      I2 => p_73_in,
      I3 => gpio_Data_In(1),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2[1]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2[1]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[1].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(11),
      I1 => \^gpio_io_t\(11),
      I2 => p_73_in,
      I3 => gpio_Data_In(20),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1[20]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1[20]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[20].reg2_reg\,
      I1 => \^gpio_io_t\(11),
      I2 => p_73_in,
      I3 => gpio_Data_In(20),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2[20]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2[20]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[20].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(10),
      I1 => \^gpio_io_t\(10),
      I2 => p_73_in,
      I3 => gpio_Data_In(21),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1[21]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1[21]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[21].reg2_reg\,
      I1 => \^gpio_io_t\(10),
      I2 => p_73_in,
      I3 => gpio_Data_In(21),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2[21]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2[21]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[21].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(9),
      I1 => \^gpio_io_t\(9),
      I2 => p_73_in,
      I3 => gpio_Data_In(22),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1[22]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1[22]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[22].reg2_reg\,
      I1 => \^gpio_io_t\(9),
      I2 => p_73_in,
      I3 => gpio_Data_In(22),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2[22]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2[22]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[22].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(8),
      I1 => \^gpio_io_t\(8),
      I2 => p_73_in,
      I3 => gpio_Data_In(23),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1[23]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1[23]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[23].reg2_reg\,
      I1 => \^gpio_io_t\(8),
      I2 => p_73_in,
      I3 => gpio_Data_In(23),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2[23]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2[23]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[23].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(7),
      I1 => \^gpio_io_t\(7),
      I2 => p_73_in,
      I3 => gpio_Data_In(24),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1[24]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1[24]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[24].reg2_reg\,
      I1 => \^gpio_io_t\(7),
      I2 => p_73_in,
      I3 => gpio_Data_In(24),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2[24]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2[24]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[24].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(6),
      I1 => \^gpio_io_t\(6),
      I2 => p_73_in,
      I3 => gpio_Data_In(25),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1[25]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1[25]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[25].reg2_reg\,
      I1 => \^gpio_io_t\(6),
      I2 => p_73_in,
      I3 => gpio_Data_In(25),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2[25]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2[25]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[25].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(5),
      I1 => \^gpio_io_t\(5),
      I2 => p_73_in,
      I3 => gpio_Data_In(26),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1[26]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1[26]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[26].reg2_reg\,
      I1 => \^gpio_io_t\(5),
      I2 => p_73_in,
      I3 => gpio_Data_In(26),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2[26]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2[26]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[26].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(4),
      I1 => \^gpio_io_t\(4),
      I2 => p_73_in,
      I3 => gpio_Data_In(27),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1[27]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1[27]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[27].reg2_reg\,
      I1 => \^gpio_io_t\(4),
      I2 => p_73_in,
      I3 => gpio_Data_In(27),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2[27]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2[27]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[27].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(3),
      I1 => \^gpio_io_t\(3),
      I2 => p_73_in,
      I3 => gpio_Data_In(28),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1[28]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1[28]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[28].reg2_reg\,
      I1 => \^gpio_io_t\(3),
      I2 => p_73_in,
      I3 => gpio_Data_In(28),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2[28]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2[28]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[28].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(2),
      I1 => \^gpio_io_t\(2),
      I2 => p_73_in,
      I3 => gpio_Data_In(29),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1[29]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1[29]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[29].reg2_reg\,
      I1 => \^gpio_io_t\(2),
      I2 => p_73_in,
      I3 => gpio_Data_In(29),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2[29]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2[29]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[29].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(29),
      I1 => \^gpio_io_t\(29),
      I2 => p_73_in,
      I3 => gpio_Data_In(2),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1[2]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1[2]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[2].reg2_reg\,
      I1 => \^gpio_io_t\(29),
      I2 => p_73_in,
      I3 => gpio_Data_In(2),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2[2]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2[2]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[2].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(1),
      I1 => \^gpio_io_t\(1),
      I2 => p_73_in,
      I3 => gpio_Data_In(30),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1[30]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1[30]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[30].reg2_reg\,
      I1 => \^gpio_io_t\(1),
      I2 => p_73_in,
      I3 => gpio_Data_In(30),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2[30]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2[30]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[30].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(0),
      I1 => \^gpio_io_t\(0),
      I2 => p_73_in,
      I3 => gpio_Data_In(31),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_2_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1[31]_i_2_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[31].reg2_reg\,
      I1 => \^gpio_io_t\(0),
      I2 => p_73_in,
      I3 => gpio_Data_In(31),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2[31]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2[31]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[31].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(28),
      I1 => \^gpio_io_t\(28),
      I2 => p_73_in,
      I3 => gpio_Data_In(3),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1[3]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1[3]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[3].reg2_reg\,
      I1 => \^gpio_io_t\(28),
      I2 => p_73_in,
      I3 => gpio_Data_In(3),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2[3]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2[3]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[3].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(27),
      I1 => \^gpio_io_t\(27),
      I2 => p_73_in,
      I3 => gpio_Data_In(4),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1[4]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1[4]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[4].reg2_reg\,
      I1 => \^gpio_io_t\(27),
      I2 => p_73_in,
      I3 => gpio_Data_In(4),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2[4]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2[4]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[4].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(26),
      I1 => \^gpio_io_t\(26),
      I2 => p_73_in,
      I3 => gpio_Data_In(5),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1[5]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1[5]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[5].reg2_reg\,
      I1 => \^gpio_io_t\(26),
      I2 => p_73_in,
      I3 => gpio_Data_In(5),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2[5]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2[5]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[5].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(25),
      I1 => \^gpio_io_t\(25),
      I2 => p_73_in,
      I3 => gpio_Data_In(6),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1[6]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1[6]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[6].reg2_reg\,
      I1 => \^gpio_io_t\(25),
      I2 => p_73_in,
      I3 => gpio_Data_In(6),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2[6]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2[6]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[6].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(24),
      I1 => \^gpio_io_t\(24),
      I2 => p_73_in,
      I3 => gpio_Data_In(7),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1[7]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1[7]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[7].reg2_reg\,
      I1 => \^gpio_io_t\(24),
      I2 => p_73_in,
      I3 => gpio_Data_In(7),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2[7]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2[7]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[7].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(23),
      I1 => \^gpio_io_t\(23),
      I2 => p_73_in,
      I3 => gpio_Data_In(8),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1[8]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1[8]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[8].reg2_reg\,
      I1 => \^gpio_io_t\(23),
      I2 => p_73_in,
      I3 => gpio_Data_In(8),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2[8]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2[8]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[8].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^gpio_io_o\(22),
      I1 => \^gpio_io_t\(22),
      I2 => p_73_in,
      I3 => gpio_Data_In(9),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1[9]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1[9]_i_1_n_0\,
      Q => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FE02C2C2"
    )
        port map (
      I0 => \^not_dual.allout0_nd.read_reg_gen[9].reg2_reg\,
      I1 => \^gpio_io_t\(22),
      I2 => p_73_in,
      I3 => gpio_Data_In(9),
      I4 => p_75_in,
      O => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2[9]_i_1_n_0\
    );
\Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2[9]_i_1_n_0\,
      Q => \^not_dual.allout0_nd.read_reg_gen[9].reg2_reg\,
      R => bus2ip_rnw_i_reg
    );
\Not_Dual.INPUT_DOUBLE_REGS3\: entity work.MicroGPIO_axi_gpio_0_0_cdc_sync
     port map (
      gpio_io_i(31 downto 0) => gpio_io_i(31 downto 0),
      s_axi_aclk => s_axi_aclk,
      scndry_vect_out(31) => gpio_io_i_d2(0),
      scndry_vect_out(30) => gpio_io_i_d2(1),
      scndry_vect_out(29) => gpio_io_i_d2(2),
      scndry_vect_out(28) => gpio_io_i_d2(3),
      scndry_vect_out(27) => gpio_io_i_d2(4),
      scndry_vect_out(26) => gpio_io_i_d2(5),
      scndry_vect_out(25) => gpio_io_i_d2(6),
      scndry_vect_out(24) => gpio_io_i_d2(7),
      scndry_vect_out(23) => gpio_io_i_d2(8),
      scndry_vect_out(22) => gpio_io_i_d2(9),
      scndry_vect_out(21) => gpio_io_i_d2(10),
      scndry_vect_out(20) => gpio_io_i_d2(11),
      scndry_vect_out(19) => gpio_io_i_d2(12),
      scndry_vect_out(18) => gpio_io_i_d2(13),
      scndry_vect_out(17) => gpio_io_i_d2(14),
      scndry_vect_out(16) => gpio_io_i_d2(15),
      scndry_vect_out(15) => gpio_io_i_d2(16),
      scndry_vect_out(14) => gpio_io_i_d2(17),
      scndry_vect_out(13) => gpio_io_i_d2(18),
      scndry_vect_out(12) => gpio_io_i_d2(19),
      scndry_vect_out(11) => gpio_io_i_d2(20),
      scndry_vect_out(10) => gpio_io_i_d2(21),
      scndry_vect_out(9) => gpio_io_i_d2(22),
      scndry_vect_out(8) => gpio_io_i_d2(23),
      scndry_vect_out(7) => gpio_io_i_d2(24),
      scndry_vect_out(6) => gpio_io_i_d2(25),
      scndry_vect_out(5) => gpio_io_i_d2(26),
      scndry_vect_out(4) => gpio_io_i_d2(27),
      scndry_vect_out(3) => gpio_io_i_d2(28),
      scndry_vect_out(2) => gpio_io_i_d2(29),
      scndry_vect_out(1) => gpio_io_i_d2(30),
      scndry_vect_out(0) => gpio_io_i_d2(31)
    );
\Not_Dual.gpio_Data_In_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(0),
      Q => gpio_Data_In(0),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(10),
      Q => gpio_Data_In(10),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(11),
      Q => gpio_Data_In(11),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(12),
      Q => gpio_Data_In(12),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(13),
      Q => gpio_Data_In(13),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(14),
      Q => gpio_Data_In(14),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(15),
      Q => gpio_Data_In(15),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(16),
      Q => gpio_Data_In(16),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(17),
      Q => gpio_Data_In(17),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(18),
      Q => gpio_Data_In(18),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(19),
      Q => gpio_Data_In(19),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(1),
      Q => gpio_Data_In(1),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(20),
      Q => gpio_Data_In(20),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(21),
      Q => gpio_Data_In(21),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(22),
      Q => gpio_Data_In(22),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(23),
      Q => gpio_Data_In(23),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(24),
      Q => gpio_Data_In(24),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(25),
      Q => gpio_Data_In(25),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(26),
      Q => gpio_Data_In(26),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(27),
      Q => gpio_Data_In(27),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(28),
      Q => gpio_Data_In(28),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(29),
      Q => gpio_Data_In(29),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(2),
      Q => gpio_Data_In(2),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(30),
      Q => gpio_Data_In(30),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(31),
      Q => gpio_Data_In(31),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(3),
      Q => gpio_Data_In(3),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(4),
      Q => gpio_Data_In(4),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(5),
      Q => gpio_Data_In(5),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(6),
      Q => gpio_Data_In(6),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(7),
      Q => gpio_Data_In(7),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(8),
      Q => gpio_Data_In(8),
      R => '0'
    );
\Not_Dual.gpio_Data_In_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => gpio_io_i_d2(9),
      Q => gpio_Data_In(9),
      R => '0'
    );
\Not_Dual.gpio_Data_Out_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(31),
      Q => \^gpio_io_o\(31),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(21),
      Q => \^gpio_io_o\(21),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(20),
      Q => \^gpio_io_o\(20),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(19),
      Q => \^gpio_io_o\(19),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(18),
      Q => \^gpio_io_o\(18),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(17),
      Q => \^gpio_io_o\(17),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(16),
      Q => \^gpio_io_o\(16),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(15),
      Q => \^gpio_io_o\(15),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(14),
      Q => \^gpio_io_o\(14),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(13),
      Q => \^gpio_io_o\(13),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(12),
      Q => \^gpio_io_o\(12),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(30),
      Q => \^gpio_io_o\(30),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(11),
      Q => \^gpio_io_o\(11),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(10),
      Q => \^gpio_io_o\(10),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(9),
      Q => \^gpio_io_o\(9),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(8),
      Q => \^gpio_io_o\(8),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(7),
      Q => \^gpio_io_o\(7),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(6),
      Q => \^gpio_io_o\(6),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(5),
      Q => \^gpio_io_o\(5),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(4),
      Q => \^gpio_io_o\(4),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(3),
      Q => \^gpio_io_o\(3),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(2),
      Q => \^gpio_io_o\(2),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(29),
      Q => \^gpio_io_o\(29),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(1),
      Q => \^gpio_io_o\(1),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(0),
      Q => \^gpio_io_o\(0),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(28),
      Q => \^gpio_io_o\(28),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(27),
      Q => \^gpio_io_o\(27),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(26),
      Q => \^gpio_io_o\(26),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(25),
      Q => \^gpio_io_o\(25),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(24),
      Q => \^gpio_io_o\(24),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(23),
      Q => \^gpio_io_o\(23),
      R => SR(0)
    );
\Not_Dual.gpio_Data_Out_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => bus2ip_rnw_i_reg_0(0),
      D => s_axi_wdata(22),
      Q => \^gpio_io_o\(22),
      R => SR(0)
    );
\Not_Dual.gpio_OE_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(31),
      Q => \^gpio_io_t\(31),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(21),
      Q => \^gpio_io_t\(21),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(20),
      Q => \^gpio_io_t\(20),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(19),
      Q => \^gpio_io_t\(19),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(18),
      Q => \^gpio_io_t\(18),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(17),
      Q => \^gpio_io_t\(17),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(16),
      Q => \^gpio_io_t\(16),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[16]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(15),
      Q => \^gpio_io_t\(15),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[17]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(14),
      Q => \^gpio_io_t\(14),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[18]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(13),
      Q => \^gpio_io_t\(13),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[19]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(12),
      Q => \^gpio_io_t\(12),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[1]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(30),
      Q => \^gpio_io_t\(30),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[20]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(11),
      Q => \^gpio_io_t\(11),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[21]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(10),
      Q => \^gpio_io_t\(10),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[22]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(9),
      Q => \^gpio_io_t\(9),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[23]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(8),
      Q => \^gpio_io_t\(8),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[24]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(7),
      Q => \^gpio_io_t\(7),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[25]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(6),
      Q => \^gpio_io_t\(6),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[26]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(5),
      Q => \^gpio_io_t\(5),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[27]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(4),
      Q => \^gpio_io_t\(4),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[28]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(3),
      Q => \^gpio_io_t\(3),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[29]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(2),
      Q => \^gpio_io_t\(2),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(29),
      Q => \^gpio_io_t\(29),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[30]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(1),
      Q => \^gpio_io_t\(1),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[31]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(0),
      Q => \^gpio_io_t\(0),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[3]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(28),
      Q => \^gpio_io_t\(28),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(27),
      Q => \^gpio_io_t\(27),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(26),
      Q => \^gpio_io_t\(26),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(25),
      Q => \^gpio_io_t\(25),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(24),
      Q => \^gpio_io_t\(24),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(23),
      Q => \^gpio_io_t\(23),
      S => SR(0)
    );
\Not_Dual.gpio_OE_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => s_axi_wdata(22),
      Q => \^gpio_io_t\(22),
      S => SR(0)
    );
gpio_xferAck_Reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \^gpio_xferack_i\,
      Q => \^gpio_xferack_reg\,
      R => SR(0)
    );
iGPIO_xferAck_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^gpio_xferack_reg\,
      I1 => bus2ip_cs,
      I2 => \^gpio_xferack_i\,
      O => iGPIO_xferAck
    );
iGPIO_xferAck_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => iGPIO_xferAck,
      Q => \^gpio_xferack_i\,
      R => SR(0)
    );
ip2bus_rdack_i_D1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \^gpio_xferack_i\,
      I1 => bus2ip_rnw,
      O => ip2bus_rdack_i
    );
ip2bus_wrack_i_D1_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^gpio_xferack_i\,
      I1 => bus2ip_rnw,
      O => ip2bus_wrack_i
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_slave_attachment is
  port (
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    \MEM_DECODE_GEN[0].cs_out_i_reg[0]\ : out STD_LOGIC;
    p_75_in : out STD_LOGIC;
    p_73_in : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \Not_Dual.gpio_Data_Out_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]_0\ : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    GPIO_xferAck_i : in STD_LOGIC;
    gpio_xferAck_Reg : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ : in STD_LOGIC;
    ip2bus_rdack_i_D1 : in STD_LOGIC;
    ip2bus_wrack_i_D1 : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_slave_attachment : entity is "slave_attachment";
end MicroGPIO_axi_gpio_0_0_slave_attachment;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_slave_attachment is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[2]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[0]\ : signal is "yes";
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  attribute RTL_KEEP of \FSM_onehot_state_reg_n_0_[3]\ : signal is "yes";
  signal \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg[0]\ : STD_LOGIC;
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bus2ip_addr : STD_LOGIC_VECTOR ( 0 to 6 );
  signal \bus2ip_addr_i[2]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[3]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[8]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[8]_i_2_n_0\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal is_read_i_1_n_0 : STD_LOGIC;
  signal is_read_reg_n_0 : STD_LOGIC;
  signal is_write_i_1_n_0 : STD_LOGIC;
  signal is_write_i_2_n_0 : STD_LOGIC;
  signal is_write_reg_n_0 : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_5_in : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal rst_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal s_axi_bresp_i : STD_LOGIC;
  attribute RTL_KEEP of s_axi_bresp_i : signal is "yes";
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal s_axi_bvalid_i_i_1_n_0 : STD_LOGIC;
  signal s_axi_rresp_i : STD_LOGIC;
  attribute RTL_KEEP of s_axi_rresp_i : signal is "yes";
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal s_axi_rvalid_i_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  signal start2 : STD_LOGIC;
  signal start2_i_1_n_0 : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \state1__2\ : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[0]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute KEEP : string;
  attribute KEEP of \FSM_onehot_state_reg[0]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[1]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute KEEP of \FSM_onehot_state_reg[1]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[2]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute KEEP of \FSM_onehot_state_reg[2]\ : label is "yes";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[3]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute KEEP of \FSM_onehot_state_reg[3]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[0]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_2\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[8]_i_2\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of start2_i_1 : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \state[1]_i_2\ : label is "soft_lutpair4";
begin
  \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ <= \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg[0]\;
  SR(0) <= \^sr\(0);
  s_axi_arready <= \^s_axi_arready\;
  s_axi_bvalid <= \^s_axi_bvalid\;
  s_axi_rvalid <= \^s_axi_rvalid\;
  s_axi_wready <= \^s_axi_wready\;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF150015001500"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => s_axi_wvalid,
      I2 => s_axi_awvalid,
      I3 => \FSM_onehot_state_reg_n_0_[0]\,
      I4 => \state1__2\,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \^s_axi_arready\,
      I3 => s_axi_rresp_i,
      O => \FSM_onehot_state[1]_i_1_n_0\
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0800FFFF08000800"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => s_axi_awvalid,
      I2 => s_axi_arvalid,
      I3 => \FSM_onehot_state_reg_n_0_[0]\,
      I4 => \^s_axi_wready\,
      I5 => s_axi_bresp_i,
      O => \FSM_onehot_state[2]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888F888FFFFF888"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => s_axi_bresp_i,
      I2 => s_axi_rresp_i,
      I3 => \^s_axi_arready\,
      I4 => \FSM_onehot_state_reg_n_0_[3]\,
      I5 => \state1__2\,
      O => \FSM_onehot_state[3]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => s_axi_bready,
      I1 => \^s_axi_bvalid\,
      I2 => s_axi_rready,
      I3 => \^s_axi_rvalid\,
      O => \state1__2\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[0]\,
      S => \^sr\(0)
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[1]_i_1_n_0\,
      Q => s_axi_rresp_i,
      R => \^sr\(0)
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[2]_i_1_n_0\,
      Q => s_axi_bresp_i,
      R => \^sr\(0)
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[3]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[3]\,
      R => \^sr\(0)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(0),
      O => plusOp(0)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(0),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(1),
      O => plusOp(1)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(0),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(1),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(2),
      O => plusOp(2)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      O => clear
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(1),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(0),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(2),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(3),
      O => plusOp(3)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(0),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(0),
      R => clear
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(1),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(1),
      R => clear
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(2),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(2),
      R => clear
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(3),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(3),
      R => clear
    );
I_DECODER: entity work.MicroGPIO_axi_gpio_0_0_address_decoder
     port map (
      D(31 downto 0) => D(31 downto 0),
      E(0) => E(0),
      GPIO_xferAck_i => GPIO_xferAck_i,
      \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\(3 downto 0) => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg__0\(3 downto 0),
      \MEM_DECODE_GEN[0].cs_out_i_reg[0]_0\ => \MEM_DECODE_GEN[0].cs_out_i_reg[0]\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]_0\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\,
      \Not_Dual.gpio_Data_Out_reg[0]\(0) => \Not_Dual.gpio_Data_Out_reg[0]\(0),
      Q => start2,
      \bus2ip_addr_i_reg[8]\(2) => bus2ip_addr(0),
      \bus2ip_addr_i_reg[8]\(1) => bus2ip_addr(5),
      \bus2ip_addr_i_reg[8]\(0) => bus2ip_addr(6),
      bus2ip_rnw_i_reg => \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg[0]\,
      gpio_xferAck_Reg => gpio_xferAck_Reg,
      ip2bus_rdack_i_D1 => ip2bus_rdack_i_D1,
      ip2bus_wrack_i_D1 => ip2bus_wrack_i_D1,
      is_read_reg => is_read_reg_n_0,
      is_write_reg => is_write_reg_n_0,
      p_73_in => p_73_in,
      p_75_in => p_75_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => \^s_axi_arready\,
      s_axi_wready => \^s_axi_wready\
    );
\bus2ip_addr_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_awaddr(0),
      I2 => s_axi_arvalid,
      O => \bus2ip_addr_i[2]_i_1_n_0\
    );
\bus2ip_addr_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => s_axi_araddr(1),
      I1 => s_axi_awaddr(1),
      I2 => s_axi_arvalid,
      O => \bus2ip_addr_i[3]_i_1_n_0\
    );
\bus2ip_addr_i[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000EA"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => s_axi_awvalid,
      I2 => s_axi_wvalid,
      I3 => state(1),
      I4 => state(0),
      O => \bus2ip_addr_i[8]_i_1_n_0\
    );
\bus2ip_addr_i[8]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_awaddr(2),
      I2 => s_axi_arvalid,
      O => \bus2ip_addr_i[8]_i_2_n_0\
    );
\bus2ip_addr_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[8]_i_1_n_0\,
      D => \bus2ip_addr_i[2]_i_1_n_0\,
      Q => bus2ip_addr(6),
      R => \^sr\(0)
    );
\bus2ip_addr_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[8]_i_1_n_0\,
      D => \bus2ip_addr_i[3]_i_1_n_0\,
      Q => bus2ip_addr(5),
      R => \^sr\(0)
    );
\bus2ip_addr_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[8]_i_1_n_0\,
      D => \bus2ip_addr_i[8]_i_2_n_0\,
      Q => bus2ip_addr(0),
      R => \^sr\(0)
    );
bus2ip_rnw_i_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[8]_i_1_n_0\,
      D => s_axi_arvalid,
      Q => \^not_dual.allout0_nd.read_reg_gen[0].reg2_reg[0]\,
      R => \^sr\(0)
    );
is_read_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8888"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \state1__2\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => is_read_reg_n_0,
      O => is_read_i_1_n_0
    );
is_read_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => is_read_i_1_n_0,
      Q => is_read_reg_n_0,
      R => \^sr\(0)
    );
is_write_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2000FFFF20000000"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => s_axi_arvalid,
      I2 => s_axi_awvalid,
      I3 => s_axi_wvalid,
      I4 => is_write_i_2_n_0,
      I5 => is_write_reg_n_0,
      O => is_write_i_1_n_0
    );
is_write_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEAEAEAAAAAAAAA"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => s_axi_bready,
      I2 => \^s_axi_bvalid\,
      I3 => s_axi_rready,
      I4 => \^s_axi_rvalid\,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => is_write_i_2_n_0
    );
is_write_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => is_write_i_1_n_0,
      Q => is_write_reg_n_0,
      R => \^sr\(0)
    );
rst_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_aresetn,
      O => rst_i_1_n_0
    );
rst_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => rst_i_1_n_0,
      Q => \^sr\(0),
      R => '0'
    );
s_axi_bvalid_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08FF0808"
    )
        port map (
      I0 => \^s_axi_wready\,
      I1 => state(1),
      I2 => state(0),
      I3 => s_axi_bready,
      I4 => \^s_axi_bvalid\,
      O => s_axi_bvalid_i_i_1_n_0
    );
s_axi_bvalid_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_bvalid_i_i_1_n_0,
      Q => \^s_axi_bvalid\,
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(0),
      Q => s_axi_rdata(0),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(10),
      Q => s_axi_rdata(10),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(11),
      Q => s_axi_rdata(11),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(12),
      Q => s_axi_rdata(12),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(13),
      Q => s_axi_rdata(13),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(14),
      Q => s_axi_rdata(14),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(15),
      Q => s_axi_rdata(15),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(16),
      Q => s_axi_rdata(16),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(17),
      Q => s_axi_rdata(17),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(18),
      Q => s_axi_rdata(18),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(19),
      Q => s_axi_rdata(19),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(1),
      Q => s_axi_rdata(1),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(20),
      Q => s_axi_rdata(20),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(21),
      Q => s_axi_rdata(21),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(22),
      Q => s_axi_rdata(22),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(23),
      Q => s_axi_rdata(23),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(24),
      Q => s_axi_rdata(24),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(25),
      Q => s_axi_rdata(25),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(26),
      Q => s_axi_rdata(26),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(27),
      Q => s_axi_rdata(27),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(28),
      Q => s_axi_rdata(28),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(29),
      Q => s_axi_rdata(29),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(2),
      Q => s_axi_rdata(2),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(30),
      Q => s_axi_rdata(30),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(31),
      Q => s_axi_rdata(31),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(3),
      Q => s_axi_rdata(3),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(4),
      Q => s_axi_rdata(4),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(5),
      Q => s_axi_rdata(5),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(6),
      Q => s_axi_rdata(6),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(7),
      Q => s_axi_rdata(7),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(8),
      Q => s_axi_rdata(8),
      R => \^sr\(0)
    );
\s_axi_rdata_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i,
      D => Q(9),
      Q => s_axi_rdata(9),
      R => \^sr\(0)
    );
s_axi_rvalid_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"08FF0808"
    )
        port map (
      I0 => \^s_axi_arready\,
      I1 => state(0),
      I2 => state(1),
      I3 => s_axi_rready,
      I4 => \^s_axi_rvalid\,
      O => s_axi_rvalid_i_i_1_n_0
    );
s_axi_rvalid_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_rvalid_i_i_1_n_0,
      Q => \^s_axi_rvalid\,
      R => \^sr\(0)
    );
start2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000000F8"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_wvalid,
      I2 => s_axi_arvalid,
      I3 => state(1),
      I4 => state(0),
      O => start2_i_1_n_0
    );
start2_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => start2_i_1_n_0,
      Q => start2,
      R => \^sr\(0)
    );
\state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"77FC44FC"
    )
        port map (
      I0 => \state1__2\,
      I1 => state(0),
      I2 => s_axi_arvalid,
      I3 => state(1),
      I4 => \^s_axi_wready\,
      O => p_0_out(0)
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"55FFFF0C5500FF0C"
    )
        port map (
      I0 => \state1__2\,
      I1 => p_5_in,
      I2 => s_axi_arvalid,
      I3 => state(1),
      I4 => state(0),
      I5 => \^s_axi_arready\,
      O => p_0_out(1)
    );
\state[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_wvalid,
      O => p_5_in
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => p_0_out(0),
      Q => state(0),
      R => \^sr\(0)
    );
\state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => p_0_out(1),
      Q => state(1),
      R => \^sr\(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_axi_lite_ipif is
  port (
    bus2ip_reset : out STD_LOGIC;
    bus2ip_rnw : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    bus2ip_cs : out STD_LOGIC;
    p_75_in : out STD_LOGIC;
    p_73_in : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \Not_Dual.gpio_Data_Out_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    GPIO_xferAck_i : in STD_LOGIC;
    gpio_xferAck_Reg : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ : in STD_LOGIC;
    \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ : in STD_LOGIC;
    ip2bus_rdack_i_D1 : in STD_LOGIC;
    ip2bus_wrack_i_D1 : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_axi_lite_ipif : entity is "axi_lite_ipif";
end MicroGPIO_axi_gpio_0_0_axi_lite_ipif;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_axi_lite_ipif is
begin
I_SLAVE_ATTACHMENT: entity work.MicroGPIO_axi_gpio_0_0_slave_attachment
     port map (
      D(31 downto 0) => D(31 downto 0),
      E(0) => E(0),
      GPIO_xferAck_i => GPIO_xferAck_i,
      \MEM_DECODE_GEN[0].cs_out_i_reg[0]\ => bus2ip_cs,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ => bus2ip_rnw,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]_0\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\,
      \Not_Dual.gpio_Data_Out_reg[0]\(0) => \Not_Dual.gpio_Data_Out_reg[0]\(0),
      Q(31 downto 0) => Q(31 downto 0),
      SR(0) => bus2ip_reset,
      gpio_xferAck_Reg => gpio_xferAck_Reg,
      ip2bus_rdack_i_D1 => ip2bus_rdack_i_D1,
      ip2bus_wrack_i_D1 => ip2bus_wrack_i_D1,
      p_73_in => p_73_in,
      p_75_in => p_75_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(2 downto 0) => s_axi_araddr(2 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(2 downto 0) => s_axi_awaddr(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wready => s_axi_wready,
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0_axi_gpio is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_t : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio2_io_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio2_io_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio2_io_t : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute C_ALL_INPUTS : integer;
  attribute C_ALL_INPUTS of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_ALL_INPUTS_2 : integer;
  attribute C_ALL_INPUTS_2 of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_ALL_OUTPUTS : integer;
  attribute C_ALL_OUTPUTS of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_ALL_OUTPUTS_2 : integer;
  attribute C_ALL_OUTPUTS_2 of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_DOUT_DEFAULT : integer;
  attribute C_DOUT_DEFAULT of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_DOUT_DEFAULT_2 : integer;
  attribute C_DOUT_DEFAULT_2 of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is "artix7";
  attribute C_GPIO2_WIDTH : integer;
  attribute C_GPIO2_WIDTH of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 32;
  attribute C_GPIO_WIDTH : integer;
  attribute C_GPIO_WIDTH of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 32;
  attribute C_INTERRUPT_PRESENT : integer;
  attribute C_INTERRUPT_PRESENT of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_IS_DUAL : integer;
  attribute C_IS_DUAL of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 0;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 9;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is 32;
  attribute C_TRI_DEFAULT : integer;
  attribute C_TRI_DEFAULT of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is -1;
  attribute C_TRI_DEFAULT_2 : integer;
  attribute C_TRI_DEFAULT_2 of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is -1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is "axi_gpio";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is "yes";
  attribute ip_group : string;
  attribute ip_group of MicroGPIO_axi_gpio_0_0_axi_gpio : entity is "LOGICORE";
end MicroGPIO_axi_gpio_0_0_axi_gpio;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0_axi_gpio is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal AXI_LITE_IPIF_I_n_11 : STD_LOGIC;
  signal AXI_LITE_IPIF_I_n_7 : STD_LOGIC;
  signal AXI_LITE_IPIF_I_n_8 : STD_LOGIC;
  signal GPIO_xferAck_i : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ : STD_LOGIC;
  signal \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ : STD_LOGIC;
  signal bus2ip_cs : STD_LOGIC;
  signal bus2ip_reset : STD_LOGIC;
  signal bus2ip_rnw : STD_LOGIC;
  signal gpio_xferAck_Reg : STD_LOGIC;
  signal ip2bus_data : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ip2bus_data_i_D1 : STD_LOGIC_VECTOR ( 0 to 31 );
  signal ip2bus_rdack_i : STD_LOGIC;
  signal ip2bus_rdack_i_D1 : STD_LOGIC;
  signal ip2bus_wrack_i : STD_LOGIC;
  signal ip2bus_wrack_i_D1 : STD_LOGIC;
  signal p_73_in : STD_LOGIC;
  signal p_75_in : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  attribute sigis : string;
  attribute sigis of ip2intc_irpt : signal is "INTR_LEVEL_HIGH";
  attribute max_fanout : string;
  attribute max_fanout of s_axi_aclk : signal is "10000";
  attribute sigis of s_axi_aclk : signal is "Clk";
  attribute max_fanout of s_axi_aresetn : signal is "10000";
  attribute sigis of s_axi_aresetn : signal is "Rst";
begin
  gpio2_io_o(31) <= \<const0>\;
  gpio2_io_o(30) <= \<const0>\;
  gpio2_io_o(29) <= \<const0>\;
  gpio2_io_o(28) <= \<const0>\;
  gpio2_io_o(27) <= \<const0>\;
  gpio2_io_o(26) <= \<const0>\;
  gpio2_io_o(25) <= \<const0>\;
  gpio2_io_o(24) <= \<const0>\;
  gpio2_io_o(23) <= \<const0>\;
  gpio2_io_o(22) <= \<const0>\;
  gpio2_io_o(21) <= \<const0>\;
  gpio2_io_o(20) <= \<const0>\;
  gpio2_io_o(19) <= \<const0>\;
  gpio2_io_o(18) <= \<const0>\;
  gpio2_io_o(17) <= \<const0>\;
  gpio2_io_o(16) <= \<const0>\;
  gpio2_io_o(15) <= \<const0>\;
  gpio2_io_o(14) <= \<const0>\;
  gpio2_io_o(13) <= \<const0>\;
  gpio2_io_o(12) <= \<const0>\;
  gpio2_io_o(11) <= \<const0>\;
  gpio2_io_o(10) <= \<const0>\;
  gpio2_io_o(9) <= \<const0>\;
  gpio2_io_o(8) <= \<const0>\;
  gpio2_io_o(7) <= \<const0>\;
  gpio2_io_o(6) <= \<const0>\;
  gpio2_io_o(5) <= \<const0>\;
  gpio2_io_o(4) <= \<const0>\;
  gpio2_io_o(3) <= \<const0>\;
  gpio2_io_o(2) <= \<const0>\;
  gpio2_io_o(1) <= \<const0>\;
  gpio2_io_o(0) <= \<const0>\;
  gpio2_io_t(31) <= \<const1>\;
  gpio2_io_t(30) <= \<const1>\;
  gpio2_io_t(29) <= \<const1>\;
  gpio2_io_t(28) <= \<const1>\;
  gpio2_io_t(27) <= \<const1>\;
  gpio2_io_t(26) <= \<const1>\;
  gpio2_io_t(25) <= \<const1>\;
  gpio2_io_t(24) <= \<const1>\;
  gpio2_io_t(23) <= \<const1>\;
  gpio2_io_t(22) <= \<const1>\;
  gpio2_io_t(21) <= \<const1>\;
  gpio2_io_t(20) <= \<const1>\;
  gpio2_io_t(19) <= \<const1>\;
  gpio2_io_t(18) <= \<const1>\;
  gpio2_io_t(17) <= \<const1>\;
  gpio2_io_t(16) <= \<const1>\;
  gpio2_io_t(15) <= \<const1>\;
  gpio2_io_t(14) <= \<const1>\;
  gpio2_io_t(13) <= \<const1>\;
  gpio2_io_t(12) <= \<const1>\;
  gpio2_io_t(11) <= \<const1>\;
  gpio2_io_t(10) <= \<const1>\;
  gpio2_io_t(9) <= \<const1>\;
  gpio2_io_t(8) <= \<const1>\;
  gpio2_io_t(7) <= \<const1>\;
  gpio2_io_t(6) <= \<const1>\;
  gpio2_io_t(5) <= \<const1>\;
  gpio2_io_t(4) <= \<const1>\;
  gpio2_io_t(3) <= \<const1>\;
  gpio2_io_t(2) <= \<const1>\;
  gpio2_io_t(1) <= \<const1>\;
  gpio2_io_t(0) <= \<const1>\;
  ip2intc_irpt <= \<const0>\;
  s_axi_awready <= \^s_axi_wready\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_wready <= \^s_axi_wready\;
AXI_LITE_IPIF_I: entity work.MicroGPIO_axi_gpio_0_0_axi_lite_ipif
     port map (
      D(31) => ip2bus_data(0),
      D(30) => ip2bus_data(1),
      D(29) => ip2bus_data(2),
      D(28) => ip2bus_data(3),
      D(27) => ip2bus_data(4),
      D(26) => ip2bus_data(5),
      D(25) => ip2bus_data(6),
      D(24) => ip2bus_data(7),
      D(23) => ip2bus_data(8),
      D(22) => ip2bus_data(9),
      D(21) => ip2bus_data(10),
      D(20) => ip2bus_data(11),
      D(19) => ip2bus_data(12),
      D(18) => ip2bus_data(13),
      D(17) => ip2bus_data(14),
      D(16) => ip2bus_data(15),
      D(15) => ip2bus_data(16),
      D(14) => ip2bus_data(17),
      D(13) => ip2bus_data(18),
      D(12) => ip2bus_data(19),
      D(11) => ip2bus_data(20),
      D(10) => ip2bus_data(21),
      D(9) => ip2bus_data(22),
      D(8) => ip2bus_data(23),
      D(7) => ip2bus_data(24),
      D(6) => ip2bus_data(25),
      D(5) => ip2bus_data(26),
      D(4) => ip2bus_data(27),
      D(3) => ip2bus_data(28),
      D(2) => ip2bus_data(29),
      D(1) => ip2bus_data(30),
      D(0) => ip2bus_data(31),
      E(0) => AXI_LITE_IPIF_I_n_7,
      GPIO_xferAck_i => GPIO_xferAck_i,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg[0]\ => AXI_LITE_IPIF_I_n_11,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\,
      \Not_Dual.gpio_Data_Out_reg[0]\(0) => AXI_LITE_IPIF_I_n_8,
      Q(31) => ip2bus_data_i_D1(0),
      Q(30) => ip2bus_data_i_D1(1),
      Q(29) => ip2bus_data_i_D1(2),
      Q(28) => ip2bus_data_i_D1(3),
      Q(27) => ip2bus_data_i_D1(4),
      Q(26) => ip2bus_data_i_D1(5),
      Q(25) => ip2bus_data_i_D1(6),
      Q(24) => ip2bus_data_i_D1(7),
      Q(23) => ip2bus_data_i_D1(8),
      Q(22) => ip2bus_data_i_D1(9),
      Q(21) => ip2bus_data_i_D1(10),
      Q(20) => ip2bus_data_i_D1(11),
      Q(19) => ip2bus_data_i_D1(12),
      Q(18) => ip2bus_data_i_D1(13),
      Q(17) => ip2bus_data_i_D1(14),
      Q(16) => ip2bus_data_i_D1(15),
      Q(15) => ip2bus_data_i_D1(16),
      Q(14) => ip2bus_data_i_D1(17),
      Q(13) => ip2bus_data_i_D1(18),
      Q(12) => ip2bus_data_i_D1(19),
      Q(11) => ip2bus_data_i_D1(20),
      Q(10) => ip2bus_data_i_D1(21),
      Q(9) => ip2bus_data_i_D1(22),
      Q(8) => ip2bus_data_i_D1(23),
      Q(7) => ip2bus_data_i_D1(24),
      Q(6) => ip2bus_data_i_D1(25),
      Q(5) => ip2bus_data_i_D1(26),
      Q(4) => ip2bus_data_i_D1(27),
      Q(3) => ip2bus_data_i_D1(28),
      Q(2) => ip2bus_data_i_D1(29),
      Q(1) => ip2bus_data_i_D1(30),
      Q(0) => ip2bus_data_i_D1(31),
      bus2ip_cs => bus2ip_cs,
      bus2ip_reset => bus2ip_reset,
      bus2ip_rnw => bus2ip_rnw,
      gpio_xferAck_Reg => gpio_xferAck_Reg,
      ip2bus_rdack_i_D1 => ip2bus_rdack_i_D1,
      ip2bus_wrack_i_D1 => ip2bus_wrack_i_D1,
      p_73_in => p_73_in,
      p_75_in => p_75_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(2) => s_axi_araddr(8),
      s_axi_araddr(1 downto 0) => s_axi_araddr(3 downto 2),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(2) => s_axi_awaddr(8),
      s_axi_awaddr(1 downto 0) => s_axi_awaddr(3 downto 2),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wready => \^s_axi_wready\,
      s_axi_wvalid => s_axi_wvalid
    );
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
gpio_core_1: entity work.MicroGPIO_axi_gpio_0_0_GPIO_Core
     port map (
      E(0) => AXI_LITE_IPIF_I_n_7,
      GPIO_xferAck_i => GPIO_xferAck_i,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[0].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[10].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[11].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[12].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[13].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[14].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[15].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[16].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[17].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[18].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[19].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[1].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[20].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[21].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[22].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[23].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[24].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[25].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[26].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[27].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[28].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[29].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[2].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[30].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[31].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[3].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[4].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[5].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[6].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[7].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[8].reg2_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg1_reg\,
      \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\ => \Not_Dual.ALLOUT0_ND.READ_REG_GEN[9].reg2_reg\,
      SR(0) => bus2ip_reset,
      bus2ip_cs => bus2ip_cs,
      bus2ip_rnw => bus2ip_rnw,
      bus2ip_rnw_i_reg => AXI_LITE_IPIF_I_n_11,
      bus2ip_rnw_i_reg_0(0) => AXI_LITE_IPIF_I_n_8,
      gpio_io_i(31 downto 0) => gpio_io_i(31 downto 0),
      gpio_io_o(31 downto 0) => gpio_io_o(31 downto 0),
      gpio_io_t(31 downto 0) => gpio_io_t(31 downto 0),
      gpio_xferAck_Reg => gpio_xferAck_Reg,
      ip2bus_rdack_i => ip2bus_rdack_i,
      ip2bus_wrack_i => ip2bus_wrack_i,
      p_73_in => p_73_in,
      p_75_in => p_75_in,
      s_axi_aclk => s_axi_aclk,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0)
    );
\ip2bus_data_i_D1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(0),
      Q => ip2bus_data_i_D1(0),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(10),
      Q => ip2bus_data_i_D1(10),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(11),
      Q => ip2bus_data_i_D1(11),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(12),
      Q => ip2bus_data_i_D1(12),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(13),
      Q => ip2bus_data_i_D1(13),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(14),
      Q => ip2bus_data_i_D1(14),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(15),
      Q => ip2bus_data_i_D1(15),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(16),
      Q => ip2bus_data_i_D1(16),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(17),
      Q => ip2bus_data_i_D1(17),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(18),
      Q => ip2bus_data_i_D1(18),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(19),
      Q => ip2bus_data_i_D1(19),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(1),
      Q => ip2bus_data_i_D1(1),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(20),
      Q => ip2bus_data_i_D1(20),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(21),
      Q => ip2bus_data_i_D1(21),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(22),
      Q => ip2bus_data_i_D1(22),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(23),
      Q => ip2bus_data_i_D1(23),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(24),
      Q => ip2bus_data_i_D1(24),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(25),
      Q => ip2bus_data_i_D1(25),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(26),
      Q => ip2bus_data_i_D1(26),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(27),
      Q => ip2bus_data_i_D1(27),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(28),
      Q => ip2bus_data_i_D1(28),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(29),
      Q => ip2bus_data_i_D1(29),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(2),
      Q => ip2bus_data_i_D1(2),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(30),
      Q => ip2bus_data_i_D1(30),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(31),
      Q => ip2bus_data_i_D1(31),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(3),
      Q => ip2bus_data_i_D1(3),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(4),
      Q => ip2bus_data_i_D1(4),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(5),
      Q => ip2bus_data_i_D1(5),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(6),
      Q => ip2bus_data_i_D1(6),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(7),
      Q => ip2bus_data_i_D1(7),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(8),
      Q => ip2bus_data_i_D1(8),
      R => bus2ip_reset
    );
\ip2bus_data_i_D1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(9),
      Q => ip2bus_data_i_D1(9),
      R => bus2ip_reset
    );
ip2bus_rdack_i_D1_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_rdack_i,
      Q => ip2bus_rdack_i_D1,
      R => bus2ip_reset
    );
ip2bus_wrack_i_D1_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_wrack_i,
      Q => ip2bus_wrack_i_D1,
      R => bus2ip_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroGPIO_axi_gpio_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gpio_io_t : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of MicroGPIO_axi_gpio_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of MicroGPIO_axi_gpio_0_0 : entity is "MicroGPIO_axi_gpio_0_0,axi_gpio,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of MicroGPIO_axi_gpio_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of MicroGPIO_axi_gpio_0_0 : entity is "axi_gpio,Vivado 2018.2";
end MicroGPIO_axi_gpio_0_0;

architecture STRUCTURE of MicroGPIO_axi_gpio_0_0 is
  signal NLW_U0_ip2intc_irpt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_gpio2_io_o_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_gpio2_io_t_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute C_ALL_INPUTS : integer;
  attribute C_ALL_INPUTS of U0 : label is 0;
  attribute C_ALL_INPUTS_2 : integer;
  attribute C_ALL_INPUTS_2 of U0 : label is 0;
  attribute C_ALL_OUTPUTS : integer;
  attribute C_ALL_OUTPUTS of U0 : label is 0;
  attribute C_ALL_OUTPUTS_2 : integer;
  attribute C_ALL_OUTPUTS_2 of U0 : label is 0;
  attribute C_DOUT_DEFAULT : integer;
  attribute C_DOUT_DEFAULT of U0 : label is 0;
  attribute C_DOUT_DEFAULT_2 : integer;
  attribute C_DOUT_DEFAULT_2 of U0 : label is 0;
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_GPIO2_WIDTH : integer;
  attribute C_GPIO2_WIDTH of U0 : label is 32;
  attribute C_GPIO_WIDTH : integer;
  attribute C_GPIO_WIDTH of U0 : label is 32;
  attribute C_INTERRUPT_PRESENT : integer;
  attribute C_INTERRUPT_PRESENT of U0 : label is 0;
  attribute C_IS_DUAL : integer;
  attribute C_IS_DUAL of U0 : label is 0;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of U0 : label is 9;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of U0 : label is 32;
  attribute C_TRI_DEFAULT : integer;
  attribute C_TRI_DEFAULT of U0 : label is -1;
  attribute C_TRI_DEFAULT_2 : integer;
  attribute C_TRI_DEFAULT_2 of U0 : label is -1;
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
  attribute ip_group : string;
  attribute ip_group of U0 : label is "LOGICORE";
  attribute x_interface_info : string;
  attribute x_interface_info of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of s_axi_aclk : signal is "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET s_axi_aresetn, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1";
  attribute x_interface_info of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST";
  attribute x_interface_parameter of s_axi_aresetn : signal is "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW";
  attribute x_interface_info of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  attribute x_interface_info of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  attribute x_interface_info of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWREADY";
  attribute x_interface_info of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWVALID";
  attribute x_interface_info of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S_AXI BREADY";
  attribute x_interface_info of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI BVALID";
  attribute x_interface_info of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  attribute x_interface_info of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
  attribute x_interface_info of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S_AXI WREADY";
  attribute x_interface_info of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI WVALID";
  attribute x_interface_info of gpio_io_i : signal is "xilinx.com:interface:gpio:1.0 GPIO TRI_I";
  attribute x_interface_parameter of gpio_io_i : signal is "XIL_INTERFACENAME GPIO, BOARD.ASSOCIATED_PARAM GPIO_BOARD_INTERFACE";
  attribute x_interface_info of gpio_io_o : signal is "xilinx.com:interface:gpio:1.0 GPIO TRI_O";
  attribute x_interface_info of gpio_io_t : signal is "xilinx.com:interface:gpio:1.0 GPIO TRI_T";
  attribute x_interface_info of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  attribute x_interface_info of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWADDR";
  attribute x_interface_parameter of s_axi_awaddr : signal is "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 9, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /clk_wiz_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0";
  attribute x_interface_info of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI BRESP";
  attribute x_interface_info of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  attribute x_interface_info of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
  attribute x_interface_info of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI WDATA";
  attribute x_interface_info of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S_AXI WSTRB";
begin
U0: entity work.MicroGPIO_axi_gpio_0_0_axi_gpio
     port map (
      gpio2_io_i(31 downto 0) => B"00000000000000000000000000000000",
      gpio2_io_o(31 downto 0) => NLW_U0_gpio2_io_o_UNCONNECTED(31 downto 0),
      gpio2_io_t(31 downto 0) => NLW_U0_gpio2_io_t_UNCONNECTED(31 downto 0),
      gpio_io_i(31 downto 0) => gpio_io_i(31 downto 0),
      gpio_io_o(31 downto 0) => gpio_io_o(31 downto 0),
      gpio_io_t(31 downto 0) => gpio_io_t(31 downto 0),
      ip2intc_irpt => NLW_U0_ip2intc_irpt_UNCONNECTED,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(8 downto 0) => s_axi_araddr(8 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(8 downto 0) => s_axi_awaddr(8 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1 downto 0) => s_axi_bresp(1 downto 0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
