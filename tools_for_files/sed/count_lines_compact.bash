#!/usr/bin/bash
#
# Count Lines in file
#
# Credits:
# stackoverflow.com/questions/1781329/count-the-number-of-occurrences-of-a-string-using-sed

FN=$1

PATTERN=""

sed -n "/^${PATTERN}/! bl; x; /^$/ s/^.*$/0/; /^9*$/ s/^/0/;
        s/.9*$/x&/; h; s/^.*x//; y/0123456789/1234567890/; x;
        s/x.*$//; G; s/\n//; h; :l; $ {x;p}" "${FN}"
