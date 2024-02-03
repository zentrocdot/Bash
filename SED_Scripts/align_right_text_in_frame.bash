#!/usr/bin/bash
#
# Right aligned text in frame

# Set the filename.
FN=$1

# Set the border char.
CHR=${2:-*}

# Set the width.
LINE_WIDTH=${3:-100}

# Set the inner width
WIDTH=$((LINE_WIDTH-5))

# Print text.
sed -n '
# Print border line; store the border line in the hold space.
1 {x;{s/^.*$/'${CHR}'/;:l;/^.\{1,'${LINE_WIDTH}'\}$/ {s/^\(.*\)$/'${CHR}'\1/
bl};s/.$//p};x}
# Print all lines except the last line.
$! {
/^$/ {s/^$/ /};
:y;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\x20\1/;by};
s/\(..\{1,'${WIDTH}'\}\).*$/\1/;s/^/'${CHR}' /;s/$/ '${CHR}'/p}
# Print last line and print footer.
$ {
# Case 1: Line empty.
/^$/ {s/^$/ /;:z;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\x20\1/;bz}
s/\(..\{1,'${WIDTH}'\}\).*/\1/;s/^/'${CHR}' /;s/$/ '${CHR}'/p}
# Case 2: Line not empty.
/^$/! {:z;/^.\{1,'${WIDTH}'\}$/ {s/^\(.*\)$/\x20\1/;bz}
s/\(..\{1,'${WIDTH}'\}\).*/\1/;s/^/'${CHR}' /;s/$/ '${CHR}'/p}
# Get the border line back; Print the border line.
x;p
}
# We are done.
' "${FN}" 2> /dev/null

# Exit the script.
exit 0


