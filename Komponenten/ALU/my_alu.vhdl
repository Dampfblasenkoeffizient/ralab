library ieee;
use ieee.std_logic_1164.all;

use work.constant_package.all;


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
    component and_alu
        port(
            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component or_alu
        port(
            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component xor_alu
        port(
            pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component sll_alu
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component srl_alu
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component sra_alu
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component add_alu
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out std_logic
    );
    end component;
    component sub_alu
    port(
        pi_opa       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out std_logic
    );
    end component;

    signal s_and_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_or_result  : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_xor_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sll_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_srl_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sra_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_add_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_sub_result : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    signal s_carry : std_logic_vector(G_DATA_WIDTH_GEN - 1 downto 0);
    
    begin

    and_alu_inst : and_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_and_result);
    or_alu_inst : or_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_or_result);
    xor_alu_inst : xor_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_xor_result);
    sll_alu_inst : sll_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sll_result);
    srl_alu_inst : srl_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_srl_result);
    sra_alu_inst : sra_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sra_result);
    add_alu_inst : add_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_add_result, s_carry);
    sub_alu_inst : sub_alu generic map(G_DATA_WIDTH_GEN) port map(pi_opa, pi_opb, s_sub_result, s_carry);


        process(pi_opa, pi_opb, pi_opcode)
        variable v_opcode : std_logic_vector(G_ALU_OPCODE_WIDTH - 1 downto 0);
        begin
            v_opcode := pi_opcode(G_ALU_OPCODE_WIDTH - 1 downto 0);
            with v_opcode select 
                po_result    <= s_and_result when AND_ALU_OP,
                                s_or_result  when OR_ALU_OP,
                                s_xor_result when XOR_ALU_OP,
                                s_sll_result when SLL_ALU_OP,
                                s_srl_result when SRL_ALU_OP,
                                s_sra_result when SRA_ALU_OP,
                                s_add_result when ADD_ALU_OP,
                                s_sub_result when SUB_ALU_OP;
            po_carryOut <= s_carry;
        end process;
end architecture my_alu_arch;
    