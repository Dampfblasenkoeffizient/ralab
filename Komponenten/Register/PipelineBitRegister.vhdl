-- Paul Riedel
-- 10.06.2025 V7

library ieee;
use ieee.std_logic_1164.all;

entity PipelineBitRegister is
    port (
        pi_clk, pi_rst, pi_stall : in std_logic := '0';
        pi_data : in std_logic;
        po_data : out std_logic := '0'
    );
end PipelineBitRegister;

architecture behavior of PipelineBitRegister is
    begin
        process(pi_clk, pi_rst)
            begin
                po_data <= '0' when pi_rst = '1' else
                    pi_data when rising_edge(pi_clk) and pi_stall = '0';
        end process;    
end architecture;    