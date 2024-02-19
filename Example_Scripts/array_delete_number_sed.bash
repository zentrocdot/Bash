#!/usr/bin/bash

NUM=20

declare -a ARR

for ((i=1; i<="${NUM}"; i++)); do ARR+=("${i}"); done

printf "%s%b" "Print array:" "\n\r\n\r"

for j in "${ARR[@]}"; do printf "%s " "${j}"; done

printf "%b%s%b" "\n\r\n\r" "Remove elements 2...19 from array ..." "\n\r\n\r"

for element in $(seq 2 19); do
    ARR=($(sed 's/^/ /;s/$/ /;s/ '"${element}"' / /' <<<${ARR[*]}))
done

printf "%s%b" "Print remaining values with line break:" "\n\r\n\r"

for j in "${ARR[@]}"; do echo "${j}"; done

printf "%b" "\n\r"

printf "%s%b" "Print remaining values without line break:" "\n\r\n\r"

for k in "${ARR[@]}"; do printf "%s " "${k}"; done

printf "%b" "\n\r"
