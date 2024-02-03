#!/usr/bin/bash

# Simulate a file. The quoted string is the start value.
IFS='' read -d '' -r FN <<'HEREDOC'
Sample Header Title Example
First Line Header (e.g. version)
Middle Line Header (e.g. copyright)
Last Line Header (e.g. licence)
First Line Text
Second Line Text
HEREDOC

# Set the border char.
CHR=${1:-#}

# Set the width.
LINE_WIDTH="90"

# Set the width
WIDTH=$((LINE_WIDTH-2))

# Run the sed script.
sed -n "
# Add a line between header and text.
#4a
# Print the head line.
1 {h;s/^.*$/${CHR}/;:x;/^.\{1,${LINE_WIDTH}\}$/ {s/^\(.*\)$/${CHR}\1/;bx;};p;x}
#s/\(..\{1,${LINE_WIDTH}\}\).*/\1/
# Print the text with the border chars.
1,4 {/^$/! {:y;/^.\{1,${WIDTH}\}$/ {s/^\(..*\)$/\x20\1\x20/;by}
s/\(..\{1,${WIDTH}\}\).*/\1/;s/^/${CHR}/;s/$/${CHR}/;p}}
# Print the foot line.
#4 {x;s/^.*$/${CHR}/;:z;/^.\{1,${LINE_WIDTH}\}$/ {s/^\(.*\)$/\1\1\1/;bz};p}
4 {h;s/^.*$/${CHR}/;:x;/^.\{1,${LINE_WIDTH}\}$/ {s/^\(.*\)$/${CHR}\1/;bx;};p;x}
# Print lines after header.
5,$ {/^$/! p}
# We are done.
" <(echo "${FN}")
# 2> /dev/null

# Exit the script.
exit 0

