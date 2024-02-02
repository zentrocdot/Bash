#!/usr/bin/bash
#
# Line numbering demo
#
# Description:
# The approach for the numbering as well as the formatting is taken from the
# GNU sed tutorial.
#
# Header and footer can be commented out. The line format can be reformatted
# according to requirements. The file which sed reads is simulated by reading
# a heredoc. Incrementing the line numbers is done within the pattern space.
# The line to be printed is temporarily stored in the hold space. Composing
# of the printed line is done in the pattern space.
#
# Acknowledgment:
# The core code of the underlying sed script was written by Bruno Haible.
#
# Reference:
# getdocs.org/Sed/docs/latest/Increment-a-number
# www.gnu.org/software/sed/manual/html_node/cat-_002dn.html
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
test line 13
test line 14
test line 15
test line 16
HEREDOC

# Run the sed script.
sed -n '
# Add a header.
1i\No.   Printed line\n====  ============\n
# Add a footer.
$a\\nEnd of printout.
# If the last line is empty, delete it.
$ {/^$/d}
# Exchange the hold space with the pattern space.
# Then execute the subroutine.
x; {
# If the hold space is empty set the counter to 0.
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
# Add a most-significant digit 1 if there are only 9s.
s/^\(_*\)$/1\1/; tend
# Define the label end.
:end
# Transliterate the underscore _ back to digit 0.
y/_/0/ }
# Append a newline and the pattern space to the hold space.
# Then exchange the hold space with the pattern space.
H; x
# Exchange the line and the numbering.
s/\(.*\)\n\(.*\)/\2\n\1/
# Format the line and print it.
s/^/    /; s/^ *\(....\)\n/\1  /p
' <(echo "${FN}")

# Print the exit code of the sed script (on demand).
#echo -e "Exit code: $?"

# Exit the script.
exit 0
