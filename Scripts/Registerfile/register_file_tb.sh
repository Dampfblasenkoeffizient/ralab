#!bin/bash

# Paul Riedel

ghdl --clean

ghdl -a --std=08 Packages/constant_package.vhdl
ghdl -a --std=08 Packages/type_packages.vhdl
ghdl -a --std=08 Komponenten/Registerfile/Addressable_Register.vhdl
ghdl -a --std=08 Komponenten/Registerfile/Register_File.vhdl
ghdl -a --std=08 Testbenches/Registerfile/register_file_tb.vhdl

ghdl -e --std=08 register_file_tb

ghdl -r --std=08 register_file_tb -gG_WORD_WIDTH=16 --vcd=reg.vcd
gtkwave reg.vcd