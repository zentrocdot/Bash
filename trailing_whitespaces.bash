#!/usr/bin/bash

# Use standard Posix bracket Expression for removal:
# [[:space:]] = all whitespace characters, including line breaks
# [[:blank:]] = space and tab

# Get the filename from the command line argument.
FN=$1

# Check if filename was given.
if [ "${FN}" = '' ]; then
    echo "No filename given. Bye!"
    exit 1
fi

# Remove trailing whitespaces from file.
sed -i 's/[[:space:]]*$//' "${FN}"

# Exit script without error.
exit 0
