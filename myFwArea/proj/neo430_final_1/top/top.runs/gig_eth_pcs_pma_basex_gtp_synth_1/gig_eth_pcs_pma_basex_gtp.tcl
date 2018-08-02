# 
# Synthesis run script generated by Vivado
# 

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
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a35tfgg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.cache/wt [current_project]
set_property parent.project_path /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp.xci
set_property used_in_implementation false [get_files -all /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_board.xdc]
set_property used_in_implementation false [get_files -all /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/synth/gig_eth_pcs_pma_basex_gtp.xdc]
set_property used_in_implementation false [get_files -all /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/synth/gig_eth_pcs_pma_basex_gtp_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1 -new_name gig_eth_pcs_pma_basex_gtp -ip [get_ips gig_eth_pcs_pma_basex_gtp]]

if { $cached_ip eq {} } {
close [open __synthesis_is_running__ w]

synth_design -top gig_eth_pcs_pma_basex_gtp -part xc7a35tfgg484-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
# disable binary constraint mode for IPCache checkpoints
set_param constraints.enableBinaryConstraints false

catch {
 write_checkpoint -force -noxdef -rename_prefix gig_eth_pcs_pma_basex_gtp_ gig_eth_pcs_pma_basex_gtp.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ gig_eth_pcs_pma_basex_gtp_stub.v
 lappend ipCachedFiles gig_eth_pcs_pma_basex_gtp_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ gig_eth_pcs_pma_basex_gtp_stub.vhdl
 lappend ipCachedFiles gig_eth_pcs_pma_basex_gtp_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ gig_eth_pcs_pma_basex_gtp_sim_netlist.v
 lappend ipCachedFiles gig_eth_pcs_pma_basex_gtp_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ gig_eth_pcs_pma_basex_gtp_sim_netlist.vhdl
 lappend ipCachedFiles gig_eth_pcs_pma_basex_gtp_sim_netlist.vhdl

 config_ip_cache -add -dcp gig_eth_pcs_pma_basex_gtp.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips gig_eth_pcs_pma_basex_gtp]
}

rename_ref -prefix_all gig_eth_pcs_pma_basex_gtp_

# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef gig_eth_pcs_pma_basex_gtp.dcp
create_report "gig_eth_pcs_pma_basex_gtp_synth_1_synth_report_utilization_0" "report_utilization -file gig_eth_pcs_pma_basex_gtp_utilization_synth.rpt -pb gig_eth_pcs_pma_basex_gtp_utilization_synth.pb"

if { [catch {
  file copy -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp.dcp /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp.dcp /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp_stub.v /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp_stub.vhdl /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp_sim_netlist.v /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.runs/gig_eth_pcs_pma_basex_gtp_synth_1/gig_eth_pcs_pma_basex_gtp_sim_netlist.vhdl /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.ip_user_files/ip/gig_eth_pcs_pma_basex_gtp]} {
  catch { 
    file copy -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.v /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.ip_user_files/ip/gig_eth_pcs_pma_basex_gtp
  }
}

if {[file isdir /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.ip_user_files/ip/gig_eth_pcs_pma_basex_gtp]} {
  catch { 
    file copy -force /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/gig_eth_pcs_pma_basex_gtp/gig_eth_pcs_pma_basex_gtp_stub.vhdl /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.ip_user_files/ip/gig_eth_pcs_pma_basex_gtp
  }
}
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]