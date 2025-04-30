#!/bin/bash
#for file in $(find . -type f -name "*.vhdl"); do
#    ghdl -a "$file"
#done   
#ghdl -e my_alu_tb


ghdl --clean

# Analyze
ghdl -a --std=08 Packages/constant_package.vhdl
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

# Elaborate
ghdl -e --std=08 my_alu_tb

# Run 
ghdl -r --std=08 my_alu_tb