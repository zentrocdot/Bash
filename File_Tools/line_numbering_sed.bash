#!/usr/bin/bash
#
# Simple line numbering using sed command =
# Version 0.0.0.1
#
# Description:
# For a good line numbering using the sed command =
# we need to use sed twice. Next to this we need some
# formatting.
#
# Result:
#   1  First line with text
#   2  Second line with text
#   3  Third line with text
#   4  Fourth line with text

# Assign the command line argument to the global variable.
FN=$1

# Get the length of the Determine the length of the longest line number.
LEN=$(sed -n '$=' "${FN}" | wc -c)
LEN=$((LEN-1))

# Set the indentation of the line numbering.
ITN="  "

# Set the spaces between numbering and text (padding).
PAD="  "

# Create spaces.
SPC=$(for i in $(eval echo "{1..$LEN}"); do echo -n " "; done)

# Create dots.
DOT=$(for i in $(eval echo "{1..$LEN}"); do echo -n "."; done)

# Number the lines of a file with sed and pipe the sesult to a second sed session.
sed '=' "${FN}" | \
sed -n '
N                                               # Read line and next (number and text)
s/^/'"${SPC}"'/                                 # Add spaces to the pattern space.
s/^ *\('"${DOT}"'\)\n/'"${ITN}"'\1'"${PAD}"'/p  # Remove the newline and format the line.
'

# Exit the script.
exit 0

