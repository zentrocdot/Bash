#!/usr/bin/bash
#
# Description:
# Number lines.

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

# Read sed from file.
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
