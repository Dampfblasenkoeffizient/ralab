library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;
  use work.types.all;

entity slt is
port(
    opa, opb : in std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    result : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
);
end entity;

architecture structure of slt is
begin
    result <= (0 => '1', others => '0') when to_integer(signed(opa)) < to_integer(signed(opb)) else
              (others => '0');
end architecture;