

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list sysclk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {cmp_i2c_iface/wb_dat_o[0]} {cmp_i2c_iface/wb_dat_o[1]} {cmp_i2c_iface/wb_dat_o[2]} {cmp_i2c_iface/wb_dat_o[3]} {cmp_i2c_iface/wb_dat_o[4]} {cmp_i2c_iface/wb_dat_o[5]} {cmp_i2c_iface/wb_dat_o[6]} {cmp_i2c_iface/wb_dat_o[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {cmp_i2c_iface/wb_dat_i[0]} {cmp_i2c_iface/wb_dat_i[1]} {cmp_i2c_iface/wb_dat_i[2]} {cmp_i2c_iface/wb_dat_i[3]} {cmp_i2c_iface/wb_dat_i[4]} {cmp_i2c_iface/wb_dat_i[5]} {cmp_i2c_iface/wb_dat_i[6]} {cmp_i2c_iface/wb_dat_i[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 3 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {cmp_i2c_iface/wb_adr_i[0]} {cmp_i2c_iface/wb_adr_i[1]} {cmp_i2c_iface/wb_adr_i[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {neo430_top_std_logic_inst/wb_dat_o[0]} {neo430_top_std_logic_inst/wb_dat_o[1]} {neo430_top_std_logic_inst/wb_dat_o[2]} {neo430_top_std_logic_inst/wb_dat_o[3]} {neo430_top_std_logic_inst/wb_dat_o[4]} {neo430_top_std_logic_inst/wb_dat_o[5]} {neo430_top_std_logic_inst/wb_dat_o[6]} {neo430_top_std_logic_inst/wb_dat_o[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {neo430_top_std_logic_inst/wb_dat_i[0]} {neo430_top_std_logic_inst/wb_dat_i[1]} {neo430_top_std_logic_inst/wb_dat_i[2]} {neo430_top_std_logic_inst/wb_dat_i[3]} {neo430_top_std_logic_inst/wb_dat_i[4]} {neo430_top_std_logic_inst/wb_dat_i[5]} {neo430_top_std_logic_inst/wb_dat_i[6]} {neo430_top_std_logic_inst/wb_dat_i[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 3 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {neo430_top_std_logic_inst/wb_adr_o[2]} {neo430_top_std_logic_inst/wb_adr_o[3]} {neo430_top_std_logic_inst/wb_adr_o[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 3 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {s_addr[2]} {s_addr[3]} {s_addr[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {s_data_i[0]} {s_data_i[1]} {s_data_i[2]} {s_data_i[3]} {s_data_i[4]} {s_data_i[5]} {s_data_i[6]} {s_data_i[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {s_data_o[0]} {s_data_o[1]} {s_data_o[2]} {s_data_o[3]} {s_data_o[4]} {s_data_o[5]} {s_data_o[6]} {s_data_o[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list uid_sda_TRI]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list uid_scl_TRI]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list cmp_i2c_iface/scl_pad_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list cmp_i2c_iface/scl_padoen_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list cmp_i2c_iface/sda_pad_i]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list cmp_i2c_iface/sda_padoen_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list uart_rxd_i_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list uart_txd_o_OBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets sysclk_IBUF_BUFG]
