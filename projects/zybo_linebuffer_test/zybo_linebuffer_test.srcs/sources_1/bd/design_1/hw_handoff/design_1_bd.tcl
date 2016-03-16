
################################################################
# This is a generated script based on design: design_1
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
# source design_1_script.tcl

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
set design_name design_1

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

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Assume_Synchronous_Clk {false} \
CONFIG.Byte_Size {8} \
CONFIG.Enable_32bit_Address {true} \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Read_Width_A {32} \
CONFIG.Read_Width_B {32} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {true} \
CONFIG.Use_RSTA_Pin {true} \
CONFIG.Use_RSTB_Pin {true} \
CONFIG.Write_Depth_A {8192} \
CONFIG.Write_Width_A {32} \
CONFIG.Write_Width_B {32} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $blk_mem_gen_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {312.659} \
CONFIG.CLKOUT1_PHASE_ERROR {245.713} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25} \
CONFIG.MMCM_CLKFBOUT_MULT_F {36.500} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.500} \
CONFIG.MMCM_DIVCLK_DIVIDE {5} \
 ] $clk_wiz_0

  # Create instance: i_buf_controller_0, and set properties
  set i_buf_controller_0 [ create_bd_cell -type ip -vlnv mikeanthonywild.com:user:i_buf_controller:1.0 i_buf_controller_0 ]
  set_property -dict [ list \
CONFIG.ADDRESS_WIDTH {31} \
 ] $i_buf_controller_0

  # Create instance: test_pattern_generator_0, and set properties
  set test_pattern_generator_0 [ create_bd_cell -type ip -vlnv user.org:user:test_pattern_generator:1.0 test_pattern_generator_0 ]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins i_buf_controller_0/pclk] [get_bd_pins test_pattern_generator_0/clk]
  connect_bd_net -net i_buf_controller_0_addr [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins i_buf_controller_0/addr]
  connect_bd_net -net i_buf_controller_0_o_data [get_bd_pins blk_mem_gen_0/dina] [get_bd_pins i_buf_controller_0/o_data]
  connect_bd_net -net test_pattern_generator_0_hsync [get_bd_pins i_buf_controller_0/hsync] [get_bd_pins test_pattern_generator_0/hsync]
  connect_bd_net -net test_pattern_generator_0_r [get_bd_pins i_buf_controller_0/i_data] [get_bd_pins test_pattern_generator_0/r]
  connect_bd_net -net test_pattern_generator_0_vde [get_bd_pins i_buf_controller_0/vde] [get_bd_pins test_pattern_generator_0/vde]
  connect_bd_net -net test_pattern_generator_0_vsync [get_bd_pins i_buf_controller_0/vsync] [get_bd_pins test_pattern_generator_0/vsync]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port clk -pg 1 -y 260 -defaultsOSRD
preplace inst test_pattern_generator_0 -pg 1 -lvl 2 -y 360 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 4 -y 320 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 1 -y 270 -defaultsOSRD
preplace inst i_buf_controller_0 -pg 1 -lvl 3 -y 360 -defaultsOSRD
preplace netloc i_buf_controller_0_o_data 1 3 1 850
preplace netloc test_pattern_generator_0_hsync 1 2 1 470
preplace netloc test_pattern_generator_0_vsync 1 2 1 460
preplace netloc test_pattern_generator_0_r 1 2 1 490
preplace netloc clk_1 1 0 1 NJ
preplace netloc clk_wiz_0_clk_out1 1 1 3 180 260 500 260 NJ
preplace netloc test_pattern_generator_0_vde 1 2 1 480
preplace netloc i_buf_controller_0_addr 1 3 1 840
levelinfo -pg 1 0 100 360 730 1020 1160 -top 0 -bot 460
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


