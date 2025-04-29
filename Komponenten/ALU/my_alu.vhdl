library ieee;
use ieee.std_logic_1164.all;

use work.constant_package.AND_ALU_OP;
use work.constant_package.XOR_ALU_OP;
use work.constant_package.OR_ALU_OP;
use work.constant_package.SLL_ALU_OP;
use work.constant_package.SRL_ALU_OP;
use work.constant_package.SRA_ALU_OP;
use work.constant_package.ADD_ALU_OP;
use work.constant_package.SUB_ALU_OP;


entity my_alu is generic(
        G_DATA_WIDTH_GEN : integer := 32;
        G_ALU_OPCODE_WIDTH : integer := 4
    ); 
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opcode    : in  std_logic_vector(G_ALU_OPCODE_WIDTH - 1 downto 0);
        po_result    : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_carryOut  : out std_logic
    );
end my_alu;

architecture my_alu_arch of my_alu is
--    component and_alu
--            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--        );
--    end component;
--    component or_alu
--        port(
--            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--        );
--    end component;
--    component xor_alu
--        port(
--            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--        );
--    end component;
--    component sll_alu
--    port(
--        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--    );
--    end component;
--    component srl_alu
--    port(
--        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--    );
--    end component;
--    component sra_alu
--    port(
--        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
--    );
--    end component;
--    component add_alu
--    port(
--        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_carry     : out std_logic
--    );
--    end component;
--    component sub_alu
--    port(
--        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
--        po_carry     : out std_logic
--    );
--    end component;

    signal s_and_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_or_result  : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_xor_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sll_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_srl_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sra_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_add_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sub_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_carry : std_logic;
    
    begin

    and_alu_inst : entity work.and_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_and_result);
    or_alu_inst  : entity work.or_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_or_result);
    xor_alu_inst : entity work.xor_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_xor_result);
    sll_alu_inst : entity work.sll_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sll_result);
    srl_alu_inst : entity work.srl_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_srl_result);
    sra_alu_inst : entity work.sra_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sra_result);
    add_alu_inst : entity work.add_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_add_result, s_carry);
    sub_alu_inst : entity work.sub_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sub_result, s_carry);

    po_result <= s_and_result when pi_opcode = AND_ALU_OP else
                 s_or_result  when pi_opcode = OR_ALU_OP else
                 s_xor_result when pi_opcode = XOR_ALU_OP else
                 s_sll_result when pi_opcode = SLL_ALU_OP else
                 s_srl_result when pi_opcode = SRL_ALU_OP else
                 s_sra_result when pi_opcode = SRA_ALU_OP else
                 s_add_result when pi_opcode = ADD_ALU_OP else
                 s_sub_result when pi_opcode = SUB_ALU_OP else
                 (others => '0');
    po_carryOut <= s_carry;
end architecture my_alu_arch;
    