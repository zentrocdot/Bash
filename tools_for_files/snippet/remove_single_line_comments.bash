#!/usr/bin/bash

# Assign the command line argument to the global variable.
FN=$1

# Remove single line comments from file.
sed -i '/^[[:blank:]]*#/d' "${FN}" 2> /dev/null

# Exit script.
exit 0
