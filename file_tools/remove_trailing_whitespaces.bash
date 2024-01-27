#!/usr/bin/bash
#
# [:space:]
# tab, vertical tab, form feed, newline, line feed, carriage return and space
# [:blank:]
# tab and space
#
# See also:
# www.gnu.org/software/sed/manual/sed.html

# Assign the command line argument to the global variable.
FN=$1

# Use sed for the replacements in the file.
sed -i 's/[[:space:]]\+$//g' "${FN}" 2> /dev/null

# Exit script.
exit 0
