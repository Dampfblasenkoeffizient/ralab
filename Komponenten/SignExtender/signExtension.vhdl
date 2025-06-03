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
      po_imm: out std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0')
    );
   -- end solution!!
end entity signExtension;

architecture arc of signExtension is
-- begin solution:
signal s_immediateImm, s_storeImm, s_unsignedImm, s_branchImm, s_jumpImm : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
begin
    s_immediateImm(11 downto 0) <= pi_instr(31 downto 20);
    s_immediateImm(31 downto 12) <= (others => pi_instr(31));

    s_storeImm(4 downto 0) <= pi_instr(11 downto 7);
    s_storeImm(11 downto 5) <= pi_instr(31 downto 25);
    s_storeImm(31 downto 12) <= (others => pi_instr(31));

    s_unsignedImm(31 downto 12) <= pi_instr(31 downto 12);
    s_unsignedImm(11 downto 0) <= (others => '0');
    
    s_branchImm(10 downto 0) <= pi_instr(30 downto 25) & pi_instr(11 downto 8) & '0';
    s_branchImm(11) <= pi_instr(7);
    s_branchImm(12) <= pi_instr(31);
    s_branchImm(31 downto 13) <= (others => pi_instr(31));

    s_jumpImm(10 downto 0) <= pi_instr(30 downto 21) & '0';
    s_jumpImm(11) <= pi_instr(20);
    s_jumpImm(19 downto 12) <= pi_instr(19 downto 12);
    s_jumpImm(20) <= pi_instr(31);
    s_jumpImm(31 downto 21) <= (others => pi_instr(31));

    with pi_instr(6 downto 0) select po_Imm <=
      s_immediateImm when JAL_INS_OP,
      s_immediateImm when L_INS_OP,
      s_immediateImm when I_INS_OP,
      s_storeImm when S_INS_OP,
      s_unsignedImm when LUI_INS_OP,
      s_unsignedImm when AUIPC_INS_OP,
      s_branchImm when B_INS_OP,
      s_jumpImm when JAL_INS_OP;
 -- end solution!!
end architecture arc;
