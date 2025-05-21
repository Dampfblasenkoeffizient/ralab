# Clara Heilig
#!/bin/bash 

ghdl -a Komponenten/Multiplexer/gen_mux.vhdl
ghdl -a Testbenches/Multiplexer/gen_mux_tb.vhdl
ghdl -e gen_mux_tb
ghdl -r gen_mux_tb