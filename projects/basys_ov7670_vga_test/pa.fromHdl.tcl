
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name basys_ov7670_vga_test -dir "/home/mike/Documents/osiris-hdl/projects/basys_ov7670_vga_test/planAhead_run_3" -part xc3s250etq144-5
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "basys_top.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../../hdl/ov7670/ov7670_init.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../hdl/ov7670/i2c_sender.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
add_files [list {ipcore_dir/block_ram_framebuf.ngc}]
set hdlfile [add_files [list {../../hdl/vga/vga_controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../hdl/ov7670/ov7670_controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../hdl/ov7670/ov7670_capture.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {basys_top.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top basys_top $srcset
add_files [list {basys_top.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s250etq144-5
