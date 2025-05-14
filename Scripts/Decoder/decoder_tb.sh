#Paul Riedel

ghdl --clean

ghdl -a --std=08 Packages/*;
ghdl -a --std=08 Komponenten/Decoder/decoder.vhdl
ghdl -a --std=08 Testbenches/Decoder/decoder_tb.vhdl

ghdl -e --std=08 decoder_tb

ghdl -r --std=08 decoder_tb --vcd=reg.vcd
gtkwave reg.vcd