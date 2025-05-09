#!bin/bash
# Clara Heilig

ghdl --clean

ghdl -a --std=08 Packages/constant_package.vhdl
ghdl -a --std=08 Packages/Util_Asm_Package.vhdl
ghdl -a --std=08 Komponenten/SignExtender/signExtension.vhdl
ghdl -a --std=08 Testbenches/SignExtender/signExtension_tb.vhdl

ghdl -e --std=08 signExtension_tb

ghdl -r --std=08 signExtension_tb --vcd=signExtender.vcd

gtkwave signExtender.vcd