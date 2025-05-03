-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.types_package.all;

entity Single_Port_RAM is
    generic(
        word_width : integer;
        adr_width : integer 
    );
    port(
        pi_clk : in std_logic;
        pi_rst : in std_logic;
        pi_add : in std_logic_vector (adr_width -1 downto 0);
        pi_we : in std_logic;
        po_data : out memory
    );
end entity;    

architecture behavior of Single_Port_RAM is
    
    begin
        process(pi_clk, pi_rst, pi_we)
        VARIABLE i : Integer := 0;

        if not rising_edge(pi_clk) -- do nothing
        else
            if pi_rst = '1' then 
                for i in 0 to 5 loop
                    po_data (i) <= (others => '0');
                end loop;    
            else if pi_we = '1' then -- adrr wie?


            end if;            
        end if;            
        end process;
    
end behavior;