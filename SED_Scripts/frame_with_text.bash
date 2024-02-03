#!/usr/bin/bash
#
# Print frame with text
# Version 0.0.0.2

# Assign the command line argument to the global variable.
# Odd number of characters.
#STR=${1:-This String Is A Good Sample Text Example}
# Even number of characters.
STR=${1:-This String Is A Good Sample Text Example!}

# Next block can be used to test odd and even text lengths.
# Exchange command line in the sed script to do this.
# Get the lenght of the string.
##LEN=${#STR}
## Calculate the modulo.
##N=$((LEN%2))
## Add a depending on the modulo.
##if [[ "${N}" = "0" ]]; then
##    STR+=" "
##fi

# Set the char.
CHR=${2:-#}

# Set the width.
LINE_WIDTH="80"

# Set the width
WIDTH=$((LINE_WIDTH-2))

# Run the sed script.
sed -n "
# Print the head line.
x;s/^.*$/${CHR}/;:x;/^.\{1,${LINE_WIDTH}\}$/ {s/^\(.*\)$/${CHR}\1/;bx;};p
# Print the text
## The next command line is sensitive to even and odd text lengths.
##x;:y;/^.\{1,${WIDTH}\}$/ {s/^\(.*\)$/\x20\1\x20/;by};s/^/${CHR}/;s/$/${CHR}/;p
x;:y;/^.\{1,${WIDTH}\}$/ {s/^\(.*\)$/\x20\1\x20/;by};s/\(..\{1,${WIDTH}\}\).*/\1/;s/^/${CHR}/;s/$/${CHR}/;p
# Print the foot line.
x;s/^.*$/${CHR}/;:z;/^.\{1,${LINE_WIDTH}\}$/ {s/^\(.*\)$/${CHR}\1/;bz;};p
# We are done.
" < <(echo "${STR}") 2> /dev/null

# Exit the script.
exit 0
