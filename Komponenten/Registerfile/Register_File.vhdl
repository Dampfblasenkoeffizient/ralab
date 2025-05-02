library ieee;
use ieee.std_logic_1164.all;

entity register_file is 
    generic (WORD_WIDTH, REG_ADR_WIDTH : integer);
    port (
        pi_clk, pi_rst, pi_writeEnable : in std_logic;
        pi_writeRegData : in std_logic_vector ((WORD_WIDTH -1) downto 0);
        pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr : in std_logic_vector ((REG_ADR_WIDTH -1) downto 0);
        po_readRegData1, po_readRegData2 : out std_logic_vector ((REG_ADR_WIDTH -1) downto 0)
    );
end register_file;

architecture behaviour of register_file is 
    signal s_write : std_logic_vector (WORD_WIDTH - 1 downto 0);
    begin
        s_write <= pi_writeRegData when pi_writeEnable = '1';
        registers : for i in REG_ADR_WIDTH * REG_ADR_WIDTH - 1 to 0 generate 
            reg : entity work.addressable_register generic map(WORD_WIDTH, REG_ADR_WIDTH, i) port map(pi_clk, pi_rst, s_write, pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr, po_readRegData1, po_readRegData2);
        end generate;
end architecture;