#!/bin/bash
# Pfad?
ghdl -a gen_mux_tb
ghdl -e gen_mux_tb
ghdl -r gen_mux_tb