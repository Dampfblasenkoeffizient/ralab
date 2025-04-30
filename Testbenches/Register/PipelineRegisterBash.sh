#!/bin/bash 
# Pfad?
ghdl -a Komponenten/Register/PipelineRegister.vhdl
ghdl -a Testbenches/Register/PipelineRegister_tb.vhdl
ghdl -e PipelineRegister_tb
ghdl -r PipelineRegister_tb