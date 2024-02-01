#!/usr/bin/bash
# shellcheck disable=SC2034
# shellcheck disable=SC2312
# shellcheck disable=SC2250
#
# Description:
# This script is intended to show how it is possible to write a sed script
# without having a meaningful input file. The main goal of the script is
# to endlessly concatenate numbers from 0 to 9 on the screen. This is the
# preliminary stage to implementing a counter. The script writes the numbers
# to the full screen.
#
# Open question:
# At the moment it is not 100% clear to me why I do not have a break in the
# number series. I awaited this in the output. This has to be checked.

# Simulate an empty file.
file=$'test1\ntest2\ntest3\ntest4'

echo -e "My example:\n"

# Read sed from file.
sed -n '
x
s/^/0/
s/.*\([0-9]\{1\}\)$/\1/g
y/0123456789/1234567890/
x
H
x
s/\n/ /g
# Functionality of the GNU sed example added.
s/\(.*\)/     \1/p
' <<< "${file}"

echo -e "\nModified GNU sed tutorial example:\n"

sed -n '
x
/^$/ s/^.*$/1/
G
h
# The next two lines format the numbering.
s/^/      /
s/^ *\(......\)\n/\1 /p
g
s/\n.*$//
/^9*$/ s/^/0/
s/.9*$/x&/
h
s/^.*x//
y/0123456789/1234567890/
x
s/x.*$//
G
s/\n//
h
' <<< "${file}"

# Exit the script.
exit 0
