-- Top-level design for ipbus demo
--
-- You must edit this file to set the IP and MAC addresses
--
-- Dave Newbold, 08/01/16

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.ipbus_trans_decl.all;

entity top is port(
		eth_clk_p: in std_logic; -- 125MHz MGT clock
		eth_clk_n: in std_logic;
		eth_rx_p: in std_logic; -- Ethernet MGT input
		eth_rx_n: in std_logic;
		eth_tx_p: out std_logic; -- Ethernet MGT output
		eth_tx_n: out std_logic;
		sfp_los: in std_logic;
		sfp_tx_disable: out std_logic;
		leds: out std_logic_vector(7 downto 0); -- TE712 LEDs
		dip_sw: in std_logic_vector(3 downto 0); -- carrier switches
		neo_rst: in std_logic; 
		uart_txd_o : out std_logic; -- UART send data
        uart_rxd_i : in  std_logic;  -- UART receive data
        uid_scl : inout std_logic;
        uid_sda : inout std_logic
	);

end top;

architecture rtl of top is

	signal clk_ipb, rst_ipb, nuke, soft_rst, userled: std_logic;
	signal ipb_out: ipb_wbus;
	signal ipb_in: ipb_rbus;
	signal infra_leds: std_logic_vector(1 downto 0);
	signal mac_addr: std_logic_vector(47 downto 0);
	signal ip_addr: std_logic_vector(31 downto 0);
	signal s_clk_ipb, s_rst_ipb : std_logic;
	
    signal s_ipb_in:  ipb_wbus;
    signal s_ipb_out: ipb_rbus;
    signal  s_oon_in: ipbus_trans_out_array(0 downto 0);
    signal s_oon_out: ipbus_trans_in_array(0 downto 0);  
    
    signal s_spi_sclk_o : std_logic; -- serial clock line
    signal s_spi_mosi_o : std_logic; -- serial data line out
    signal s_spi_miso_i :   std_logic; -- serial data line in
    signal s_spi_cs_o   :  std_logic_vector(05 downto 0);
    signal s_clk125:  std_logic;
    signal s_rst125:  std_logic;
    signal s_clk200:  std_logic;
	
begin

-- Infrastructure

	infra: entity work.atfc_infra -- Should work for artix also...
	    generic map (
	    N_OOB =>1
	    )
		port map(
			eth_clk_p => eth_clk_p,
			eth_clk_n => eth_clk_n,
			eth_tx_p => eth_tx_p,
			eth_tx_n => eth_tx_n,
			eth_rx_p => eth_rx_p,
			eth_rx_n => eth_rx_n,
			sfp_los => sfp_los,
			clk_ipb_o => clk_ipb,
			rst_ipb_o => rst_ipb,
			clk125_o => s_clk125,
			rst125_o => s_rst125,
			clk200 => s_clk200,
			pllclk => open,
			pllrefclk => open,
			nuke => nuke,
			soft_rst => soft_rst,
			leds => infra_leds,
			debug => open,
			mac_addr => mac_addr,
			ip_addr => ip_addr,
			ipb_in => ipb_in,
			ipb_out => ipb_out,
			oob_in => s_oon_out,
			oob_out => s_oon_in
		);
		
	leds <= userled & "11" & "11" & userled & infra_leds; -- Turning on green LED will lead to blindness
	sfp_tx_disable <= '0';
	
	mac_addr <= X"020ddba1158" & dip_sw; -- Careful here, arbitrary addresses do not always work
	ip_addr <= X"c0a8eb8" & dip_sw; -- 192.168.200.16+n
	
	slaves: entity work.ipbus_example
		port map(
			ipb_clk => clk_ipb,
			ipb_rst => rst_ipb,
			ipb_in => ipb_out,
			ipb_out => ipb_in,
			nuke => nuke,
			soft_rst => soft_rst,
			userled => userled
		);
		
	neo430_test_top_inst: entity work.neo430_test_top 
          port map (
            -- global control --
            sysclk      => clk_ipb,-- global clock, rising edge
            rst_i       => neo_rst,
            -- serial com --
             uart_txd_o => uart_txd_o, -- UART send data
             uart_rxd_i => uart_rxd_i,   -- UART receive data
             
             spi_sclk_o => s_spi_sclk_o, -- serial clock line
             spi_mosi_o => s_spi_mosi_o, -- serial data line out
             spi_miso_i => s_spi_miso_i,-- serial data line in
             spi_cs_o   => s_spi_cs_o,-- SPI CS 0..5
             uid_scl    => uid_scl,
             uid_sda    => uid_sda
            
            );	
            
uc_if_inst: entity work.uc_if
               port map(
                   clk125      =>s_clk125,
                   rst125      =>s_clk125,
                   clk200      =>s_clk125,
 --Remvoing pipe singals--                   
                 uc_pipe_nrd => '0',
                 uc_pipe_nwe => '0',
                 uc_pipe     => open,
                   
                   uc_spi_miso=> s_spi_mosi_o,
                   uc_spi_mosi => s_spi_miso_i,
                   uc_spi_sck  => s_spi_sclk_o,
                   uc_spi_cs_b => s_spi_cs_o(0),
                   
                   clk_ipb     => s_clk_ipb,-- ipbus clock (nominally ~30MHz) & reset
                   rst_ipb     => s_rst_ipb,
                   ipb_in      => s_ipb_in,
                   ipb_out     => s_ipb_out,
                   oob_in      => s_oon_in(0),
                   oob_out     => s_oon_out(0)
                  
                  );    
                               

end rtl;
