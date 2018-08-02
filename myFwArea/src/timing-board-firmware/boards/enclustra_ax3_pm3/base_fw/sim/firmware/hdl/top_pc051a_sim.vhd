-- Top-level design for ipbus demo
--
-- You must edit this file to set the IP and MAC addresses
--
-- Dave Newbold, 08/01/16

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;

entity top is

end top;

architecture rtl of top is

	signal clk_ipb, rst_ipb, clk125, nuke, soft_rst, userled, clk200: std_logic;
	signal ipb_out: ipb_wbus;
	signal ipb_in: ipb_rbus;
	
begin

-- Infrastructure

	infra: entity work.pc051a_infra_sim -- Should work for artix also...
		port map(
			clk_ipb_o => clk_ipb,
			rst_ipb_o => rst_ipb,
			clk125_o => clk125,
			nuke => nuke,
			soft_rst => soft_rst,
			mac_addr => X"020ddba11610",
			ip_addr => X"c0a8c910", -- 192.168.201.16
			ipb_in => ipb_in,
			ipb_out => ipb_out
		);

	payload: entity work.payload_sim
		generic map(
			CARRIER_TYPE => X"00"
		)
		port map(
			ipb_clk => clk_ipb,
			ipb_rst => rst_ipb,
			ipb_in => ipb_out,
			ipb_out => ipb_in,
			clk125 => clk125,
			nuke => nuke,
			soft_rst => soft_rst
		);

end rtl;
