# Paul Riedel

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
ghdl -a --std=08 Komponenten/ALU/my_alu.vhdl
ghdl -a --std=08 Testbenches/ALU/my_alu_tb.vhdl

ghdl -a --std=08 Komponenten/Decoder/*
ghdl -a --std=08 Komponenten/Register/*
ghdl -a --std=08 Komponenten/Registerfile/*
ghdl -a --std=08 Komponenten/Cache/*    
ghdl -a --std=08 RISCV/*
ghdl -a --std=08 Testbenches/RISCV/R_only_RISC_V_tb.vhdl
ghdl -e --std=08 R_only_RISC_V_tb
ghdl -r --std=08 R_only_RISC_V_tb --vcd=reg.vcd
gtkwave reg.vcd
