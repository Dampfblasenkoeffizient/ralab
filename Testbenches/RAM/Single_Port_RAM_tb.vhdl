-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;

entity Single_Port_RAM_tb is begin end;

architecture behavior of Single_Port_RAM_tb is
    signal clk : std_logic;
    signal rst : std_logic := '0';
    signal add : std_logic_vector(0 to 15) := (others => '0'); 
    signal data_in :  std_logic_vector(15 downto 0) := (others => '0');
    signal we : std_logic := '0';
    signal data_out : std_logic_vector(15 downto 0);
    constant zero : std_logic_vector(15 downto 0) := (others => '0');
    
    begin
        RAM : entity work.Single_Port_RAM generic map (16, 16) port map (clk, rst, add, we, data_in, data_out);
        clock : process
        begin
            while now < 160 ns loop
                clk <= '0';
                wait for 10 ns;
                clk <= '1';
                wait for 10 ns;    
            end loop;
            wait;
        end process;
                    
        test : process
        begin
            report "RAM Test!";

            --we = 1
            report "wring test starts";
            add <= (others => '0');
            we <= '1';
            data_in(15) <= '1';
            wait for 20 ns;

            assert data_out = data_in report "failure to write"
            severity error;

            add(14) <= '1';
            data_in(14) <= '1';
            wait for 20 ns;

            assert data_out = data_in report "failure to write"
            severity error;

            we <= '0';
            add(14) <= '0';
            wait for 20 ns;

            assert data_out(15) = '1' report "written Info did not remain at address"
            severity error;
 
            report "reading test starts";
            
            wait for 1 ns;
            add(15) <= '1';
            wait for 19 ns;

            assert data_out /= data_in report "wrote while writing flag not set" 
            severity error;

            -- rst
            report "reset test starts";
            add(15) <= '0';
            wait for 20 ns;
            rst <= '1';
            wait for 20 ns;

            assert data_out = zero report "failed to reset"
            severity error;

            add(14) <= '1';
            wait for 20 ns;
            
            assert data_out = zero report "failed to reset"
            severity error;

            we <= '1';
            wait for 20 ns;
            assert data_out = zero report "wrote while rst = 1"
            severity error;

            report "All tests have finished";
            wait;
        end process;

end behavior;    