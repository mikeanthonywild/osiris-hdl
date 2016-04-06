proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.cache/wt [current_project]
  set_property parent.project_path C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.xpr [current_project]
  set_property ip_repo_paths {
  c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.cache/ip
  C:/Users/Mike/Documents/osiris-hdl/hdl
} [current_project]
  set_property ip_output_repo c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.cache/ip [current_project]
  add_files -quiet C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.runs/synth_1/linebuffer_test_wrapper.dcp
  read_xdc -ref linebuffer_test_processing_system7_0_0 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_processing_system7_0_0/linebuffer_test_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_processing_system7_0_0/linebuffer_test_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref linebuffer_test_rst_processing_system7_0_100M_0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref linebuffer_test_rst_processing_system7_0_100M_0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rst_processing_system7_0_100M_0/linebuffer_test_rst_processing_system7_0_100M_0.xdc]
  read_xdc -ref linebuffer_test_axi_cdma_0_1 -cells U0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_1/linebuffer_test_axi_cdma_0_1.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_1/linebuffer_test_axi_cdma_0_1.xdc]
  read_xdc -prop_thru_buffers -ref linebuffer_test_clk_wiz_0_0 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0_board.xdc]
  read_xdc -ref linebuffer_test_clk_wiz_0_0 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_0/linebuffer_test_clk_wiz_0_0.xdc]
  read_xdc -ref linebuffer_test_axi_cdma_0_0 -cells U0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_0/linebuffer_test_axi_cdma_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_axi_cdma_0_0/linebuffer_test_axi_cdma_0_0.xdc]
  read_xdc -ref linebuffer_test_rgb2dvi_0_0 -cells U0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi.xdc]
  read_xdc -prop_thru_buffers -ref linebuffer_test_clk_wiz_0_1 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1_board.xdc]
  read_xdc -ref linebuffer_test_clk_wiz_0_1 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1.xdc
  set_property processing_order EARLY [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_clk_wiz_0_1/linebuffer_test_clk_wiz_0_1.xdc]
  read_xdc C:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc
  read_xdc -ref linebuffer_test_rgb2dvi_0_0 -cells U0 c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
  read_xdc -ref linebuffer_test_auto_ds_0 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_0/linebuffer_test_auto_ds_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_0/linebuffer_test_auto_ds_0_clocks.xdc]
  read_xdc -ref linebuffer_test_auto_us_0 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_0/linebuffer_test_auto_us_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_0/linebuffer_test_auto_us_0_clocks.xdc]
  read_xdc -ref linebuffer_test_auto_ds_1 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_1/linebuffer_test_auto_ds_1_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_ds_1/linebuffer_test_auto_ds_1_clocks.xdc]
  read_xdc -ref linebuffer_test_auto_us_1 -cells inst c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_1/linebuffer_test_auto_us_1_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/Mike/Documents/osiris-hdl/projects/zybo_linebuffer_test/zybo_linebuffer_test.srcs/sources_1/bd/linebuffer_test/ip/linebuffer_test_auto_us_1/linebuffer_test_auto_us_1_clocks.xdc]
  link_design -top linebuffer_test_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force linebuffer_test_wrapper_opt.dcp
  report_drc -file linebuffer_test_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file linebuffer_test_wrapper.hwdef}
  place_design 
  write_checkpoint -force linebuffer_test_wrapper_placed.dcp
  report_io -file linebuffer_test_wrapper_io_placed.rpt
  report_utilization -file linebuffer_test_wrapper_utilization_placed.rpt -pb linebuffer_test_wrapper_utilization_placed.pb
  report_control_sets -verbose -file linebuffer_test_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force linebuffer_test_wrapper_routed.dcp
  report_drc -file linebuffer_test_wrapper_drc_routed.rpt -pb linebuffer_test_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file linebuffer_test_wrapper_timing_summary_routed.rpt -rpx linebuffer_test_wrapper_timing_summary_routed.rpx
  report_power -file linebuffer_test_wrapper_power_routed.rpt -pb linebuffer_test_wrapper_power_summary_routed.pb
  report_route_status -file linebuffer_test_wrapper_route_status.rpt -pb linebuffer_test_wrapper_route_status.pb
  report_clock_utilization -file linebuffer_test_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force linebuffer_test_wrapper.mmi }
  write_bitstream -force linebuffer_test_wrapper.bit 
  catch { write_sysdef -hwdef linebuffer_test_wrapper.hwdef -bitfile linebuffer_test_wrapper.bit -meminfo linebuffer_test_wrapper.mmi -file linebuffer_test_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

