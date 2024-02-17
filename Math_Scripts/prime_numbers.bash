#!/usr/bin/bash
#
# Prime number calculation
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# github.com/zentrocdot/Bash_Programming/tree/main?tab=MIT-1-ov-file#readme
#
# Description:
# The prime numbers are calculated using a algorithm based on the Sieve of
# Eratosthenes.
#
# The Sieve of Eratosthenes is a simple systematic procedure for finding prime
# numbers. First all of the natural numbers (1, 2, 3, ...) up to a given value
# are arranged in numerical order. The number 1 is striked out, because 1 is
# not a prime number. Then every second number following on number 2 is striked
# out, then every third number following the number 3 is striked out and so on.
# This is continued in the same manner for all of the other numbers. Every nth
# number following the number n is striked out. The remaining numbers are the
# prime number.
#
# See also:
# de.wikipedia.org/wiki/Primzahl
# en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# www.britannica.com/science/sieve-of-Eratosthenes
# www.baeldung.com/cs/prime-number-algorithms
# praxistipps.chip.de/warum-ist-1-keine-primzahl-zu-peinlich-zu-fragen_93329

# Set the maximum number for which the prime numbers should be calculated.
NUM=${1:-100}

# Calculate the square root using bc.
SQRT=$(bc <<< "scale=0; sqrt(${NUM})")

# Declare an associative array.
declare -A ARR

# Set the values of the associative array to true.
for ((i=2; i<="${NUM}"; i++)) do ARR["${i}"]=true; done

# Determine the prime numbers.
for ((i=2; i<="${SQRT}"; i++)) do
    # If associative array value is true do something.
    if [[ "${ARR[${i}]}" == true ]]; then
        # Set j to the square of i.
        j=$((i*i))
        # Run a loop until MAX_NUM is reached.
        while [[ "${j}" -le "${NUM}" ]]
        do
            # If j is not a prime number set the value to key j to false.
            ARR["${j}"]=false
            # Increment j by i.
            j=$((j+i))
        done
    fi
done

# Print the prime numbers.
for ((i=2; i<="${NUM}"; i++)) do
    if [[ "${ARR["${i}"]}" == true ]]; then printf "%s " "${i}"; fi
done

# Print an empty line.
printf "%b" "\n"

# Exit script.
exit 0
