library ieee;
use ieee.std_logic_1164.all;
use work.constant_package.all;
use work.types.all;

entity fourWayMux is
    port(
        pi_sel : in std_logic_vector(1 downto 0) := (others => '0');
        pi_0, pi_1, pi_2, pi_3 : in std_logic_vector(WORD_WIDTH - 1 downto 0) := (others => '0');
        po : out std_logic_vector(WORD_WIDTH - 1 downto 0)
    );
end entity;

architecture fourWayMux_arch of fourWayMux is
begin
    po <=   pi_0 when pi_sel = "00" else
            pi_1 when pi_sel = "01" else
            pi_2 when pi_sel = "10" else
            pi_3 when pi_sel = "11";
end architecture;