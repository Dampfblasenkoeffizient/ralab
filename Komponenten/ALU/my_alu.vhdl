library ieee;
use ieee.std_logic_1164.all;

use work.constant_package.all;


entity my_alu is generic(
        G_DATA_WIDTH_GEN : integer := 32;
        G_ALU_OPCODE_WIDTH : integer := 4
    ); 
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opcode    : in  std_logic_vector(ALU_OPCODE_WIDTH - 1 downto 0);
        po_result    : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_carryOut  : out std_logic
    );
end my_alu;

architecture my_alu_arch of my_alu is
    component and_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component or_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component xor_alu
        port(
            pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
            po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
        );
    end component;
    component sll_alu
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component srl_alu
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component sra_alu
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0)
    );
    end component;
    component add_alu
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out std_logic
    );
    end component;
    component sub_alu
    port(
        pi_opa       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        pi_opb       : in  std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_out       : out std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
        po_carry     : out std_logic
    );
    end component;

    signal and_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal or_result  : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal xor_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal sll_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal srl_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal sra_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal add_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    signal sub_result : std_logic_vector(DATA_WIDTH_GEN - 1 downto 0);
    
    begin

    and_alu_inst : and_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, and_result);
    or_alu_inst : or_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, or_result);
    xor_alu_inst : xor_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, xor_result);
    sll_alu_inst : sll_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, sll_result);
    srl_alu_inst : srl_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, srl_result);
    sra_alu_inst : sra_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, sra_result);
    add_alu_inst : add_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, add_result, po_carry);
    sub_alu_inst : sub_alu generic map(DATA_WIDTH_GEN) port map(pi_opa, pi_opb, sub_result, po_carry);


        process(pi_opa, pi_opb, pi_opcode)
        variable v_opcode : std_logic_vector(ALU_OPCODE_WIDTH - 1 downto 0);
        begin
            v_opcode := pi_opcode(ALU_OPCODE_WIDTH - 1 downto 0);
            with v_opcode is 
                po_result    <= and_result when AND_ALU_OP;
                                or_result  when OR_ALU_OP;
                                xor_result when XOR_ALU_OP;
                                sll_result when SLL_ALU_OP;
                                srl_result when SRL_ALU_OP;
                                sra_result when SRA_ALU_OP;
                                add_result when ADD_ALU_OP;
                                sub_result when SUB_ALU_OP;
            end with;
        end process;
end architecture my_alu_arch;
    