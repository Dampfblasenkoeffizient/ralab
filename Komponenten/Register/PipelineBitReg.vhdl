-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;

entity PipelineBitReg is
    port (
        pi_clk, pi_rst : in std_logic;
        pi_data : in std_logic;
        po_data : out std_logic
    );
end PipelineBitReg;

architecture behavior of PipelineBitReg is
    begin
        process(pi_clk, pi_rst)
            begin
                po_data <= '0' when pi_rst = '1' else
                            pi_data when rising_edge(pi_clk);
        end process;    
end architecture; 