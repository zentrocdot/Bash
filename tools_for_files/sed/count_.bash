#!/usr/bin/bash
#
# Count lines, words, and characters in a text file.
# Version 0.0.0.1
#
# Foreword:
# I found this nice high sophisticated sed script while looking for good
# sed script examples. At first the sed script did not work as expected.
# After a short analysis, I got it to run without errors. The result can
# be found below. I have added a comment to the problematic part of the
# script. This way, anyone can get the script running.
#
# Acknowledgment:
# Written by Greg Ubben on 25 March 1989.
# Resources:
# sed.sourceforge.io/
# sed.sourceforge.io/grabbag/tutorials/greg_wc.txt
# github.com/aureliojargas/sed.sf.net

# Assign the command line argument to the global variable.
FN=$1

# Count lines, word and characters in a file.
sed '
1 {
x
s/^/hgfedcba/
s/.*/,&,&;&/
x
}
s/^/ /
H
s/./a/g
H
g
# s/[<space><tab>]\{1,\}[^<tab>-<space>]\{1,\}/a/g
s/[ 	]\{1,\}[^	- ]\{1,\}/a/g
s/\(;[a-z]*\).\(a*\)/\2\1/
# s/[<tab>-<space>]//g
s/[	- ]//g
s/a/aa/
:a
s/\(.\)\(.\)\2\2\2\2\2\2\2\2\2\2/\1\1\2/
ta
h
$!d
s/\([a-z]\)\1\1\1\1\1\1\1\1\1/9/g
s/\([a-z]\)\1\1\1\1\1\1\1\1/8/g
s/\([a-z]\)\1\1\1\1\1\1\1/7/g
s/\([a-z]\)\1\1\1\1\1\1/6/g
s/\([a-z]\)\1\1\1\1\1/5/g
s/\([a-z]\)\1\1\1\1/4/g
s/\([a-z]\)\1\1\1/3/g
s/\([a-z]\)\1\1/2/g
s/\([a-z]\)\1/1/g
s/\([a-z]\)/0/g
s/[,;]0*\([0-9]\)/ \1/g
s/ //
' "${FN}"

# Exit the script.
exit 0
