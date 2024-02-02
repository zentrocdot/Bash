#!/bin/bash

LEN=8

MAX=1000

rm wordlist.txt
touch wordlist.txt

CHARLIST=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
          "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
          "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

CHARNUM=${#CHARLIST[@]}

for i in $(seq 1 $MAX)
do
    KEYWORD=''
    # for ((i=0; i < $LEN; i++))
    for i in $(seq 1 $LEN)
    do
        RANDNUM=$(( ( RANDOM % ${CHARNUM} )  + 1 ))
        RANDCHAR=${CHARLIST[$RANDNUM]}
        KEYWORD="${KEYWORD}${RANDCHAR}" 
    done
    echo -e "$KEYWORD" | tee -a wordlist.txt
done

# Exit script.
exit 0
