#!/usr/bin/bash
#
# Count the occurrence of a pattern at the beginning of a line
#
# Credits:
# stackoverflow.com/questions/1781329/count-the-number-of-occurrences-of-a-string-using-sed

FN=$1

PATTERN="#"

sed -n "
/^${PATTERN}/! b done
x
/^$/ s/^.*$/0/
/^9*$/ s/^/0/
s/.9*$/x&/
h
s/^.*x//
y/0123456789/1234567890/
x
s/x.*$//
G
s/\n//
h
: done
$ {x;/[0-9]/p;t;s/^$/0/p}
" "${FN}"
