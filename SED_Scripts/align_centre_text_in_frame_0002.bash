#!/usr/bin/bash
#
# Center text aligned in frame
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# Description:
# The script reads a file line by line that was specified via the first
# command line argument. The script prints the text centered in a frame.
# The character of the frame and the frame width can be optionally
# specified via further command line arguments.
#
# Limitation:
# The script is not preserving lines while printing which are longer than
# the given line width.
#
# Remark:
# In this script I used single quotes instead of double quotes. This way the
# sed script itself is protected. The variable expansion is done outside of
# the sed script.
#
# To-Do:
# Preserve the line to print in length.
#
# Open Issue:
# I am still looking for a way to address the lines from the second line to
# the penultimate line. Addressing lines in general needs to be studied in
# more detail.

# Set the filename.
FN=$1

# Set the border char.
CHR=${2:-*}

# Set the line width.
LINE_WIDTH=${3:-80}

# Set the inner width plus 1.
WIDTH=$((LINE_WIDTH-5))

# Add some command line help.
if [[ $1 == '' || $1 == '-h' ]]; then
    printf "%s\n%s\n" "usage:" "bash $0 '<filename>' ['<border_char>', ['<line_width>']]"
fi

# Print text.
sed -n '
# Add a bunch of spaces if line is empty.
/^$/ s/^$/    /
# Print the border line (header). Store the border line in the hold space.
1 {x;{s/^.*$/'"${CHR}"'/;:l;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/
bl};s/.$//p};x}
# Print all lines with left and right border chars except the last line.
$! {
:y;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\ \1\ /;by}
s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"' /;s/$/ '"${CHR}"'/p}
# Perform two operations on last line.
$ {
# Print last line with left and right border chars.
:z;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\ \1\ /;bz}
s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"' /;s/$/ '"${CHR}"'/p
# Get the border line back. Print the border line (footer).
x;p
}
# We are done.
' "${FN}" 2> /dev/null

# Exit the script with the exit status of the sed command execution.
exit $?



