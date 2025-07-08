-- Paul Riedel
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constant_package.all;




entity my_alu is generic(
        G_DATA_WIDTH_GEN : integer := 32;
        G_ALU_OPCODE_WIDTH : integer := 4
    ); 
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opcode    : in  std_logic_vector(G_ALU_OPCODE_WIDTH - 1 downto 0);
        po_result    : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0) := (others => '0');
        po_carryOut, po_zero  : out std_logic := '0'
    );
end my_alu;

architecture my_alu_arch of my_alu is

    signal s_and_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_or_result  : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_xor_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sll_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_srl_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sra_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_add_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sub_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_add_carry, s_sub_carry : std_logic;
    
    signal s_slt_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sltu_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
	 
	 signal s_out : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);

    begin

    and_alu_inst : entity work.and_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_and_result);
    or_alu_inst  : entity work.or_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_or_result);
    xor_alu_inst : entity work.xor_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_xor_result);
    sll_alu_inst : entity work.sll_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sll_result);
    srl_alu_inst : entity work.srl_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_srl_result);
    sra_alu_inst : entity work.sra_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sra_result);
    add_alu_inst : entity work.add_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_add_result, s_add_carry);
    sub_alu_inst : entity work.sub_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sub_result, s_sub_carry);
    
    slt_alu_inst : entity work.slt generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_slt_result);
    sltu_alu_inst : entity work.sltu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sltu_result);

    s_out <= s_and_result when pi_opcode = AND_ALU_OP else
                 s_or_result  when pi_opcode = OR_ALU_OP else
                 s_xor_result when pi_opcode = XOR_ALU_OP else
                 s_sll_result when pi_opcode = SLL_ALU_OP else
                 s_srl_result when pi_opcode = SRL_ALU_OP else
                 s_sra_result when pi_opcode = SRA_ALU_OP else
                 s_add_result when pi_opcode = ADD_ALU_OP else
                 s_sub_result when pi_opcode = SUB_ALU_OP else
                 s_slt_result when pi_opcode = SLT_ALU_OP else
                 s_sltu_result when pi_opcode = SLTU_ALU_OP else

                 (others => '0');
					  
	 po_result <= s_out;
    po_carryOut <= s_add_carry when pi_opcode = ADD_ALU_OP else s_sub_carry when pi_opcode = SUB_ALU_OP else '0';
    po_zero <= '1' when s_out = std_logic_vector(to_unsigned(0, G_DATA_WIDTH_GEN)) else '0';
end architecture my_alu_arch;
    