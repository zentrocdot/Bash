#!/usr/bin/bash
#
# Clear Terminal Window
#
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
#
# The script is published under the MIT license.
# The usage of this script is at your own risk.
#
# Description:
# Using the so-called ANSI escape sequences is much faster than using the well
# known command clear.
#
# See also:
#   en.wikipedia.org/wiki/ANSI_escape_code

#printf "\033c"

# ******************************
# Function clear terminal window
# ******************************
clear_term () {
    # Clear the terminal window.
    #printf "\x1b[1;1H\x1b[2J"
    #printf "\033[1;1H\033[2J"
    printf "\e[1;1H\e[2J"
}

# Call the function.
clear_term
