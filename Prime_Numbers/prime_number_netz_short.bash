#!/usr/bin/bash
#
# Prime number calculation
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# github.com/zentrocdot/Bash_Programming/tree/main?tab=MIT-1-ov-file#readme

# Set the maximum number for which the prime numbers should be calculated.
NUM=${1:-100}

#SQRT=$(bc <<< "scale=0; sqrt(${NUM})")

# Declare the prime number and composite number arrays.
declare -a cn=(1 4 6 8 9)
declare -a pn=(2 3 5 7)

# Initialise the variable is_prime.
is_prime=0

# Run a loop from 10 to the value of NUM.
for ((i=10; i<="${NUM}"; i++)); do
    # Set the value of is_prime to 1.
    is_prime=1
    # Loop over the primes found so far.
    for j in "${pn[@]}"; do
        # The divisor j cannot be greater than half of the size of i.
        if [[ "${j}" -le "$((i/2))" ]]; then
            # Check if the result of the calculation has a remainder.
            if [[ "$((i%j))" -eq 0 ]]; then
                # Set the value of is_prime to 0.
                is_prime=0
                # Leave the loop.
                break
            fi
        fi
    done
    # Write the number to the related array.
    if [[ "${is_prime}" -eq 1 ]]; then pn+=("${i}"); else cn+=("${i}"); fi
done

# Print the length of the array.
len_pn=${#pn[@]}
printf "%s%s%b" "Prime numbers: " "${len_pn}" "\n"

# Print the prime numbers.
printf "%s%b" "List of primes:" "\n"
for i in "${pn[@]}"; do
    printf "%s " "$i"
done

# Print the length of the array.
len_cn=${#cn[@]}
printf "%b%s%s%b" "\n" "Composite numbers: " "${len_cn}" "\n"

# Print the composite numbers.
printf "%s%b" "List of composites:" "\n"
for i in "${cn[@]}"; do
    printf "%s " "$i"
done

# Plausibility check if number of primes plus number of composites are the value of NUM.
if [[ "${NUM}" -ne "$((len_pn+len_cn))" ]]; then
    printf "%b%s%b" "\n" "Unknown error occured!" "\n"
fi

# Print a farewell message.
printf "%b%s%b" "\n" "Have a nice day. Bye!" "\n"

# Exit script.
exit 0
