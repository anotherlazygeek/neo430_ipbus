set_property SRC_FILE_INFO {cfile:/usersc/ng18731/ATFC_IPBus_neo_test/neo430_test/myFwArea/proj/neo430_final/top/top.srcs/sources_1/ip/temac_gbe_v9_0/synth/temac_gbe_v9_0.xdc rfile:../../../top.srcs/sources_1/ip/temac_gbe_v9_0/synth/temac_gbe_v9_0.xdc id:1 order:EARLY scoped_inst:U0} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_0_core/flow/rx_pause/pause*to_tx_reg[*]}] -to [get_cells {temac_gbe_v9_0_core/flow/tx_pause/count_set*reg}] 32 -datapath_only
set_property src_info {type:SCOPED_XDC file:1 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_0_core/flow/rx_pause/pause*to_tx_reg[*]}] -to [get_cells {temac_gbe_v9_0_core/flow/tx_pause/pause_count*reg[*]}] 32 -datapath_only
set_property src_info {type:SCOPED_XDC file:1 line:38 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay -from [get_cells {temac_gbe_v9_0_core/flow/rx_pause/pause_req_to_tx_int_reg}] -to [get_cells {temac_gbe_v9_0_core/flow/tx_pause/sync_good_rx/data_sync_reg0}] 6 -datapath_only
