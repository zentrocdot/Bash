#!/usr/bin/bash
#
# Description:
# Number lines.
#
# Limitation:
# Works up to 9 lines.
#
# To do:
# Increase the correct numbering to infinite.

# Simulate a text file.
file=$'test1\ntest2\ntest3\ntest4\ntest5\ntest6\ntest7\ntest8\ntest9\ntest10\ntest11'

echo -e "My simplified numbering example:\n"

# Read sed from file.
sed -n '
x                         # Exchange pattern space with hold space.
s/^/0/                    # Initialise the line number counter.
s/.*\([0-9]\{1\}\)$/\1/g  # If mor than one number get the last number.
y/0123456789/1234567890/  # Transliterate the number.
x                         # Exchange pattern space with hold space.
H                         # Add newline and append the pattern space.
x                         # Exchange pattern space with hold space.
s/\n/ /g                  # Substitute newline by space.
# Functionality of the GNU sed example added.
s/\(.*\)/     \1/p
' <<< "${file}"

echo -e "\nModified GNU sed tutorial example:\n"

sed -n '
x                                  # Exchange hold space with pattern space.
/^$/ s/^.*$/1/                     # If empty initialise countr with 1
G                                  # Append new line to pattern space, append hold space to pattern space.
h                                  # Store pattern space to hold space.
s/^/      /                        # The next two lines format the numbering.
s/^ *\(......\)\n/\1 /p            # The next two lines format the numbering.
g                                  # Replace content of pattern space with content of hold space.
s/\n.*$//                          # Replace newline and everything to the end.
/^9*$/ s/^/0/                      # If there is a 9 at the beginning change it to 0.
s/.9*$/m&/                         # If there is a 9 set the marker.
h                                  # Store pattern space to hold space.
s/^.*m//                           # Remove all before marker.
y/0123456789/1234567890/           # Transliterate the numbers.
x                                  # Exchange hold space with pattern space.
s/m.*$//                           # Remove alle after marker.
G                                  # Append new line to pattern space, append hold space to pattern space.
s/\n//                             # Remove newline.
h                                  # Store pattern space to hold space.
' <<< "${file}"

# Exit the script.
exit 0
