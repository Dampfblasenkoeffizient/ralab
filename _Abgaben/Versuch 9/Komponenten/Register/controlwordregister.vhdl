-- Laboratory RA solutions/versuch9
-- Sommersemester 25
-- Group Details
-- Lab Date: 02.07.2025
-- 1. Participant First and Last Name: Clara Heilig
-- 2. Participant First and Last Name: Paul Riedel

-- ========================================================================
-- Author:       Niklas Gutsmiedl
-- Last updated: 02.2024
-- Description:  Register to hold signals of type controlWord,
--               as defined in types.vhdl. Used as phase registers  
--               for the control path in the RV pipeline
-- ========================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.all;
use work.Constant_Package.all;
use work.types.all;

entity ControlWordRegister is

  port (
    pi_rst : in std_logic;
    pi_clk, pi_stall : in std_logic := '0';
    pi_controlWord : in controlWord := CONTROL_WORD_INIT; -- incoming control word
    po_controlWord : out controlWord := CONTROL_WORD_INIT -- outgoing control word
  );
end ControlWordRegister;

architecture arc1 of ControlWordRegister is
  signal s_controlWord : controlWord := CONTROL_WORD_INIT;
begin

  process (pi_clk,pi_rst)
    
  begin
      if (pi_rst) then
        s_controlWord <= CONTROL_WORD_INIT;
      elsif rising_edge (pi_clk) then
        s_controlWord <= pi_controlWord when not pi_stall; -- update register contents on falling clock edge
    end if;
  end process;

  po_controlWord <= s_controlWord;
end arc1;
