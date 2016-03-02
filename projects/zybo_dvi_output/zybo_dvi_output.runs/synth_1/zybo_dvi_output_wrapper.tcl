# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.cache/wt [current_project]
set_property parent.project_path /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
set_property ip_repo_paths /home/mike/Documents/osiris-hdl/hdl [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/zybo_dvi_output.bd
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_rgb2dvi_0_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_rgb2dvi_0_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_clk_wiz_0_0/zybo_dvi_output_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_clk_wiz_0_0/zybo_dvi_output_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/ip/zybo_dvi_output_clk_wiz_0_0/zybo_dvi_output_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/zybo_dvi_output_ooc.xdc]
set_property is_locked true [get_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/zybo_dvi_output.bd]

read_verilog -library xil_defaultlib /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/sources_1/bd/zybo_dvi_output/hdl/zybo_dvi_output_wrapper.v
read_xdc /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc
set_property used_in_implementation false [get_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_output/zybo_dvi_output.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top zybo_dvi_output_wrapper -part xc7z010clg400-1
write_checkpoint -noxdef zybo_dvi_output_wrapper.dcp
catch { report_utilization -file zybo_dvi_output_wrapper_utilization_synth.rpt -pb zybo_dvi_output_wrapper_utilization_synth.pb }
