library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity gen_mux is 
    generic (
        dataWidth : integer
    );
    port (
        pi_sel : in std_logic_vector(1 downto 0);
        pi_a, pi_b, pi_c, pi_d : in std_logic_vector((dataWidth-1) downto 0); 
        po_res : out std_logic_vector((dataWidth-1) downto 0) := (others => '0')
    );
end gen_mux;    

architecture behavior of gen_mux is 
begin
    with pi_sel select po_res <=
        pi_a when "00",
        pi_b when "01",
        pi_c when "10",
        pi_d when "11";
end architecture    