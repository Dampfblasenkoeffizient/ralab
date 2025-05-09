-- Laboratory RA solutions/versuch3
-- Sommersemester 25
-- Group Details
-- Lab Date: 14.05.2025
-- 1. Participant First and Last Name: Clara Heilig
-- 2. Participant First and Last Name: Paul Riedel

-- ========================================================================
-- Description:  Sign extender for a RV32I processor. Takes the entire instruction
--               and produces a 32-Bit value by sign-extending, shifting and piecing
--               together the immedate value in the instruction.
-- ========================================================================

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;

entity signExtension is
-- begin solution:
    port(
      pi_instr : in std_logic_vector(WORD_WIDTH - 1 downto 0);
      po_immediateImm, po_storeImm, po_unsignedImm, po_branchImm, po_jumpImm : out std_logic_vector(WORD_WIDTH - 1 downto 0)
    );
   -- end solution!!
end entity signExtension;

architecture arc of signExtension is
-- begin solution:
begin

    po_immediateImm(11 downto 0) <= pi_instr(31 downto 20);
    po_immediateImm(31 downto 12) <= (others => pi_instr(31));

    po_storeImm(5 downto 0) <= pi_instr(11 downto 7);
    po_storeImm(13 downto 6) <= pi_instr(31 downto 25);
    po_storeImm(31 downto 14) <= (others => pi_instr(31));

    po_unsignedImm(20 downto 0) <= pi_instr(31 downto 12);
    po_unsignedImm(31 downto 21) <= (others => pi_instr(31));

    po_branchImm(5 downto 0) <= pi_instr(11 downto 7);
    po_branchImm(12 downto 6) <= pi_instr(31 downto 25);
    po_branchImm(31 downto 13) <= (others => pi_instr(31));

    po_jumpImm(20 downto 0) <= pi_instr(31 downto 12);
    po_jumpImm(31 downto 21) <= (others => pi_instr(31));
 -- end solution!!
end architecture arc;
