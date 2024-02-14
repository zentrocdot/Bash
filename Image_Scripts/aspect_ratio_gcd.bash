#!/usr/bin/bash
#
# Calculate the aspect ratio of an image
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# github.com/zentrocdot/Bash_Programming/tree/main?tab=MIT-1-ov-file

# Initialise the values of the resolutions.
XRES=${1:-5184}
YRES=${2:-3456}

# ############
# Function gcd
# ############
function gcd() {
    local a=$1
    local b=$2
    while [[ "${b}" -gt 0 ]]; do
        local n="${a}"
        a="${b}"
        b=$((n%b))
    done
    echo "${a}"
    return 0
}

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

# Call the function:
GCD=$(gcd "${XRES}" "${YRES}")

# Print the gcd.
#echo -e "GCD: ${gcd}"

# Calculate the aspect ratio.
x=$((XRES/GCD))
y=$((YRES/GCD))

# Print the result.
printf "%s:%s%b" "${x}" "${y}" "\n"

# Exit the script.
exit 0
