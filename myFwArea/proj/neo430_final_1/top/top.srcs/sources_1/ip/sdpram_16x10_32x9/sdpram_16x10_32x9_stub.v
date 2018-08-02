// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Tue Jul 17 17:59:53 2018
// Host        : kairos.phy.bris.ac.uk running 64-bit Scientific Linux release 7.5 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/sdpram_16x10_32x9/sdpram_16x10_32x9_stub.v
// Design      : sdpram_16x10_32x9
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.1" *)
module sdpram_16x10_32x9(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[15:0],clkb,addrb[8:0],doutb[31:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [15:0]dina;
  input clkb;
  input [8:0]addrb;
  output [31:0]doutb;
endmodule
