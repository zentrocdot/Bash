#!/usr/bin/bash
#
# Reset Terminal Window
#
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
#
# The script is published under the MIT license.
# The usage of this script is at your own risk.
#
# Description:
# Using the so-called ANSI escape sequences is much faster than using the well
# known command reset.
#
# See also:
#   en.wikipedia.org/wiki/ANSI_escape_code

# ******************************
# Function reset terminal window
# ******************************
reset_term () {
    # Reset the terminal window.
    #printf "\x1bc"
    #printf "\033c"
    printf "\ec"
}

# Call the function.
reset_term
