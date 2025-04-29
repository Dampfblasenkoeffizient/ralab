library ieee;
use ieee.std_logic_1164.all;

entity gen_mux_tb is end;

architecture behavior of gen_mux_tb is
    component gen_mux is
        generic (
            dataWidth : Integer
        );
        port(
            pi_sel : in std_logic;
            pi_first, pi_second  : in std_logic_vector((dataWidth-1) downto 0);
            po_res : out std_logic((dataWidth-1) downto 0)
        );
    end component;    
    variable DATAWIDTH : integer := 8;
    signal pi_sel : std_logic;
    signal pi_first, pi_second, po_res : std_logic_vector((DATAWIDTH-1) downto 0);

begin
    uut : gen_mux port map(
        pi_sel => pi_sel,
        pi_first => pi_first,
        pi_second => pi_second
    );

    -- testen :(

end behavior;   