#!/usr/bin/bash
#
# Print formatted unicode character ranges
#
# Version 0.0.0.5
#
# To-do:
# Completion of interesting Unicode symbol areas.

NUM=40

# Define the unicode ranges.
# Unused array at the moment.
# shellcheck disable=SC2034
UNICODE_RANGES=("0x2000 0x206f General punctuation"
                "0x2150 0x218f Numerals"
                "0x2190 0x21ff Arrows"
                "0x2200 0x22ff Mathematical operators"
                "0x2300 0x23ff Various technical signs"
                "0x2460 0x24ff Enclosed alphanumeric characters"
                "0x2500 0x257f Frame symbols"
                "0x25a0 0x25ff Geometric shapes"
                "0x2600 0x26ff Various symbols"
                "0x2700 0x27bf  Dingbats"
                "0x1f300 0x1f5ff Various symbols and pictograms"
                "0x1f600 0x1f64f Emojis"
                "0x1f680 0x1f6fc Traffic and map symbols"
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

printf "%s\n" "Select the unicode range:"
printf "%s\n\n" "-------------------------"
printf "%s\n" "  1)  General punctuation"
printf "%s\n" "  2)  Numerals"
printf "%s\n" "  3)  Arrows"
printf "%s\n" "  4)  Mathematical operators"
printf "%s\n" "  5)  Various technical signs"
printf "%s\n" "  6)  Enclosed alphanumeric characters"
printf "%s\n" "  7)  Frame symbols"
printf "%s\n" "  8)  Geometric shapes"
printf "%s\n" "  9)  Various symbols"
printf "%s\n" "  10) Dingbats"
printf "%s\n" "  11) Various symbols and pictograms"
printf "%s\n" "  12) Emojis"
printf "%s\n" "  13) Traffic and map symbols"
printf "%s\n" "  14) Geometric shapes, extensions"
printf "%s\n" "  15) Arrows supplement C"
printf "%s\n" "  16) Supplementary symbols and pictograms"
printf "%s\n" "  17) Chess symbols"
printf "%s\n" "  18) Symbols and pictograms, extension A"
printf "%s\n" "  19) Symbols for legacy computers"
printf "\n%s" "Your selection: "

read -r n
case "${n}" in
  1) start=0x2000; end=0x206f;;
  2) start=0x2150; end=0x218f;;
  3) start=0x2190; end=0x21ff;;
  4) start=0x2200; end=0x22ff;;
  5) start=0x2300; end=0x23ff;;
  6) start=0x2460; end=0x24ff;;
  7) start=0x2500; end=0x257f;;
  8) start=0x25a0; end=0x25ff;;
  9) start=0x2600; end=0x26ff;;
  10) start=0x2700; end=0x27bf;;
  11) start=0x1f300; end=0x1f5ff;;
  12) start=0x1f600; end=0x1f64f;;
  13) start=0x1f680; end=0x1f6fc;;
  14) start=0x1f780; end=0x1f7f0;;
  15) start=0x1f800; end=0x1f8ff;;
  16) start=0x1f900; end=0x1f9ff;;
  17) start=0x1fa00; end=0x1fa6d;;
  18) start=0x1fa70; end=0x1faf6;;
  19) start=0x1fb00; end=0x1fbf9;;
  *) echo "Invalid option selected!";;
esac

# Print an empty line.
printf "\n"

# Loop over the hex range.
unicode_char_list "${start}" "${end}"

# Print an empty line.
printf "\n\n"

# Exit the script.
exit 0
