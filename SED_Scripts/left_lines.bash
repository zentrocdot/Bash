#!/usr/bin/bash
#
# Center the lines of a file on the screen
# Version 0.0.0.1
#
# Description:
# Align the lines of a file to the right side on basis of a given line width.
# This can be done adding one space from the left side until the line width
# is reached.
#
# See also:
# www.pement.org/sed/
# www.pement.org/sed/sed1line.txt

# Assign the command line argument to the local variable.
FN=$1

# Set the line width.
LINE_WIDTH="80"

# Set the work width.
WORK_WIDTH=$((LINE_WIDTH-1))

# Run the sed script.
sed "
# Remove the leading and the trailing spaces.
s/^[[:blank:]]*//; s/[[:blank:]]*$//
# Run a loop until a line with LINE_WIDTH characters is obtained.
:z; /^.\{1,${WORK_WIDTH}\}$/ {s/^\(.*\)$/\x20\1/; bz}
# Remove the created trailing spaces.
s/[[:blank:]]*$//
# We are done.
" "${FN}"

# Exit the script.
exit 0
