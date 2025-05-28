-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity gen_mux is 
    generic (
        dataWidth : integer
    );
    port (
        pi_sel : in std_logic;
        pi_first, pi_second : in std_logic_vector((dataWidth-1) downto 0); 
        po_res : out std_logic_vector((dataWidth-1) downto 0) := (others => '0')
    );
end gen_mux;    

architecture behavior of gen_mux is 
begin
    po_res <= pi_first when pi_sel = '0' else pi_second;
--    process(pi_first, pi_second, pi_sel)
--    begin
--        if pi_sel = '0' then
--            po_res <= pi_first;
--        else po_res <= pi_second;  
--        end if;
--    end process; 
end architecture;    