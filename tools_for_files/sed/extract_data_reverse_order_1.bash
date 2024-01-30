#!Usr/bin/bash
#
# Extract words from structured data
#
# Description
# The sed script reads a file line by line. If there is data after a semicolon ;
# the data is extracted from the line and printed out line by line. Empty lines
# are ignored and if there is no valid data the field is ignored.
#
# Example for a file content:
# ; United Kingdom; Germany; Marshall Islands; France
# ; Argentina; Saint Kitts and Nevis
# ; Vanuatu
# ; United States
# ; Australia; Norway; Mexico
# ; Brazil; Cyprus

# Assign the command line argument to the global variable.
FN=$1

# Print out the extracted data line by line.
sed -n '
/\;/ {                          # Match every line with the pattern.
s/^[^\;]*\;/;/                  # Remove everything before first pattern.
:z                              # Set the label z.
h                               # Store the pattern space in the hold space.
s/.*\;[[:blank:]]*\(.*\)$/\1/g  # Match the pattern and what follows.
/^[[:space:]]*$/! {p}           # Print match if not empty.
g                               # Write the hold space to the pattern space.
s/\(.*\)\;.*/\1/g               # Remove the match.
tz }                            # Branch to label z
' "${FN}"

# Exit the script.
exit 0
