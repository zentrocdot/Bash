#!/usr/bin/bash
#
# See also:
# www.gnu.org/software/sed/manual/sed.html

# Assign the command line argument to the global variable.
FN=$1

# Use sed for the replacements in the file.
sed -i 's/^[[:space:]]\+//g;s/[[:space:]]\+$//g' "${FN}" 2> /dev/null

