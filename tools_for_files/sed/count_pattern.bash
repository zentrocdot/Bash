#!/usr/bin/bash
#
# Count Lines with a Pattern in a File
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# Description:
# The sed script counts the lines with a pattern in a file. If there
# is a line with a pattern in the file, the number of lines is output,
# otherwise the output is zero.
#
# If no file name is given on the command line the output is always
# empty. Otherwise, what was written previously is valid.
#
# Use at the command line:
#     man sed
#     info sed
#
# Motivation.
# This sed script is another good example to take a deeper look in the
# possibilities of sed. The script demonstrates how to work with pattern
# space and hold space.
#
# Acknowledgement:
# stackoverflow.com/questions/1781329/count-the-number-of-occurrences-of-a-string-using-sed
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf

# Disable shellcheck warning.
# shellcheck disable=SC2250

# Assign the command line argument to the global variable.
FN=$1

PATTERN=${2:-#}

# Initialise the exit code.
exit_code=0

# Count the lines withe a pattern in a file.
sed -n "
/$PATTERN/! b done;        # If not pattern match branch to label done.
x                          # Swap the counter from hold space into pattern space.
/^$/ s/^.*$/0/             # If pattern space is empty start the counter with zero.
/^9*$/ s/^/0/              # If pattern space starts with a nine prepend a zero.
s/.9*$/z&/                 # If any mark the position of the last digit before a sequence of nines with an z.
h                          # Copy the marked counter to hold space.
s/^.*z//                   # Delete everything infront of the marker z.
y/0123456789/1234567890/   # Increment the digits which are behind the marker.
x                          # Swap hold space with pattern space.
s/z.*$//                   # Delete everything after the marker z. Leave the leading digits.
G                          # Append hold space to pattern space.
s/\n//                     # Remove the newline. Leave the digits concatenated.
h;                         # Store the counter into the hold space.
:done;                     # Set label done.
$ {x;/[0-9]/p;t;s/^$/0/p}  # If it is the last line of input, swap the counter and print it.
" "${FN}" 2> /dev/null

# Get the exit code from the sed command execution.
exit_code=$?

# Exit the script with a exit code.
exit "${exit_code}"
