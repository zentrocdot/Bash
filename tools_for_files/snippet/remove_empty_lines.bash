#!/usr/bin/bash

# Assign the command line argument to the global variable.
FN=$1

# Remove empty lines from file.
sed -i '/^[[:space:]]*$/d' "${FN}" 2> /dev/null

# Exit script.
exit 0
