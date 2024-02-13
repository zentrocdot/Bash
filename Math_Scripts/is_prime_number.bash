#!/usr/bin/bash
#
# Is prime number
# Version 0.0.0.2
#
# Description:
# Application of a simple approach to check if a given number is a prime
# number or not.
#
# To-Do:
# Final check if the script is working as expected and without any errors.
# After that writing a more sophisticated script for the check.
#
# See also:
# www.gnu.org/software/bash/manual/bash.html
# www.baeldung.com/linux/bash-prime-number-test
# www.wikihow.com/Check-if-a-Number-Is-Prime
# www.rookieslab.com/posts/fastest-way-to-check-if-a-number-is-prime-or-not
# stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash

# Assign the command line argument to the global variable.
NUM=$1

# ########################
# Function is prime number
# ########################
is_prime_number () {
    # Declare the local variables.
    local num
    local is_prime
    # Assign the function argument to the local variable.
    num=$1
    # Initialise the variable is_prime.
    is_prime=0
    # Check if a valid number is given.
    # shellcheck disable=SC2292
    [ -n "${num}" ] && [ "${num}" -eq "${num}" ] 2>/dev/null
    # shellcheck disable=SC2181
    if [[ $? -ne 0 ]] || [[ "${num}" -lt 1 ]]; then
        echo -n "2"
        return 2
    fi
    # Loop over the range of meaningful divisors.
    for((i=2; i<=((num/2)); i++))
    do
        # Calculate the remainder of the division.
        rem=$((num%i))
        # Change the value of is_prime if it is not a prime number.
        if [[ "${rem}" -eq 0 ]]; then
            is_prime=1
            break
        fi
    done
    # Output 0 if it is a prime number otherwise 1.
    echo -n "${is_prime}"
    # Return 0.
    return 0
}

# Check if number is a prime number.
is_prime=$(is_prime_number "${NUM}")

# Return the result of the check.
if [[ "${is_prime}" -eq 0 ]]; then
    echo "${NUM} is a prime number."
elif [[ "${is_prime}" -eq 1 ]]; then
    echo "${NUM} is NOT a prime number."
elif [[ "${is_prime}" -eq 2 ]]; then
    echo "${NUM} is NOT a valid number."
else
    echo "Unknown state of function."
fi

# Exit script.
exit 0
