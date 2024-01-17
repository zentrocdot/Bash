#!/bin/bash

# http://passwordsgenerator.net/
# https://bttn.freshdesk.com/support/solutions/articles/5000529141-firmware-201412-wi-fi-ssid-and-password-cannot-have-spaces-or-special-characters
# https://www.heise.de/ct/hotline/Sonderzeichen-im-WLAN-Passwort-2056815.html

# The shortest password allowed with WPA2 is 8 characters long
# WPA2 passwords can be up to 63 characters long, and can contain a host of special characters.

# a-z A-Z 0-9 ! " # $ % & '( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
# See: https://wiki.ubuntuusers.de/WLAN/Sonderzeichen/

MINLEN=8
MAXLEN=32

IMAX=3333

MAX=$((IMAX/(MAXLEN-MINLEN+1)))

rm -f dictionary.txt
touch dictionary.txt

CHARLIST=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11"
          "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
          "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

SCHARLIST0=("@" "%" "$" "&" "=" "?" "<" ">" "!" "#" ":" "-" "+" "*" "(" ")" "[" "]" "{" "}" "/" "," ";" "." "^" "~" "_")

SCHARLIST1=("\"" "\'" "\`" "\\")

CHARNUM=${#CHARLIST[@]}

CNT=0

(for len in $(seq $MINLEN $MAXLEN)
do 
    for i in $(seq 1 $MAX)
    do  
        CNT=$((CNT+1))
        KEYWORD=''
        for i in $(seq 1 $len)
        do
            RANDNUM=$(( ( RANDOM % ${CHARNUM} )  + 1 ))
            RANDCHAR=${CHARLIST[$RANDNUM]}
            KEYWORD="${KEYWORD}${RANDCHAR}" 
        done
        # echo -e "$KEYWORD" | tee -a wordlist.txt
        result=$(cat temp.txt |grep -w "$KEYWORD")
        # echo $result
        if [[ $result == '' ]] 
        then
            echo -e "$KEYWORD" >> dictionary.txt 
            echo -e -e "$KEYWORD" >> temp.txt
        fi
        PCT=$(( (CNT*100)/IMAX ))
        echo $PCT; 
    done
done)  | zenity --progress --percentage=0 --auto-close

#| dialog --gauge "Please wait" 8 80 0

clear

# | zenity --progress --pulsate --auto-close

# Exit script.
exit 0
