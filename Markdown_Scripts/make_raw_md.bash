#!/usr/bin/bash
#
# Make raw data
# Version 0.0.0.1

FN_IN="fmt_in.txt"
FN_OUT="raw_out.txt"

sed -n '
s/[\t]*/    /g                              # Exchange tabs.
s/^|\(.*\)/\1/                              # Remove leading |
s/^ *//                                     # Remove leading spaces
s/ *$//                                     # Remove trailing spaces
s/\(.*\)|$/\1/                              # Remove trailing |
s/\(.*\)|\(.*\)/\1;\2/                      # Echange delimiter | with ;
s/\(.*[^ ]\)[ ]*;[ ]*\(.*\)/\1; \2/         # Remove not wanted spaces.
p                                           # Print result of operation.
' "${FN}" > "raw_out.txt"

exit 0
