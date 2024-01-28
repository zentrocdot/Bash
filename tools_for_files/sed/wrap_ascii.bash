#!/usr/bin/bash
#
# Wrap ASCII text after a defined number of characters.
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# Description:
# The script is intended to reformat Base64 data.
#
# Remarks:
# One can use 'fold -w <number_chars> <filename>' from the GNU coreutils
# to get the same result.
#
# Linter:
# Script was checked with ShellCheck.
#
# Arguments:
#     $1  Filename of input file
#     $2  Wrap length
#
# Output:
#     Wrapped ASCII text into txt-file
#
# Returns:
#     exit_code
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/sed.pdf

# Assign the command line argument to the global variable.
FN=$1

# Set the number of characters for wrapping.
# Default value is set to 40 characters.
NR=${2:-40}

# Get output flag.
OUT_FLAG=${3:-false}

# Define the output file.
FN_OUT="wrap_ascii.out"

# Initialise the exit code.
exit_code=0

# Wrap Ascii text and print result to screen.
sed "
:outer                  # Define the label outer (outer loop).
$ {/^$/d}               # Remove remaining empty lines in a command group.
N                       # Append a newline and the next input line to the pattern space.
s/\n//g                 # Remove all newlines from the pattern space.
:inner                  # Define the label inner (inner loop).
s/\(.\{${NR}\}\)/\1\n/  # Add a newline after the first NR characters.
/\n/ {                  # Execute command group if there is a newline in the pattern space.
P                       # Print the pattern space until the first newline.
s/.*\n//                # Remove the printed characters and the first newline.
b inner                 # Branch to label inner.
}; b outer              # Branch to label outer.
" "${FN}" > "${FN_OUT}" 2> /dev/null

# Get the exit code from the sed command execution.
exit_code=$?

# Write message into terminal window.
if [ ${exit_code} = 0 ]; then
    printf "%s\n" "Wrapped data written to file '${FN_OUT}'."
fi

# Output data into terminal window.
if [ "${OUT_FLAG}" = true ]; then
    # Use cat to print the file content.
    printf "\n"
    cat "${FN_OUT}"
    printf "\n"
fi

# Print farewell message.
printf "%s\n" "Have a nice day. Bye!"

# Exit the script with a exit code.
exit "${exit_code}"
