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
IFS='' read -d '' -r FN <<'HEREDOC'
test line 1
test line 2
test line 3
test line 4
test line 5
test line 6
test line 7
test line 8
test line 9
test line 10
test line 11
test line 12
test line 14
test line 15
HEREDOC

# Run the sed script.
sed -n '
# Add header.
1 {
i\No.   Printed line\n====  ============\n
}
# Add footer.
$ {
a\\nEnd of printout.
}
# If last line is empty, delete it.
$ {/^$/d}
# Exchange hold pattern with space pattern.
x
# Execute the subroutine.
{
# If hold pattern is empty set counter to 0.
s/^$/0/g
# Replace all trailing 9s by the underscore _.
:l; s/9\(_*\)$/_\1/; tl
# Increment only the last digit except the 9.
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
}
# Append a newline to the hold space, append the pattern space to the hold space.
H
# Exchange hold space with pattern space.
x
# Print the numbered line.
s/\(.*\)\n\(.*\)/\2\n\1/
# Applying the printing format.
s/^/    /
s/^ *\(....\)\n/\1  /p
' <(echo "${FN}")

# Print the exit code of the sed script (on demand).
#echo -e "Exit code: $?"

# Exit the script.
exit 0
