#!Usr/bin/bash
#
# Extract expressions from structured data
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# Description
# The sed script reads a file line by line. If there is data after a
# semicolon ; followed by a space the data is extracted from the line
# and printed out line by line. Empty lines are ignored and if there
# is no valid data the field is ignored too.
#
# Output takes place in the correct order!
#
# The script works as expected. However, there is still potential and
# need for optimisation.
#
# Limitation:
# If the pattern is escaped like \; it will not be recognised.
#
# Example for a file content to work with:
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
/\;[[:blank:]]/ {                   # Match only lines with pattern and space.
s/^[^\;]*\;/;/                      # Remove everything before first pattern.
s/\;$//                             # If last char is the pattern remove it.
h                                   # Store pattern space to hold space.
:z                                  # Set label z.
x                                   # Exchange hold space with pattern space.
s/^[^\;]*;\([^\;]*\)\;.*/\1/g       # Remove everything after second pattern.
{                                   # Group defines the breaking condition for the loop.
s/^[[:blank:]]*//                   # Remove leading spaces if existing.
s/^\;[[:blank:]]*\(.*$\)/\1/        # Remove pattern and spaces if exiting.
T                                   # Branch on no success. End the cycle.
}                                   # End of group commands.
/^[[:space:]]*$/! {p}               # Print match if not empty.
x                                   # Exchange hold space with pattern space.
s/^[^\;]*;\([^\;]*\)\(\;.*\)/\2/g   # Remove last match from pattern space.
h                                   # Store pattern space to hold space.
tz                                  # Branch to label z on success.
}
' "${FN}"

# Exit the script.
exit 0
