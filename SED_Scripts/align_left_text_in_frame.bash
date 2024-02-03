#!/usr/bin/bash
#
# Left aligned text in frame

# Set the filename.
FN=$1

# Set the border char.
CHR=${2:-*}

# Set the width.
LINE_WIDTH=${3:-100}

# Set the inner width
WIDTH=$((LINE_WIDTH-2))

# Print text.
sed -n '
# Print border line; store the border line in the hold space.
1 {x;{s/^.*$/'${CHR}'/;:l;/^.\{1,'${LINE_WIDTH}'\}$/ {s/^\(.*\)$/'${CHR}'\1/
bl};s/.$//p};x}
# Print all lines except the last line.
$! {
/^$/ {s/^$/ /};:y;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\1\x20/;by}
s/^/'${CHR}' /;s/\(.\{1,'${WIDTH}'\}\).*/\1/;s/$/ '${CHR}'/p}
# Print last line and print footer.
$ {
# Case 1: Line empty.
/^$/ {s/^$/ /;:z;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\1\x20/;bz}
s/^/'${CHR}' /;s/\(.\{1,'${WIDTH}'\}\).*/\1/;s/$/ '${CHR}'/p}
# Case 2: Line not empty.
/^$/! {:z;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\1\x20/;bz}
s/^/'${CHR}' /;s/\(.\{1,'${WIDTH}'\}\).*/\1/;s/$/ '${CHR}'/p}
# Get the border line back; Print the border line.
x;p
}
# We are done.
' "${FN}" 2> /dev/null

# Exit the script.
exit 0


