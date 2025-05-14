-- Laboratory RA solutions/versuch3
-- Sommersemester 25
-- Group Details
-- Lab Date:
-- 1. Participant First and Last Name: Paul Riedel
-- 2. Participant First and Last Name: Clara Heilig

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Constant_package.all;
use work.types.all;
use ieee.std_logic_textio.all;

entity decoder is
    generic (
        G_WORD_WIDTH : integer := 32
    );
    port(
        pi_clk : in std_logic;
        pi_instruction : in std_logic_vector(G_WORD_WIDTH - 1 downto 0);
        po_controlWord : out controlword := control_word_init
    );
end entity decoder;

architecture arc of decoder is
    begin
        process(pi_instruction)
            variable opcode : std_logic_vector(OPCODE_WIDTH - 1 downto 0);
            variable funct3 : std_logic_vector(2 downto 0);
            variable funct7 : std_logic_vector(6 downto 0);
            variable v_insFormat : t_instruction_type;
        begin
                opcode := pi_instruction(6 downto 0);
                funct3 := pi_instruction(14 downto 12);
                funct7 := pi_instruction(31 downto 25);

                case opcode is
                    when R_INS_OP =>
                        v_insFormat := bFormat;
                    when LUI_INS_OP =>
                        v_insFormat := uFormat;
                    when AUIPC_INS_OP =>
                        v_insFormat := uFormat;
                    when JAL_INS_OP =>
                        v_insFormat := jFormat;
                    when B_INS_OP =>
                        v_insFormat := bFormat;
                    when S_INS_OP => 
                        v_insFormat := sFormat;
                    when JALR_INS_OP =>
                        v_insFormat := iFormat;
                    when L_INS_OP =>
                        v_insFormat := iFormat;
                    when I_INS_OP =>
                        v_insFormat := iFormat;
                    when others =>
                        v_insFormat := nullFormat;
                end case;

                -- decoding the opcode component of the incomming instruction

                case v_insFormat is
                    when rFormat => 
                        -- register operations (r_type) set the alu_opcode based on the operation (func3) and the selector bit (func7(1))
                        -- the immediate select bit of the alu input mux is cleared since both inputs are registers
                        po_controlWord.ALU_OP <= funct7(5) & funct3;
                        po_controlWord.I_IMM_SEL <= '0';
                    when iFormat =>
                        
                    when uFormat =>
                    
                    when bFormat =>
                        
                    when sFormat =>
                        
                    when jFormat =>

                    when nullFormat =>
                        po_controlWord <= control_word_init;
                end case;

        end process;
end architecture;