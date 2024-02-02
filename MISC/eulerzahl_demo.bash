#!/bin/bash
# shellcheck disable=SC2001
# shellcheck disable=SC2086
# shellcheck disable=SC2015

# ##############################################################################
#  Euler's number demo
#  Version 0.0.2
#  Copyright © 2018, Dr. Peter Netz
#
# Remark:
#
#    The spigot algorithm is called Zapfhahnalgorithmus and Tröpfelalgorithmus
#    in German.
#
# Known problems:
#
#     1. In the case of Euler's number, printf does not print more than 18
#        decimal places correctly (e.g. printf "%.18f\n" "${float}").
#     2. The command echo makes a line wrap of Euler's number at column 70
#        (e.g. echo -n "${euler}").
# ##############################################################################

# Set the locale.
LANG=en_US.utf8

# Set Euler's number with 64 and 128 decimal places.
# EULER64="2.7182818284590452353602874713526624977572470936999595749669676277"
EULER128="2.718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427427466391932003059921817413"

# ==============================================================================
# Function factorial()
#
# DESCRIPTION:
#     The factorial is a function in mathematics that assigns the product of
#     all natural numbers (without zero) smaller and equal to this number to
#     a new natural number. It is abbreviated by an exclamation mark ("!")
#     after the argument.
#
# INPUT:  $1          ->  Number from which the factorial should be calculated
# OUTPUT: $factorial  ->  Factorial of the given number $1
# RETURN: 0           ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function factorial() {
    # Declare the local variables.
    local counter factorial
    # Assign the function parameter to the local variable.
    counter=$1
    # Calculate the factorial.
    factorial=$(bc <<< "f=1;for(i=1;i<=${counter};i++){f=f*i;};print f")
    # Output the value of the factorial.
    echo -n "${factorial}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function numloops()
#
# FUNCTION CALL: factorial
#
# INPUT:  $1    ->  Number of decimal places
# OUTPUT: $nls  ->  Number of loops
# RETURN: 0     ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function numloops() {
    # Declare the local variables.
    local n nls len factorial
    # Assign the function parameter to the local variable.
    n=$1
    # Initialise the local variables.
    nls=0; len=0
    # Loop until the length is found.
    while [ "${len}" -lt "${n}" ]; do
        # Get the factorial for the given nls.
        factorial=$(factorial "${nls}")
        # Determine the length of the factorial.
        len=${#factorial}
        # Increment the value of nls.
        ((nls++))
    done
    # Subtract 1 from the value of nls.
    nls=$((nls-1))
    # Output the number of places.
    echo -n "${nls}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function euler_number_spigot()
#
# FUNCTION CALL: numloops
#
# GLOBAL: $N      ->  Number of decimal places
# INPUT:  none    ->  No input via function parameter
# OUTPUT: $euler  ->  Euler's number
# RETURN: 0       ->  No error
#
# e = 2 + ½*(1 + ⅓*(1 + ¼*(1 + ...)))
#
# https://de.wikipedia.org/wiki/Tr%C3%B6pfelalgorithmus
#
# Last modified: 2018/08/02
# ==============================================================================
function euler_number_spigot() {
    # Declare the local variables.
    local i product places euler scale
    # Initialise the local variable.
    product=0
    # Set scale for bc.
    scale=$((N+2))
    # Determine the number of necessary loops. Add 2 places for paranoia reasons.
    places=$(($(numloops "$N")+2))
    # Calculate the Euler's number.
    euler=$(bc <<< "scale=${scale};dp=${places}
                    p=0;for(i=dp;i>=1;i--){b=1+p;f=1/i;p=f*b};p+1")
    # Get Euler's number with the needed precision.
    euler=${euler:0:$((N+3))}
    # Output Euler's number.
    echo -n "${euler}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function euler_number_serexp()
#
# FUNCTION CALL: factorial
#
# GLOBAL: $N      ->  Number of decimal places
# INPUT:  none    ->  No input via function parameter
# OUTPUT: $euler  ->  Euler's number
# RETURN: 0       ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function euler_number_serexp() {
    # Declare the local variables.
    local i places scale factorial fraction sum euler oe64 ne64
    # Initialise the local variables.
    sum=0
    oe64=0
    prec=$((N+2))
    # Set the variables.
    places=$((N*2))
    scale=$((N*2))
    # Loop over the number of places.
    for ((i=0;i<="${places}";i++)); do
        # Calculate the factorial.
        factorial=$(factorial "${i}")
        # Calculate the sum.
        sum=$(bc <<< "scale=${scale};f=1.0/${factorial};${sum}+f")
        # Observe the needed precision of Euler's number.
        ne64=${sum:0:${prec}}
        [[ "${oe64}" != "${ne64}" ]] && oe64="${ne64}" || break
    done
    # Extract the euler number.
    euler=${sum:0:$((N+3))}
    # Output the euler number.
    echo -n "${euler}"
    # Return the exit status 0.
    return 0
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Body of script starts here.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Clear the screen.
clear

# Read number of places.
echo -n "Number of decimal places: "
read -r N

# Print an empty line.
printf "\n"

# Select the algorithm.
printf "%s\n%s\n" "Select the method:" "=================="
select _ in "Series expansion" "Spigot algorithm"; do
    case $REPLY in
        1) EULER=$(euler_number_serexp); break;;
        2) EULER=$(euler_number_spigot); break;;
        *) exit;;
    esac
done

# Print an empty line.
printf "\n"

# For paranoia reasons remove the last decimal place. Remove also an existing
# control sequence from the given string.
EULER_MOD=$(echo -e ${EULER} | sed 's/.$//; s/\\ //g')

# Print Euler's number with the needed decimal places.
echo "Calculation (echo):   ${EULER_MOD}"
printf "Calculation (printf): %s\n" "${EULER_MOD}"

# Print Euler's number with 128 decimal places as reference value.
echo "Reference (echo):     ${EULER128}"
printf "Reference (printf):   %s\n" "${EULER128}"

# Print the elapsed time into the terminal window.
echo -e "\nElapsed time: $SECONDS seconds"

# Exit the script.
exit 0
