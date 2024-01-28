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
# Remark:
# One can use 'fold -w <number_chars> <filename>' from the GNU coreutils
# to get the same result.
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf

# Assign the command line argument to the global variable.
FN=$1

# Set the number of characters for wrapping.
NR=40

# Wrap Ascii text and print result to screen.
sed "
: z                   # Define the label z.
$ {/^$/d}             # Remove remaining empty lines in a command group.
N                     # Append a newline and the next input line to the pattern space.
s/\n//g               # Remove all newlines from the pattern space.
: y                   # Define the label y.
s/\(.\{$NR\}\)/\1\n/  # Add a newline after the first NR characters.
/\n/ {                # Execute command group if there is a newline in the pattern space.
P                     # Print the pattern space until the first newline.
s/.*\n//              # Remove the printed characters and the first newline.
by                    # Branch to label y.
}; bz                 # Branch to label z.
" "${FN}"

# Exit script.
exit 0
