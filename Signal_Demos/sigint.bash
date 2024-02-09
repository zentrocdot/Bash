#!/usr/bin/bash
#
# SIGINT trap signal demo

# ==============================================================================
# Function trap_sigint
# Function called by trap
# ==============================================================================
function trap_sigint () {
    printf "\r%s\n" "SIGINT caught"
    printf "\r%s\n" "You pressed CTRL+C"
    exit 1
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Trap signal SIGINT
# Register signal handler
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
trap 'trap_sigint' SIGINT

# Run an infinite loop.
sed ':x;bx' < <(echo "")

# Exit script.
exit 0
