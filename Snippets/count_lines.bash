#!/usr/bin/bash

# Assign the command line argument to the global variable.
FN=$1

# Count the lines in a file.
sed -n '
/^/! b done
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
$ {x;p}
' "${FN}" 2> /dev/null

# Exit the script.
exit 0
