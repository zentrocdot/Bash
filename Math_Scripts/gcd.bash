#!/usr/bin/bash
#
# Calculate the greates common divisor
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# github.com/zentrocdot/Bash_Programming/tree/main?tab=MIT-1-ov-file
#
# See also:
# de.wikipedia.org/wiki/Bildauflösungen_in_der_Digitalfotografie

# Initialise the values.
a=${1:-5184}
b=${2:-3456}

# ############
# Function gcd
# ############
function gcd () {
    # Assign the function arguments to the local variables.
    local a=$1
    local b=$2
    # Declare the variable n.
    local n
    # Loop until the gcd is found.
    while [[ "${b}" -gt 0 ]]
    do
        n="${a}"
        a="${b}"
        b=$((n%b))
    done
    # Output the greatest common devisor.
    echo "${a}"
    # Return 0.
    return 0
}

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

# Call the function:
GCD=$(gcd "${a}" "${b}")

# Print the gcd.
echo -e "${GCD}"

# Exit the script.
exit 0
