# XDC constraints for the Xilinx VCU1525 board
# part: xcvu9p-fsgd2104-2L-e

# General configuration
set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-1 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]

# System clocks
# 300 MHz (DDR 0)
#set_property -dict {LOC AY37 IOSTANDARD LVDS} [get_ports clk_300mhz_0_p]
#set_property -dict {LOC AY38 IOSTANDARD LVDS} [get_ports clk_300mhz_0_n]
#create_clock -period 3.333 -name clk_300mhz_0 [get_ports clk_300mhz_0_p]

# 300 MHz (DDR 1)
#set_property -dict {LOC AW20 IOSTANDARD LVDS} [get_ports clk_300mhz_1_p]
#set_property -dict {LOC AW19 IOSTANDARD LVDS} [get_ports clk_300mhz_1_n]
#create_clock -period 3.333 -name clk_300mhz_1 [get_ports clk_300mhz_1_p]

# 300 MHz (DDR 2)
#set_property -dict {LOC F32  IOSTANDARD LVDS} [get_ports clk_300mhz_2_p]
#set_property -dict {LOC E32  IOSTANDARD LVDS} [get_ports clk_300mhz_2_n]
#create_clock -period 3.333 -name clk_300mhz_2 [get_ports clk_300mhz_2_p]

# 300 MHz (DDR 3)
#set_property -dict {LOC J16  IOSTANDARD LVDS} [get_ports clk_300mhz_3_p]
#set_property -dict {LOC H16  IOSTANDARD LVDS} [get_ports clk_300mhz_3_n]
#create_clock -period 3.333 -name clk_300mhz_3 [get_ports clk_300mhz_3_p]

# SI570 user clock
#set_property -dict {LOC AU19 IOSTANDARD LVDS} [get_ports clk_user_p]
#set_property -dict {LOC AV19 IOSTANDARD LVDS} [get_ports clk_user_n]
#create_clock -period 6.400 -name clk_user [get_ports clk_user_p]

# LEDs
set_property -dict {LOC BC21 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[0]}]
set_property -dict {LOC BB21 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[1]}]
set_property -dict {LOC BA20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[2]}]

# Reset button
#set_property -dict {LOC AL20 IOSTANDARD LVCMOS12} [get_ports reset]

# DIP switches
set_property -dict {LOC AN22 IOSTANDARD LVCMOS12} [get_ports {sw[0]}]
set_property -dict {LOC AM19 IOSTANDARD LVCMOS12} [get_ports {sw[1]}]
set_property -dict {LOC AL19 IOSTANDARD LVCMOS12} [get_ports {sw[2]}]
set_property -dict {LOC AP20 IOSTANDARD LVCMOS12} [get_ports {sw[3]}]

# UART
#set_property -dict {LOC BB20 IOSTANDARD LVCMOS12} [get_ports uart_txd]
#set_property -dict {LOC BF18 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports uart_rxd]

# QSFP28 Interfaces
set_property -dict {LOC N9} [get_ports qsfp0_tx1_p]
#set_property -dict {LOC N8  } [get_ports qsfp0_tx1_n] ;# MGTYTXN0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
set_property -dict {LOC N4} [get_ports qsfp0_rx1_p]
#set_property -dict {LOC N3  } [get_ports qsfp0_rx1_n] ;# MGTYRXN0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
set_property -dict {LOC M7} [get_ports qsfp0_tx2_p]
#set_property -dict {LOC M6  } [get_ports qsfp0_tx2_n] ;# MGTYTXN1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
set_property -dict {LOC M2} [get_ports qsfp0_rx2_p]
#set_property -dict {LOC M1  } [get_ports qsfp0_rx2_n] ;# MGTYRXN1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
set_property -dict {LOC L9} [get_ports qsfp0_tx3_p]
#set_property -dict {LOC L8  } [get_ports qsfp0_tx3_n] ;# MGTYTXN2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
set_property -dict {LOC L4} [get_ports qsfp0_rx3_p]
#set_property -dict {LOC L3  } [get_ports qsfp0_rx3_n] ;# MGTYRXN2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
set_property -dict {LOC K7} [get_ports qsfp0_tx4_p]
#set_property -dict {LOC K6  } [get_ports qsfp0_tx4_n] ;# MGTYTXN3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
set_property -dict {LOC K2} [get_ports qsfp0_rx4_p]
#set_property -dict {LOC K1  } [get_ports qsfp0_rx4_n] ;# MGTYRXN3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC M11 } [get_ports qsfp0_mgt_refclk_0_p] ;# MGTREFCLK0P_231 from U14.4 via U43.13
#set_property -dict {LOC M10 } [get_ports qsfp0_mgt_refclk_0_n] ;# MGTREFCLK0N_231 from U14.5 via U43.14
set_property -dict {LOC K11} [get_ports qsfp0_mgt_refclk_1_p]
#set_property -dict {LOC K10 } [get_ports qsfp0_mgt_refclk_1_n] ;# MGTREFCLK1N_231 from U9.17
set_property -dict {LOC BE16 IOSTANDARD LVCMOS12} [get_ports qsfp0_modsell]
set_property -dict {LOC BE17 IOSTANDARD LVCMOS12} [get_ports qsfp0_resetl]
set_property -dict {LOC BE20 IOSTANDARD LVCMOS12} [get_ports qsfp0_modprsl]
set_property -dict {LOC BE21 IOSTANDARD LVCMOS12} [get_ports qsfp0_intl]
set_property -dict {LOC BD18 IOSTANDARD LVCMOS12} [get_ports qsfp0_lpmode]
set_property -dict {LOC AT22 IOSTANDARD LVCMOS12} [get_ports qsfp0_refclk_reset]
set_property -dict {LOC AT20 IOSTANDARD LVCMOS12} [get_ports {qsfp0_fs[0]}]
set_property -dict {LOC AU22 IOSTANDARD LVCMOS12} [get_ports {qsfp0_fs[1]}]

# 156.25 MHz MGT reference clock (from SI570)
#create_clock -period 6.400 -name qsfp0_mgt_refclk_0 [get_ports qsfp0_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp0_mgt_refclk_1 [get_ports qsfp0_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI5335, FS = 0b10)
#create_clock -period 6.206 -name qsfp0_mgt_refclk_1 [get_ports qsfp0_mgt_refclk_1_p]

set_property -dict {LOC U9} [get_ports qsfp1_tx1_p]
#set_property -dict {LOC U8  } [get_ports qsfp1_tx1_n] ;# MGTYTXN0_230 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC U4} [get_ports qsfp1_rx1_p]
#set_property -dict {LOC U3  } [get_ports qsfp1_rx1_n] ;# MGTYRXN0_230 GTYE4_CHANNEL_X1Y44 / GTYE4_COMMON_X1Y11
set_property -dict {LOC T7} [get_ports qsfp1_tx2_p]
#set_property -dict {LOC T6  } [get_ports qsfp1_tx2_n] ;# MGTYTXN1_230 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC T2} [get_ports qsfp1_rx2_p]
#set_property -dict {LOC T1  } [get_ports qsfp1_rx2_n] ;# MGTYRXN1_230 GTYE4_CHANNEL_X1Y45 / GTYE4_COMMON_X1Y11
set_property -dict {LOC R9} [get_ports qsfp1_tx3_p]
#set_property -dict {LOC R8  } [get_ports qsfp1_tx3_n] ;# MGTYTXN2_230 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC R4} [get_ports qsfp1_rx3_p]
#set_property -dict {LOC R3  } [get_ports qsfp1_rx3_n] ;# MGTYRXN2_230 GTYE4_CHANNEL_X1Y46 / GTYE4_COMMON_X1Y11
set_property -dict {LOC P7} [get_ports qsfp1_tx4_p]
#set_property -dict {LOC P6  } [get_ports qsfp1_tx4_n] ;# MGTYTXN3_230 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11
set_property -dict {LOC P2} [get_ports qsfp1_rx4_p]
#set_property -dict {LOC P1  } [get_ports qsfp1_rx4_n] ;# MGTYRXN3_230 GTYE4_CHANNEL_X1Y47 / GTYE4_COMMON_X1Y11
#set_property -dict {LOC T11 } [get_ports qsfp1_mgt_refclk_0_p] ;# MGTREFCLK0P_230 from U14.4 via U43.15
#set_property -dict {LOC T10 } [get_ports qsfp1_mgt_refclk_0_n] ;# MGTREFCLK0N_230 from U14.5 via U43.16
set_property -dict {LOC P11} [get_ports qsfp1_mgt_refclk_1_p]
#set_property -dict {LOC P10 } [get_ports qsfp1_mgt_refclk_1_n] ;# MGTREFCLK1N_230 from U12.17
set_property -dict {LOC AY20 IOSTANDARD LVCMOS12} [get_ports qsfp1_modsell]
set_property -dict {LOC BC18 IOSTANDARD LVCMOS12} [get_ports qsfp1_resetl]
set_property -dict {LOC BC19 IOSTANDARD LVCMOS12} [get_ports qsfp1_modprsl]
set_property -dict {LOC AV21 IOSTANDARD LVCMOS12} [get_ports qsfp1_intl]
set_property -dict {LOC AV22 IOSTANDARD LVCMOS12} [get_ports qsfp1_lpmode]
set_property -dict {LOC AR21 IOSTANDARD LVCMOS12} [get_ports qsfp1_refclk_reset]
set_property -dict {LOC AR22 IOSTANDARD LVCMOS12} [get_ports {qsfp1_fs[0]}]
set_property -dict {LOC AU20 IOSTANDARD LVCMOS12} [get_ports {qsfp1_fs[1]}]

# 156.25 MHz MGT reference clock (from SI570)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

# 156.25 MHz MGT reference clock (from SI5335, FS = 0b01)
#create_clock -period 6.400 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# 161.1328125 MHz MGT reference clock (from SI5335, FS = 0b10)
#create_clock -period 6.206 -name qsfp1_mgt_refclk_1 [get_ports qsfp1_mgt_refclk_1_p]

# I2C interface
#set_property -dict {LOC BF19 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_mux_reset]
set_property -dict {LOC BF20 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_scl]
set_property -dict {LOC BF17 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports i2c_sda]

# PCIe Interface
set_property -dict {LOC AF2} [get_ports {pcie_rx_p[0]}]
#set_property -dict {LOC AF1  } [get_ports {pcie_rx_n[0]}]  ;# MGTYRXN3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AF7} [get_ports {pcie_tx_p[0]}]
#set_property -dict {LOC AF6  } [get_ports {pcie_tx_n[0]}]  ;# MGTYTXN3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AG4} [get_ports {pcie_rx_p[1]}]
#set_property -dict {LOC AG3  } [get_ports {pcie_rx_n[1]}]  ;# MGTYRXN2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AG9} [get_ports {pcie_tx_p[1]}]
#set_property -dict {LOC AG8  } [get_ports {pcie_tx_n[1]}]  ;# MGTYTXN2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AH2} [get_ports {pcie_rx_p[2]}]
#set_property -dict {LOC AH1  } [get_ports {pcie_rx_n[2]}]  ;# MGTYRXN1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AH7} [get_ports {pcie_tx_p[2]}]
#set_property -dict {LOC AH6  } [get_ports {pcie_tx_n[2]}]  ;# MGTYTXN1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AJ4} [get_ports {pcie_rx_p[3]}]
#set_property -dict {LOC AJ3  } [get_ports {pcie_rx_n[3]}]  ;# MGTYRXN0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AJ9} [get_ports {pcie_tx_p[3]}]
#set_property -dict {LOC AJ8  } [get_ports {pcie_tx_n[3]}]  ;# MGTYTXN0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
set_property -dict {LOC AK2} [get_ports {pcie_rx_p[4]}]
#set_property -dict {LOC AK1  } [get_ports {pcie_rx_n[4]}]  ;# MGTYRXN3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AK7} [get_ports {pcie_tx_p[4]}]
#set_property -dict {LOC AK6  } [get_ports {pcie_tx_n[4]}]  ;# MGTYTXN3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AL4} [get_ports {pcie_rx_p[5]}]
#set_property -dict {LOC AL3  } [get_ports {pcie_rx_n[5]}]  ;# MGTYRXN2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AL9} [get_ports {pcie_tx_p[5]}]
#set_property -dict {LOC AL8  } [get_ports {pcie_tx_n[5]}]  ;# MGTYTXN2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AM2} [get_ports {pcie_rx_p[6]}]
#set_property -dict {LOC AM1  } [get_ports {pcie_rx_n[6]}]  ;# MGTYRXN1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AM7} [get_ports {pcie_tx_p[6]}]
#set_property -dict {LOC AM6  } [get_ports {pcie_tx_n[6]}]  ;# MGTYTXN1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AN4} [get_ports {pcie_rx_p[7]}]
#set_property -dict {LOC AN3  } [get_ports {pcie_rx_n[7]}]  ;# MGTYRXN0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AN9} [get_ports {pcie_tx_p[7]}]
#set_property -dict {LOC AN8  } [get_ports {pcie_tx_n[7]}]  ;# MGTYTXN0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
set_property -dict {LOC AP2} [get_ports {pcie_rx_p[8]}]
#set_property -dict {LOC AP1  } [get_ports {pcie_rx_n[8]}]  ;# MGTYRXN3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AP7} [get_ports {pcie_tx_p[8]}]
#set_property -dict {LOC AP6  } [get_ports {pcie_tx_n[8]}]  ;# MGTYTXN3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AR4} [get_ports {pcie_rx_p[9]}]
#set_property -dict {LOC AR3  } [get_ports {pcie_rx_n[9]}]  ;# MGTYRXN2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AR9} [get_ports {pcie_tx_p[9]}]
#set_property -dict {LOC AR8  } [get_ports {pcie_tx_n[9]}]  ;# MGTYTXN2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AT2} [get_ports {pcie_rx_p[10]}]
#set_property -dict {LOC AT1  } [get_ports {pcie_rx_n[10]}] ;# MGTYRXN1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AT7} [get_ports {pcie_tx_p[10]}]
#set_property -dict {LOC AT6  } [get_ports {pcie_tx_n[10]}] ;# MGTYTXN1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AU4} [get_ports {pcie_rx_p[11]}]
#set_property -dict {LOC AU3  } [get_ports {pcie_rx_n[11]}] ;# MGTYRXN0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AU9} [get_ports {pcie_tx_p[11]}]
#set_property -dict {LOC AU8  } [get_ports {pcie_tx_n[11]}] ;# MGTYTXN0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
set_property -dict {LOC AV2} [get_ports {pcie_rx_p[12]}]
#set_property -dict {LOC AV1  } [get_ports {pcie_rx_n[12]}] ;# MGTYRXN3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AV7} [get_ports {pcie_tx_p[12]}]
#set_property -dict {LOC AV6  } [get_ports {pcie_tx_n[12]}] ;# MGTYTXN3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AW4} [get_ports {pcie_rx_p[13]}]
#set_property -dict {LOC AW3  } [get_ports {pcie_rx_n[13]}] ;# MGTYRXN2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
set_property -dict {LOC BB5} [get_ports {pcie_tx_p[13]}]
#set_property -dict {LOC BB4  } [get_ports {pcie_tx_n[13]}] ;# MGTYTXN2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
set_property -dict {LOC BA2} [get_ports {pcie_rx_p[14]}]
#set_property -dict {LOC BA1  } [get_ports {pcie_rx_n[14]}] ;# MGTYRXN1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
set_property -dict {LOC BD5} [get_ports {pcie_tx_p[14]}]
#set_property -dict {LOC BD4  } [get_ports {pcie_tx_n[14]}] ;# MGTYTXN1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
set_property -dict {LOC BC2} [get_ports {pcie_rx_p[15]}]
#set_property -dict {LOC BC1  } [get_ports {pcie_rx_n[15]}] ;# MGTYRXN0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
set_property -dict {LOC BF5} [get_ports {pcie_tx_p[15]}]
#set_property -dict {LOC BF4  } [get_ports {pcie_tx_n[15]}] ;# MGTYTXN0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
set_property -dict {LOC AM11} [get_ports pcie_refclk_p]
#set_property -dict {LOC AM10 } [get_ports pcie_refclk_n] ;# MGTREFCLK0N_226
set_property PACKAGE_PIN BD21 [get_ports pcie_reset_n]
set_property IOSTANDARD LVCMOS12 [get_ports pcie_reset_n]
set_property PULLUP true [get_ports pcie_reset_n]

# 100 MHz MGT reference clock
create_clock -period 10.000 -name pcie_mgt_refclk_1 [get_ports pcie_refclk_p]


create_pblock pblock_1
add_cells_to_pblock [get_pblocks pblock_1] [get_cells -quiet [list {core_inst/riscv_cores[0].pr_wrapper}]]
resize_pblock [get_pblocks pblock_1] -add {SLICE_X13Y0:SLICE_X41Y119}
resize_pblock [get_pblocks pblock_1] -add {DSP48E2_X1Y0:DSP48E2_X5Y47}
resize_pblock [get_pblocks pblock_1] -add {RAMB18_X1Y0:RAMB18_X2Y47}
resize_pblock [get_pblocks pblock_1] -add {RAMB36_X1Y0:RAMB36_X2Y23}
resize_pblock [get_pblocks pblock_1] -add {URAM288_X0Y0:URAM288_X0Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_1]
create_pblock pblock_2
add_cells_to_pblock [get_pblocks pblock_2] [get_cells -quiet [list {core_inst/riscv_cores[1].pr_wrapper}]]
resize_pblock [get_pblocks pblock_2] -add {SLICE_X49Y0:SLICE_X79Y119}
resize_pblock [get_pblocks pblock_2] -add {DSP48E2_X7Y0:DSP48E2_X8Y47}
resize_pblock [get_pblocks pblock_2] -add {RAMB18_X4Y0:RAMB18_X4Y47}
resize_pblock [get_pblocks pblock_2] -add {RAMB36_X4Y0:RAMB36_X4Y23}
resize_pblock [get_pblocks pblock_2] -add {URAM288_X1Y0:URAM288_X1Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_2]
create_pblock pblock_3
add_cells_to_pblock [get_pblocks pblock_3] [get_cells -quiet [list {core_inst/riscv_cores[2].pr_wrapper}]]
resize_pblock [get_pblocks pblock_3] -add {SLICE_X85Y0:SLICE_X114Y119}
resize_pblock [get_pblocks pblock_3] -add {DSP48E2_X10Y0:DSP48E2_X13Y47}
resize_pblock [get_pblocks pblock_3] -add {RAMB18_X6Y0:RAMB18_X7Y47}
resize_pblock [get_pblocks pblock_3] -add {RAMB36_X6Y0:RAMB36_X7Y23}
resize_pblock [get_pblocks pblock_3] -add {URAM288_X2Y0:URAM288_X2Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_3]
create_pblock pblock_4
add_cells_to_pblock [get_pblocks pblock_4] [get_cells -quiet [list {core_inst/riscv_cores[3].pr_wrapper}]]
resize_pblock [get_pblocks pblock_4] -add {SLICE_X121Y0:SLICE_X149Y119}
resize_pblock [get_pblocks pblock_4] -add {DSP48E2_X15Y0:DSP48E2_X16Y47}
resize_pblock [get_pblocks pblock_4] -add {RAMB18_X9Y0:RAMB18_X9Y47}
resize_pblock [get_pblocks pblock_4] -add {RAMB36_X9Y0:RAMB36_X9Y23}
resize_pblock [get_pblocks pblock_4] -add {URAM288_X3Y0:URAM288_X3Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_4]
create_pblock pblock_5
add_cells_to_pblock [get_pblocks pblock_5] [get_cells -quiet [list {core_inst/riscv_cores[4].pr_wrapper}]]
resize_pblock [get_pblocks pblock_5] -add {SLICE_X13Y150:SLICE_X41Y269}
resize_pblock [get_pblocks pblock_5] -add {DSP48E2_X1Y60:DSP48E2_X5Y107}
resize_pblock [get_pblocks pblock_5] -add {RAMB18_X1Y60:RAMB18_X2Y107}
resize_pblock [get_pblocks pblock_5] -add {RAMB36_X1Y30:RAMB36_X2Y53}
resize_pblock [get_pblocks pblock_5] -add {URAM288_X0Y40:URAM288_X0Y71}
set_property SNAPPING_MODE ON [get_pblocks pblock_5]
create_pblock pblock_6
add_cells_to_pblock [get_pblocks pblock_6] [get_cells -quiet [list {core_inst/riscv_cores[5].pr_wrapper}]]
resize_pblock [get_pblocks pblock_6] -add {SLICE_X50Y150:SLICE_X79Y269}
resize_pblock [get_pblocks pblock_6] -add {DSP48E2_X7Y60:DSP48E2_X8Y107}
resize_pblock [get_pblocks pblock_6] -add {RAMB18_X4Y60:RAMB18_X4Y107}
resize_pblock [get_pblocks pblock_6] -add {RAMB36_X4Y30:RAMB36_X4Y53}
resize_pblock [get_pblocks pblock_6] -add {URAM288_X1Y40:URAM288_X1Y71}
set_property SNAPPING_MODE ON [get_pblocks pblock_6]
create_pblock pblock_7
add_cells_to_pblock [get_pblocks pblock_7] [get_cells -quiet [list {core_inst/riscv_cores[6].pr_wrapper}]]
resize_pblock [get_pblocks pblock_7] -add {SLICE_X85Y150:SLICE_X114Y269}
resize_pblock [get_pblocks pblock_7] -add {DSP48E2_X10Y60:DSP48E2_X13Y107}
resize_pblock [get_pblocks pblock_7] -add {RAMB18_X6Y60:RAMB18_X7Y107}
resize_pblock [get_pblocks pblock_7] -add {RAMB36_X6Y30:RAMB36_X7Y53}
resize_pblock [get_pblocks pblock_7] -add {URAM288_X2Y40:URAM288_X2Y71}
set_property SNAPPING_MODE ON [get_pblocks pblock_7]
create_pblock pblock_8
add_cells_to_pblock [get_pblocks pblock_8] [get_cells -quiet [list {core_inst/riscv_cores[7].pr_wrapper}]]
resize_pblock [get_pblocks pblock_8] -add {SLICE_X121Y150:SLICE_X149Y269}
resize_pblock [get_pblocks pblock_8] -add {DSP48E2_X15Y60:DSP48E2_X16Y107}
resize_pblock [get_pblocks pblock_8] -add {RAMB18_X9Y60:RAMB18_X9Y107}
resize_pblock [get_pblocks pblock_8] -add {RAMB36_X9Y30:RAMB36_X9Y53}
resize_pblock [get_pblocks pblock_8] -add {URAM288_X3Y40:URAM288_X3Y71}
set_property SNAPPING_MODE ON [get_pblocks pblock_8]
create_pblock pblock_9
add_cells_to_pblock [get_pblocks pblock_9] [get_cells -quiet [list {core_inst/riscv_cores[8].pr_wrapper}]]
resize_pblock [get_pblocks pblock_9] -add {SLICE_X21Y630:SLICE_X48Y749}
resize_pblock [get_pblocks pblock_9] -add {DSP48E2_X2Y252:DSP48E2_X6Y299}
resize_pblock [get_pblocks pblock_9] -add {RAMB18_X2Y252:RAMB18_X2Y299}
resize_pblock [get_pblocks pblock_9] -add {RAMB36_X2Y126:RAMB36_X2Y149}
resize_pblock [get_pblocks pblock_9] -add {URAM288_X0Y168:URAM288_X0Y199}
set_property SNAPPING_MODE ON [get_pblocks pblock_9]
create_pblock pblock_10
add_cells_to_pblock [get_pblocks pblock_10] [get_cells -quiet [list {core_inst/riscv_cores[9].pr_wrapper}]]
resize_pblock [get_pblocks pblock_10] -add {SLICE_X53Y630:SLICE_X82Y749}
resize_pblock [get_pblocks pblock_10] -add {DSP48E2_X8Y252:DSP48E2_X9Y299}
resize_pblock [get_pblocks pblock_10] -add {RAMB18_X4Y252:RAMB18_X4Y299}
resize_pblock [get_pblocks pblock_10] -add {RAMB36_X4Y126:RAMB36_X4Y149}
resize_pblock [get_pblocks pblock_10] -add {URAM288_X1Y168:URAM288_X1Y199}
set_property SNAPPING_MODE ON [get_pblocks pblock_10]
create_pblock pblock_11
add_cells_to_pblock [get_pblocks pblock_11] [get_cells -quiet [list {core_inst/riscv_cores[10].pr_wrapper}]]
resize_pblock [get_pblocks pblock_11] -add {SLICE_X87Y630:SLICE_X115Y749}
resize_pblock [get_pblocks pblock_11] -add {DSP48E2_X10Y252:DSP48E2_X13Y299}
resize_pblock [get_pblocks pblock_11] -add {RAMB18_X7Y252:RAMB18_X8Y299}
resize_pblock [get_pblocks pblock_11] -add {RAMB36_X7Y126:RAMB36_X8Y149}
resize_pblock [get_pblocks pblock_11] -add {URAM288_X2Y168:URAM288_X2Y199}
set_property SNAPPING_MODE ON [get_pblocks pblock_11]
create_pblock pblock_12
add_cells_to_pblock [get_pblocks pblock_12] [get_cells -quiet [list {core_inst/riscv_cores[11].pr_wrapper}]]
resize_pblock [get_pblocks pblock_12] -add {SLICE_X121Y630:SLICE_X149Y749}
resize_pblock [get_pblocks pblock_12] -add {DSP48E2_X15Y252:DSP48E2_X16Y299}
resize_pblock [get_pblocks pblock_12] -add {RAMB18_X9Y252:RAMB18_X9Y299}
resize_pblock [get_pblocks pblock_12] -add {RAMB36_X9Y126:RAMB36_X9Y149}
resize_pblock [get_pblocks pblock_12] -add {URAM288_X3Y168:URAM288_X3Y199}
set_property SNAPPING_MODE ON [get_pblocks pblock_12]
create_pblock pblock_13
add_cells_to_pblock [get_pblocks pblock_13] [get_cells -quiet [list {core_inst/riscv_cores[12].pr_wrapper}]]
resize_pblock [get_pblocks pblock_13] -add {SLICE_X21Y780:SLICE_X48Y899}
resize_pblock [get_pblocks pblock_13] -add {DSP48E2_X2Y312:DSP48E2_X6Y359}
resize_pblock [get_pblocks pblock_13] -add {RAMB18_X2Y312:RAMB18_X2Y359}
resize_pblock [get_pblocks pblock_13] -add {RAMB36_X2Y156:RAMB36_X2Y179}
resize_pblock [get_pblocks pblock_13] -add {URAM288_X0Y208:URAM288_X0Y239}
set_property SNAPPING_MODE ON [get_pblocks pblock_13]
create_pblock pblock_14
add_cells_to_pblock [get_pblocks pblock_14] [get_cells -quiet [list {core_inst/riscv_cores[13].pr_wrapper}]]
resize_pblock [get_pblocks pblock_14] -add {SLICE_X53Y780:SLICE_X82Y899}
resize_pblock [get_pblocks pblock_14] -add {DSP48E2_X8Y312:DSP48E2_X9Y359}
resize_pblock [get_pblocks pblock_14] -add {RAMB18_X4Y312:RAMB18_X4Y359}
resize_pblock [get_pblocks pblock_14] -add {RAMB36_X4Y156:RAMB36_X4Y179}
resize_pblock [get_pblocks pblock_14] -add {URAM288_X1Y208:URAM288_X1Y239}
set_property SNAPPING_MODE ON [get_pblocks pblock_14]
create_pblock pblock_15
add_cells_to_pblock [get_pblocks pblock_15] [get_cells -quiet [list {core_inst/riscv_cores[14].pr_wrapper}]]
resize_pblock [get_pblocks pblock_15] -add {SLICE_X87Y780:SLICE_X115Y899}
resize_pblock [get_pblocks pblock_15] -add {DSP48E2_X10Y312:DSP48E2_X13Y359}
resize_pblock [get_pblocks pblock_15] -add {RAMB18_X7Y312:RAMB18_X8Y359}
resize_pblock [get_pblocks pblock_15] -add {RAMB36_X7Y156:RAMB36_X8Y179}
resize_pblock [get_pblocks pblock_15] -add {URAM288_X2Y208:URAM288_X2Y239}
set_property SNAPPING_MODE ON [get_pblocks pblock_15]
create_pblock pblock_16
add_cells_to_pblock [get_pblocks pblock_16] [get_cells -quiet [list {core_inst/riscv_cores[15].pr_wrapper}]]
resize_pblock [get_pblocks pblock_16] -add {SLICE_X121Y780:SLICE_X149Y899}
resize_pblock [get_pblocks pblock_16] -add {DSP48E2_X15Y312:DSP48E2_X16Y359}
resize_pblock [get_pblocks pblock_16] -add {RAMB18_X9Y312:RAMB18_X9Y359}
resize_pblock [get_pblocks pblock_16] -add {RAMB36_X9Y156:RAMB36_X9Y179}
resize_pblock [get_pblocks pblock_16] -add {URAM288_X3Y208:URAM288_X3Y239}
set_property SNAPPING_MODE ON [get_pblocks pblock_16]


create_pblock pblock_17
add_cells_to_pblock [get_pblocks pblock_17] [get_cells -quiet [list {core_inst/riscv_cores[0].core_wrapper}]]
resize_pblock [get_pblocks pblock_17] -add {SLICE_X13Y120:SLICE_X41Y134}
resize_pblock [get_pblocks pblock_17] -add {RAMB18_X1Y48:RAMB18_X2Y53}
resize_pblock [get_pblocks pblock_17] -add {RAMB36_X1Y24:RAMB36_X2Y26}
create_pblock pblock_18
add_cells_to_pblock [get_pblocks pblock_18] [get_cells -quiet [list {core_inst/riscv_cores[1].core_wrapper}]]
resize_pblock [get_pblocks pblock_18] -add {SLICE_X49Y120:SLICE_X79Y134}
resize_pblock [get_pblocks pblock_18] -add {RAMB18_X4Y48:RAMB18_X4Y53}
resize_pblock [get_pblocks pblock_18] -add {RAMB36_X4Y24:RAMB36_X4Y26}
create_pblock pblock_19
add_cells_to_pblock [get_pblocks pblock_19] [get_cells -quiet [list {core_inst/riscv_cores[2].core_wrapper}]]
resize_pblock [get_pblocks pblock_19] -add {SLICE_X85Y120:SLICE_X114Y134}
resize_pblock [get_pblocks pblock_19] -add {RAMB18_X6Y48:RAMB18_X7Y53}
resize_pblock [get_pblocks pblock_19] -add {RAMB36_X6Y24:RAMB36_X7Y26}
create_pblock pblock_20
add_cells_to_pblock [get_pblocks pblock_20] [get_cells -quiet [list {core_inst/riscv_cores[3].core_wrapper}]]
resize_pblock [get_pblocks pblock_20] -add {SLICE_X121Y120:SLICE_X149Y134}
resize_pblock [get_pblocks pblock_20] -add {RAMB18_X9Y48:RAMB18_X9Y53}
resize_pblock [get_pblocks pblock_20] -add {RAMB36_X9Y24:RAMB36_X9Y26}
create_pblock pblock_21
add_cells_to_pblock [get_pblocks pblock_21] [get_cells -quiet [list {core_inst/riscv_cores[4].core_wrapper}]]
resize_pblock [get_pblocks pblock_21] -add {SLICE_X13Y270:SLICE_X41Y284}
resize_pblock [get_pblocks pblock_21] -add {RAMB18_X1Y108:RAMB18_X2Y113}
resize_pblock [get_pblocks pblock_21] -add {RAMB36_X1Y54:RAMB36_X2Y56}
create_pblock pblock_22
add_cells_to_pblock [get_pblocks pblock_22] [get_cells -quiet [list {core_inst/riscv_cores[5].core_wrapper}]]
resize_pblock [get_pblocks pblock_22] -add {SLICE_X50Y270:SLICE_X79Y284}
resize_pblock [get_pblocks pblock_22] -add {RAMB18_X4Y108:RAMB18_X4Y113}
resize_pblock [get_pblocks pblock_22] -add {RAMB36_X4Y54:RAMB36_X4Y56}
create_pblock pblock_23
add_cells_to_pblock [get_pblocks pblock_23] [get_cells -quiet [list {core_inst/riscv_cores[6].core_wrapper}]]
resize_pblock [get_pblocks pblock_23] -add {SLICE_X85Y270:SLICE_X114Y284}
resize_pblock [get_pblocks pblock_23] -add {RAMB18_X6Y108:RAMB18_X7Y113}
resize_pblock [get_pblocks pblock_23] -add {RAMB36_X6Y54:RAMB36_X7Y56}
create_pblock pblock_24
add_cells_to_pblock [get_pblocks pblock_24] [get_cells -quiet [list {core_inst/riscv_cores[7].core_wrapper}]]
resize_pblock [get_pblocks pblock_24] -add {SLICE_X121Y270:SLICE_X149Y284}
resize_pblock [get_pblocks pblock_24] -add {RAMB18_X9Y108:RAMB18_X9Y113}
resize_pblock [get_pblocks pblock_24] -add {RAMB36_X9Y54:RAMB36_X9Y56}
create_pblock pblock_25
add_cells_to_pblock [get_pblocks pblock_25] [get_cells -quiet [list {core_inst/riscv_cores[8].core_wrapper}]]
resize_pblock [get_pblocks pblock_25] -add {SLICE_X21Y615:SLICE_X48Y629}
resize_pblock [get_pblocks pblock_25] -add {RAMB18_X2Y246:RAMB18_X2Y251}
resize_pblock [get_pblocks pblock_25] -add {RAMB36_X2Y123:RAMB36_X2Y125}
create_pblock pblock_26
add_cells_to_pblock [get_pblocks pblock_26] [get_cells -quiet [list {core_inst/riscv_cores[9].core_wrapper}]]
resize_pblock [get_pblocks pblock_26] -add {SLICE_X53Y615:SLICE_X82Y629}
resize_pblock [get_pblocks pblock_26] -add {RAMB18_X4Y246:RAMB18_X4Y251}
resize_pblock [get_pblocks pblock_26] -add {RAMB36_X4Y123:RAMB36_X4Y125}
create_pblock pblock_27
add_cells_to_pblock [get_pblocks pblock_27] [get_cells -quiet [list {core_inst/riscv_cores[10].core_wrapper}]]
resize_pblock [get_pblocks pblock_27] -add {SLICE_X87Y615:SLICE_X115Y629}
resize_pblock [get_pblocks pblock_27] -add {RAMB18_X7Y246:RAMB18_X8Y251}
resize_pblock [get_pblocks pblock_27] -add {RAMB36_X7Y123:RAMB36_X8Y125}
create_pblock pblock_28
add_cells_to_pblock [get_pblocks pblock_28] [get_cells -quiet [list {core_inst/riscv_cores[11].core_wrapper}]]
resize_pblock [get_pblocks pblock_28] -add {SLICE_X121Y615:SLICE_X149Y629}
resize_pblock [get_pblocks pblock_28] -add {RAMB18_X9Y246:RAMB18_X9Y251}
resize_pblock [get_pblocks pblock_28] -add {RAMB36_X9Y123:RAMB36_X9Y125}
create_pblock pblock_29
add_cells_to_pblock [get_pblocks pblock_29] [get_cells -quiet [list {core_inst/riscv_cores[12].core_wrapper}]]
resize_pblock [get_pblocks pblock_29] -add {SLICE_X21Y765:SLICE_X48Y779}
resize_pblock [get_pblocks pblock_29] -add {RAMB18_X2Y306:RAMB18_X2Y311}
resize_pblock [get_pblocks pblock_29] -add {RAMB36_X2Y153:RAMB36_X2Y155}
create_pblock pblock_30
add_cells_to_pblock [get_pblocks pblock_30] [get_cells -quiet [list {core_inst/riscv_cores[13].core_wrapper}]]
resize_pblock [get_pblocks pblock_30] -add {SLICE_X53Y765:SLICE_X82Y779}
resize_pblock [get_pblocks pblock_30] -add {RAMB18_X4Y306:RAMB18_X4Y311}
resize_pblock [get_pblocks pblock_30] -add {RAMB36_X4Y153:RAMB36_X4Y155}
create_pblock pblock_31
add_cells_to_pblock [get_pblocks pblock_31] [get_cells -quiet [list {core_inst/riscv_cores[14].core_wrapper}]]
resize_pblock [get_pblocks pblock_31] -add {SLICE_X87Y765:SLICE_X115Y779}
resize_pblock [get_pblocks pblock_31] -add {RAMB18_X7Y306:RAMB18_X8Y311}
resize_pblock [get_pblocks pblock_31] -add {RAMB36_X7Y153:RAMB36_X8Y155}
create_pblock pblock_32
add_cells_to_pblock [get_pblocks pblock_32] [get_cells -quiet [list {core_inst/riscv_cores[15].core_wrapper}]]
resize_pblock [get_pblocks pblock_32] -add {SLICE_X121Y765:SLICE_X149Y779}
resize_pblock [get_pblocks pblock_32] -add {RAMB18_X9Y306:RAMB18_X9Y311}
resize_pblock [get_pblocks pblock_32] -add {RAMB36_X9Y153:RAMB36_X9Y155}

create_pblock pblock_33
add_cells_to_pblock [get_pblocks pblock_33] [get_cells -quiet [list {core_inst/MAC_async_FIFO[0].mac_rx_fifo_inst} {core_inst/MAC_async_FIFO[0].mac_tx_fifo_inst} {core_inst/MAC_async_FIFO[1].mac_rx_fifo_inst} {core_inst/MAC_async_FIFO[1].mac_tx_fifo_inst}]]
resize_pblock [get_pblocks pblock_33] -add {SLICE_X0Y600:SLICE_X16Y899}
resize_pblock [get_pblocks pblock_33] -add {CMACE4_X0Y7:CMACE4_X0Y8}
resize_pblock [get_pblocks pblock_33] -add {LAGUNA_X0Y480:LAGUNA_X1Y719}
resize_pblock [get_pblocks pblock_33] -add {RAMB18_X0Y240:RAMB18_X1Y359}
resize_pblock [get_pblocks pblock_33] -add {RAMB36_X0Y120:RAMB36_X1Y179}

create_pblock pblock_34
add_cells_to_pblock [get_pblocks pblock_34] [get_cells -quiet [list core_inst/cores_to_broadcaster/shrink.axis_switch_2lvl_shrink_inst/last_level_arbiter.sw_lvl2 core_inst/ctrl_in_sw/grow.axis_switch_2lvl_grow_inst/sw_lvl1 core_inst/ctrl_out_sw/shrink.axis_switch_2lvl_shrink_inst/last_level_arbiter.sw_lvl2 core_inst/data_in_sw/grow.axis_switch_2lvl_grow_inst/sw_lvl1 core_inst/data_out_sw/shrink.axis_switch_2lvl_shrink_inst/last_level_sw.sw_lvl2 core_inst/dram_ctrl_in_sw/grow.axis_switch_2lvl_grow_inst/sw_lvl1 core_inst/dram_ctrl_out_sw/shrink.axis_switch_2lvl_shrink_inst/last_level_arbiter.sw_lvl2 core_inst/loopback_msg_fifo_inst core_inst/pcie_controller_inst core_inst/scheduler pcie4_uscale_plus_inst pcie_us_cfg_inst pcie_us_msi_inst]]
resize_pblock [get_pblocks pblock_34] -add {SLR1}


