#!/usr/bin/bash
#
# Calculate the aspect ratio of an image.
# Version 0.0.0.1
#
# Description:
# An array with the prime numbers of x-resolution as well as y-resolution
# is created. These two arrays then untouched in the whole script.
#
# See also:
# de.wikipedia.org/wiki/Bildaufl%C3%B6sungen_in_der_Digitalfotografie

# Example aspect ratios:
# Canon EOS 550D:
XRES=5184
YRES=3456
# Pentacon Praktica DCZ 6.3:
#XRES=2848
#YRES=2136
# Pentacon Praktica DCZ 12.1:
#XRES=3264
#YRES=2448

# ####################
# Function print_array
# ####################
print_array () {
    # shellcheck disable=SC2124
    local arr=$@
    local i=0
    for i in "${arr[@]}"
    do
        printf "%s%b" "${i}" "\n"
    done
    return 0
}

# ####################
# Function is_in_array
# ####################
is_in_array () {
    # Assign the funktion argument to the local variable.
    local search_string=$1
    # Initialise the return value to false.
    local return_value=1
    # Declare the local loop variable.
    local element
    # Remove the first argument from the list of arguments $@.
    shift
    # Loop over the list of arguments.
    for element in "$@"
    do
        # Check if the search string is found.
        if [[ "${search_string}" = "${element}" ]]
        then
            # Set the return value to true.
            return_value=0
        fi
    done
    # Return the return value.
    return "${return_value}"
}

# Determine the primes of the x- and y-resolution.
# shellcheck disable=SC2312
PX=$(factor "${XRES}" | sed 's/^.*: \(.*\)/\1/')
# shellcheck disable=SC2312
PY=$(factor "${YRES}" | sed 's/^.*: \(.*\)/\1/')

# Make an array from the prime numbers.
# shellcheck disable=SC2206,SC2250
PA=($PX)
# shellcheck disable=SC2206,SC2250
PB=($PY)

# Get the length of the arrays.
LEN1=${#PA[@]}
LEN2=${#PB[@]}

# Initialise the arrays.
RA=()
RB=()

# Calculate the difference.
DIFF=$((LEN1-LEN2))
#ABS=${DIFF#-}

# Initialise the arrays.
REF=()
TMP=()

# Set the switch variable.
SWITCH=0

# Switch arrays.
if [[ "${DIFF}" -lt 0 ]]; then
    REF=("${PA[@]}")
    TMP=("${PB[@]}")
    RA=("${PA[@]}")
    RB=("${PB[@]}")
    SWITCH=0
else
    REF=("${PB[@]}")
    TMP=("${PA[@]}")
    RA=("${PB[@]}")
    RB=("${PA[@]}")
    SWITCH=1
fi

# ###################
# Function ext_ele_RA
# ###################
ext_ele_RA () {
    local element=$1
    local idx
    for idx in "${!RA[@]}"; do
        if [[ "${RA[${idx}]}" == "${element}" ]]; then
            # Remove element from global array.
            unset "RA[${idx}]"
            break
        fi
    done
    return 0
}

# ###################
# Function ext_ele_RB
# ###################
ext_ele_RB () {
    local element=$1
    local idx
    for idx in "${!RB[@]}"; do
        if [[ "${RB[${idx}]}" == "${element}" ]]; then
            # Remove element from global array.
            unset "RB[${idx}]"
            break
        fi
    done
    return 0
}

# Create two arrays with the remaining values.
for element in "${REF[@]}"; do
    if is_in_array "${element}" "${TMP[@]}"; then
        for index in "${!TMP[@]}"; do
            if [[ "${TMP[${index}]}" == "${element}" ]]; then
                unset "TMP[${index}]"
                ext_ele_RA "${element}"
                ext_ele_RB "${element}"
                break
            fi
        done
    fi
done

# Multiply all elements of the arrays.
m1=1; for i in "${RA[@]}"; do m1=$((m1*i)); done
m2=1; for i in "${RB[@]}"; do m2=$((m2*i)); done

# Print the aspect ratio.
if [[ "${SWITCH}" == 1 ]]; then
    echo -e "${m2}:${m1}"
else
    echo -e "${m1}:${m2}"
fi

# Exit the script.
exit 0
