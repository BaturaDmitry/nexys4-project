# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/37529/Desktop/project_dop/project_dop.cache/wt [current_project]
set_property parent.project_path C:/Users/37529/Desktop/project_dop/project_dop.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/37529/Desktop/project_dop/project_dop.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/I2C_Master.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/I2C_Controller.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/TX_FSM.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/baud_rate_generator.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/debouncer.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/Desktop/displ7seg.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/rx_fsm.vhd
  C:/Users/37529/Desktop/project_dop/project_dop.srcs/sources_1/imports/new/main_unit.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/37529/Desktop/project_dop/project_dop.srcs/constrs_1/new/Nexys4.xdc
set_property used_in_implementation false [get_files C:/Users/37529/Desktop/project_dop/project_dop.srcs/constrs_1/new/Nexys4.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top main_unit -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef main_unit.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file main_unit_utilization_synth.rpt -pb main_unit_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]