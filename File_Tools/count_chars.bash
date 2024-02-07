#!/usr/bin/bash

# Set the filename.
FN=$1

# Read file in a global string variable.
CONTENT=$(<"${FN}")

# Get the length of the string in the variable.
LEN=${#CONTENT}

# Print the result to the terminal window.
echo "Number of characters in file: ${LEN}"

# Exit the script.
exit 0
