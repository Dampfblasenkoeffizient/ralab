-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister is
    generic (
        registerWidth : integer
    );
    port (
        pi_clk, pi_rst : in std_logic;
        pi_data : in std_logic_vector ((registerWidth -1) downto 0);
        po_data : out std_logic_vector ((registerWidth -1) downto 0) := (others => '0')
    );
end PipelineRegister;

architecture behavior of PipelineRegister is
    begin
        process(pi_clk, pi_rst)
            begin
                po_data <= (others => '0') when pi_rst = '1' else
                            pi_data when rising_edge(pi_clk);
        end process;    
end architecture;    