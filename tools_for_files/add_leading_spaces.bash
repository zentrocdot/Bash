#!/usr/bin/bash
#
# Add Leading Spaces
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# See also:
# www.asciitable.com/
# www.gnu.org/software/sed/manual/sed.html
# www.regular-expressions.info/posixbrackets.html

# Assign the command line argument to the global variable.
FN=$1

# Set the number of spaces to add to each line.
NR=8

# ***********************
# Function check_filename
# ***********************
check_filename () {
    # Assign the function argument to the local variable.
    fn=$1
    # Initialise the exit code.
    exit_code=128
    # Check if a filename was given.
    if [ "${fn}" != "" ]; then
        # Set the exit code to 0.
        exit_code=0
    else
        # Set the exit code to 1.
        exit_code=1
    fi
    # Return the exit code.
    return "${exit_code}"
}

# *******************
# Function check_file
# *******************
check_file () {
    # Assign the function argument to the local variable.
    fn=$1
    # Initialise the exit code.
    exit_code=128
    # Check if the file related to the filename exists.
    if [ -e "${fn}" ]; then
        # Set the exit code to 0.
        exit_code=0
    else
        # Set the exit code to 1.
        exit_code=1
    fi
    # Return the exit code.
    return "${exit_code}"
}

# Check if filename exist.
check_filename "${FN}"
if [ $? -eq 1 ]; then
    # Print an error message into the terminal window.
    echo "Filename was not given. Bye!"
    # Exit the script with exit code 1.
    exit 1
fi

# Check if the file exist.
check_file "${FN}"
if [ $? -eq 1 ]; then
    # Print an error message into the terminal window.
    echo "File does not exist. Bye!"
    # Exit the script with exit code 2.
    exit 2
fi

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

# Create a repeated string.
spc=$(echo -e "$(for i in $(eval echo {1..$NR}); do echo -n "\x20"; done)")

# Use sed for adding the repeated string to the lines of the file.
sed -i "s/\(^.*$\)/${spc}\1/" "${FN}" 2> /dev/null

# Exit script without an error.
exit 0
