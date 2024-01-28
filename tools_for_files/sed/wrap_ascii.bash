#!/usr/bin/bash
#
# Wrap text after a defined number of characters.
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf

FN=$1

NR=160

sed ":z
N
s/\n//g
:y
s/\(.\{$NR\}\)/\1\n/
/\n/ {
P
s/.*\n//
by
}
bz" "${FN}"

exit 0
