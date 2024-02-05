#!/usr/bin/bash
#
# Print frame with text
# Version 0.0.0.3

# Assign the command line argument to the global variable.
# For Odd number of characters use:
# STR=${1:-This String Is A Good Sample Text Example}
# For even number of charactersuse:
STR=${1:-This String Is A Good Sample Text Example!}

# Set the char.
CHR=${2:-#}

# Set the line width.
LINE_WIDTH="80"

# Set the inner width.
WIDTH=$((LINE_WIDTH-2))

# Run the sed script.
sed -n '
# Print the head line.
x;s/^.*$/'"${CHR}"'/;:x;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/;bx;};p
# Print the text
x;:y;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\x20\1\x20/;by};s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"'/;s/$/'"${CHR}"'/;p
# Print the foot line.
x;s/^.*$/'"${CHR}"'/;:z;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/;bz;};p
# We are done.
' < <(echo "${STR}") 2> /dev/null

# Exit the script.
exit 0
