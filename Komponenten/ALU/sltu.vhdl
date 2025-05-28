library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;

entity sltu is generic (G_DATA_WIDTH_GEN : integer);
port(
    opa, opb : in std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    result : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
);
end entity;

architecture structure of sltu is
begin
    result <= (0 => '1', others => '0') when unsigned(opa) < unsigned(opb) else
              (others => '0');
end architecture;