#!/bin/bash 
# Clara Heilig

ghdl --clean

ghdl -a --std=08 Komponenten/RAM/Single_Port_RAM.vhdl
ghdl -a --std=08 Komponenten/RAM/Single_Port_RAM_tb.vhdl

ghdl -e --std=08 Testbenches/RAM/Single_Port_RAM_tb.vhdl

ghdl -r --std=08 Komponenten/RAM/Single_Port_RAM_tb.vhdl

gtkwave reg.vcd