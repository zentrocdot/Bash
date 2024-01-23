#!/usr/bin/bash

# ******************************************************************************
# (c) 2017-2024, Dr. Peter Netz, Version 0.0.0.2
#
# Description:
#     Channel hopping over the 14 channels, which are in WLAN with 2.4 GHz are
#     allowed.
#
# Exit codes:
#     0 -> No error
#     1 -> Sudo error
#     2 -> Getopt error
#     3 -> Signal handler error
#     4 -> Interface not given error
#     5 -> Interface not exists error
#     6 -> Package error
#
# Shellcheck Reference:
#     www.shellcheck.net
#
# Reference:
#     tldp.org/LDP/abs/html/exitcodes.html
#     www.tldp.org/LDP/abs/html/exitcodes.html
#
# Prerequisites:
#     For full functionality of the script the third party packages lolcat and
#     figlet must be installed. lolcat and figlet are available in Debian for
#     the architectures AMD, I386 and ARM.
#
# Remarks:
#     Check the command of a package with dpkg -S $(which <command>).
#
# Dependencies:
#     Command	Standard Linux package
#     ========  ======================
#     getopt	util-linux
#     ifconfig	net-tools
#     iwconfig	wireless-tool
#     kill	procps
#     rfkill	rfkill
#     which 	debianutils
#
# # To-do:
#     Further test after 6 yeras under Linux Mint 21. Revision and modernisation
#     of the code
#
# Last modified: 2024/01/22
# ******************************************************************************

# Check if the script was started with sudo privileges.
if [ $UID -ne 0 ]; then
    # Write a message into the terminal window.
    echo -e "Please run the script with sudo:"
    echo -e "sudo ${SCRIPT_NAME} ${CMD_PARAMS}"
    # Exit the script with an error.
    exit 1
fi

# Set locale to US english and UTF-8.
# This fixes decimal point problems.
LANG=en_US.UTF-8

# Get the name of the script.
SCRIPT_NAME=$0

# Get the command line parameters.
CMD_PARAMS=$*

# Get child PID.
CHILD_PID=$$

# Get parent PID.
PARENT_PID=$(awk '/PPid:/{print $2}' /proc/${CHILD_PID}/status)

# Execute getopt on the arguments which are passed to the script.
ARGS=$(getopt -n "$0" -o "hodi:" --long "help,output,debug,interface:" -- "$@")
status=$?

# Exit the script when something has gone wrong with the command getopt.
if [ "${status}" -ne 0 ]; then
    # Exit the script with an error.
    exit 2
fi

# A little bit magic, necessary when using the command getopt.
eval set -- "$ARGS"

# Initialise the global variables.
INTERFACE=""
OUTPUT=false
DEBUG=false

# Set some global strings.
STR1="Usage short:"
STR2="$0 -h -o -d -i <interface>"
STR3="or usage long:"
STR4="$0 --help --output --debug --interface <interface>"
NL="\n\r"

# Go through the options, option by option.
while true;
do
    case "$1" in
        "-h"|"--help")
            printf "%s${NL}  %s${NL}%s${NL}  %s${NL}" \
                   "${STR1}" "${STR2}" "${STR3}" "${STR4}";
            shift;;
        "-o"|"--output") OUTPUT=true;
            shift;;
        "-d"|"--debug") DEBUG=true;
            shift;;
        "-i"|"--interface")
            if [ -n "$2" ]; then
                INTERFACE="$2"
            fi
            shift 2;;
        --) shift; break;;
    esac
done

# Workaround for PATH problems (to be checked?!).
# shellcheck disable=SC2002
ENV=$(cat /etc/environment | awk -F '=' '{print $2}' | sed 's/\"//g')
export PATH=$PATH:$ENV

# Define the list with the channels over which the interface should hop.
CHANNEL_LIST=(1 2 3 4 5 6 7 8 9 10 11 12 13 14)

# ==============================================================================
# Function signalhandler()
#
# Function call:
#     trap signalhandler <signal0> <signal1> etc.
#
# Params:    None
# Returns:   None
# Exit code: 3
#
# Last modified: 2017/05/14
# ==============================================================================
function signalhandler() {
    # Set local strings.
    local nl="\n\r"
    local msg="Script trapped a signal! Bye!"
    # Check the flags to be true or false.
    if [[ "${OUTPUT}" == true ]] || [[ "${DEBUG}" == true ]]; then
        # Write a message into the terminal window.
        echo -e "${nl}${msg}"
    fi
    # Exit the script with an error.
    exit 3
}

# ==============================================================================
# Function chk_pkg()
#
# Description:
#     Check if the packages figlet and lolcat are installed.
#
# Params:  None
# Returns: Zero
# Exit code: 6
#
# Last modified: 2017/05/20
# ==============================================================================
function chk_pkg() {
    # Set local error flag to false.
    local error_flag=false
    # Initialise the local command array.
    cmd_arr=("figlet" "lolcat")
    # Loop over the command array.
    for cmd in "${cmd_arr[@]}";
    do
        # Check if cmd is installed.
        if which "${cmd}" >/dev/null 2>&1; then
            # Write a message into the terminal window.
            echo "${cmd} is installed! OK!"
        else
            # Write a message into the terminal window.
            echo "${cmd} is NOT installed!"
            # Set error flag to true.
            error_flag=true
        fi
    done
    # Check the error flag.
    if [[ "${error_flag}" == true ]]; then
        # Write an error message into the terminal window.
        echo -e "Exit on package error. Bye!"
        # Exit script with an error.
        exit 6
    fi
    # Return Zero
    return 0
}

# ==============================================================================
# Function chk_mod()
#
# Description:
#     Check if the script is executable. If the script is not executable, make
#     the script executable.
#
# Params:
#     $1 -> <script-name>
#     $2 -> <flag>
#
# Returns: Zero
#
# Function call:
#     check_chmod
#
# Last modified: 2017/05/20
# ==============================================================================
function chk_mod() {
    # Assign the function parameter to the local variables.
    local script_name=$1
    local flag=$2
    # Check if the script is executable.
    if [ ! -x "${script_name}" ]; then
        # Make the script executable.
        chmod +x "${script_name}"
    else
        # Check the flag to be true or false.
        if [[ "${flag}" == true ]]; then
            # Modify the script name.
            script_name=$(echo "${script_name}" | sed 's/\.\///g')
            # Write a message into the terminal window.
            echo -e "Script call:"
            echo -e "  sudo bash ${script_name} <options>"
            echo -e "  sudo ./${script_name} <options>\n\r"
        fi
    fi
    # Return Zero.
    return 0
}

# ==============================================================================
# Function reset_screen()
#
# Params:  None
# Returns: Zero
#
# Last modified: 2017/05/14
# ==============================================================================
function reset_screen() {
    # Reset the terminal window.
    reset
    # Return zero.
    return 0
}

# ==============================================================================
# Function print_header()
#
# Params:  None
# Returns: Zero
#
# Last modified: 2017/05/17
# ==============================================================================
function print_header() {
    # Declare the local path variable.
    local path_lolcat
    # Set the local string variables.
    local str0="Channel Hopper 24xx"
    local str1="(c) 2017, Dr. Peter Netz, Version 0.0.0.2"
    # Get the path to the command lolcat.
    path_lolcat=$(which "lolcat")
    # Check the output flag to be true or false.
    if [[ "${OUTPUT}" == true ]]; then
        # Write header into the terminal window.
        figlet "${str0}" -w 120 | ${path_lolcat}
        printf "%s\n\r" "${str1}" | ${path_lolcat}
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function kill_prev_inst()
#
# Params:  None
# Returns: Zero
#
# Last modified: 2024/01/22
# ==============================================================================
function kill_prev_inst() {
    # Declare local variables.
    local pattern=""
    local pids=""
    local ipids=""
    local kpids=""
    # Set local string.
    local nl="\n\r"
    # Check the debug flag to be true or false.
    if [[ "${DEBUG}" == true ]]; then
        # Write PIDs into the terminal window.
        echo -e "Parent PID: ${PARENT_PID}"
        echo -e "Child PID:  ${CHILD_PID}${nl}"
    fi
    # shellcheck disable=SC2001
    pattern=$(echo "${SCRIPT_NAME}" | sed 's/\.\///g')
    # shellcheck disable=SC2009
    pids=$(ps aux | grep "${pattern}" | grep -v "colour")
    echo -e "\n${pids}"
    ipids=$(echo "${pids}" | grep "${INTERFACE}")
    echo -e "\n${ipids}"
    # Check on the correct interface.
    if [[ "${ipids}" != "" ]]; then
        # shellcheck disable=SC2009
        kpids=$(echo "${ipids}" | awk -F ' ' '{print $2}')
        kpids=$(echo "${kpids}" | \
                    grep -v "${PARENT_PID}" | grep -v "${CHILD_PID}")
        echo -e "\n${kpids}"
        # shellcheck disable=SC2086
        #kill -9 ${kpids} >/dev/null 2>&1
        kill -9 ${kpids}
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function chk_params()
#
# Params:    None
# Returns:   0
# Exit code: 4
#
# Last modified: 2017/05/20
# ==============================================================================
function chk_params() {
    # Check if interface is given as command line parameter.
    if [[ "${INTERFACE}" == "" ]]; then
        # Check the debug flag to be true or false.
        if [[ "${DEBUG}" == true ]]; then
            # Write an error message into the terminal window.
            echo -e "Interface is NOT given! Bye!"
        fi
        # Exit the script with an error.
        exit 4
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function chk_iface()
#
# Params:    None
# Returns:   0
# Exit code: 5
#
# Last modified: 2017/05/20
# ==============================================================================
function chk_iface() {
    # Redirect stdout and stderr of iwconfig to /dev/null.
    iwconfig "${INTERFACE}" >/dev/null 2>&1
    status=$?
    # Check if the interface exists.
    if [ "${status}" -ne 0 ]; then
        # Check the debug flag to be true or false.
        if [[ "${DEBUG}" == true ]]; then
            # Write an error message into the terminal window.
            echo -e "Interface is NOT existing! Bye!"
        fi
        # Exit the script with an error.
        exit 5
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function set_monmod()
#
# Params:
#     $1 -> <interface>
#
# Returns: 0
#
# Last modified: 2017/05/18
# ==============================================================================
function set_monmod() {
    # Assign the function parameter to a local variable.
    interface=$1
    # Turn the interface as background process down.
    ifconfig "${INTERFACE}" down &
    pid=$!
    wait $pid
    # Set the interface as background process to monitor mode.
    iwconfig "${INTERFACE}" mode monitor &
    pid=$!
    wait $pid
    # Turn the interface as background process up.
    ifconfig "${INTERFACE}" up &
    pid=$!
    wait $pid
    # Return zero.
    return 0
}

# ==============================================================================
# Function check_rfkill()
#
# Params:  None
# Returns: 0
#
# Last modified: 2024/01/22
# ==============================================================================
function chk_rfkill() {
    echo "OK"
    # Check if wlan devices are blocked.
    #if rfkill list wlan | grep yes; then
    if rfkill list wifi | grep yes; then
        # Unblock all wlan devices.
        #rfkill unblock wlan
        rfkill unblock wifi
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function errorhandler()
# ==============================================================================
function errorhandler() {
    # Check rfkill.
    chk_rfkill
    # Set monitor mode.
    set_monmod
    # Return zero.
    return 0
}

# ==============================================================================
# Function chk_monmod()
#
# Params:  None
# Returns: 0
#
# Last modified: 2017/05/18
# ==============================================================================
function chk_monmod() {
    # Initialise local variables.
    local pattern0='IEEE'
    local pattern1='Mode:Monitor'
    local isMonMod=""
    # Get interface status from iwconfig.
    isMonMod=$(iwconfig "${INTERFACE}" \
               | grep "${pattern0}" | xargs | grep -o "${pattern1}")
    # Check if the interface is in monitor moden.
    if [[ "${isMonMod}" == "" ]]; then
        # Check the debug flag to be true or false.
        if [[ "${DEBUG}" == true ]]; then
            # Write an error message into the terminal window.
            echo -e "Interface monitor mode error!"
            # Unblock device.
            chk_rfkill
            # Turn monitor mode on.
            set_monmod
        fi
    fi
    # Return zero.
    return 0
}

# ==============================================================================
# Function main_loop()
#
# Params:  None
# Returns: 0
#
# Last modified: 2017/05/14
# ==============================================================================
function main_loop() {
    # Set local variables.
    local cr="\r"
    local chn_str="Current channel:"
    local dif_str="Time intervall:"
    local pid=""
    local status=""
    local count=0
    local no=""
    # Set global variable SECONDS to zero.
    SECONDS=0
    # Run an infinite loop.
    while true;
    do
        # Loop over the elements of the channel list.
        for chn in "${CHANNEL_LIST[@]}";
        do
            status_str="OK"
            # Set a new channel on the interface as background process.
            iwconfig "${INTERFACE}" channel "${chn}" 2>/dev/null &
            pid=$!
            wait $pid
            status=$?
            # Check the exit status of the last process.
            if [ "${status}" -ne 0 ]; then
                # Check the output flag to be true or false.
                if [[ "${DEBUG}" == true ]]; then
                    # Write a message into the terminal window.
                    echo -e "\n\rError setting new channel!"
                fi
                # Unblock device.
                chk_rfkill
                # Turn monitor mode on.
                set_monmod
                status_str="ERROR"
            fi
            # Increment the count variable.
            count=$((count+1))
            # Check the output flag to be true or false.
            if [[ "${OUTPUT}" == true ]]; then
                # Calculate the time difference.
                no=$(echo "scale=16; ($SECONDS/$count)*1000" | bc)
                no=$(printf "%4.0f %s" "${no}" "msecs")
                # Write the current channel into the terminal window.
                printf "%s %-2s \t %s %s \t Status: %-5s${cr}" \
                       "${chn_str}" "${chn}" "${dif_str}" "${no}" \
                       "${status_str}"
            fi
        done
    done
    # Return zero.
    return 0
}

# ##############################################################################
# Main script section.
# ##############################################################################

# Check the flags to be true or false.
if [[ "${DEBUG}" == true || "${OUTPUT}" == true ]]; then
    # Reset the terminal window.
    reset_screen
fi

# Check the debug flag to be true or false.
if [[ "${DEBUG}" == true ]]; then
    chk_pkg
fi

# Check the output flag to be true or false.
if [[ "${OUTPUT}" == true ]]; then
    # Print header into the terminal window.
    print_header
fi

# Check if the script is executable.
chk_mod "${SCRIPT_NAME}" "${DEBUG}"

# Kill all previous instances of the script.
# I do not understand my intention from 2017
#kill_prev_inst

# Define trap. Catch SIGINT and SIGTERM.
# see:      help trap
# see also: trap -l
trap signalhandler SIGINT SIGTERM

# Perform some tests.
chk_params
chk_iface
chk_monmod

# Run main loop.
main_loop

# Exit the script without an error.
exit 0


