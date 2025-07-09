library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  use work.constant_package.all;
  use work.types.all;
  use work.util_asm_package.all;

entity risc_v is 
    port (
        KEY     : in std_logic_vector(1 downto 0) := "00";
        SW      : in std_logic_vector(9 downto 0);
        LEDR    : out std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(6 downto 0)
    );
end entity;

architecture risc_v_arch of risc_v is
    signal s_instructions : memory := (others => (others => '0'));
    signal s_instrIF : std_logic_vector(WORD_WIDTH - 1 downto 0) :=  (others => '0');
	 signal s_registersOut : registerMemory := (others => (others => '0'));
    type sevenSegArray is array (5 downto 0 ) of std_logic_vector (6 downto 0);
    signal seg_patterns : sevenSegArray := (others => (others => '0'));

begin
    riubs_inst : entity work.riubs_only_RISC_V
    port map(
        pi_rst => KEY(0),
        pi_clk => KEY(1),
        pi_instruction => s_instructions,
		  po_registersOut => s_registersOut,
        po_debugInstr => s_instrIF
    );

    LEDR <= s_registersOut(to_integer(unsigned(SW(4 downto 0))))(7 downto 0);

    gen_decoder : for i in 0 to 5 generate
        decoder_inst : entity work.hex_7seg_decoder
        port map(
            bin_in => s_instrIF((i * 4 + 3) downto (i * 4)),
            seg_out => seg_patterns(i)
        );
    end generate;
    
    HEX0 <= seg_patterns(0);
    HEX1 <= seg_patterns(1);
    HEX2 <= seg_patterns(2);
    HEX3 <= seg_patterns(3);
    HEX4 <= seg_patterns(4);
    HEX5 <= seg_patterns(5);
	 
	 --- BSP Code

    -- s_instructions(1) <= Asm2Std("ADDI", 1, 0, 9);
    -- s_instructions(2) <= Asm2Std("ADDI", 2, 0, 8);
    -- s_instructions(3) <= Asm2Std("OR", 10, 1, 2);
    -- s_instructions(4) <= Asm2Std("ADD", 8, 1, 2);
    -- s_instructions(5) <= Asm2Std("SUB", 11, 1, 2);
    -- s_instructions(6) <= Asm2Std("SUB", 12, 2, 1);
    -- s_instructions(7) <= Asm2Std("ADD", 12, 2, 8);
    -- s_instructions(8) <= Asm2Std("SUB", 12, 2, 1);
    -- s_instructions(9) <= Asm2Std("AND", 1, 2, 1);
    -- s_instructions(10) <= Asm2Std("XOR", 12, 1, 2);
    -- s_instructions(11) <= Asm2Std("LUI", 13, 8, 0);
    -- s_instructions(12) <= Asm2Std("LUI", 13, 29, 0);
    -- s_instructions(13) <= Asm2Std("AUIPC", 14, 1, 0);
    -- s_instructions(14) <= Asm2Std("AUIPC", 14, 1, 0);
	 
	 
	 --- FIB
	 
	 s_instructions(1) <= Asm2Std("ADDI", 5, 0, 8);
    s_instructions(2) <= Asm2Std("ADDI", 6, 0, 0);
    s_instructions(3) <= Asm2Std("ADDI", 7, 0, 1);
    s_instructions(4) <= Asm2Std("ADDI", 10, 0, 10);
    s_instructions(5) <= Asm2Std("ADDI", 29, 0, 2);
	 
    s_instructions(6) <= Asm2Std("SW", 6, 0, 0);
    s_instructions(7) <= Asm2Std("SW", 7, 4, 0);
	 
	 -- for
	 
    s_instructions(8) <= Asm2Std("BEQ", 29, 10, 32); -- 32 => end
    s_instructions(9) <= Asm2Std("ADDI", 29, 29, 1);
    s_instructions(10) <= Asm2Std("ADD", 28, 6, 7);
    s_instructions(11) <= Asm2Std("SW", 28, 0, 5);
    s_instructions(12) <= Asm2Std("ADD", 6, 7, 0);
    s_instructions(13) <= Asm2Std("ADD", 7, 28, 0);
    s_instructions(14) <= Asm2Std("ADDI", 5, 5, 4);
	 s_instructions(15) <= Asm2Std("JAL", 0, -28, 0); -- -28 => for
	 
	 --end
	 
	 s_instructions(16) <= Asm2Std("ADDI", 0, 0, 0);




end architecture;