-- Laboratory RA solutions/versuch4
-- Sommersemester 25
-- Group Details
-- Lab Date: 21.05.2025
-- 1. Participant First and Last Name: Clara Heilig
-- 2. Participant First and Last Name: Paul Riedel

-- ========================================================================
-- Author:       Marcel Rieß
-- Last updated: 14.05.2025
-- Description:  R-Only-RISC-V foran incomplete RV32I implementation, support
--               only R-Instructions. 
--
-- ========================================================================

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;
  use work.types.all;
  use work.util_asm_package.all;
  
entity R_only_RISC_V_2_tb is
end entity R_only_RISC_V_2_tb;

architecture structure of R_only_RISC_V_2_tb is

  constant PERIOD                : time                                           := 10 ns;
  -- signals
  -- begin solution:
  signal s_rst : std_logic := '1';
  signal s_clk : std_logic := '0';
  -- end solution!!
  signal   s_registersOut    : registerMemory := (others => (others => '0'));
  signal   s_instructions : memory                                     := (
    -- begin solution:
      (others => '0'),
      (others => '0'),
      (others => '0'),
      --(others => '0'),
      --(others => '0'),
      std_logic_vector'("0000000" &  STD_LOGIC_VECTOR(to_unsigned(1, 5)) & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & "000" & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & R_INS_OP),
      std_logic_vector'("0000000" &  STD_LOGIC_VECTOR(to_unsigned(1, 5)) & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & "000" & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & R_INS_OP),
      std_logic_vector'("0000000" &  STD_LOGIC_VECTOR(to_unsigned(1, 5)) & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & "000" & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & R_INS_OP),
      std_logic_vector'("0000000" &  STD_LOGIC_VECTOR(to_unsigned(1, 5)) & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & "000" & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & R_INS_OP),
      std_logic_vector'("0000000" &  STD_LOGIC_VECTOR(to_unsigned(1, 5)) & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & "000" & STD_LOGIC_VECTOR(to_unsigned(2, 5)) & R_INS_OP),
      others => (others => '0')
  -- end solution!!
                                  );

begin
-- Instanziierung der Entity
riscv_inst : entity work.R_only_RISC_V
  port map (
    pi_rst             => s_rst,
    pi_clk             => s_clk,
    pi_instruction     => s_instructions,
    po_registersOut    => s_registersOut
  );

  process is


  begin
   wait for PERIOD/2;
   for i in 1 to 21 loop
      s_clk <= '1';
      wait for PERIOD / 2;
      s_clk <= '0';
      wait for PERIOD / 2;

    -- begin solution:
      if(i = 2) then s_rst <= '0';
      end if;

      report integer'image(to_integer(unsigned(s_registersOut(2))));
      --assert (to_integer(unsigned(s_registersOut(2))) = 8 + 9 * i) report "Test failed in Takt" & integer'image(i)
      --severity error;
    -- end solution!!

    end loop;
    report "End of test!!!";
wait;

  end process;

end architecture;
