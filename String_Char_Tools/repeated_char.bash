#!/usr/bin/bash
# shellcheck disable=SC2016
# shellcheck disable=SC2051
# shellcheck disable=SC2086
# shellcheck disable=SC2248
# shellcheck disable=SC2250
# shellcheck disable=SC2312
#
# Version 0.0.0.5
#
# The snippet was checked with ShellCheck.
#
# See also:
# www.cyberciti.biz/faq/repeat-a-character-in-bash-script-under-linux-unix/
# unix.stackexchange.com/questions/122845/using-a-b-for-variable-assignment-in-scripts
# dirask.com/posts/Bash-repeat-a-character-N-times-prz6rp
# stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash
# stackoverflow.com/questions/50118009/bash-repeat-character-a-variable-number-of-times

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

# Clear screen.
clear

# Test the function.
echo -e "Function test ...\n"
echo -e "$(repchr)"
nr=80
echo -e "$(repchr ":" ${nr})"
echo -e "$(repchr "?" ${nr})"
echo -e "$(repchr "#" ${nr})"

# Onliner if char and number are predefined.
echo -e "\nOnliner test ...\n"
echo -e "$(for i in {1..80}; do echo -n "+"; done)"              # 80 * "+"
echo -e "$(for i in {1..80}; do printf "+"; done)"               # 80 * "+"
echo -e "$(for (( i = 0; i < 80; i++ )); do echo -n "-"; done)"  # 80 * "-"
echo -e "$(for (( i = 0; i < 80; i++ )); do printf "-"; done)"   # 80 * "-"
echo -e "$(for i in $(seq 1 80); do echo -n "a"; done)"          # 80 * "a"
echo -e "$(for i in $(seq 1 80); do printf "a"; done)"           # 80 * "a"
echo -e "$(printf "=%.0s" {1..80})"                              # 80 * "="
echo -e "$(printf %80s " " |tr " " "%")"                         # 80 * "%"
echo -e "$(printf %*s 80 "" |tr " " "!")"                        # 80 * "!"
echo -e "$(echo -e ''$_{1..80}'\b_')"                            # 80 * "_"

# Repeated char with variable length.
echo -e "\nOnliner test with variable length and char...\n"
no=90
chr="#"
echo -e "$(for i in $(eval echo "{1..$no}"); do echo -n "${chr}"; done)"
echo -e "$(eval "$(echo printf '"$chr%0.s"' {1..$no})")"
echo -e "$(printf "${chr}%.0s" $(seq $no))"
echo -e "$(while ((no--)); do echo -n "${chr}"; done)"
