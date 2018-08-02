-- #################################################################################################
-- #  << NEO430 - Processor Test Implementation (neo430_test.vhd) >>                               #
-- # ********************************************************************************************* #
-- #  If you do not have an own design (yet), you can use this unit as top entity to play with     #
-- #  the NEO430 processor. Take a look at the project's documentary (chapter "Let's Get It        #
-- #  Started!") to get more information.                                                          #
-- # ********************************************************************************************* #
-- # This file is part of the NEO430 Processor project: https://github.com/stnolting/neo430        #
-- # Copyright by Stephan Nolting: stnolting@gmail.com                                             #
-- #                                                                                               #
-- # This source file may be used and distributed without restriction provided that this copyright #
-- # statement is not removed from the file and that any derivative work contains the original     #
-- # copyright notice and the associated disclaimer.                                               #
-- #                                                                                               #
-- # This source file is free software; you can redistribute it and/or modify it under the terms   #
-- # of the GNU Lesser General Public License as published by the Free Software Foundation,        #
-- # either version 3 of the License, or (at your option) any later version.                       #
-- #                                                                                               #
-- # This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;      #
-- # without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.     #
-- # See the GNU Lesser General Public License for more details.                                   #
-- #                                                                                               #
-- # You should have received a copy of the GNU Lesser General Public License along with this      #
-- # source; if not, download it from https://www.gnu.org/licenses/lgpl-3.0.en.html                #
-- # ********************************************************************************************* #
-- # Stephan Nolting, Hannover, Germany                                                 24.04.2018 #
-- #################################################################################################

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library neo430;
--use neo430.neo430_package.all;
use work.neo430_package.all;

entity neo430_test is
  port (
    -- global control --
    sysclk      : in  std_ulogic; -- global clock, rising edge
    rst_i      : in  std_ulogic; -- global reset, async, LOW-active
    -- parallel io --
    leds     : out std_ulogic_vector(07 downto 0); -- parallel output
    -- serial com --
    uart_txd_o : out std_ulogic; -- UART send data
    uart_rxd_i : in  std_ulogic  -- UART receive data
    
    uid_scl : out std_logic;
    uid_sda : inout std_logic;
    
    
  );
end neo430_test;

architecture neo430_test_rtl of neo430_test is

  -- wishbone/ipbus signals.
    signal ipbus_wbus : ipb_wbus;
    signal ipbus_rbus : ipb_rbus;
    
    signal s_addr : std_ulogic_vector(31 downto 0); -- address
    signal s_do  : std_ulogic_vector(31 downto 0); 

  -- local signals --
  signal gpio_out : std_ulogic_vector(15 downto 0);
  signal rst_int  : std_ulogic;
  
  signal s_sda     : std_logic;
    
begin

  
  -- The Core of the Problem --------------------------------------------------
  -- -----------------------------------------------------------------------------
  neo430_top_test_inst: neo430_top
  generic map (
    -- general configuration --
    CLOCK_SPEED => 100000000,         -- main clock in Hz
    IMEM_SIZE   => 4*1024,            -- internal IMEM size in bytes, max 32kB (default=4kB)
    DMEM_SIZE   => 2*1024,            -- internal DMEM size in bytes, max 28kB (default=2kB)
    -- additional configuration --
    USER_CODE   => x"CAFE",           -- custom user code
    -- module configuration --
    DADD_USE    => true,              -- implement DADD instruction? (default=true)
    MULDIV_USE  => true,              -- implement multiplier/divider unit? (default=true)
    WB32_USE    => true,              -- implement WB32 unit? (default=true)
    WDT_USE     => true,              -- implement WDT? (default=true)
    GPIO_USE    => true,              -- implement GPIO unit? (default=true)
    TIMER_USE   => true,              -- implement timer? (default=true)
    USART_USE   => true,              -- implement USART? (default=true)
    CRC_USE     => true,              -- implement CRC unit? (default=true)
    CFU_USE     => false,             -- implement custom functions unit? (default=false)
    PWM_USE     => true,              -- implement PWM controller? (default=true)
    TRNG_USE    => false,             -- implement true random number generator? (default=false)
    -- boot configuration --
    BOOTLD_USE  => true,              -- implement and use bootloader? (default=true)
    IMEM_AS_ROM => false              -- implement IMEM as read-only memory? (default=false)
  )
  port map (
    -- global control --
    clk_i      => sysclk,              -- global clock, rising edge
    rst_i      => rst_int,            -- global reset, async, low-active
    -- gpio --
    gpio_o     => gpio_out,           -- parallel output
    gpio_i     => x"0000",            -- parallel input
    -- pwm channels --
    pwm_o      => open,               -- pwm channels
    -- serial com --
    uart_txd_o => uart_txd_o,         -- UART send data
    uart_rxd_i => uart_rxd_i,         -- UART receive data
    spi_sclk_o => open,               -- serial clock line
    spi_mosi_o => open,               -- serial data line out
    spi_miso_i => '0',                -- serial data line in
    spi_cs_o   => open,               -- SPI CS 0..5
   
    -- 32-bit wishbone interface --
       wb_adr_o   => s_addr,               -- address
    wb_dat_i   => std_ulogic_vector(ipbus_rbus.ipb_rdata),        -- read data
    wb_dat_o   => s_do,               -- write data
    wb_we_o    => ipbus_wbus.ipb_write,               -- read/write
    wb_sel_o   => open,               -- byte enable
    wb_stb_o   => ipbus_wbus.ipb_strobe,               -- strobe
    wb_cyc_o   => open,               -- valid cycle
    wb_ack_i   => ipbus_rbus.ipb_ack,                -- transfer acknowledge
   
    -- external interrupt --
    irq_i      => '0',                -- external interrupt request line
    irq_ack_o  => open                -- external interrupt request acknowledge
  );

   cmp_i2c_iface: entity work.ipbus_i2c_master
      port map(
          clk => clk_i,
          rst => '0',
          ipb_in => ipbus_wbus,
          ipb_out => ipbus_rbus,
          scl => uid_scl,
          sda_o => s_sda,
          sda_i => uid_sda
      );

    uid_sda <= '0' when s_sda = '0' else 'Z';

  -- constrain output signals --
  leds <= gpio_out(7 downto 0);

  -- internal reset (must be low-active!) --
  rst_int <= rst_i; -- invert me?!


end neo430_test_rtl;
