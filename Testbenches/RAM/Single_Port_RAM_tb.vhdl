-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;

entity Single_Port_RAM_tb is begin end;

architecture behavior of Single_Port_RAM_tb is
    signal clk : std_logic;
    signal rst : std_logic;
    signal add : std_logic_vector(0 to 3);
    signal data_in :  std_logic_vector(15 downto 0);
    signal we : std_logic;
    signal data_out : std_logic_vector(15 downto 0);
    
    begin
        RAM : entity work.Single_Port_RAM port map (clk, rst, add, data_in, we, data_out);
        clock : process
        begin
            clk <= 0;
            wait for 10 ns;
            clk <= 1;
            wait for 10 ns;    
        end process;

        process
        begin
            report "RAM Test!";

            --writing
            report "writing test starts";
            rst <= 0;
            add <= 0;
            data_in <= ();
            


        end process;

end behavior;    