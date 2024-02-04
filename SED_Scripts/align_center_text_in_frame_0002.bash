#!/usr/bin/bash
#
# Center text aligned in frame
# Version 0.0.0.2
#
# Remark:
# In this script I used single quotes instead of double quotes. This way the
# sed script itself is protected. The variable expansion is done outside of
# the sed script.
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
LINE_WIDTH=${3:-100}

# Set the inner width plus 1.
WIDTH=$((LINE_WIDTH-5))

# Print text.
sed -n '
# Print border line; store the border line in the hold space.
1 {x;{s/^.*$/'"${CHR}"'/;:l;/^.\{1,'"${LINE_WIDTH}"'\}$/ {s/^\(.*\)$/'"${CHR}"'\1/
bl};s/.$//p};x}
# Print all lines except the last line.
$! {
/^$/ {s/^$/ /};:y;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\x20\1\x20/;by}
s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"' /;s/$/ '"${CHR}"'/p}
# Print last line and print footer.
$ {
# Case 1: Line empty.
/^$/ {s/^$/ /;:z;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\x20\1\x20/;bz}
s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"' /;s/$/ '"${CHR}"'/p}
# Case 2: Line not empty.
/^$/! {:z;/^.\{1,'"${WIDTH}"'\}$/ {s/^\(.*\)$/\x20\1\x20/;bz}
s/\(..\{1,'"${WIDTH}"'\}\).*/\1/;s/^/'"${CHR}"' /;s/$/ '"${CHR}"'/p}
# Get the border line back; Print the border line.
x;p
}
# We are done.
' "${FN}" 2> /dev/null

# Exit the script.
exit 0


