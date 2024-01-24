#!/usr/bin/bash
#
# Version 0.0.0.3
# Copyright © 2024, Dr. Peter Netz
#
# You are using the script on your own risk.
#
# Description:
# Remove leading and trailing spaces from a file. Read the file and exchange
# line feed, carriage return and tab by one space.
#
# Background Information:
# If one tries to replace linefeeds together with the substitution this will
# fail. Reading line by line sed will not see the trailing line feeds. So we
# have to carry out various operations one after the other.
#
# Explanation:
#
# s/^[[:space:]]*//g -> remove leading spaces
# s/[[:space:]]*$//g -> remove trailing spaces
#
# :a;N;$!ba
#
# :a   -> create a label 'a'
# N    -> append the next line to the pattern space
# $!ba -> if it is not the last line, branch to (go to) label 'a'
#
# sed will loop through these three steps until the last line is reached,
# grabbing all lines fit in the pattern space where sed will perform the
# substitutions.
#
# s/[\n\r]/ /g -> substitute line feed and carriage return by one space
# s/\t]/ /g    -> substitute tab by one space
#
# Global match means as many times as it is possible.

# Get the filename from the command line argument.
FN=$1

# Check if filename was given.
if [ "${FN}" = '' ]; then
    echo "No filename given. Bye!"
    exit 1
fi

# ***************************
# Function remove_whitespaces
# ***************************
remove_whitespaces () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Remove leading and trailing whitespaces from file.
    sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "${fn}"
    # Return no error.
    return 0
}

# **********************
# Function exchange_tabs
# **********************
exchange_tabs () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Read file and exchange tab by one space.
    sed -i ':a;N;$!ba;s/\t/ /g' "${FN}"
    # Return no error.
    return 0
}

# **********************
# Function exchange_lfcr
# **********************
exchange_lfcr () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Read file and exchange line feed and carriage return by one space.
    sed -i ':a;N;$!ba;s/[\n\r]/ /g' "${FN}"
    # Return no error.
    return 0
}

# Call the functions.
remove_whitespaces "${FN}"
exchange_lfcr "${FN}"
exchange_tabs "${FN}"
remove_whitespaces "${FN}"

# Exit script without error.
exit 0
