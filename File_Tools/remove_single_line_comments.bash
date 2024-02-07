#!/usr/bin/bash
#
# Remove Single Lines Comments
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

# Check if a filename was given on the command line.
if [ "${FN}" = "" ]; then
    # Print an error message into the terminal window.
    echo "No filename was given. Bye!"
    # Exit script with error code 1.
    exit 1
fi

# Check if file exists.
if [ ! -e "${FN}" ]; then
    # Print an error message into the terminal window.
    echo "File does not exist. Bye!"
    # Exit script with error code 2.
    exit 2
fi

# Use sed for the deletion in the file.
sed -i '/^[[:blank:]]*#/d' "${FN}" 2> /dev/null

# Exit script without an error.
exit 0
