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
# The intention to write this script is to save primes using the sieve in one
# array and the composite numbers in another array. The length von both array
# must result in the number which is given.
#
# To-Do:
# Check if the algorithm is working as expected under all possible conditions.
#
# See also:
# de.wikipedia.org/wiki/Primzahl
# en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# www.britannica.com/science/sieve-of-Eratosthenes
# www.baeldung.com/cs/prime-number-algorithms
# praxistipps.chip.de/warum-ist-1-keine-primzahl-zu-peinlich-zu-fragen_93329
#
# shellcheck disable=SC2250

# Set the maximum number for which the prime numbers should be calculated.
NUM=${1:-100}

# Declare the indexed arrays.
declare -a CARR=(1)
declare -a PARR=()

# Determine the prime numbers.
for ((i=2; i<="${NUM}"; i++))
do
    rgx=" ${i} "
    # shellcheck disable=SC2076
    if [[ ! " ${CARR[*]} " =~ "${rgx}" ]] && [[ ! " ${PARR[*]} " =~ "${rgx}" ]]; then
        PARR+=("${i}")
    fi
    # shellcheck disable=SC2076
    if [[ ! "${PARR[*]}" =~ "${rgx}" ]]; then
        j=$((i*i))
        while [[ "${j}" -le "${NUM}" ]]
        do
            # shellcheck disable=SC2076
            rgy=" ${j} "
            if [[ ! " ${CARR[*]} " =~ "${rgy}" ]]; then
                CARR+=("${j}")
            fi
            j=$((j+i))
        done
    fi
done

# Print prime numbers.
#echo -e "Prime numbers:\n"
for i in "${PARR[@]}"; do printf "%s " "${i}"; done

# Print an empty line.
printf "%b" "\n"

# Print composite numbers.
#echo -e "No prime numbers:\n"

# shellcheck disable=SC2207
#sorted=($(printf '%s\n' "${CARR[@]}" | sort -n))
#echo "${sorted[*]}"

# Print an empty line.
#printf "%b" "\n"

# Print length of arrays.
#a=${#PARR[@]}
#b=${#CARR[@]}
#echo -e "$NUM $((a))\n"
#echo -e "$NUM $((b))\n"
#echo -e "$NUM $((a+b))\n"

# Exit script.
exit 0
