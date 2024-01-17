#!/bin/bash

# ##############################################################################
# 16 Terminal Color Demonstrator
# Version 0.0.1
# (c) 2018, Dr. Peter Netz
#
# Script Name:
#   terminal_color_16.bash
#
# Description:
#     The script generates an color table with 16 colors for demonstration
#     purposes, using the ANSI escape sequences in the form CSI+SGR. An
#     Addition of column and row results a color number between 0 and 255.
#
# Usage of 16 color mode:
#     CSI = ESC[					-> CSI sequence
#     SGR = ${attribute};${bg-color};${fg-color}m	-> Set color
#     SGR = [0m                    			-> Default color
#
# Abbreviations:
#     CSI = Control Sequence Introducer
#     SGR = Select Graphic Rendition
#
# Development:
#     The script was developed and tested under Linux Mint 18 Cinnamon. The
#     installed Bash version was 4.3.42(1)-release. The shell script analysis
#     tool shellcheck was used for checking the script.
#
# Possible Attributes:
#
#     parameter -> result
#     0            Reset all attributes to their defaults
#     1            Bold/Bright
#     2            Half-bright
#     3            Italic
#     4            Underlined
#     5            Blink
#     7            Reverse video
#     8            Hidden
#     21           Bold/Bright off
#     22           Half-bright off
#     23           Italic off
#     24           Underline off
#     25           Blink off
#     27           Reverse video off
#     28           Hidden off
#
# Foreground colors:
#     39 	Default foreground color
#     30 	Black
#     31 	Red
#     32 	Green
#     33 	Yellow
#     34 	Blue
#     35 	Magenta
#     36 	Cyan
#     37 	Light gray
#     90 	Dark gray
#     91 	Light red
#     92 	Light green
#     93 	Light yellow
#     94 	Light blue
#     95 	Light magenta
#     96 	Light cyan
#     97 	White
#
# Background colors:
#     49 	Default background color
#     40 	Black
#     41 	Red
#     42 	Green
#     43 	Yellow
#     44 	Blue
#     45 	Magenta
#     46 	Cyan
#     47 	Light gray
#     100 	Dark gray
#     101 	Light red
#     102 	Light green
#     103 	Light yellow
#     104 	Light blue
#     105 	Light magenta
#     106 	Light cyan
#     107 	White
#
# Ref.: http://misc.flogisoft.com/bash/tip_colors_and_formatting
#
# Copyright Notice:
# -----------------
#
# The software is for private use of natural persons only. The use of the
# software by authorities, institutions, enterprises and profit as well as
# non-profit organisations etc. is explicitly prohibited.
#
# The permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files, to deal in the
# software without restriction, including without limitation the rights to
# use, to copy, to modify, to merge, to publish, to distribute, to sublicense,
# and to permit persons to whom the software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the software.
#
# Warranty:
# ---------
#
# The software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising
# from, out of or in connection with the software or the use or other dealings
# in the software.
# ##############################################################################

# Script variables.
TITLE="16 Terminal Color Demonstrator"
VERSION="Version 0.0.1"
COPYRIGHT="(c) 2018, Dr. Peter Netz"

# Set header variables.
CHAR="#"
OLEN=70
ILEN=$((OLEN-2))

# Set the line feed and carriage return variables.
NL="\n\r"
NLNL="\n\n\r"

# Set the space variable.
SPC="\040"

# Set the Control Sequence Introducer.
CSI="\033["

# Reset attributes.
CRA="0m"

# ==============================================================================
# Function head_line
# ==============================================================================
function head_line {
    # Set local string.
    local s=$1
    # Calculate the length of the string.
    local slen=${#s}
    # Calculate the length of the substrings.
    local l=$(((ILEN - slen)/2))
    local r=$((ILEN - l - slen))
    # Return string.
    printf "%s%-${l}b%s%-${r}b%s%b" "${CHAR}" "${SPC}" "${s}" "${SPC}" "${CHAR}"
    # Exit code 0.
    return 0
}

# ==============================================================================
# Function write_header
# ==============================================================================
function write_header {
    # Define border string.
    local b=''
    b=$(printf "%${OLEN}s" | tr "${SPC}" "${CHAR}")
    # Write header into the terminal window.
    printf "%s%b" "${b}" "${NL}"
    printf "%s%${ILEN}b%s%b" "${CHAR}" "${SPC}" "${CHAR}" "${NL}"
    printf "%s%b" "$(head_line "${TITLE}")" "${NL}"
    printf "%s%b" "$(head_line "${VERSION}")" "${NL}"
    printf "%s%b" "$(head_line "${COPYRIGHT}")" "${NL}"
    printf "%s%${ILEN}b%s%b" "${CHAR}" "${SPC}" "${CHAR}" "${NL}"
    printf "%s%b" "${b}" "${NL}"
    # Exit code 0.
    return 0
}

# ==============================================================================
# Function print_column_numbers
# ==============================================================================
function print_column_numbers {
    # Set local variable.
    local plus="\053"
    # Print first column.
    printf "%3b%b%2b" "${SPC}" "${plus}" "${SPC}"
    # Loop over the next 8 columns.
    for n in $(seq 0 7)
    do
        # Print the column number into the terminal window.
        printf "%-2b%-4u%-2b"  "${SPC}" "$n" "${SPC}"
    done
    # Exit code 0.
    return 0
}

# ==============================================================================
# Function print_colors
# ==============================================================================
function print_colors {
    # Write the row number into the terminal window.
    printf "%b%b%3b%2b" "${NLNL}" "${SPC}" "$1" "${SPC}"
    # Set the local variables.
    local attr=0
    local count=$1
    # Set background color.
    if [ "$1" == 30 ] || [ "$1" == 40 ]; then
        first=40
        last=47
    elif [ "$1" == 90 ] || [ "$1" == 100 ]; then
        first=100
        last=107
    fi
    # Loop over the background color.
    for clbg in $(seq "${first}" "${last}")
    do
        # Change foreground color.
        if [ "$clbg" == "$first" ]; then
            clfg=37
        elif [ "$clbg" != "$first" ]; then
            clfg=30
        fi
        # Write color into the terminal window.
        printf "%b%-2b%-3u%-2b%b%b" "${CSI}${attr};${clfg};${clbg}m" "${SPC}" \
                                    "${count}" "${SPC}" "${CSI}${CRA}" "${SPC}"
        # Increment the counter.
        count=$((count+1))
    done
    # Exit code 0.
    return 0
}

# ##############################################################################
# Main script section
# ##############################################################################

# Reset the terminal window.
reset

# Write the header into the terminal window.
write_header

# Write an empty line into the terminal window.
printf "%b" "${NL}"

# Write a headline into the terminal window.
str0="Foreground Color Numbers"
str1="========================"
printf "%s%b" "${str0}" "${NL}"
printf "%s%b" "${str1}" "${NLNL}"

# Write the column numbers into the terminal window.
print_column_numbers

# Write the colors into the terminal window.
print_colors 30 37

# Write the colors into the terminal window.
print_colors 90 97

# Write an empty line into the terminal window.
printf "%b" "${NLNL}"

# Write a headline into the terminal window.
str0="Background Color Numbers"
str1="========================"
printf "%s%b" "${str0}" "${NL}"
printf "%s%b" "${str1}" "${NLNL}"

# Write the column numbers into the terminal window.
print_column_numbers

# Write the colors into the terminal window.
print_colors 40

# Write the colors into the terminal window.
print_colors 100

# Write an empty line into the terminal window.
printf "%b" "${NLNL}"

# Exit the script.
exit 0

