#!/usr/bin/bash
#
# Print unique line of file
# Version 0.0.0.1

# Assign the command line argument to the global variable.
FN=$1

# Declare the arrays.
declare -a inarr=()
declare -a outarr=()

# Read the file content into an array.
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

# Create an array with unique lines.
for line in "${inarr[@]}"; do
    # Check if a line is in the array.
    if ! is_in_array "${line}" "${outarr[@]}"; then
        # Append an match to the array.
        outarr+=("${line}")
    fi
done

# Print the result to the terminal window.
for line in "${outarr[@]}"; do
    echo "${line}"
done

# Exit script.
exit 0



