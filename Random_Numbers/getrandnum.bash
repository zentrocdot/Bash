#!/usr/bin/bash
#
# Get random number
# Version 0.0.0.1
#
# Copyright (c) 2023, Dr. Peter Netz
# Published under the MIT license.
#
# Description:
# Create a random number of given length. Zero is allowed
# as first digit.
#
# Code finally checked with ShellCheck.

# Set the number of digits.
LEN=2

# Define a list with the decimal numbers charset.
CHARLIST=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")

# Get the number of elements of the charset.
CHARNUM=${#CHARLIST[@]}

# Initialise the keyword.
KEYWORD=''

# Loop over the number of requested digits.
for _ in $(seq 1 $LEN)
do
    RANDNUM=$(((RANDOM % CHARNUM)))
    RANDCHAR="${CHARLIST[${RANDNUM}]}"
    KEYWORD="${KEYWORD}${RANDCHAR}"
done

# Print the random number.
echo -e "${KEYWORD}"

# Exit script.
exit 0
