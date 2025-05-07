library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.constant_package.all;

entity register_file_tb is
     generic (G_WORD_WIDTH : integer := 16); 
end entity register_file_tb;

architecture behav of register_file_tb is

signal s_we, s_rst, s_clk : std_logic := '0';
signal s_adr1, s_adr2, s_adrWr : std_logic_vector(REG_ADR_WIDTH - 1 downto 0) := (others => '0');

signal s_reg1, s_reg2, s_reg3 : std_logic_vector(G_WORD_WIDTH - 1 downto 0) := (others => '0');
begin 
dut1 : entity work.register_file
    generic map (G_WORD_WIDTH, REG_ADR_WIDTH)
    port map(
        pi_readRegAddr1 => s_adr1,
        pi_readRegAddr2 => s_adr2,
        pi_writeRegAddr => s_adrWr,
        po_readRegData1 => s_reg1,
        po_readRegData2 => s_reg2,
        pi_writeRegData => s_reg3,
        pi_clk => s_clk,
        pi_writeEnable => s_we,
        pi_rst => s_rst 
    );

test: process is
begin
    report "test begin";
    
    s_we <= '1';
    s_adrWr <= "00100";
    s_reg3 <= std_logic_vector(to_unsigned(7, G_WORD_WIDTH));

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adr1 <= "00100";

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adrWr <= "00101";
    s_reg3 <= std_logic_vector(to_unsigned(13, G_WORD_WIDTH));

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adr2 <= "00101";

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg1 = std_logic_vector(to_unsigned(7, G_WORD_WIDTH)) and s_reg2 = std_logic_vector(to_unsigned(13, G_WORD_WIDTH))
    report "value is read incorrectly"
    severity error;

    -- write to R0

    s_adrWr <= "00000";
    s_reg3 <= std_logic_vector(to_unsigned(35, G_WORD_WIDTH));

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adr1 <= "00000";
    
    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg1 = std_logic_vector(to_unsigned(0, G_WORD_WIDTH))
    report "R0 writes to non zero after write"
    severity error;

    -- reset

    s_rst <= '1';

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg2 = std_logic_vector(to_unsigned(0, G_WORD_WIDTH))
    report "reset does not work"
    severity error;

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg2 = std_logic_vector(to_unsigned(0, G_WORD_WIDTH))
    report "write during reset possible"
    severity error;

    s_rst <= '0';
    s_we <= '0';

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg2 = std_logic_vector(to_unsigned(0, G_WORD_WIDTH))
    report "write without w_enable"
    severity error;

    -- write after reset

    s_we <= '1';
    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adrWr <= "00101";
    s_reg3 <= std_logic_vector(to_unsigned(13, G_WORD_WIDTH));

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    s_adr2 <= "00101";

    s_clk <= '0';
    wait for 1 ns;
    s_clk <= '1';
    wait for 1 ns;

    assert s_reg2 = std_logic_vector(to_unsigned(13, G_WORD_WIDTH))
    report "write after reset not possible"
    severity error;

    report "all tests finished";

    wait;
end process;

end architecture;
