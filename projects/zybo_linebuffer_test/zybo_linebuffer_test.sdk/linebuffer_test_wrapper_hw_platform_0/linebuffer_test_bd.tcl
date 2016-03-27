
################################################################
# This is a generated script based on design: linebuffer_test
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source linebuffer_test_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1
#    set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name linebuffer_test

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set btn [ create_bd_port -dir I -from 3 -to 0 -type intr btn ]
  set_property -dict [ list \
CONFIG.PortWidth {4} \
CONFIG.SENSITIVITY {EDGE_RISING} \
 ] $btn
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {125000000} \
 ] $clk
  set vga_b [ create_bd_port -dir O -from 4 -to 0 vga_b ]
  set vga_g [ create_bd_port -dir O -from 5 -to 0 vga_g ]
  set vga_hs [ create_bd_port -dir O vga_hs ]
  set vga_r [ create_bd_port -dir O -from 4 -to 0 vga_r ]
  set vga_vs [ create_bd_port -dir O vga_vs ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {4} \
 ] $GND

  # Create instance: VDD, and set properties
  set VDD [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VDD ]

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $axi_mem_intercon

  # Create instance: axi_mem_intercon_1, and set properties
  set axi_mem_intercon_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon_1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $axi_mem_intercon_1

  # Create instance: bram_we_concat, and set properties
  set bram_we_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 bram_we_concat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {4} \
 ] $bram_we_concat

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {281.423} \
CONFIG.CLKOUT1_PHASE_ERROR {365.405} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.175} \
CONFIG.MMCM_CLKFBOUT_MULT_F {61.500} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {43.625} \
CONFIG.MMCM_DIVCLK_DIVIDE {7} \
 ] $clk_wiz_0

  # Create instance: i_axi_bram_ctrl, and set properties
  set i_axi_bram_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 i_axi_bram_ctrl ]
  set_property -dict [ list \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $i_axi_bram_ctrl

  # Create instance: i_axi_cdma, and set properties
  set i_axi_cdma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 i_axi_cdma ]
  set_property -dict [ list \
CONFIG.C_INCLUDE_SG {0} \
CONFIG.C_M_AXI_MAX_BURST_LEN {256} \
 ] $i_axi_cdma

  # Create instance: i_buf_controller, and set properties
  set i_buf_controller [ create_bd_cell -type ip -vlnv mikeanthonywild.com:user:i_buf_controller:1.0 i_buf_controller ]

  # Create instance: i_linebuffer, and set properties
  set i_linebuffer [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 i_linebuffer ]
  set_property -dict [ list \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Use_RSTB_Pin {true} \
 ] $i_linebuffer

  # Create instance: irq_concat, and set properties
  set irq_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 irq_concat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {4} \
 ] $irq_concat

  # Create instance: o_axi_bram_ctrl, and set properties
  set o_axi_bram_ctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 o_axi_bram_ctrl ]
  set_property -dict [ list \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $o_axi_bram_ctrl

  # Create instance: o_axi_cdma, and set properties
  set o_axi_cdma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 o_axi_cdma ]
  set_property -dict [ list \
CONFIG.C_INCLUDE_SG {0} \
CONFIG.C_M_AXI_MAX_BURST_LEN {256} \
 ] $o_axi_cdma

  # Create instance: o_buf_controller, and set properties
  set o_buf_controller [ create_bd_cell -type ip -vlnv mikeanthonywild.com:user:o_buf_controller:1.0 o_buf_controller ]

  # Create instance: o_linebuffer, and set properties
  set o_linebuffer [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 o_linebuffer ]
  set_property -dict [ list \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Use_RSTB_Pin {true} \
 ] $o_linebuffer

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {650} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_0_PULLUP {enabled} \
CONFIG.PCW_MIO_10_PULLUP {enabled} \
CONFIG.PCW_MIO_11_PULLUP {enabled} \
CONFIG.PCW_MIO_12_PULLUP {enabled} \
CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {fast} \
CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {fast} \
CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {fast} \
CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {fast} \
CONFIG.PCW_MIO_1_PULLUP {disabled} \
CONFIG.PCW_MIO_1_SLEW {fast} \
CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {fast} \
CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {fast} \
CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {fast} \
CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {fast} \
CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {fast} \
CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {fast} \
CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {fast} \
CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} \
CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {fast} \
CONFIG.PCW_MIO_28_PULLUP {disabled} \
CONFIG.PCW_MIO_28_SLEW {fast} \
CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_29_SLEW {fast} \
CONFIG.PCW_MIO_2_SLEW {fast} \
CONFIG.PCW_MIO_30_PULLUP {disabled} \
CONFIG.PCW_MIO_30_SLEW {fast} \
CONFIG.PCW_MIO_31_PULLUP {disabled} \
CONFIG.PCW_MIO_31_SLEW {fast} \
CONFIG.PCW_MIO_32_PULLUP {disabled} \
CONFIG.PCW_MIO_32_SLEW {fast} \
CONFIG.PCW_MIO_33_PULLUP {disabled} \
CONFIG.PCW_MIO_33_SLEW {fast} \
CONFIG.PCW_MIO_34_PULLUP {disabled} \
CONFIG.PCW_MIO_34_SLEW {fast} \
CONFIG.PCW_MIO_35_PULLUP {disabled} \
CONFIG.PCW_MIO_35_SLEW {fast} \
CONFIG.PCW_MIO_36_PULLUP {disabled} \
CONFIG.PCW_MIO_36_SLEW {fast} \
CONFIG.PCW_MIO_37_PULLUP {disabled} \
CONFIG.PCW_MIO_37_SLEW {fast} \
CONFIG.PCW_MIO_38_PULLUP {disabled} \
CONFIG.PCW_MIO_38_SLEW {fast} \
CONFIG.PCW_MIO_39_PULLUP {disabled} \
CONFIG.PCW_MIO_39_SLEW {fast} \
CONFIG.PCW_MIO_3_SLEW {fast} \
CONFIG.PCW_MIO_40_PULLUP {disabled} \
CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_41_SLEW {fast} \
CONFIG.PCW_MIO_42_PULLUP {disabled} \
CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_43_SLEW {fast} \
CONFIG.PCW_MIO_44_PULLUP {disabled} \
CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_45_SLEW {fast} \
CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {fast} \
CONFIG.PCW_MIO_50_DIRECTION {inout} \
CONFIG.PCW_MIO_50_PULLUP {disabled} \
CONFIG.PCW_MIO_51_DIRECTION {inout} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_PULLUP {disabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_SLEW {fast} \
CONFIG.PCW_MIO_6_SLEW {fast} \
CONFIG.PCW_MIO_8_SLEW {fast} \
CONFIG.PCW_MIO_9_PULLUP {enabled} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.176} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.159} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.162} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.187} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.034} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.03} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.082} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {525} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K128M16 JT-125} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_RESET_ENABLE {1} \
CONFIG.PCW_USB0_RESET_IO {MIO 46} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {1} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $processing_system7_0_axi_periph

  # Create instance: rgb2vga_0, and set properties
  set rgb2vga_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2vga:1.0 rgb2vga_0 ]

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: test_pattern_generator_0, and set properties
  set test_pattern_generator_0 [ create_bd_cell -type ip -vlnv user.org:user:test_pattern_generator:1.0 test_pattern_generator_0 ]

  # Create instance: vga_concat, and set properties
  set vga_concat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 vga_concat ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {3} \
 ] $vga_concat

  # Create interface connections
  connect_bd_intf_net -intf_net axi_mem_intercon_1_M00_AXI [get_bd_intf_pins axi_mem_intercon_1/M00_AXI] [get_bd_intf_pins o_axi_bram_ctrl/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_1_M01_AXI [get_bd_intf_pins axi_mem_intercon_1/M01_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP1]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins i_axi_bram_ctrl/S_AXI]
  connect_bd_intf_net -intf_net axi_mem_intercon_M01_AXI [get_bd_intf_pins axi_mem_intercon/M01_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net i_axi_bram_ctrl_BRAM_PORTA [get_bd_intf_pins i_axi_bram_ctrl/BRAM_PORTA] [get_bd_intf_pins i_linebuffer/BRAM_PORTA]
  connect_bd_intf_net -intf_net i_axi_cdma_M_AXI [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins i_axi_cdma/M_AXI]
  connect_bd_intf_net -intf_net o_axi_bram_ctrl_BRAM_PORTA [get_bd_intf_pins o_axi_bram_ctrl/BRAM_PORTA] [get_bd_intf_pins o_linebuffer/BRAM_PORTA]
  connect_bd_intf_net -intf_net o_axi_cdma_M_AXI [get_bd_intf_pins axi_mem_intercon_1/S00_AXI] [get_bd_intf_pins o_axi_cdma/M_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins i_axi_cdma/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins o_axi_cdma/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]

  # Create port connections
  connect_bd_net -net GND_dout [get_bd_pins GND/dout] [get_bd_pins o_linebuffer/web]
  connect_bd_net -net VDD_dout [get_bd_pins VDD/dout] [get_bd_pins i_buf_controller/reset_n] [get_bd_pins i_linebuffer/enb] [get_bd_pins o_buf_controller/reset_n] [get_bd_pins o_linebuffer/enb]
  connect_bd_net -net btn_1 [get_bd_ports btn] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins i_buf_controller/pclk] [get_bd_pins i_linebuffer/clkb] [get_bd_pins o_buf_controller/pclk] [get_bd_pins o_linebuffer/clkb] [get_bd_pins rgb2vga_0/PixelClk] [get_bd_pins test_pattern_generator_0/clk]
  connect_bd_net -net i_buf_controller_addr [get_bd_pins i_buf_controller/addr] [get_bd_pins i_linebuffer/addrb]
  connect_bd_net -net i_buf_controller_frame_valid [get_bd_pins i_buf_controller/frame_valid] [get_bd_pins irq_concat/In1]
  connect_bd_net -net i_buf_controller_line_valid [get_bd_pins i_buf_controller/line_valid] [get_bd_pins irq_concat/In0]
  connect_bd_net -net i_buf_controller_o_data [get_bd_pins i_buf_controller/o_data] [get_bd_pins i_linebuffer/dinb]
  connect_bd_net -net i_buf_controller_we [get_bd_pins bram_we_concat/In0] [get_bd_pins bram_we_concat/In1] [get_bd_pins bram_we_concat/In2] [get_bd_pins bram_we_concat/In3] [get_bd_pins i_buf_controller/we]
  connect_bd_net -net o_buf_controller_addr [get_bd_pins o_buf_controller/addr] [get_bd_pins o_linebuffer/addrb]
  connect_bd_net -net o_buf_controller_hsync [get_bd_pins o_buf_controller/hsync] [get_bd_pins rgb2vga_0/rgb_pHSync]
  connect_bd_net -net o_buf_controller_o_data [get_bd_pins o_buf_controller/o_data] [get_bd_pins vga_concat/In0] [get_bd_pins vga_concat/In1] [get_bd_pins vga_concat/In2]
  connect_bd_net -net o_buf_controller_req_frame [get_bd_pins irq_concat/In3] [get_bd_pins o_buf_controller/req_frame]
  connect_bd_net -net o_buf_controller_req_line [get_bd_pins irq_concat/In2] [get_bd_pins o_buf_controller/req_line]
  connect_bd_net -net o_buf_controller_vde [get_bd_pins o_buf_controller/vde] [get_bd_pins rgb2vga_0/rgb_pVDE]
  connect_bd_net -net o_buf_controller_vsync [get_bd_pins o_buf_controller/vsync] [get_bd_pins rgb2vga_0/rgb_pVSync]
  connect_bd_net -net o_linebuffer_doutb [get_bd_pins o_buf_controller/i_data] [get_bd_pins o_linebuffer/doutb]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/M01_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon_1/ACLK] [get_bd_pins axi_mem_intercon_1/M00_ACLK] [get_bd_pins axi_mem_intercon_1/M01_ACLK] [get_bd_pins axi_mem_intercon_1/S00_ACLK] [get_bd_pins i_axi_bram_ctrl/s_axi_aclk] [get_bd_pins i_axi_cdma/m_axi_aclk] [get_bd_pins i_axi_cdma/s_axi_lite_aclk] [get_bd_pins o_axi_bram_ctrl/s_axi_aclk] [get_bd_pins o_axi_cdma/m_axi_aclk] [get_bd_pins o_axi_cdma/s_axi_lite_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP1_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net rgb2vga_0_vga_pBlue [get_bd_ports vga_b] [get_bd_pins rgb2vga_0/vga_pBlue]
  connect_bd_net -net rgb2vga_0_vga_pGreen [get_bd_ports vga_g] [get_bd_pins rgb2vga_0/vga_pGreen]
  connect_bd_net -net rgb2vga_0_vga_pHSync [get_bd_ports vga_hs] [get_bd_pins rgb2vga_0/vga_pHSync]
  connect_bd_net -net rgb2vga_0_vga_pRed [get_bd_ports vga_r] [get_bd_pins rgb2vga_0/vga_pRed]
  connect_bd_net -net rgb2vga_0_vga_pVSync [get_bd_ports vga_vs] [get_bd_pins rgb2vga_0/vga_pVSync]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins axi_mem_intercon_1/ARESETN] [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/M01_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon_1/M00_ARESETN] [get_bd_pins axi_mem_intercon_1/M01_ARESETN] [get_bd_pins axi_mem_intercon_1/S00_ARESETN] [get_bd_pins i_axi_bram_ctrl/s_axi_aresetn] [get_bd_pins i_axi_cdma/s_axi_lite_aresetn] [get_bd_pins o_axi_bram_ctrl/s_axi_aresetn] [get_bd_pins o_axi_cdma/s_axi_lite_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
  connect_bd_net -net test_pattern_generator_0_hsync [get_bd_pins i_buf_controller/hsync] [get_bd_pins test_pattern_generator_0/hsync]
  connect_bd_net -net test_pattern_generator_0_r [get_bd_pins i_buf_controller/i_data] [get_bd_pins test_pattern_generator_0/r]
  connect_bd_net -net test_pattern_generator_0_vde [get_bd_pins i_buf_controller/vde] [get_bd_pins test_pattern_generator_0/vde]
  connect_bd_net -net test_pattern_generator_0_vsync [get_bd_pins i_buf_controller/vsync] [get_bd_pins test_pattern_generator_0/vsync]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins rgb2vga_0/rgb_pData] [get_bd_pins vga_concat/dout]
  connect_bd_net -net xlconcat_2_dout [get_bd_pins bram_we_concat/dout] [get_bd_pins i_linebuffer/web]

  # Create address segments
  create_bd_addr_seg -range 0x1000 -offset 0xC0000000 [get_bd_addr_spaces i_axi_cdma/Data] [get_bd_addr_segs i_axi_bram_ctrl/S_AXI/Mem0] SEG_i_axi_bram_ctrl_Mem0
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces i_axi_cdma/Data] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x1000 -offset 0xC0001000 [get_bd_addr_spaces o_axi_cdma/Data] [get_bd_addr_segs o_axi_bram_ctrl/S_AXI/Mem0] SEG_o_axi_bram_ctrl_Mem0
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces o_axi_cdma/Data] [get_bd_addr_segs processing_system7_0/S_AXI_HP1/HP1_DDR_LOWOCM] SEG_processing_system7_0_HP1_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x7E200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs i_axi_cdma/S_AXI_LITE/Reg] SEG_i_axi_cdma_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x7E210000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs o_axi_cdma/S_AXI_LITE/Reg] SEG_o_axi_cdma_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 220 -defaultsOSRD
preplace port vga_hs -pg 1 -y 1100 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 240 -defaultsOSRD
preplace port vga_vs -pg 1 -y 1120 -defaultsOSRD
preplace port clk -pg 1 -y 770 -defaultsOSRD
preplace portBus vga_b -pg 1 -y 1080 -defaultsOSRD
preplace portBus btn -pg 1 -y 380 -defaultsOSRD
preplace portBus vga_r -pg 1 -y 1040 -defaultsOSRD
preplace portBus vga_g -pg 1 -y 1060 -defaultsOSRD
preplace inst o_axi_cdma -pg 1 -lvl 3 -y 500 -defaultsOSRD
preplace inst axi_mem_intercon_1 -pg 1 -lvl 4 -y 580 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 1 -y 90 -defaultsOSRD
preplace inst i_axi_bram_ctrl -pg 1 -lvl 5 -y 530 -defaultsOSRD
preplace inst GND -pg 1 -lvl 5 -y 950 -defaultsOSRD
preplace inst test_pattern_generator_0 -pg 1 -lvl 2 -y 770 -defaultsOSRD
preplace inst o_buf_controller -pg 1 -lvl 3 -y 1050 -defaultsOSRD
preplace inst o_linebuffer -pg 1 -lvl 6 -y 860 -defaultsOSRD
preplace inst i_buf_controller -pg 1 -lvl 3 -y 790 -defaultsOSRD
preplace inst i_axi_cdma -pg 1 -lvl 3 -y 340 -defaultsOSRD
preplace inst vga_concat -pg 1 -lvl 5 -y 1100 -defaultsOSRD
preplace inst VDD -pg 1 -lvl 2 -y 920 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 780 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 4 -y 320 -defaultsOSRD
preplace inst bram_we_concat -pg 1 -lvl 5 -y 810 -defaultsOSRD
preplace inst irq_concat -pg 1 -lvl 4 -y 830 -defaultsOSRD
preplace inst rgb2vga_0 -pg 1 -lvl 6 -y 1080 -defaultsOSRD
preplace inst o_axi_bram_ctrl -pg 1 -lvl 5 -y 660 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 330 -defaultsOSRD
preplace inst i_linebuffer -pg 1 -lvl 6 -y 610 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 5 -y 310 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 5 2 NJ 220 NJ
preplace netloc o_axi_bram_ctrl_BRAM_PORTA 1 5 1 1870
preplace netloc i_axi_bram_ctrl_BRAM_PORTA 1 5 1 1860
preplace netloc axi_mem_intercon_M01_AXI 1 4 1 1350
preplace netloc btn_1 1 0 5 NJ 190 NJ 150 NJ 150 NJ 150 1410
preplace netloc rgb2vga_0_vga_pRed 1 6 1 NJ
preplace netloc test_pattern_generator_0_hsync 1 2 1 N
preplace netloc test_pattern_generator_0_vsync 1 2 1 N
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 1 710
preplace netloc rgb2vga_0_vga_pGreen 1 6 1 NJ
preplace netloc o_buf_controller_req_line 1 3 1 1020
preplace netloc o_buf_controller_vsync 1 3 3 NJ 1010 NJ 1020 1860
preplace netloc axi_mem_intercon_1_M00_AXI 1 4 1 1370
preplace netloc processing_system7_0_M_AXI_GP0 1 1 5 410 110 NJ 110 NJ 110 NJ 110 1870
preplace netloc test_pattern_generator_0_r 1 2 1 710
preplace netloc o_buf_controller_vde 1 3 3 NJ 1050 NJ 1170 1910
preplace netloc xlconcat_1_dout 1 5 1 1890
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 6 30 180 NJ 160 NJ 160 NJ 160 NJ 160 1860
preplace netloc axi_mem_intercon_1_M01_AXI 1 4 1 1360
preplace netloc axi_mem_intercon_M00_AXI 1 4 1 1400
preplace netloc o_buf_controller_o_data 1 3 2 NJ 1070 NJ
preplace netloc i_buf_controller_o_data 1 3 3 1030 730 NJ 730 NJ
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 1 4 370 480 730 420 1040 170 1390
preplace netloc i_buf_controller_addr 1 3 3 1000 130 NJ 130 NJ
preplace netloc clk_1 1 0 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 5 2 NJ 240 NJ
preplace netloc o_buf_controller_addr 1 3 3 NJ 990 NJ 1000 1860
preplace netloc clk_wiz_0_clk_out1 1 1 5 390 870 720 940 NJ 940 NJ 1010 1880
preplace netloc rgb2vga_0_vga_pVSync 1 6 1 NJ
preplace netloc rgb2vga_0_vga_pHSync 1 6 1 NJ
preplace netloc o_buf_controller_req_frame 1 3 1 1040
preplace netloc test_pattern_generator_0_vde 1 2 1 N
preplace netloc o_axi_cdma_M_AXI 1 3 1 1010
preplace netloc VDD_dout 1 2 4 730 920 NJ 920 NJ 900 1900
preplace netloc o_buf_controller_hsync 1 3 3 NJ 1180 NJ 1180 1900
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 1 3 400 190 NJ 190 1030
preplace netloc processing_system7_0_FCLK_CLK0 1 0 6 20 270 410 470 710 580 1020 180 1380 450 1850
preplace netloc i_buf_controller_we 1 3 2 N 750 NJ
preplace netloc xlconcat_2_dout 1 5 1 NJ
preplace netloc GND_dout 1 5 1 NJ
preplace netloc o_linebuffer_doutb 1 2 4 740 910 NJ 910 NJ 890 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 1 720
preplace netloc i_axi_cdma_M_AXI 1 3 1 1010
preplace netloc rgb2vga_0_vga_pBlue 1 6 1 NJ
preplace netloc i_buf_controller_frame_valid 1 3 1 1020
preplace netloc i_buf_controller_line_valid 1 3 1 1020
levelinfo -pg 1 -10 200 560 870 1200 1630 2060 2230 -top 0 -bot 1190
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


