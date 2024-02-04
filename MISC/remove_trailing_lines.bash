#!/usr/bin/bash
#
# Remove the last empty lines in a file if present
# Version 0.0.0.1
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

FN=$1

exit_status=5

count=-1

while [[ "${exit_status}" -ne 42 ]]; do
    sed -i".bak" '$ {/^$/d};$ {/^.*$/ q42}' "${FN}" 2> /dev/null
    exit_status=$?
    ((count++))
done

printf "%s\n" "${count} empty lines are removed from file."

exit 0


