#!/usr/bin/bash
#
# Print formatted unicode chars
#
# Version 0.0.0.2

NUM=40

# General punctuation.
#start=0x2000
#end=0x206f

# Numerals.
#start=0x2150
#end=0x218f

# Arrows.
#start=0x2190
#end=0x21ff

# Various technical signs.
#start=0x2300
#end=0x23ff

# Frame symbols.
#start=0x2500
#end=0x257f

# Geometric shapes.
#start=0x25a0
#end=0x25ff

# Various symbols.
#start=0x2600
#end=0x26ff

# Dingbats.
#start=0x2700
#end=0x27bf

# Various symbols and pictograms.
start=0x1f300
end=0x1f5ff

# Traffic and map symbols.
#start=0x1f680
#end=0x1f6fc

# Geometric shapes, extensions
#start=0x1f780
#end=0x1f7f0

# Chess symbols.
#start=0x1fa00
#end=0x1fa6d

# Symbols and pictograms, extension A
#start=0x1fa70
#end=0x1faf6

# ##################
# Print unicode char
# ##################
print_unicode_char () {
    # Assign the function arguments to the local variables.
    local uc=$1
    local spc=$2
    # Print the unicode character to screen.
    printf "%b%s" "${uc}" "${spc}"
    # Return 0.
    return 0
}

# #######################
# Print unicode character
# #######################
create_unicode_char () {
    # Assign the function argument to the local variable.
    local char=$1
    # Initialise  return value.
    local ret=0
    # Create the unicode character.
    local uc=$(printf '%b' "${char}")
    # Get the length of the unicode character.
    local len=$(echo "${uc}" | wc -L)
    # Add space if required.
    if [[ "${len}" -gt 0 ]]; then
        if [[ "${len}" -eq 1 ]]; then
            spc=' '
        else
            spc=''
        fi
        # Print the unicode character to screen.
        ! print_unicode_char "${uc}" "${spc}"
        ret=$?
    fi
    # Return the return value.
    return "${ret}"
}

# Print unicode character list.
unicode_char_list () {
    # Assign the function arguments to the local variables.
    local start=$1
    local end=$2
    # Initialise the return value.
    local ret=0
    # Set the counter.
    count=0
    # Loop over the hex range.
    for (( i="${start}"; i<="${end}"; i++ )); do
        # Add a newline after a given number of printed chars.
        n=$((count%NUM))
        if [[ "${n}" == 0 ]] && [[ "${count}" != 0 ]]; then
            printf "\n"
        fi
        # Get the hex number without the '0x'.
        hex=$(printf '%#x' "${i}" | sed 's/^0x//g')
        # Decide if we have to use \U or \u for the unicode representation.
        if [[ ${#hex} -gt 4 ]]; then
            char=$(echo -en "\U${hex}")
        else
            char=$(echo -en "\u${hex}")
        fi
        # Call the subroutine.
        create_unicode_char "${char}"
        ret=$?
        # Increment the counter.
        ((count+=ret))
    done
    return 0
}

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

echo -e ""

unicode_char_list "${start}" "${end}"

echo -e "\n"

# Exit the script.
exit 0
