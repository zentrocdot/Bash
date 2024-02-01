#!/usr/bin/bash
#
# Simple number count.

# Assign command line argument to global variable.
FN=$''

# Maximal number to print.
NR=30

# Calculate termination condition.
QUIT=$((NR+1))

# Read data from empty file.
sed -n "
x                         # Exchange the (empty) hold space with the pattern space.
#/^$/ { s/^.*$/1/ }       # Set the line counter to 1.
/^$/ { s/^$/1/ }          # Set the line counter to 1.
:l {                      # Set the label l.
p                         # Print the incremented number.
h                         # Store the pattern space to the hold space.
/^9\+$/ s/^/0/            # Add a 0 if the line number starts with one or more 9.
s/.9*$/m&/                # Separate changing and unchanged digits with an m.
h                         # Keep the changing digits in the hold space.
s/^.*m//                  # Remove everything inclusive the marker.
y/0123456789/1234567890/  # Transliterate the remaining digit(s).
x                         # Exchange the hold space with the pattern space.
s/m.*$//                  # Keep the unchanged numbers in the pattern space.
G                         # Compose the new line number and adding a newline.
s/\n//                    # Remove the unwanted newline, which was added.
/$QUIT/ {q42}             # Stopp incrementing number. Exit code 42.
bl }                      # Branch to label l.
" <<< "${FN}"

# Print the exit code.
#echo -e "Exit code: $?"

# Exit the script.
exit 0
