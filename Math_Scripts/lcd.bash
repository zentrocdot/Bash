#!/usr/bin/bash
#
# Lowest common divisor
# Version 0.0.0.1

a=${1:-0}
b=${2:-0}

lcd () {
    # Assign the function arguments to the local variables.
    local a=$1
    local b=$2
    # Initialise the local variable l.
    local z=1
    # Check if a or b are 0.
    if [[ "$((a*b))" -le 0 ]]; then
        # Lcd cannot be found.
        z=0
    else
        # Loop from 2 to the value of the smaller number.
        y=$((b<a?b:a))
        for ((i=2; i<=y; i++)); do
            if [[ "$((a%i))" -eq 0 ]] && [[ "$((b%i))" -eq 0 ]]; then
                # Lcd is i.
                z="${i}"
                break
            fi
        done
    fi
    # Output the lcd.
    echo "${z}"
    # Return 0.
    return 0
}

echo $(lcd "$a" "$b")
