-- Clara Heilig
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.constant_package.all;
--use work.types_package.all

-- adr_width auf 16 statt 32. oder wollen die generic?

entity Single_Port_RAM is
    generic(
        G_word_width : integer := word_width;
        G_adr_width : integer := adr_width
    );
    port(
        pi_clk : in std_logic;
        pi_rst : in std_logic;
        pi_add : in std_logic_vector (0 to G_adr_width -1); 
        pi_we : in std_logic;
        pi_data : in std_logic_vector(G_word_width -1 downto 0);
        po_data : out std_logic_vector(G_word_width -1 downto 0)
    );
end entity;    

architecture behavior of Single_Port_RAM is
    type memory is array (0 to 2 ** G_adr_width - 1) of std_logic_vector (G_word_width -1 downto 0);
    signal regs : memory := (others => (others => '0'));
    signal add : integer;
    begin
        process(pi_clk, pi_rst, pi_we)
            begin 
            if pi_rst = '1' then 
                regs <= (others => (others => '0'));
                if rising_edge(pi_clk) then 
                    po_data <= (others => '0');
                end if;
            else 
                if rising_edge(pi_clk) then
                    if(pi_we = '1') then
                        regs(to_integer(unsigned(pi_add))) <= pi_data;
                        po_data <= pi_data;    
                    else
                        po_data <= regs(to_integer(unsigned(pi_add)));  
                    end if;            
                end if;            
            end if; 
        end process;
        
    
end behavior;