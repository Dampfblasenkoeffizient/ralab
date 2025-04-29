library ieee;
use ieee.std_logic_1164.all;

entity PipelineRegister_tb is 
end PipelineRegister_tb;

architecture behavior of PipelineRegister_tb is
    component PipelineRegister is 
        generic (
            registerWidth : integer 
        );
        port (
            pi_clk, pi_rst : in std_logic;
            pi_data : in std_logic_vector ((registerWidth -1) downto 0);
            po_data : out std_logic_vector ((registerWidth -1) downto 0)
        ); 
    end component;
    variable REGISTERWIDTH : integer := 8;
    signal pi_clk, pi_rst : std_logic;
    signal pi_data, po_data: std_logic_vector ((REGISTERWIDTH -1) downto 0); -- registerwidth var hier

    begin
        uut : PipelineRegister port map (
            pi_clk => pi_clk,
            pi_rst => pi_rst,
            pi_data => pi_data,
            po_data => po_data
        );

        -- wie?
        -- testen für REGISTERWIDTH 5, 6, 8, 16, 32

end behavior;    