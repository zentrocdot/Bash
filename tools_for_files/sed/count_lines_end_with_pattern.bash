#!/usr/bin/bash
#
# Count the occurrence of a pattern at the end of a line
#
# Please note:
# sed is reading line by line up to a newline. The newline is not included
# in the line in the pattern space. So the newline cannot be matched as last
# character.
#
# Credits:
# stackoverflow.com/questions/1781329/count-the-number-of-occurrences-of-a-string-using-sed

FN=$1

PATTERN=${2:-#}

sed -n "
/${PATTERN}$/! b done
x
/^$/ s/^.*$/0/
/^9*$/ s/^/0/
s/.9*$/z&/
h
s/^.*z//
y/0123456789/1234567890/
x
s/z.*$//
G
s/\n//
h
:done
$ {x;/[0-9]/p;t;s/^$/0/p}
" "${FN}"
