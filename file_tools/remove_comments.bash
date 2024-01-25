#!/usr/bin/bash
#
# See also:
# www.gnu.org/software/sed/manual/sed.html

# Assign the command line argument to the global variable.
FN=$1

# Remove comment lines from file.
sed -i -e '/^[#]/d' "${FN}" 2> /dev/null

