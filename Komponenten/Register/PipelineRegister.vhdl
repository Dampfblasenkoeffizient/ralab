library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister is
    generic (
        registerWidth : integer
    );
    port (
        pi_clk, pi_rst : in std_logic;
        pi_data : in std_logic_vector ((registerWidth -1) downto 0);
        po_data : out std_logic_vector ((registerWidth -1) downto 0)
    );
end PipelineRegister;

architecture behavior of PipelineRegister is
    begin
        process(pi_clk, pi_rst)
            begin
                if(pi_rst = '1') then
                    po_data <= (others => '0');
                else 
                    if rising_edge(pi_clk) then
                        po_data <= pi_data;
                    end if; 
                end if;
        end process;               
end architecture;    