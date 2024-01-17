#!/bin/bash

# ##############################################################################
# bell_speaker-test.bash
# Version 0.0.1
# Copyright © 2018, Dr. Peter Netz
#
# DESCRIPTION: The script plays a sound which is similar to the well known beep
#              (bell) of the computer speaker. This is done with the help of the
#              package alsa-utils. The programme speaker-test which is used to
#              do this is part of the package alsa-utils.
#
# REMARKS: If the package sox is installed can be checked with:
#          dpkg -S alsa-utils | grep -w "alsa-utils:"
#          Where the programme play is located can be checked with:
#          which speaker-test
#
# REFERENCE:
#     https://rosettacode.org/wiki/Terminal_control/Ringing_the_terminal_bell
# ##############################################################################

# Set the global script variables.
__SCRIPT_NAME="$0"
__SCRIPT_VERSION="0.0.1"
__COPYRIGHT_NOTICE="Copyright © 2018, Dr. Peter Netz"

# Set the duration in seconds.
DURATION="0.5"

# Set the frequency in hertz.
FREQUENCY="2600"

# ==============================================================================
# FUNCTION
# NAME: chk_pkg()
# DESCRIPTION: The function is checking if a software package is installed.
# SCRIPT CALL: chk_pkg "${PACKAGE}" "${OPTION}"
# ==============================================================================
function chk_pkg()
{
    # Declare the local variables.
    local cmd opt status
    # Assign the function parameters to the local variables.
    cmd=$1; opt=$2
    # Execute the given command with the given option.
    # Redirect stdout (1) und stderr (2) to /dev/null.
    "${cmd}" "${opt}" 2>/dev/null 1>&2
    # Store the exit status.
    status=$?
    # Evaluate the exit status.
    if [ "${status}" != "0" ]; then
        # Print a formatted message into the terminal window.
        printf "%s\n" "The package '${cmd}' is not installed. Bye!"
        # Exit the script with the exit status 1.
        exit 1
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# FUNCTION
# NAME: user_beep()
# DESCRIPTION: The function plays the user defined beep.
# SCRIPT CALL: user_beep "${DURATION}" "${FREQUENCY}"
# ==============================================================================
function user_beep()
{
    # Declare the local variables.
    local dur frq
    # Assign the function parameters to the local variables.
    dur=$1; frq=$2
    # Play the sound. Silent output of command.
    nohup speaker-test -t sine -f "${frq}" 2>/dev/null 1>&2 &
    pid=$!
    disown $pid
    sleep "${dur}s"
    kill -9 $pid 2>/dev/null 1>&2
    # Return the exit code 0.
    return 0
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Main body of script starts here.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Check if the package sox is installed.
chk_pkg "speaker-test" "--help"

# Play the user defined beep.
user_beep "${DURATION}" "${FREQUENCY}"

# Exit the script with exit status 0.
exit 0
