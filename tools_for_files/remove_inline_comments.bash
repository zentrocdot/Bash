#!/usr/bin/bash
#
# Remove Inline Comments
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# You are using the script on your own risk. If you have any doubts whether
# the script is working correctly, you should always make a backup copy of
# the file to be on the secure side.
#
# Description:
# A loop runs over each line content until all comments are removed from the
# back side. Single line comments and indented comments are ignored by default.
# There may be one or more spaces before the inline comments to be considered.
# Inline comments then starts with one or more hashtags # and may be followed
# by one or more spaces, alphanumeric characters and numbers, which will be
# removed. The characters of the punctuation character set are not allowed
# after the hashtag # of the inline comment to be recognised.
#
# [:space:]
# tab, vertical tab, form feed, newline, line feed, carriage return and space
# [:blank:]
# tab and space
# [:alnum:]
# [a-zA-Z0-9]
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.regular-expressions.info/posixbrackets.html

# Assign the command line argument to the global variable.
FN=$1

# Check if filename was given.
if [ "${FN}" = '' ]; then
    echo "No filename given. Bye!"
    exit 1
fi

# Remove inline comments from file.
sed -i ':x;/^[[:blank:]]*#/!s/[[:blank:]]\+[#]\+[[:blank:]]*\([[:alnum:][:blank:]]*\)$//g;tx' "${FN}" 2> /dev/null

# Exit script with exit code 0.
exit 0
