#!/bin/bash

# Clear screen.
clear

printf "%s" "Input decimal number: "
read -r DEC

HEX=$(bc <<< "ibase=A; obase=16; ${DEC}")
DEC1=$(bc <<< "ibase=16; obase=A; ${HEX}")
OCT=$(bc <<< "ibase=A; obase=8; ${DEC}")
DEC2=$(bc <<< "ibase=8; obase=A; ${OCT}")
BIN=$(bc <<< "ibase=A; obase=2; ${DEC}")
DEC3=$(bc <<< "ibase=2; obase=A; ${BIN}")

printf "\n"

printf "%-16s %-10s %-10s\n" "DEC -> HEX: " $DEC $HEX
printf "%-16s %-10s %-10s\n" "HEX -> DEC: " $HEX $DEC1
printf "%-16s %-10s %-10s\n" "DEC -> OCT: " $DEC $OCT
printf "%-16s %-10s %-10s\n" "OCT -> DEC: " $OCT $DEC2
printf "%-16s %-10s %-10s\n" "DEC -> BIN: " $DEC $BIN
printf "%-16s %-10s %-10s\n" "BIN -> DEC: " $BIN $DEC3

exit 0
