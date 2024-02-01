#!/usr/bin/bash
#
# Simple line numbering of a file content
#
# Description:
# Adding line numbers by using a marker is the best solution I found so far.
# My own learning curve quickly overlapped with the known existing solutions.
# The following script is a mixture of my thoughts and the known approaches.
# I am using for the marker m instead of x. This makes it easier to distinguish
# between the marker m and the sed command x.
#
# Resources:
# https://www.gnu.org/software/sed/manual/sed.html
# https://sed.sourceforge.io/grabbag/scripts/
# https://sed.sourceforge.io/grabbag/scripts/cat-n.sed

# Assign command line argument to global variable.
FN=$1

# Read data from file.
sed -n '
x                         # Exchange the (empty) hold space with the pattern space.
/^$/ { s/^.*$/1/ }        # Set the line counter to 1.
G                         # Add the line number and a newline before the pattern space.
h                         # Store the pattern space to the hold space.
s/\n/ /g                  # Remove the unwanted newline.
s/\(.*\) \(.*\)/\1 \2/p   # <- Change the format of the output to the personal needs here.
x                         # Exchange the hold space with the pattern space.
s/\n.*$//                 # Remove everything except the line number from the pattern space.
/^9\+$/ s/^/0/            # Add a 0 if the line number starts with one or more 9.
s/.9*$/m&/                # Separate changing and unchanged digits with an m.
h                         # Keep the changing digits in the hold space.
s/^.*m//                  # Remove everything inclusive the marker.
y/0123456789/1234567890/  # Transliterate the remaining digit(s).
x                         # Exchange the hold space with the pattern space.
s/m.*$//                  # Keep the unchanged numbers in the pattern space.
G                         # Compose the new line number and adding a newline.
s/\n//                    # Remove the unwanted newline, which was added.
h' "${FN}"

# Exit the script.
exit 0
