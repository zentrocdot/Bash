#!/usr/bin/bash
#
# Update & Upgrade System
# Version 0.0.0.2
#
# This script is intendet to work on a System with Debian, Ubuntu or Mint.
#
# Check out:
# id -u
#
# Fix broken packages:
# sudo apt-get update --fix-missing
# sudo apt-get install -f
# sudo dpkg --configure -a
#
# See also:
# stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# phoenixnap.com/kb/ubuntu-fix-broken-packages

# Check if the script is started as root.
if [ "$EUID" -ne 0 ]; then
    echo "Please run script as root!"
    exit 1
fi

# Get the name of this script.
SCRIPTNAME=$(basename "$0")

# Function make script executable.
make_executable () {
    # Assign the function argument to a local variable.
    scriptname=$1
    # Make the script executable.
    if [ -x "${scriptname}" ]; then
        echo -e "Script is executable!"
    else
        echo -e "Script is NOT executable yet!"
        chmod u+x "${scriptname}"
    fi
    # Return the error code 0.
    return 0
}

# Function print header.
header () {
    # Print the header to the screen.
    echo -e "\e[44m***********************\e[49m"
    echo -e "\e[44mSystem Update & Upgrade\e[49m"
    echo -e "\e[44m***********************\e[49m\n"
    # Return the error code 0.
    return 0
}

# ********************
# Main script function
# ********************
main_script_function () {
    # Update & upgrade the system.
    echo -e "\nRun update ...\n"
    apt-get update
    echo -e "\nRun upgrade ...\n"
    apt-get upgrade
    echo -e "\nRun dist-upgrade ...\n"
    apt-get dist-upgrade
    echo -e "\nRun clean ..."
    apt-get clean
    echo -e "\nRun autoclean ...\n"
    apt-get autoclean
    echo -e "\nRun autoremove ...\n"
    apt-get autoremove
    # Return the error code 0.
    return 0
}

# Clear screen.
clear

# Call function header.
header

# Make this script executable.
make_executable "${SCRIPTNAME}"

# Call the main script function.
main_script_function

# Print a farewell message.
echo -e "\nHave a nice day. Bye!"

# Exit script without error.
exit 0
