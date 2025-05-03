#!bin/bash

ghdl --clean

ghdl -a Packages/constant_package.vhdl
ghdl -a Komponenten/Registerfile/Addressable_Register.vhdl
ghdl -a Komponenten/Registerfile/Register_File.vhdl
ghdl -a Testbenches/Registerfile/register_file_tb.vhdl

ghdl -e register_file_tb

ghdl -r register_file_tb