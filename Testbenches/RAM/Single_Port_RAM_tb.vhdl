-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;

entity Single_Port_RAM_tb is begin end;

architecture behavior of Single_Port_RAM_tb is
    signal clk : std_logic;
    signal rst : std_logic := '0';
    signal add : std_logic_vector(0 to 31) := (others => '0'); 
    signal data_in :  std_logic_vector(15 downto 0) := (others => '0');
    signal we : std_logic := '0';
    signal data_out : std_logic_vector(15 downto 0);
    constant zero : std_logic_vector(15 downto 0) := (others => '0');
    
    begin
        RAM : entity work.Single_Port_RAM port map (clk, rst, add, we, data_in, data_out);
        clock : process
        begin
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;    
        end process;

        process
        begin
            report "RAM Test!";
            wait for 2 ns;

            --we = 0
            report "reading test starts";
            add <= (others => '0');
            we <= '0';
            data_in <= (others => '1');
            wait for 20 ns;

            assert data_out /= data_in report "wrote while writing flag not set"
            severity error;

            -- we = 1    
            report "writing test starts";
            we <= '1';
            add(31) <= '1';
            wait for 20 ns;

            assert data_out = data_in report "failure to write" 
            severity error;

            -- rst
            report "reset test starts";
            rst <= '1';
            wait for 1 ns;
            assert data_out = zero report "failed to reset"
            severity error;

            report "All tests have finished";
            wait;
        end process;

end behavior;    