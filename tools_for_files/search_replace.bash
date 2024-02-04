#!/usr/bin/bash
# shellcheck disable=all

# Assign the command line argument to the global variable.
FN=$1

# Assign the command line arguments to the pattern for search and replace.
OLD_STR=$2
NEW_STR=$3

# Run the sed script.
sed -i".bak" "
# Substitute old string with new string.
s/${OLD_STR}/${NEW_STR}/g
# We are done.
" "${FN}" 2> /dev/null

# Get the exit status from the sed command execution.
exit_status=$?

# Check the exit status and print a message.
if [[ "${exit_status}" = 0 ]]; then
    printf "%s\n" "Operation was executed without error. Bye!"
else
    printf "%s\n" "Operation returned an error with exit status ${exit_status}. Bye!"
fi

# Exit the script with the exit status of the sed command.
exit "${exit_status}"
