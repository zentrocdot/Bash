#!/usr/bin/bash
#
# Increment a number
#
# Description:
# This is the best solution for incrementing a number by 1. This
# solution is easy to understand and straightforward.
#
# Acknowledgment:
# The core code of the underlying sed script was written by Bruno
# Haible.
#
# Reference:
# getdocs.org/Sed/docs/latest/Increment-a-number
# www.gnu.org/software/sed/manual/html_node/Increment-a-number.html

# Simulate a file. The quoted string is the start value.
FN=$'0'

# Set the breaking condition.
#QUIT='infinite'
QUIT='100'

# Run the sed script.
sed "
# Define the label loop.
:loop
# Replace all trailing 9s by the underscore _.
:l; s/9\(_*\)$/_\1/; tl
# Increment only the last digit except the 9.
# The 9 is represented by the underscore _.
s/8\(_*\)$/9\1/; tend
s/7\(_*\)$/8\1/; tend
s/6\(_*\)$/7\1/; tend
s/5\(_*\)$/6\1/; tend
s/4\(_*\)$/5\1/; tend
s/3\(_*\)$/4\1/; tend
s/2\(_*\)$/3\1/; tend
s/1\(_*\)$/2\1/; tend
s/0\(_*\)$/1\1/; tend
# Add a most-significant digit 1 if there are only 9s..
s/^\(_*\)$/1\1/; tend
# Define the label end.
:end
# Transliterate the underscore _ back to digit 0.
y/_/0/
# Print the number.
p
# Quit the script.
/${QUIT}/ {Q42}
# Branch to label loop.
b loop
" <<< "${FN}" 2> /dev/null

# Print the exit code of the sed script (on demand).
#echo -e "Exit code: $?"

# Exit the script.
exit 0
