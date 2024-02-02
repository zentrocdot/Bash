#!/usr/bin/bash
# shellcheck disable=SC2034
# shellcheck disable=SC2312
# shellcheck disable=SC2250
#
# Description:
# This script is intended to show how it is possible to write a sed script
# without having a meaningful input file. The main goal of the script is
# to endlessly concatenate numbers from 0 to 9 on the screen. This is the
# preliminary stage to implementing a counter. The script writes the numbers
# to the full screen.
#
# Open question:
# At the moment it is not 100% clear to me why I do not have a break in the
# number series. I awaited this in the output. This has to be checked.

# Simulate an empty file.
file=$''

# Read rows and cols of screen.
read -r rows cols < <(stty size)

# Set wrap length
#NR=41
#NR=$((cols-1))


# Read sed from file.
sed -n "
s/^/0/                     # Set the first number to 0.
h                          # Store 0 to the hold space.
:z                         # Set a label z:
s/.*\([0-9]\{1\}\)$/\1/g   # Get the last number if more than one.
y/0123456789/1234567890/   # Transliterate the retrieved number.
H                          # Add a newline to the hold space and append the number.
x                          # Exchange the hold space with the pattern space.
s/\n//                     # Remove the newline.
h                          # Store the result back to the hold space.
/..\{$NR,\}/ {:y           # If the line lenght is greater than do the following.
h; s/^\(.\{$NR\}\).*/\1/p  # Print the chunk of numbers.
g; s/^.\{$NR\}\(.*\)/\1/g  # Remove the chunk of numbers.
ty }                       # Branch to label y.
bz                         # Branch to label z.
" <<< "${file}"

# Exit the script.
exit 0
