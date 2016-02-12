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
  create_project -in_memory -part xc7z010clg400-1
  set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.cache/wt [current_project]
  set_property parent.project_path /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.xpr [current_project]
  set_property ip_repo_paths {
  /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.cache/ip
  /home/mike/Documents/osiris-hdl/hdl
} [current_project]
  set_property ip_output_repo /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.cache/ip [current_project]
  add_files -quiet /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.runs/synth_1/zybo_dvi_input_wrapper.dcp
  read_xdc -ref zybo_dvi_input_dvi2rgb_0_0 -cells U0 /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_dvi2rgb_0_0/src/dvi2rgb.xdc
  set_property processing_order EARLY [get_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_dvi2rgb_0_0/src/dvi2rgb.xdc]
  read_xdc -prop_thru_buffers -ref zybo_dvi_input_clk_wiz_0_0 -cells inst /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_clk_wiz_0_0/zybo_dvi_input_clk_wiz_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_clk_wiz_0_0/zybo_dvi_input_clk_wiz_0_0_board.xdc]
  read_xdc -ref zybo_dvi_input_clk_wiz_0_0 -cells inst /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_clk_wiz_0_0/zybo_dvi_input_clk_wiz_0_0.xdc
  set_property processing_order EARLY [get_files /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/sources_1/bd/zybo_dvi_input/ip/zybo_dvi_input_clk_wiz_0_0/zybo_dvi_input_clk_wiz_0_0.xdc]
  read_xdc /home/mike/Documents/osiris-hdl/projects/zybo_dvi_input/zybo_dvi_input.srcs/constrs_1/imports/Downloads/ZYBO_Master.xdc
  link_design -top zybo_dvi_input_wrapper -part xc7z010clg400-1
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
  write_checkpoint -force zybo_dvi_input_wrapper_opt.dcp
  report_drc -file zybo_dvi_input_wrapper_drc_opted.rpt
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
  catch {write_hwdef -file zybo_dvi_input_wrapper.hwdef}
  place_design 
  write_checkpoint -force zybo_dvi_input_wrapper_placed.dcp
  report_io -file zybo_dvi_input_wrapper_io_placed.rpt
  report_utilization -file zybo_dvi_input_wrapper_utilization_placed.rpt -pb zybo_dvi_input_wrapper_utilization_placed.pb
  report_control_sets -verbose -file zybo_dvi_input_wrapper_control_sets_placed.rpt
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
  write_checkpoint -force zybo_dvi_input_wrapper_routed.dcp
  report_drc -file zybo_dvi_input_wrapper_drc_routed.rpt -pb zybo_dvi_input_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file zybo_dvi_input_wrapper_timing_summary_routed.rpt -rpx zybo_dvi_input_wrapper_timing_summary_routed.rpx
  report_power -file zybo_dvi_input_wrapper_power_routed.rpt -pb zybo_dvi_input_wrapper_power_summary_routed.pb
  report_route_status -file zybo_dvi_input_wrapper_route_status.rpt -pb zybo_dvi_input_wrapper_route_status.pb
  report_clock_utilization -file zybo_dvi_input_wrapper_clock_utilization_routed.rpt
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
  catch { write_mem_info -force zybo_dvi_input_wrapper.mmi }
  write_bitstream -force zybo_dvi_input_wrapper.bit 
  catch { write_sysdef -hwdef zybo_dvi_input_wrapper.hwdef -bitfile zybo_dvi_input_wrapper.bit -meminfo zybo_dvi_input_wrapper.mmi -file zybo_dvi_input_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

