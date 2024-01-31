#!/usr/bin/bash
#
# Works on Bash versions 4.x and later.

# Assign the command line argument to the global variable.
FN=$1

# Declare the arrays.
declare -a inarr=()
declare -a outarr=()

# Read the file content in an array.
readarray -t inarr < "${FN}"

# ********************
# Function is_in_array
# ********************
is_in_array () {
    # Assign the funktion argument to the local variable.
    local search_string=$1
    # Initialise the return value to false.
    local return_value=1
    # Remove the first argument from the list of arguments $@.
    shift
    # Loop over the list of arguments.
    for element in "$@"; do
        # Check if search string is found.
        if [[ "${search_string}" = "${element}" ]]; then
            # Set the return value to true.
            return_value=0
        fi
    done
    # Return the return variable.
    return "${return_value}"
}

for line in "${inarr[@]}"; do
    if ! is_in_array "${line}" "${outarr[@]}"; then
        outarr+=("${line}")
    fi
done

for line in "${outarr[@]}"; do
    echo "${line}"
done




