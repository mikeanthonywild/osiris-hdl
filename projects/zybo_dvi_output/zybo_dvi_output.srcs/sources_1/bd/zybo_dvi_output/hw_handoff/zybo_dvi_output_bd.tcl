
################################################################
# This is a generated script based on design: zybo_dvi_output
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
# source zybo_dvi_output_script.tcl

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
set design_name zybo_dvi_output

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

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {125000000} \
 ] $clk
  set hdmi_clk_n [ create_bd_port -dir O hdmi_clk_n ]
  set hdmi_clk_p [ create_bd_port -dir O hdmi_clk_p ]
  set hdmi_d_n [ create_bd_port -dir O -from 2 -to 0 hdmi_d_n ]
  set hdmi_d_p [ create_bd_port -dir O -from 2 -to 0 hdmi_d_p ]
  set hdmi_out_en [ create_bd_port -dir O -from 0 -to 0 hdmi_out_en ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKIN1_JITTER_PS {80.0} \
CONFIG.CLKOUT1_DRIVES {BUFG} \
CONFIG.CLKOUT1_JITTER {157.337} \
CONFIG.CLKOUT1_PHASE_ERROR {127.299} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {148.5} \
CONFIG.CLKOUT2_DRIVES {BUFG} \
CONFIG.CLKOUT2_JITTER {117.142} \
CONFIG.CLKOUT2_PHASE_ERROR {127.299} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {742.5} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_DRIVES {BUFG} \
CONFIG.CLKOUT4_DRIVES {BUFG} \
CONFIG.CLKOUT5_DRIVES {BUFG} \
CONFIG.CLKOUT6_DRIVES {BUFG} \
CONFIG.CLKOUT7_DRIVES {BUFG} \
CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
CONFIG.MMCM_CLKFBOUT_MULT_F {11.875} \
CONFIG.MMCM_CLKIN1_PERIOD {8.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {5.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {1} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {2} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.PRIMITIVE {MMCM} \
 ] $clk_wiz_0

  # Create instance: rgb2dvi_0, and set properties
  set rgb2dvi_0 [ create_bd_cell -type ip -vlnv digilentinc.com:ip:rgb2dvi:1.2 rgb2dvi_0 ]
  set_property -dict [ list \
CONFIG.kClkRange {1} \
CONFIG.kGenerateSerialClk {false} \
 ] $rgb2dvi_0

  # Create instance: test_pattern_generator_0, and set properties
  set test_pattern_generator_0 [ create_bd_cell -type ip -vlnv user.org:user:test_pattern_generator:1.0 test_pattern_generator_0 ]
  set_property -dict [ list \
CONFIG.DISPLAY_HEIGHT {1080} \
CONFIG.DISPLAY_WIDTH {1920} \
CONFIG.H_BACK_PORCH {148} \
CONFIG.H_FRONT_PORCH {88} \
CONFIG.H_SYNC_PULSE {44} \
CONFIG.V_BACK_PORCH {36} \
CONFIG.V_FRONT_PORCH {4} \
CONFIG.V_SYNC_PULSE {5} \
 ] $test_pattern_generator_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {3} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins rgb2dvi_0/PixelClk] [get_bd_pins test_pattern_generator_0/clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins rgb2dvi_0/SerialClk]
  connect_bd_net -net rgb2dvi_0_TMDS_Clk_n [get_bd_ports hdmi_clk_n] [get_bd_pins rgb2dvi_0/TMDS_Clk_n]
  connect_bd_net -net rgb2dvi_0_TMDS_Clk_p [get_bd_ports hdmi_clk_p] [get_bd_pins rgb2dvi_0/TMDS_Clk_p]
  connect_bd_net -net rgb2dvi_0_TMDS_Data_n [get_bd_ports hdmi_d_n] [get_bd_pins rgb2dvi_0/TMDS_Data_n]
  connect_bd_net -net rgb2dvi_0_TMDS_Data_p [get_bd_ports hdmi_d_p] [get_bd_pins rgb2dvi_0/TMDS_Data_p]
  connect_bd_net -net test_pattern_generator_0_b [get_bd_pins test_pattern_generator_0/b] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net test_pattern_generator_0_g [get_bd_pins test_pattern_generator_0/g] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net test_pattern_generator_0_hsync [get_bd_pins rgb2dvi_0/vid_pHSync] [get_bd_pins test_pattern_generator_0/hsync]
  connect_bd_net -net test_pattern_generator_0_r [get_bd_pins test_pattern_generator_0/r] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net test_pattern_generator_0_vde [get_bd_pins rgb2dvi_0/vid_pVDE] [get_bd_pins test_pattern_generator_0/vde]
  connect_bd_net -net test_pattern_generator_0_vsync [get_bd_pins rgb2dvi_0/vid_pVSync] [get_bd_pins test_pattern_generator_0/vsync]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins rgb2dvi_0/vid_pData] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_ports hdmi_out_en] [get_bd_pins xlconstant_0/dout]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port hdmi_clk_n -pg 1 -y 210 -defaultsOSRD
preplace port clk -pg 1 -y 270 -defaultsOSRD
preplace port hdmi_clk_p -pg 1 -y 190 -defaultsOSRD
preplace portBus hdmi_d_n -pg 1 -y 250 -defaultsOSRD
preplace portBus hdmi_out_en -pg 1 -y 50 -defaultsOSRD
preplace portBus hdmi_d_p -pg 1 -y 230 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 4 -y 50 -defaultsOSRD
preplace inst test_pattern_generator_0 -pg 1 -lvl 2 -y 170 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 3 -y 120 -defaultsOSRD
preplace inst rgb2dvi_0 -pg 1 -lvl 4 -y 210 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 280 -defaultsOSRD
preplace netloc test_pattern_generator_0_b 1 2 1 400
preplace netloc rgb2dvi_0_TMDS_Clk_n 1 4 1 NJ
preplace netloc test_pattern_generator_0_hsync 1 2 2 NJ 190 580
preplace netloc test_pattern_generator_0_vsync 1 2 2 NJ 200 N
preplace netloc rgb2dvi_0_TMDS_Clk_p 1 4 1 NJ
preplace netloc test_pattern_generator_0_r 1 2 1 380
preplace netloc test_pattern_generator_0_g 1 2 1 390
preplace netloc xlconcat_0_dout 1 3 1 580
preplace netloc clk_1 1 0 1 N
preplace netloc xlconstant_0_dout 1 4 1 NJ
preplace netloc test_pattern_generator_0_vde 1 2 2 NJ 220 N
preplace netloc clk_wiz_0_clk_out1 1 1 3 180 270 NJ 260 N
preplace netloc rgb2dvi_0_TMDS_Data_n 1 4 1 NJ
preplace netloc clk_wiz_0_clk_out2 1 1 3 NJ 280 NJ 280 N
preplace netloc rgb2dvi_0_TMDS_Data_p 1 4 1 NJ
levelinfo -pg 1 0 100 280 490 750 930 -top 0 -bot 350
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


