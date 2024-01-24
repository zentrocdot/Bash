#!/usr/bin/bash
#
# version 0.0.0.1
#
# Description:
# Exchange newlines, carriage returns and tabs by one space and remove
# leading and trailing spaces and
#
# Explanation:
#
# s/^[[:space:]]*//g -> remove leading spaces
# s/[[:space:]]*$//g -> remove trailing spaces
#
# :a;N;$!ba
#
# 1. :a   -> create a label 'a'
# 2. N    -> append the next line to the pattern space
# 3. $!ba -> if it is not the last line, branch to (go to) label 'a'
#
# sed will loop through the steps 1 to 3 until the last line is reached,
# getting all lines fit in the pattern space where sed will perform the
# substitutions.
#
# s/[\n\r\t]/ /g -> substitute line feed, carriage return and tab by one space
#
# Global match means as many times as it is possible.

# Get the filename from the command line argument.
FN=$1

# Check if filename was given.
if [ "${FN}" = '' ]; then
    echo "No filename given. Bye!"
    exit 1
fi

# Remove leading and trailing whitespaces from a given file.
sed -i 's/^[[:space:]]*//;s/[[:space:]]*$//' "${FN}"

# Exchange line feed, carriage returns and tabs from a given file.
sed -i ':a;N;$!ba;s/[\n\r\t]/ /g' "${FN}"

# Exit script without error.
exit 0
