-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addressable_register is
    generic (
        WORD_WIDTH, REG_ADR_WIDTH, ADR: integer
    );
    port (
        pi_clk, pi_rst : in std_logic;
        pi_writeRegData : in std_logic_vector ((WORD_WIDTH -1) downto 0);
        pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr : in std_logic_vector ((REG_ADR_WIDTH -1) downto 0);
        po_readRegData1, po_readRegData2 : out std_logic_vector ((WORD_WIDTH -1) downto 0)
    );
end addressable_register;

architecture behavior of addressable_register is
    signal s_storage : std_logic_vector(WORD_WIDTH - 1 downto 0);
    signal s_adr : std_logic_vector(REG_ADR_WIDTH - 1 downto 0);

    begin
        s_adr <= std_logic_vector(to_unsigned(ADR, REG_ADR_WIDTH));
        s_storage <= (others => '0') when pi_rst = '1' else
                    pi_writeRegData when pi_writeRegAddr = s_adr and rising_edge(pi_clk);
        po_readRegData1 <= s_storage when pi_readRegAddr1 = s_adr and rising_edge(pi_clk) else 
                    (others => 'Z');
        po_readRegData2 <= s_storage when pi_readRegAddr2 = s_adr and rising_edge(pi_clk)else 
                    (others => 'Z');
end architecture;    