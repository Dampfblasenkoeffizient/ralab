-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use work.types_package.all;
use work.constant_package.all;
use ieee.numeric_std.all;

entity register_file is 
    generic (
        G_WORD_WIDTH : integer := WORD_WIDTH; 
        G_REG_ADR_WIDTH : integer := 4
    );
    port (
        pi_clk, pi_rst, pi_writeEnable : in std_logic;
        pi_writeRegData : in std_logic_vector ((G_WORD_WIDTH -1) downto 0);
        pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr : in std_logic_vector ((G_REG_ADR_WIDTH -1) downto 0);
        po_readRegData1, po_readRegData2 : out std_logic_vector ((G_WORD_WIDTH -1) downto 0)
    );
end register_file;

-- architecture behaviour of register_file is 
--     signal s_write : std_logic_vector (G_WORD_WIDTH - 1 downto 0);
--     signal s_zeros : std_logic_vector (G_REG_ADR_WIDTH - 1 downto 0);
-- begin
--         s_write <= pi_writeRegData when pi_writeEnable = '1';
--         po_readRegData1 <= (others => '0') when pi_readRegAddr1 = s_zeros and rising_edge(pi_clk) else 
--                     (others => 'Z');
--         po_readRegData2 <= (others => '0') when pi_readRegAddr2 = s_zeros and rising_edge(pi_clk) else   
--                     (others => 'Z');
--         registers : for i in 1 to 2 ** G_REG_ADR_WIDTH generate
--                 reg : entity work.addressable_register generic map(G_WORD_WIDTH, G_REG_ADR_WIDTH, i) port map(pi_clk, pi_rst, s_write, pi_readRegAddr1, pi_readRegAddr2, pi_writeRegAddr, po_readRegData1, po_readRegData2);
--         end generate;
-- end architecture;

architecture behavior of register_file is

    signal s_storage : registermemory := (others => (others => '0'));
    begin
        process(pi_clk, pi_rst)
        begin
            if pi_rst = '1' then
                s_storage <= (others => (others => '0'));
            else if rising_edge(pi_clk) then
                if pi_writeEnable = '1' and (to_integer(unsigned(pi_writeRegAddr)) /= 0) then 
                    s_storage(to_integer(unsigned(pi_writeRegAddr))) <= pi_writeRegData;
                end if;
                end if;
            end if;
            po_readRegData1 <= s_storage(to_integer(unsigned(pi_readRegAddr1)));
            po_readRegData2 <= s_storage(to_integer(unsigned(pi_readRegAddr2)));
        end process;

end architecture;