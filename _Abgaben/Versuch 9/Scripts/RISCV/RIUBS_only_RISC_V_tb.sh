# 02.07.2025 V9

ghdl --clean
ghdl -a --std=08 Packages/constant_package.vhdl
ghdl -a --std=08 Packages/types.vhdl
ghdl -a --std=08 Packages/type_packages.vhdl
ghdl -a --std=08 Packages/Util_Asm_Package.vhdl

ghdl -a --std=08 Komponenten/ALU/fadd.vhdl
ghdl -a --std=08 Komponenten/ALU/add_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/and_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/sll_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/or_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/xor_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/sra_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/srl_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/sub_alu.vhdl
ghdl -a --std=08 Komponenten/ALU/slt.vhdl
ghdl -a --std=08 Komponenten/ALU/sltu.vhdl
ghdl -a --std=08 Komponenten/ALU/my_alu.vhdl

ghdl -a --std=08 Komponenten/Decoder/*
ghdl -a --std=08 Komponenten/Register/*
ghdl -a --std=08 Komponenten/Registerfile/*
ghdl -a --std=08 Komponenten/Cache/*    
ghdl -a --std=08 Komponenten/SignExtender/signExtension.vhdl
ghdl -a --std=08 Komponenten/Multiplexer/*
ghdl -a --std=08 Komponenten/RAM/*


ghdl -a --std=08 RISCV/riubs_only_RISC_V.vhdl
ghdl -a --std=08 Testbenches/RISCV/riubs_only_RISC_V_tb.vhdl
ghdl -a --std=08 Testbenches/RISCV/riubs_only_RISC_V_tb2.vhdl
ghdl -a --std=08 Testbenches/RISCV/riubs_only_RISC_V_tb3.vhdl
#ghdl -e --std=08 riubs_only_RISC_V_tb
ghdl -e --std=08 riubs_only_RISC_V_tb2
ghdl -e --std=08 riubs_only_RISC_V_tb3
#ghdl -r --std=08 riubs_only_RISC_V_tb --wave=riscv.ghw
echo "---------------- \ running test bench 2 \ ----------------\n"
ghdl -r --std=08 riubs_only_RISC_V_tb2
echo "----------------\ running test bench 3 \ ----------------\n"
ghdl -r --std=08 riubs_only_RISC_V_tb3
gtkwave riscv.ghw 