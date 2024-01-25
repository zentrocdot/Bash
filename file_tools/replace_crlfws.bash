#!/usr/bin/bash
#
# Version 0.0.0.4
# Copyright © 2024, Dr. Peter Netz
#
# You are using the script on your own risk.
#
# Description:
# Remove leading and trailing spaces from a file. Read the file and exchange
# carriage return, line feed and tab by one space.
# The result will be in principle a onliner of the given file content.
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
# :x;N;$!bx
#
# :x   -> create a label 'x'
# N    -> append the next line to the pattern space
# $!ba -> if it is not the last line, branch to (go to) label 'x'
#
# sed will loop through these three steps until the last line is reached,
# grabbing all lines fit in the pattern space where sed will perform the
# substitutions.
#
# s/[\n\r]/ /g -> substitute line feed and carriage return by one space
# s/\t]/ /g    -> substitute tab by one space
#
# Global match means as many times as it is possible.
#
# See also:
# www.gnu.org/software/sed/manual/sed.html

# Get the filename from the command line argument.
FN=$1

# Check if filename was given.
if [ "${FN}" = '' ]; then
    echo "No filename given. Bye!"
    exit 1
fi

# *********************
# Function tab_to_space
# *********************
tab_to_space () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Read file and exchange tab by one space.
    sed -i 's/\t/ /g' "${FN}"
    # Return no error.
    return 0
}

# ********************************************
# Function remove_leading_trailing_whitespaces
# ********************************************
remove_leading_trailing_whitespaces () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Remove leading and trailing whitespaces from file.
    sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "${fn}"
    # Return no error.
    return 0
}

# **************************************
# Function multiple_whitespaces_to_space
# **************************************
multiple_whitespaces_to_space () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Remove leading and trailing whitespaces from file.
    sed -i 's/[[:blank:]]\+/ /g' "${fn}"
    # Return no error.
    return 0
}

# **********************
# Function crlf_to_space
# **********************
crlf_to_space () {
    # Assign the function argument to the local variable.
    local fn=$1
    # Read file and exchange carriage return and line feed by one space.
    sed -i ':x;N;$!bx;s/[\r\n]/ /g' "${FN}"
    # Return no error.
    return 0
}

# Call the functions.
remove_leading_trailing_whitespaces "${FN}"
crlf_to_space "${FN}"
multiple_whitespaces_to_space "${FN}"
remove_leading_trailing_whitespaces "${FN}"

# Exit script without error.
exit 0
