-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use work.constant_package.all;
use work.types.all;
use ieee.numeric_std.all;

entity register_file is 
    generic (
        G_WORD_WIDTH : integer := WORD_WIDTH; 
        G_REG_ADR_WIDTH : integer := REG_ADR_WIDTH
    );
    port (
        pi_clk, pi_rst, pi_writeEnable : in std_logic;
        pi_writeRegData : in std_logic_vector ((G_WORD_WIDTH -1) downto 0);
        pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr : in std_logic_vector ((G_REG_ADR_WIDTH -1) downto 0);
        po_readRegData1, po_readRegData2 : out std_logic_vector ((G_WORD_WIDTH -1) downto 0) := (others => '0');
        po_registerOut : out registermemory := (others => (others => '0'))
    );
end register_file;

architecture behavior of register_file is

    signal s_registers : registermemory := (
                    -- 1 => std_logic_vector(to_unsigned(9, WORD_WIDTH)),
                    -- 2 => std_logic_vector(to_unsigned(8, WORD_WIDTH)),
                    others => (others => '0')
                    );
    signal s_read1, s_read2 : std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');

    begin
        process(pi_clk, pi_rst)
        begin
            if pi_rst = '1' then
                s_registers <= (others => (others => '0')
                    );
            else if rising_edge(pi_clk) then
                s_read1 <= s_registers(to_integer(unsigned(pi_readRegAddr1)));
                s_read2 <= s_registers(to_integer(unsigned(pi_readRegAddr2)));
                if pi_writeEnable = '1' and (to_integer(unsigned(pi_writeRegAddr)) /= 0) then 
                    s_registers(to_integer(unsigned(pi_writeRegAddr))) <= pi_writeRegData;
                end if;
            end if;
            end if;
        end process;

        po_readRegData1 <= s_read1;
        po_readRegData2 <= s_read2;
        po_registerOut <= s_registers;

end architecture;

