#!/usr/bin/bash
#
# Wrap ASCII text after a defined number of characters.
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# Description:
# The script is intended to reformat Base64 data.
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf

# Assign the command line argument to the global variable.
FN=$1

# Set the number of characters for wrapping.
NR=160

# Wrap Ascii text and print result to screen.
sed ":z
N
s/\n//g
:y
s/\(.\{$NR\}\)/\1\n/
/\n/ {
P
s/.*\n//
by
}
bz" "${FN}"

# Exit script.
exit 0
