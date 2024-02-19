#!/usr/bin/bash
#
# Empty line demo
#
# Version 0.0.0.1

# Set up a string.
STR="The following line should be a blank line ..."

# Set up a counter.
CNT=0

# Clear the screen
clear

# Using command echo.
{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo ''

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo ""

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -e ''

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -e ""

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -e -n "\n"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -en "\n"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne "\n"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne "\0013"
#echo -ne "\0015\0013"
#echo -ne "\0013\0015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne "\x0A"
#echo -ne "\x0D\x0A"
#echo -ne "\x0A\x0D"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne "\012"
#echo -ne "\015\012"
#echo -ne "\012\015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne \\x0A
#echo -ne \\x0D\\x0A
#echo -ne \\x0A\\x0D

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -ne \\012
#echo -ne \\015\\012
#echo -ne \\012\\015

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -n $'\x0A'
#echo -n $'\x0D\x0A'
#echo -n $'\x0A\x0D'

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -n $'\012'
#echo -n $'\015\012'
#echo -n $'\012\015'

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
echo -n $'\cJ'
#echo -n "%b" $'\cM\cJ'
#echo -n "%b" $'\cJ\cM'

# Using command printf.

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" \\0013
#printf "%b" \\0015\\0013
#printf "%b" \\0013\\0015

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" "\0013"
#printf "%b" "\0015\0013"
#printf "%b" "\0013\0015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" \\x0A
#printf "%b" \\x0D\\x0A
#printf "%b" \\x0A\\x0D

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" "\x0A"
#printf "%b" "\x0D\x0A"
#printf "%b" "\x0A\x0D"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" \\012
#printf "%b" \\015\\012
#printf "%b" \\012\\015

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" "\012"
#printf "%b" "\015\012"
#printf "%b" "\012\015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "\x0A"
#printf "\x0D\x0A"
#printf "\x0A\x0D"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "\012"
#printf "\015\012"
#printf "\012\015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" "\0013"
#printf "%b" "\0015\0013"
#printf "%b" "\0013\0015"

{ ((++CNT)); echo "No. ${CNT}: ${STR}"; }
printf "%b" $'\cJ'
#printf "%b" $'\cM\cJ'
#printf "%b" $'\cJ\cM'

# Exit the script.
exit 0
