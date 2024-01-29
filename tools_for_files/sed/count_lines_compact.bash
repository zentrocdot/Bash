#!/usr/bin/bash
#
# Count the lines in a file

FN=$1

sed -n '/^/! ba;x;/^$/ s/^.*$/0/;/^9*$/ s/^/0/;s/.9*$/z&/;h;s/^.*z//;
        y/0123456789/1234567890/;x;s/z.*$//;G;s/\n//;h;:a;$ {x;p}' "${FN}"

exit 0
