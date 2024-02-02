#!/usr/bin/bash
#
# Center the lines of a file on the screen
# Version 0.0.0.1
#
# Description:
# The lines of a file are centered on basis of a given line width. This can be
# done adding one space from the left and the right side until the line width
# is reached.
#
# See also:
# www.pement.org/sed/
# www.pement.org/sed/sed1line.txt
# sed.sourceforge.io/
# sed.sourceforge.io/grabbag/scripts/centre_1.sed
# sed.sourceforge.io/grabbag/scripts/centre_2.sed
# www.gnu.org/software/sed/manual/sed.html

# Assign the command line argument to the local variable.
FN=$1

# Set the line width.
LINE_WIDTH="80"

# Set the work width.
WORK_WIDTH=$((LINE_WIDTH-2))

# Run the sed script.
sed "
# Remove the leading and the trailing spaces.
s/^[[:blank:]]*//; s/[[:blank:]]*$//
# Run a loop until a line with LINE_WIDTH characters is obtained.
:z; /^.\{1,${WORK_WIDTH}\}$/ {s/^\(.*\)$/\x20\1\x20/; bz}
# Remove the created trailing spaces.
s/[[:blank:]]*$//
# We are done.
" "${FN}"

# Exit the script.
exit 0
