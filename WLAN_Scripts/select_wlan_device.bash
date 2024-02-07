#!/usr/bin/bash
#
# Get Wlan Interface Name
# Version 0.0.0.1
# Copyright © 2016-2024, Dr. Peter Netz
# Published under the MIT license available here:
# https://github.com/zentrocdot/zentrocdot/blob/main/LICENSE

# Initialise the global variable.
IFACE=""

# ==============================================================================
# Function trap_sigint()
# Function called by trap
# ==============================================================================
function trap_sigint() {
    ch=" "
    str=$(printf '%*s' 67 | tr ' ' "$ch")
    printf "\r%s%s" "SIGINT caught" "${str}"
    printf "\r%s\n" "You pressed CTRL+C"
    exit 130
}

# ==============================================================================
# Function wrong_selection()
# ==============================================================================
function wrong_selection() {
    # Write message into the terminal window.
    printf "\n%s\n" "${str3}"
    # Sleep a little bit.
    sleep 0.5
    # Reset screen.
    reset
    # Get Interface.
    get_iface
    # Return exit code.
    return 0
}

# ==============================================================================
# Function get_iface()
# ==============================================================================
function get_iface() {
    # Declare the local array.
    declare -A array
    # Define the local variables.
    local ifaces=""
    #local number=""
    local count=0
    # Set the local strings.
    local str0="Available WLAN Devices:"
    local str1="======================="
    local str2="Make your selection followed by ENTER:"
    local str3="Wrong selection!"
    # Get the name of the interfaces.
    ifaces=$(iw dev | awk '$1=="Interface"{print $2}')
    # Print a headline into the terminal window.
    printf "%s\n%s\n\n" "${str0}" "${str1}"
    # List interfaces in the terminal window.
    while IFS="" read -r iface
    do
        if [ "$(ifconfig | grep "${iface}")" != "" ]; then
            if [ ! -z $(iwconfig 2>/dev/null "${iface}" | grep -o "Mode:Managed") ]; then
                # Increment the counter.
                ((count=count+1))
                # Add a pair of data to the array.
                array+=(["${count}"]="${iface}")
                # Write the pair into the terminal window.
                printf "%s  =  %s\n" "${count}" "${iface}"
            fi
        fi
    done < <(echo "${ifaces}")
    # Check the counter.
    if [ "${count}" -eq "0" ]; then
        # Print message into the terminal window.
        printf "No WLAN devices found. Bye!\n"
        # Exit script.
        exit 0
    fi
    # Read the selection.
    printf "\n%s " "${str2}"
    read -r selection
    if [ -z "${selection//[0-9]/}" ]; then
        if [ "${selection}" -gt "${count}" ] || \
           [ "${selection}" -lt "1" ]; then
            wrong_selection
        fi
    else
        wrong_selection
    fi
    # Set the wlan interface.
    IFACE="${array[${selection}]}"
    # Return exit code.
    return 0
}

# +++++++++++++++++++
# Main script section
# +++++++++++++++++++

# Trap SIGINT
trap 'trap_sigint' SIGINT

# Reset screen.
reset

# Call function.
get_iface

# Print selected device.
printf "\n%s %s\n" "Your selection:" "${IFACE}"


# Exit script.
exit 0
