#!/usr/bin/bash
#
# Calculate the aspect ratio of an image.
# Version 0.0.0.3
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# github.com/zentrocdot/Bash_Programming/tree/main?tab=MIT-1-ov-file#readme
#
# Description:
# An array with the prime numbers of x-resolution as well as y-resolution
# is created. These two arrays then untouched in the whole script. Two
# arrays are created in which we store the original found prime numbers.
# We loop over the array with the fewest elements. Now we look if an
# element is in the other array. If it is in it we delete the element from
# both arrays with the remaining prime numbers.
#
# The script was written for learning purposes. The main goal was to learn
# how to work with arrays.
#
# See also:
# de.wikipedia.org/wiki/Bildauflösungen_in_der_Digitalfotografie
# stackoverflow.com/questions/40941671/how-to-return-associative-arrays-from-function-in-shell
# unix.stackexchange.com/questions/619514/what-is-the-purpose-of-return-0-and-return-1-and-when-to-use
# codefather.tech/blog/bash-functions/

# Example aspect ratios:
# Canon EOS 550D:
#XRES=5184
#YRES=3456
# Pentacon Praktica DCZ 6.3:
#XRES=2848
#YRES=2136
# Pentacon Praktica DCZ 12.1:
XRES=3264
YRES=2448

# Get command line arguments.
XRES=${1:-$XRES}
YRES=${2:-$YRES}

# ####################
# Function is_in_array
# ####################
is_in_array () {
    # Assign the function argument to the local variable.
    local search_string="$1"
    # Remove the first argument from the list of arguments $@.
    shift
    # Assign the remaining function arguments to the local variable.
    local args_list=("$@")
    # Initialise the return value to false.
    local return_value=1
    # Declare the local loop variable.
    local element
    # Loop over the list of arguments.
    for element in "${args_list[@]}"
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

# #######################
# Function delete_element
# #######################
delete_element () {
    # Assign the function argument to the local variable.
    local element="$1"
    # Shift to the next function argument.
    shift
    # Create a local array from the remaining arguments.
    local arr=("$@")
    # Declare the local index counter.
    local idx
    # Loop over the array.
    for idx in "${!arr[@]}"; do
        # If element is found remove the element from array.
        if [[ "${arr[${idx}]}" == "${element}" ]]; then
            # Remove the element from the array.
            unset "arr[${idx}]"
            # Leave the loop.
            break
        fi
    done
    # Return the modified array.
    echo "${arr[@]}"
    # Return 0.
    return 0
}

# ####################
# Main script function
# ####################

# Determine the primes of the x- and y-resolution.
# shellcheck disable=SC2312
PX=$(factor "${XRES}" | sed 's/^.*: \(.*\)/\1/')
# shellcheck disable=SC2312
PY=$(factor "${YRES}" | sed 's/^.*: \(.*\)/\1/')

# Make an array from the prime numbers.
# shellcheck disable=SC2206,SC2250
# Do not put expression in brackets in quotes!
PA=(${PX})
# shellcheck disable=SC2206,SC2250
# Do not put expression in brackets in quotes!
PB=(${PY})

# Get the length of the arrays.
LEN1=${#PA[@]}
LEN2=${#PB[@]}

# Initialise the arrays for element search.
REF=()
TMP=()

# Initialise the arrays for the remaining elements.
RA=()
RB=()

# Calculate the difference of the array length.
DIFF=$((LEN1-LEN2))

# Initialise the arrays.

# Set the switch variable.
declare SWITCH

# Switch arrays depending on there length.
if [[ "${DIFF}" -lt 0 ]]; then
    # Create the temporay arrays.
    REF=("${PA[@]}")
    TMP=("${PB[@]}")
    # Create the required arrays.
    RA=("${PA[@]}")
    RB=("${PB[@]}")
    # Set value of SWITCH.
    SWITCH=0
else
    # Create the temporay arrays.
    REF=("${PB[@]}")
    TMP=("${PA[@]}")
    # Create the required arrays.
    RA=("${PB[@]}")
    RB=("${PA[@]}")
    # Set value of SWITCH.
    SWITCH=1
fi

# Create two arrays with the remaining values.
for element in "${REF[@]}"; do
    if is_in_array "${element}" "${TMP[@]}"; then
        for index in "${!TMP[@]}"; do
            if [[ "${TMP[${index}]}" == "${element}" ]]; then
                # Remove element from array.
                unset "TMP[${index}]"
                # shellcheck disable=SC2155,SC2178,SC2207
                # This is the trick to get a modified array!
                declare RA=($(delete_element "${element}" "${RA[@]}"))
                # shellcheck disable=SC2155,SC2178,SC2207
                # This is the trick to get a modified array!
                declare RB=($(delete_element "${element}" "${RB[@]}"))
                # Now, leave the loop.
                break
            fi
        done
    fi
done

# Multiply all elements of the arrays.
m1=1; for i in "${RA[@]}"; do m1=$((m1*i)); done
m2=1; for i in "${RB[@]}"; do m2=$((m2*i)); done

# Print the aspect ratio. Switch back to right order.
if [[ "${SWITCH}" == 1 ]]; then
    echo -e "${m2}:${m1}"
else
    echo -e "${m1}:${m2}"
fi

# Exit the script.
exit 0
