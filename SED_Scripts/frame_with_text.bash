#!/usr/bin/bash
#
# Print frame with text
# Version 0.0.0.1

# Assign the command line argument to the global variable.
# For Odd number of characters use:
# STR=${1:-This String Is A Good Sample Text Example}
# For even number of charactersuse:
STR=${1:-This String Is A Good Sample Text Example!}

# Get the length of the string.
LEN=${#STR}

# Set the char. Default is #.
CHR=${2:-#}

# Set the line width. Default is 80.
LINE_WIDTH=${3:-80}

# Check the given line width.
if [[ "${LINE_WIDTH}" -lt "${LEN}" ]]; then
    LINE_WIDTH=$((LEN+3))
fi

# Set the inner width.
WIDTH=$((LINE_WIDTH-3))

# Run the sed script.
sed -n '
# Print the head line.
x;s/^.*$/'"${CHR}"'/;:y0;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/;by0;};p
# Print the text
x;:y;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/ \1\ /;by};s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;
s/^/'"${CHR}"'/;s/$/ '"${CHR}"'/;p
# Print the foot line.
x;s/^.*$/'"${CHR}"'/;:z0;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/;bz0;};p
# We are done.
' < <(echo "${STR}") 2> /dev/null

# Exit the script.
exit 0
