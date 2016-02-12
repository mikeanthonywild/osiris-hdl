
################################################################
# This is a generated script based on design: zybo_dvi_input
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
# source zybo_dvi_input_script.tcl

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
set design_name zybo_dvi_input

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
  set DDC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 DDC ]

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {125000000} \
 ] $clk
  set hdmi_clk_n [ create_bd_port -dir I hdmi_clk_n ]
  set hdmi_clk_p [ create_bd_port -dir I hdmi_clk_p ]
  set hdmi_d_n [ create_bd_port -dir I -from 2 -to 0 hdmi_d_n ]
  set hdmi_d_p [ create_bd_port -dir I -from 2 -to 0 hdmi_d_p ]
  set hdmi_hpd [ create_bd_port -dir O -from 0 -to 0 hdmi_hpd ]
  set hdmi_out_en [ create_bd_port -dir O -from 0 -to 0 hdmi_out_en ]
  set vga_b [ create_bd_port -dir O -from 4 -to 0 vga_b ]
  set vga_g [ create_bd_port -dir O -from 5 -to 0 vga_g ]
  set vga_hs [ create_bd_port -dir O vga_hs ]
  set vga_r [ create_bd_port -dir O -from 4 -to 0 vga_r ]
  set vga_vs [ create_bd_port -dir O vga_vs ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: VDD, and set properties
  set VDD [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VDD ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_DRIVES {BUFG} \
CONFIG.CLKOUT1_JITTER {109.241} \
CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
CONFIG.CLKOUT2_DRIVES {BUFG} \
CONFIG.CLKOUT3_DRIVES {BUFG} \
CONFIG.CLKOUT4_DRIVES {BUFG} \
CONFIG.CLKOUT5_DRIVES {BUFG} \
CONFIG.CLKOUT6_DRIVES {BUFG} \
CONFIG.CLKOUT7_DRIVES {BUFG} \
CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
CONFIG.MMCM_CLKFBOUT_MULT_F {8} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {5} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {1} \
CONFIG.PRIMITIVE {PLL} \
 ] $clk_wiz_0

  # Create instance: dvi2rgb_0, and set properties
  set dvi2rgb_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:dvi2rgb:1.5 dvi2rgb_0 ]

  # Create instance: rgb2vga_0, and set properties
  set rgb2vga_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2vga:1.0 rgb2vga_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net dvi2rgb_0_DDC [get_bd_intf_ports DDC] [get_bd_intf_pins dvi2rgb_0/DDC]
  connect_bd_intf_net -intf_net dvi2rgb_0_RGB [get_bd_intf_pins dvi2rgb_0/RGB] [get_bd_intf_pins rgb2vga_0/vid_in]

  # Create port connections
  connect_bd_net -net GND_dout [get_bd_ports hdmi_out_en] [get_bd_pins GND/dout]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins dvi2rgb_0/RefClk]
  connect_bd_net -net dvi2rgb_0_PixelClk [get_bd_pins dvi2rgb_0/PixelClk] [get_bd_pins rgb2vga_0/PixelClk]
  connect_bd_net -net hdmi_clk_n_1 [get_bd_ports hdmi_clk_n] [get_bd_pins dvi2rgb_0/TMDS_Clk_n]
  connect_bd_net -net hdmi_clk_p_1 [get_bd_ports hdmi_clk_p] [get_bd_pins dvi2rgb_0/TMDS_Clk_p]
  connect_bd_net -net hdmi_d_n_1 [get_bd_ports hdmi_d_n] [get_bd_pins dvi2rgb_0/TMDS_Data_n]
  connect_bd_net -net hdmi_d_p_1 [get_bd_ports hdmi_d_p] [get_bd_pins dvi2rgb_0/TMDS_Data_p]
  connect_bd_net -net rgb2vga_0_vga_pBlue [get_bd_ports vga_b] [get_bd_pins rgb2vga_0/vga_pBlue]
  connect_bd_net -net rgb2vga_0_vga_pGreen [get_bd_ports vga_g] [get_bd_pins rgb2vga_0/vga_pGreen]
  connect_bd_net -net rgb2vga_0_vga_pHSync [get_bd_ports vga_hs] [get_bd_pins rgb2vga_0/vga_pHSync]
  connect_bd_net -net rgb2vga_0_vga_pRed [get_bd_ports vga_r] [get_bd_pins rgb2vga_0/vga_pRed]
  connect_bd_net -net rgb2vga_0_vga_pVSync [get_bd_ports vga_vs] [get_bd_pins rgb2vga_0/vga_pVSync]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports hdmi_hpd] [get_bd_pins VDD/dout]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port vga_hs -pg 1 -y 300 -defaultsOSRD
preplace port hdmi_clk_n -pg 1 -y 190 -defaultsOSRD
preplace port vga_vs -pg 1 -y 320 -defaultsOSRD
preplace port clk -pg 1 -y 280 -defaultsOSRD
preplace port hdmi_clk_p -pg 1 -y 170 -defaultsOSRD
preplace port DDC -pg 1 -y 190 -defaultsOSRD
preplace portBus vga_b -pg 1 -y 280 -defaultsOSRD
preplace portBus hdmi_d_n -pg 1 -y 230 -defaultsOSRD
preplace portBus hdmi_out_en -pg 1 -y 140 -defaultsOSRD
preplace portBus hdmi_hpd -pg 1 -y 50 -defaultsOSRD
preplace portBus hdmi_d_p -pg 1 -y 210 -defaultsOSRD
preplace portBus vga_r -pg 1 -y 240 -defaultsOSRD
preplace portBus vga_g -pg 1 -y 260 -defaultsOSRD
preplace inst GND -pg 1 -lvl 3 -y 140 -defaultsOSRD
preplace inst VDD -pg 1 -lvl 3 -y 50 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 290 -defaultsOSRD
preplace inst dvi2rgb_0 -pg 1 -lvl 2 -y 220 -defaultsOSRD
preplace inst rgb2vga_0 -pg 1 -lvl 3 -y 280 -defaultsOSRD
preplace netloc rgb2vga_0_vga_pRed 1 3 1 N
preplace netloc rgb2vga_0_vga_pGreen 1 3 1 N
preplace netloc hdmi_d_p_1 1 0 2 NJ 210 NJ
preplace netloc dvi2rgb_0_DDC 1 2 2 NJ 190 NJ
preplace netloc xlconstant_0_dout 1 3 1 NJ
preplace netloc clk_1 1 0 1 NJ
preplace netloc rgb2vga_0_vga_pVSync 1 3 1 N
preplace netloc rgb2vga_0_vga_pHSync 1 3 1 N
preplace netloc clk_wiz_0_clk_out1 1 1 1 NJ
preplace netloc hdmi_d_n_1 1 0 2 NJ 230 NJ
preplace netloc GND_dout 1 3 1 NJ
preplace netloc hdmi_clk_n_1 1 0 2 NJ 190 NJ
preplace netloc dvi2rgb_0_RGB 1 2 1 490
preplace netloc rgb2vga_0_vga_pBlue 1 3 1 N
preplace netloc dvi2rgb_0_PixelClk 1 2 1 480
preplace netloc hdmi_clk_p_1 1 0 2 NJ 170 NJ
levelinfo -pg 1 0 100 330 600 730 -top 0 -bot 370
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


