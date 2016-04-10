# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.cache/wt [current_project]
set_property parent.project_path C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {
  c:/users/mike/documents/osiris-hdl/hdl/i_buf_controller
  c:/users/mike/documents/osiris-hdl/hdl/rgb2dvi_v1_2
  c:/Users/Mike/Documents/osiris-hdl/hdl
} [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_blk_mem_gen_0_1/test_readout_into_linebuffer.coe
add_files C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_blk_mem_gen_0_1/test_video_output_from_linebuffer.coe
add_files C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/linebuffer_test.bd
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_processing_system7_0_0/linebuffer_test_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_blk_mem_gen_0_1/linebuffer_test_blk_mem_gen_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_bram_ctrl_0_1/linebuffer_test_axi_bram_ctrl_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_1/linebuffer_test_axi_cdma_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_1/linebuffer_test_axi_cdma_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_xbar_0/linebuffer_test_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_xbar_1/linebuffer_test_xbar_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_xbar_2/linebuffer_test_xbar_2_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_blk_mem_gen_0_0/linebuffer_test_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_0/linebuffer_test_axi_cdma_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_0/linebuffer_test_axi_cdma_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_bram_ctrl_0_0/linebuffer_test_axi_bram_ctrl_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_pc_0/linebuffer_test_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_0/linebuffer_test_auto_ds_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_0/linebuffer_test_auto_ds_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_pc_1/linebuffer_test_auto_pc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_0/linebuffer_test_auto_us_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_0/linebuffer_test_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_1/linebuffer_test_auto_ds_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_1/linebuffer_test_auto_ds_1_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_pc_2/linebuffer_test_auto_pc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_1/linebuffer_test_auto_us_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_1/linebuffer_test_auto_us_1_clocks.xdc]
set_property used_in_implementation false [get_files -all C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/linebuffer_test_ooc.xdc]
set_property is_locked true [get_files C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/linebuffer_test.bd]

read_verilog -library xil_defaultlib C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/hdl/linebuffer_test_wrapper.v
read_xdc C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc
set_property used_in_implementation false [get_files C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top linebuffer_test_wrapper -part xc7z010clg400-1
write_checkpoint -noxdef linebuffer_test_wrapper.dcp
catch { report_utilization -file linebuffer_test_wrapper_utilization_synth.rpt -pb linebuffer_test_wrapper_utilization_synth.pb }
