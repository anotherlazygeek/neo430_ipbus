-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Tue Jul 17 17:59:53 2018
-- Host        : kairos.phy.bris.ac.uk running 64-bit Scientific Linux release 7.5 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /usersc/ng18731/neo430_test/myFwArea/proj/neo430_final_1/top/top.srcs/sources_1/ip/sdpram_16x10_32x9/sdpram_16x10_32x9_stub.vhdl
-- Design      : sdpram_16x10_32x9
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sdpram_16x10_32x9 is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 8 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end sdpram_16x10_32x9;

architecture stub of sdpram_16x10_32x9 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[9:0],dina[15:0],clkb,addrb[8:0],doutb[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_1,Vivado 2018.1";
begin
end;
