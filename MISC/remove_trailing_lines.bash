#!/usr/bin/bash
#
# Remove the last empty lines in a file if present
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# See: github.com/zentrocdot/Bash/tree/main?tab=MIT-1-ov-file#readme
#
# Remove all empty lines after the last line with valid content.
# A backup copy is created for security reasons.
#
# Check the advantages versus the disadvantages of the current approach.
#
# The script was checked with ShellCheck.
#
# See also:
# www.baeldung.com/linux/file-remove-trailing-newline
# www.gnu.org/software/sed/manual/sed.html

# Assign the command line argument to the global variable.
FN=$1

# Initialise the sed exit status to 5.
exit_status=5

# Set the empty line counter to -1.
count=-1

# Define a array with alll sed exit codes.
error_codes=("1" "2" "4" "42")

# Loop as long there are empty lines in the file.
while [[ " ${error_codes[*]} " != *" ${exit_status} "* ]]; do
    sed -i".bak" '$ {/^$/d};$ {/^.*$/ q42}' "${FN}" 2> /dev/null
    exit_status=$?
    ((count++))
done

# Print message based on the sed exit code.
case "${exit_status}" in
    0)
    printf "%s\n" "Successful completion (not possible in our case).";;
    1)
    printf "%s\n" "Invalid command, invalid syntax, invalid regular expression or a GNU sed extension command used with --posix.";;
    2)
    printf "%s\n" "One or more of the input file specified on the command line could not be opened.";;
    4)
    printf "%s\n" "An I/O error or a serious processing error during runtime occurred.";;
    42)
    printf "%s\n" "${count} empty lines are removed from file.";;
    *)
    printf "%s\n" "Unknown error.";;
esac

# Exit the script.
exit 0


