library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister_tb is 
end PipelineRegister_tb;

architecture behavior of PipelineRegister_tb is
    component PipelineRegister is 
        generic (
            registerWidth : integer := 8
        );
        port (
            pi_clk, pi_rst : in std_logic;
            pi_data : in std_logic_vector ((registerWidth -1) downto 0);
            po_data : in std_logic_vector ((registerWidth -1) downto 0)
        ); 
    end component;

end behavior;    