-- Laboratory RA solutions/versuch9
-- Sommersemester 25
-- Group Details
-- Lab Date: 02.07.2025
-- 1. Participant First and Last Name: Clara Heilig
-- 2. Participant First and Last Name: Paul Riedel

library ieee;
use ieee.std_logic_1164.all;

entity PipelineBitRegister is
    port (
        pi_clk, pi_rst, pi_stall : in std_logic := '0';
        pi_data : in std_logic;
        po_data : out std_logic := '0'
    );
end PipelineBitRegister;

architecture behavior of PipelineBitRegister is
    begin
        process(pi_clk, pi_rst)
            begin
                if pi_rst = '1' then
						po_data <= '0';
					else 
						if rising_edge(pi_clk) and pi_stall = '0' then
							po_data <= pi_data;
						end if;
					end if;
        end process;    
end architecture;    