#!/usr/bin/bash
#
# Remove Empty Lines
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# [:space:]
# tab, vertical tab, form feed, newline, line feed, carriage return and space
# [:blank:]
# tab and space
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.regular-expressions.info/posixbrackets.html

# Assign the command line argument to the global variable.
FN=$1

# Check if a filename was given.
if [ "${FN}" = "" ]; then
    # Print message into the terminal window.
    echo "No filename given. Bye!"
    # Exit script with error.
    exit 1
fi

# Use sed for the replacements in the file.
sed -i 's/^[[:space:]]\+//g;s/[[:space:]]\+$//g' "${FN}" 2> /dev/null

# Exit script without error.
exit 0
