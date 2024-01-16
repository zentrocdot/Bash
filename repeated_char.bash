#!/usr/bin/bash
#
# Version 0.0.0.2
#
# The snippet was checked with ShellCheck.
#
# See also:
# unix.stackexchange.com/questions/122845/using-a-b-for-variable-assignment-in-scripts

# *****************************************************************************
# Function repchr $1 $2
#
# Description:
# Create a string from a repeated character. Arguments are the char to repeated
# and the number of repeated chars. Default values are preset.
#
# Function arguments:
#     $1 -> character for repetition
#     $2 -> length of returned string
#
# Echoed function result:
#     String of the requested length
#
# Returned exit code:
#     0 on no error
# *****************************************************************************
repchr () {
    # Assign the function arguments to the local variables.
    local chr="${1:-*}"
    local nr="${2:-80}"
    # Create the string from the given character.
    for _ in $(eval echo "{1..${nr}}")
    do
        echo -n "${chr}"
    done
    # Return the exit code 0.
    return 0
}

# Test the function.
echo -e "Function test ...\n"
nr=80
echo -e "$(repchr)"
echo -e "$(repchr ":" ${nr})"
echo -e "$(repchr "?" ${nr})"
echo -e "$(repchr "#" ${nr})"

# Onliner if char and number are predefined.
echo -e "\nOnliner test ...\n"
echo -e "$(for _ in {1..80}; do echo -n "+"; done)"  # chr="+" and nr=80
echo -e "$(printf "=%.0s" {1..80})"                  # chr="=" and nr=80
echo -e "$(printf %80s " " |tr " " "%")"             # chr="%" and nr=80
