#!/usr/bin/bash
#
# Print formatted Unicode character ranges
#
# Version 0.0.0.8
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license available here:
# https://github.com/zentrocdot/zentrocdot/blob/main/LICENSE
#
# To-do:
# Completion of Unicode symbol ranges of interest.
# No language specific ranges.

NUM=40

# Define the unicode ranges.
UNICODE_RANGES=("0x2000 0x206f General punctuation"
                "0x2070 0x209f Superscripts and subscripts"
                "0x20a0 0x20cf Currency symbols"
                "0x2150 0x218f Numerals"
                "0x2190 0x21ff Arrows"
                "0x2200 0x22ff Mathematical operators"
                "0x2300 0x23ff Various technical signs"
                "0x2460 0x24ff Enclosed alphanumeric characters"
                "0x2500 0x257f Frame symbols"
                "0x2580 0x2595 Block elements"
                "0x25a0 0x25ff Geometric shapes"
                "0x2600 0x26ff Various symbols"
                "0x2700 0x27bf Dingbats"
                "0x2a00 0x2aff Supplementary mathematical operators"
                "0x2b00 0x2bff Various symbols and arrows"
                "0x13000 0x1342f Egyptian hieroglyphs"
                "0x1d400 0x1d7ff Mathematical alphanumeric symbols"
                "0x1f300 0x1f5ff Various symbols and pictograms"
                "0x1f600 0x1f64f Emojis"
                "0x1f650 0x1f67f Ornamental symbols"
                "0x1f680 0x1f6fc Traffic and map symbols"
                "0x1f700 0x1f773 Alchemistic symbols"
                "0x1f780 0x1f7f0 Geometric shapes, extensions"
                "0x1f800 0x1f8ff Arrows supplement C"
                "0x1f900 0x1f9ff Supplementary symbols and pictograms"
                "0x1fa00 0x1fa6d Chess symbols"
                "0x1fa70 0x1faf6 Symbols and pictograms, extension A"
                "0x1fb00 0x1fbf9 Symbols for legacy computers")

# ##################
# print unicode char
# ##################
print_unicode_char () {
    # Assign the function argument to the local variable.
    local chr=$1
    # Initialise the local variables.
    local ret=0
    local ucc=''
    local len=0
    # Create the unicode character.
    ucc=$(printf '%b' "${chr}")
    # Determine the length of the unicode character.
    len=$(echo "${ucc}" | wc -L)
    # Check if there is a printable sysmbol.
    if [[ "${len}" -gt 0 ]]; then
        # Add one space if it is required.
        if [[ "${len}" -eq 1 ]]; then
            spc=' '
        elif [[ "${len}" -eq 2 ]]; then
            spc=''
        fi
        # Print the unicode character into the terminal window.
        printf "%b%s" "${ucc}" "${spc}"
        # Set the return code.
        ret=1
    fi
    # Return the return value.
    return "${ret}"
}

# #######################
# Print unicode char list
# #######################
unicode_char_list () {
    # Assign the function arguments to the local variables.
    local start=$1
    local end=$2
    # Initialise the return value.
    local ret=0
    # Initialise the counter.
    local count=0
    # Loop over the hex range.
    for ((i="${start}"; i<="${end}"; i++)); do
        # Use modulo for calculationg the location of a line break.
        n=$((count%NUM))
        # Add a newline after a given number of printed chars.
        if [[ "${n}" == 0 ]] && [[ "${count}" != 0 ]]; then
            printf "\n"
        fi
        # Determine the hex number.
        hex=$(printf '%x' "${i}")
        # Decide if we have to use \U or \u for the unicode representation.
        if [[ ${#hex} -gt 4 ]]; then
            char=$(echo -en "\U${hex}")
        else
            char=$(echo -en "\u${hex}")
        fi
        # Call the function.
        print_unicode_char "${char}"
        # Get the exit code.
        ret=$?
        # Increment the counter.
        ((count+=ret))
    done
    # Return 0.
    return 0
}

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

# Reset the terminal window.
reset

# Print the menu.
printf "%s\n" "Select the unicode range:"
printf "%s\n\n" "-------------------------"
count=1
for name in "${UNICODE_RANGES[@]}"; do
    name=$(echo "${name}" | awk '{$1=$2=""; print $0}' | sed 's/^  //')
    printf "%2s %s\n" "${count}" "$name"
    ((++count))
done
printf "\n%s" "Your selection: "
read -r n
range=("${UNICODE_RANGES[n-1]}")
start=$(echo "${range}" | awk '{print $1}' | sed 's/^  //')
end=$(echo "${range}" | awk '{print $2}' | sed 's/^  //')

# Print an empty line.
printf "\n"

# Loop over the hex range.
unicode_char_list "${start}" "${end}"

# Print an empty line.
printf "\n\n"

# Exit the script.
exit 0
