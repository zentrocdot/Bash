#!/usr/bin/bash
#
# Terminal window size
# Version 0.0.0.1
#
# See also:
# stackoverflow.com/questions/40941671/how-to-return-associative-arrays-from-function-in-shell
# stackoverflow.com/questions/1780483/lines-and-columns-environmental-variables-lost-in-a-script
# unix.stackexchange.com/questions/14159/how-do-i-find-the-window-dimensions-and-position-accurately-including-decoration

shopt -s checkwinsize  # Enable option checkwinsize.
cat /dev/null          # Refresh LINES and COLUMNS.
shopt -u checkwinsize  # Disable option checkwinsize


# #################
# Function wsize_v1
# #################
wsize_v1 () {
    # Initialise the local array.
    local size=()
    # Initialise the local variables.
    local cols
    local rows
    # Get cols and rows using tput.
    cols=$(tput cols)
    rows=$(tput lines)
    # Add cols and rows to the array.
    size+=("${cols}")
    size+=("${rows}")
    # Output the array.
    echo "${size[@]@K}"
    # Return 0.
    return 0
}

# Declare an associative array.
#shellcheck disable=SC2155
declare -A asocarr1="($(wsize_v1))"

# Print cols and rows.
echo "Cols: ${asocarr1[0]}"
echo "Rows: ${asocarr1[1]}"

# shellcheck disable=SC2178
size=$(stty size)

echo ""

#shellcheck disable=SC2128
cols=$(echo "${size}" | awk '{print $2}')
#shellcheck disable=SC2128
rows=$(echo "${size}" | awk '{print $1}')
echo "Cols: ${cols}"
echo "Rows: ${rows}"

echo ""

cols="${size#* }"
rows="${size% *}"
echo "Cols: ${cols}"
echo "Rows: ${rows}"

echo ""

# shellcheck disable=SC2312
read -r rows cols < <(stty size)
echo "Cols: ${cols}"
echo "Rows: ${rows}"

echo ""

echo "Cols: ${COLUMNS}"
echo "Rows: ${LINES}"

echo ""

var="$(resize)"
# shellcheck disable=SC2312,SC2086
cols=$(echo ${var} | awk -F ' ' '{print $1}' | sed 's/.*=\(.*\);/\1/')
# shellcheck disable=SC2312,SC2086
rows=$(echo ${var} | awk -F ' ' '{print $2}' | sed 's/.*=\(.*\);/\1/')
echo "Cols: ${cols}"
echo "Rows: ${rows}"
