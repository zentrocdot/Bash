#!/usr/bin/bash
#
# Count Lines in file
#
# Use at the command line: info sed
#
# Acknowledgement:
# stackoverflow.com/questions/1781329/count-the-number-of-occurrences-of-a-string-using-sed
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf
 

FN=$1

PATTERN=""

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
$ {x;p}
" "${FN}"
