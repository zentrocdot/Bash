#!/usr/bin/python3
'''Calculate prime numbers'''
# pylint: disable=useless-return
#
# Calculate prime numbers
# GPU version
# Version 0.0.0.1
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# https://github.com/zentrocdot/zentrocdot/blob/main/LICENSE
#
# Description:
# The script is calculating prime numbers using a sieve. Step by step
# a given set of numbers will be reduced by applying the sieve.

# Import the standard Python module.
import sys

# From third party module numba import jit.
from numba import jit

# Assign the command line argument to the global variable.
cmd_arg=int(sys.argv[1])

# ########################
# Function prime_numbers()
# ########################
@jit(nopython=True)
def prime_numbers(num):
    '''Calculate the prime numbers using a sieve.'''
    # Initialise the prime numbers array.
    primes_arr = []
    # Initialise the prime sieve.
    prime_sieve = set(range(2, num+1, 1))
    # Loop until the sieve is empty.
    while prime_sieve:
        # The minimum number is the prime number.
        prime_number = min(prime_sieve)
        # Create a set with the multiples of the prime number.
        multiples = set(range(prime_number, num+1, prime_number))
        # Remove the multiples from the prime sieve.
        prime_sieve -= multiples
        # Append the prime number to the prime numbers array.
        primes_arr.append(prime_number)
    # Return prime numbers array.
    return primes_arr

# ++++++++++++++++++++
# Main script function
# ++++++++++++++++++++
def main(num):
    '''Main script function'''
    # Initialise the primes array.
    primes = []
    # Calculate the prime numbers.
    primes = prime_numbers(num)
    # Print the prime numbers.
    for i in primes:
        print(i, end=" ")
    # Print an empty line.
    print()
    # return None.
    return None

# Execute script as program or as module.
if __name__ == '__main__':
    # Call the main script function.
    main(cmd_arg)
    # Exit the script.
    sys.exit()
