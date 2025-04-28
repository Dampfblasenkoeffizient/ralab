#!/bin/bash
for file in $(find . -type f -name "*.vhdl"); do
    ghdl -a "$file"
    ghdl -e "$file"
done   