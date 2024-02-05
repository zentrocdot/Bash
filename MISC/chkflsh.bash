#!/usr/bin/env bash

function main() {

# ##############################################################################
# Check Flash Drives and SD Cards
# (c) 2016, Dr. Peter Netz
# See also: f3, f3write, f3read
#
# The structure of the bash script forces the interpreter to load the whole
# script into memory. In this way the script can be modified while the script
# is executed.
#
#   main
#   {
#   content of script
#   }
#   main
#
# Check script by the command: shellcheck <script-name>
# See also website: https://www.shellcheck.net
#
# Debug modes:
# set -e  # Stops the script if a external command fails.
# set -n  # Check mode.
# set -x  # Debug mode.
# set -v  # Verbose mode.
# See `help set` for more informations.
#
# Check if variable is declared:
# if [ -z ${var1+x} ]; then test_result='false'; else test_result='true'; fi
# echo $test_result
# ##############################################################################

# Reset terminal window.
reset

# Clear terminal window.
clear

# Setting locale environment variable.
export LC_ALL=C

# Setting temp file path.
declare -r temp_file="/tmp/temp.dd"

# Setting null directory path.
declare -r null_file="/tmp/null.dd"

# Setting reference file name.
declare -r file_name="testfile.dd"

# Setting variable bs.
declare -r bsvar="1024"

# Calculate count size.
# countvar=($bsvar)^2
declare -r countvar="1048576"

# Calculate file size.
# filesize=($bsvar*$countvar)/(1024^2)
declare -r sizevar="1024"

# Setting max size for pv.
declare -r max_size="${sizevar}M"

# Initialise average write speed.
aws="0.0"

# Initialise average read speed.
ars="0.0"

# Initialise read, write and copy flag.
write_flag="0"
read_flag="0"
move_flag="0"

# Set control characters.
lf="\n"
cr="\r"
lfcr="${lf}${cr}"

# Setting the standard esc color sequences.
NO_COL='\E[0m'    # No Color
R_COL='\E[41m'    # Red
G_COL='\E[42m'    # Green
Y_COL='\E[43m'    # Yellow
B_COL='\E[44m'    # Blue
M_COL='\E[45m'    # Magenta
C_COL='\E[46m'    # Cyan
DG_COL='\E[100m'  # Dark grey
# LR_COL='\E[101m'  # Light red
# LG_COL='\E[102m'  # Light green
# LY_COL='\E[103m'  # Light yellow
# LB_COL='\E[104m'  # Light blue
# LM_COL='\E[105m'  # Light magenta
# LC_COL='\E[106m'  # Light cyan

# ==============================================================================
# Error handler/ Error traceback
#
# Exit status:
# 0        ->  Command completed successfully.
# 1        ->  Catchall for general errors.
# 2        ->  Misuse of shell builtins.
#              (according to the Bash documentation)
# 13       ->  Pipe error (SIGPIPE signal error)
# 1-125    ->  Command did not complete successfully.
#              Check the command's man page.
# 126      ->  Command was found and invoked, but couldn't be executed.
# 127      ->  Command was not found.
# 128-254  ->  Command died due to receiving a signal. The signal code is added
#              to 128 (128 + SIGNAL) to get the status.
# 130      ->  Script (command) exited due to Ctrl-C being pressed.
# > 255    ->  Exit status out of range.
#              (exit takes only integer arguments in the range 0-255)
#
# See also: http://tldp.org/LDP/abs/html/exitcodes.html
#           http://innovationsts.com/?p=1896
#           http://www.tutorialspoint.com/unix/unix-signals-traps.htm
# ==============================================================================
function error_traceback() {
    # Get error/traceback data.
    local exit_status=$?
    local bash_command=${BASH_COMMAND}
    # Set local variables.
    local lf="\n"
    local cr="\r"
    local lfcr="${lf}${cr}"
    local cmpres=""
    # Activate debug mode (same as set -x). Needed or not?
    # set +o xtrace
    # Check if the value of exit status is greater than 128.
    cmpres=$(echo "${exit_status} > 128.0" | bc)
    # If the value of the comparison result is equal to 1, a new exit status must be calculated.
    if [ "${cmpres}" -ne 0 ]; then
        # Calculate new exit status.
        exit_status=$(echo "scale=0; (${exit_status} - 128.0)/1.0" | bc)
    fi
    # Write error message into terminal window.
    local txtstr1="Trapped error in script ${BASH_SOURCE[1]} in line ${BASH_LINENO[0]}:"
    local txtstr2="'$bash_command' terminated with exit status ${exit_status}."
    echo -e "${lfcr}${R_COL}${txtstr1} ${txtstr2}${NO_COL}"
    # Get function depth.
    local depth="${#FUNCNAME[@]}"
    # Check function depth.
    if [ "${depth}" -gt 0 ]; then
        # Print out the stack trace described by the call stack.
        echo -e "${lfcr}Traceback of trapped error (most recent call last):"
        for ((i=0; i<"${depth}"+1; i++)); do
            local funcname="${FUNCNAME[$((i-1))]}"
            local lineno="${BASH_LINENO[$((i))]}"
            local source="${BASH_SOURCE[$((i))]}"
            if [ "${source}" == "" ]; then source="${BASH_SOURCE[1]}"; fi
            if [ "${lineno}" == "" ] || [ "${lineno}" == "0" ]; then lineno="n/a"; fi
            [ "$i" -eq "0" ] && funcname="$bash_command"
            echo -e "    Level $i: ${source}; line ${lineno}; ${funcname}"
        done
    fi
    # Set local text string variable.
    local txtstr="Exit status:"
    # Evaluate the exit code.
    case "${exit_status}" in
        1)   echo -e "${lfcr}${txtstr} ${exit_status} -> General error.${lfcr}"
             ;;
        13)  echo -e "${lfcr}${txtstr} ${exit_status} -> Pipe error.${lfcr}"
             ;;
        126) echo -e "${lfcr}${txtstr} ${exit_status} -> Command not executed.${lfcr}"
             ;;
        127) echo -e "${lfcr}${txtstr} ${exit_status} -> Command not found.${lfcr}"
             ;;
        *)   echo -e "${lfcr}${txtstr} ${exit_status} -> Unknown exit status.${lfcr}"
             ;;
    esac
    # Return exit status of function.
    return 0
}

# Call an error handler whenever a command exits with nonzero.
trap 'error_traceback' ERR

# =================
# Function ctrl+c()
# =================
function ctrl+c() {
    # Set local variables.
    local lfcr="\n\r"
    local msg="Good Bye!"
    # Write message into terminal window.
    echo -e "${lfcr}${msg}${lfcr}"
    # Exit script.
    exit 1
}

# Capture interrupt no. 2 (SIGINT)
trap 'ctrl+c' 2

# =======================
# Function write_header()
# =======================
function write_header() {
    # Set linefeed and carriage return.
    local lfcr="\n\r"
    # Define the strings of the script header.
    local head1="#######################################"
    local head2="#   Check Flash Drives and SD Cards   #"
    local head3="#             Version 1.0             #"
    local head4="#      (c) 2016, Dr. Peter Netz       #"
    local head5="#######################################"
    # Write the script header into the terminal window.
    echo -e "${B_COL}${head1}${NO_COL}"
    echo -e "${B_COL}${head2}${NO_COL}"
    echo -e "${B_COL}${head3}${NO_COL}"
    echo -e "${B_COL}${head4}${NO_COL}"
    echo -e "${B_COL}${head5}${NO_COL}${lfcr}"
    # Return exit status of function.
    return 0
}

# =====================
# Function empty_line()
# =====================
function empty_line() {
    # Set local variable for carriage return.
    local cr="\r"
    # Write an empty line into terminal window.
    echo -e "${cr}"
    # Return exit status of function.
    return 0
}

# ==================
# Function chkroot()
# ==================
function chkroot() {
    # Set linefeed and carriage return.
    local lfcr="\n\r"
    # Set error message.
    local msg="You need root rights for executing the script!"
    # Check if script was started as root.
    if [ "$(id -u)" != "0" ]; then
        # Write a message into the terminal window.
        echo -e "${msg}${lfcr}"
        # Terminate script.
        exit 1
    fi
}

# ==========================
# Function user_permission()
# ==========================
function user_permission() {
    # Set local variables.
    local permission=""
    local user=""
    # Check user and permission.
    permission=$(whoami)
    user=$(who | awk '{print $1}')
    # Write user and permission into terminal window.
    echo -e "Current User: ${user}"
    echo -e "Permissions:  ${permission}\n\r"
    # Return exit status of function.
    return 0
}

# ===================================================
# Function round()
# Goal:
#     Round up or round off of floating point numbers
#     by given accuracy.
# Usage:
#     value=$(round `${value}` `${accuracy}`)
#     $1 -> value
#     $2 -> accuracy
# ===================================================
function round() {
    # Assign parameters.
    local value="${1}"
    local accuracy="${2}"
    # Set local variables.
    local sp=""
    local rv=""
    # Calculate rounded value.
    sp=$(echo "scale=0; 10.0^${accuracy}" | bc)
    rv=$(echo "scale=${accuracy}; ((${sp}*${value})+0.5)/${sp}" | bc)
    # Return rounded value.
    printf "%.${accuracy}f" "${rv}"
    # Return exit status of function.
    return 0
}

# ==============================================================================
# Function trim()
# Goal:
#     Use the POSIX Character Classes to remove whitspaces from a given string.
#     The POSIX Character Class [:space:] matches whitespace characters in form
#     of spaces, tabs and line breaks.
# ==============================================================================
trim() {
    # Read function parameter.
    local param="$*"
    # Set local variable.
    local retvar=""
    # Remove leading whitespace characters.
    retvar="${param#"${var%%[![:space:]]*}"}"
    # Remove trailing whitespace characters.
    retvar="${param%"${var##*[![:space:]]}"}"
    # Return trimmed string.
    echo -n "$retvar"
    # Return exit status of function.
    return 0
}

# ==================
# Function wrspeed()
# ==================
function wrspeed() {
    # Assign the function parameter to the variable string.
    local string="$1"
    # Set the local variables.
    local var1=""
    local var2=""
    # Initalise the local variables.
    local zero="0.0"
    local retval="0.0"
    local re='^[0-9]+([.][0-9]+)?$'
    # Extract the write speed from variable string.
    var1=$(echo "${string}" | cut -d" " -f10)
    # Check the value of the variable var1.
    if [ "${var1}" == "" ]; then
        var1="0,0"
    fi
    # Replace a comma by a dot.
    var2="${var1/,/.}"
    # Check if value is a floating point number.
    if ! [[ "${var2}" =~ ${re} ]] ; then
        retval="${zero}"
    else
        retval="${var2}"
    fi
    # Return read/write speed.
    echo -n "$retval"
    # Return exit status of function.
    return 0
}

# =========================
# Function make_temp_file()
# =========================
function make_temp_file() {
    # Remove temporary file if it exists.
    if [ -e "${temp_file}" ]; then
        # Remove temporary file.
        # rm "${temp_file}" 2>/dev/null
        rm "${temp_file}" 
        # Make new temporary file.
        touch "${temp_file}"
    fi
    # Return exit status of function.
    return 0
}

# ======================
# Function write_files()
# ======================
function write_files() {
    # Initialise error flag.
    local error_flag="0"
    # Set local variables.
    local ps1=""
    local ps3=""
    local dst_fn=""
    local dst_fp=""
    local dd_result=""
    # Set source file path.
    local src_fp="${file_name}"
    # Initialise sum variable.
    local wss="0.0"
    # Initialise sum counter.
    local cnt="0"
    # Initialise loop variable.
    local i=""
    # Write testfiles to device.
    for i in $(seq "${devsize}"); do
        # Make new temporary file.
        make_temp_file
        # Set destination file name.
        dst_fn="${i}-${file_name}"
        # Assemble destination file path.
        dst_fp="${media_path}/${dst_fn}"
        # Write information into terminal window.
        echo "Write ${dst_fn}:"
        # Copy testfile from source to destination.
        { dd if="${src_fp}" bs="${bsvar}" iflag=fullblock status=none \
            | pv -s "${max_size}" -w 80 -f \
            | dd of="${dst_fp}" bs="${bsvar}" iflag=fullblock 2>&1 | tee "${temp_file}";
        local status="${PIPESTATUS[*]}"; } || {
            echo "Unknown failure in dd operation";
        }
        # Parse status variable.
        ps1=$(echo "${status}" | cut -f1 -d" ")
        ps3=$(echo "${status}" | cut -f3 -d" ")
        # Write read and write status into terminal window.
        echo -e "Read exit status:  ${ps1}"
        echo -e "Write exit status: ${ps3}"
        # Set error flag.
        error_flag="${ps3}"
        # Change value of return code on error.
        if [ "${error_flag}" -ne 0 ]; then write_flag="1"; fi
        # Read data from file.
        dd_result=$(<"${temp_file}")
        # Extract summary from dd_result.
        dd_result=$(echo "${dd_result}" | awk '/copied/ {print $0}')
        # Extract speed from dd_result.
        ws=$(wrspeed "${dd_result}")
        # Initialise local variable.
        local cmpres=""
        # Check if speed is greater zero.
        cmpres=$(echo "${ws} > 0.0" | bc)
        # Sum up write speeds if write speed is greater zero.
        if [ "${cmpres}" -ne 0 ]; then
            # Sum up speed values.
            wss=$(echo "${wss} + ${ws}" | bc)
            # Increment counter.
            cnt=$((cnt+1))
        fi
        # Write cache to disk.
        sync
        # Write empty line into terminal window.
        empty_line
    done
    # Calculate average write speed (and change global variable).
    aws=$(echo "scale=1; ${wss}/${cnt}" | bc)
    # Write average write speed into terminal window.
    echo -e "${C_COL}Average write speed: ${aws} MB/s${NO_COL}${lfcr}"
    # Return exit status of function.
    return 0
}

# =====================
# Function read_files()
# =====================
function read_files() {
    # Set error flag.
    local error_flag=""
    # Set pipe status.
    local ps1=""
    local ps3=""
    # Set other local variables.
    local src_fn=""
    local src_fp=""
    local dd_result=""
    # Initialise source file.
    local dst_fp="${null_file}"
    # Initialise sum variable.
    local rss="0.0"
    # Initialise sum counter.
    local cnt="0"
    # Set loop variable.
    local i=""
    # Read files from device.
    for i in $(seq "${devsize}"); do
        # Make new temporary file.
        make_temp_file
        # Set source file name.
        src_fn="${i}-${file_name}"
        # Assemble source file path.
        src_fp="${media_path}/${src_fn}"
        # Write information into terminal window.
        echo "Read ${i}-${file_name}:"
        # Copy testfile from source to destination.
        { dd if="${src_fp}" bs="${bsvar}" iflag=fullblock status=none \
            | pv -s "${max_size}" -w 80 -f \
            | dd of="${dst_fp}" bs="${bsvar}" iflag=fullblock 2>&1 | tee "${temp_file}";
        local status="${PIPESTATUS[*]}"; } || {
            echo "Unknown failure in dd operation";
        }
        # Parse status variable.
        ps1=$(echo "${status}" | cut -f1 -d" ")
        ps3=$(echo "${status}" | cut -f3 -d" ")
        # Write read and write status into terminal window.
        echo -e "Read exit status:  ${ps1}"
        echo -e "Write exit status: ${ps3}"
        # Assign error flag.
        error_flag="${ps1}"
        # Change value of error flag on error.
        if [ "${error_flag}" -ne 0 ]; then read_flag="1"; fi
        # Read dd result from file.
        dd_result=$(<"${temp_file}")
        dd_result=$(echo "${dd_result}" | awk '/copied/ {print $0}')
        # Extract speed from dd_result.
        rs=$(wrspeed "${dd_result}")
        # Set local variable.
        local cmpres=""
        # Check if speed is greater zero.
        cmpres=$(echo "${rs} > 0.0" | bc)
        # Sum up read speeds if read speed is greater zero.
        if [ "${cmpres}" -ne 0 ]; then
            # Sum up read speeds.
            rss=$(echo "${rss} + ${rs}" | bc)
            # Increment counter.
            cnt=$((cnt+1))
        fi
        # Write cache to disk.
        sync
        # Write empty line into terminal window.
        empty_line
    done
    # Calculate average read speed.
    ars=$(echo "scale=1; ${rss}/${cnt}" | bc)
    # Write average read speed into terminal window.
    echo -e "${C_COL}Average read speed: ${ars} MB/s${NO_COL}\n\r"
    # Return exit status of function.
    return 0
}

# ======================
# Function check_files()
# ======================
function check_files() {
    # Set local variables.
    local fn=""
    local fp=""
    local ref_sum=""
    local new_sum=""
    local md5_err=""
    # Check reference file with md5sum.
    echo "Calculate checksum of testfile.dd on hdd:"
    ref_sum=$(sudo pv "${file_name}" | md5sum | awk '{print $1}')
    echo "MD5: ${ref_sum}"
    # Write empty line into terminal window.
    empty_line
    # Setting error flag.
    md5_err="false"
    # Initialise loop variable.
    local i=""
    # Loop over all files on device.
    for i in $(seq "${devsize}"); do
        # Setting file name.
        fn="${i}-${file_name}"
        # Setting file path.
        fp="${media_path}/${fn}"
        # Check if file exist.
        if test -f "${fp}"; then
            echo "Calculate checksum of ${fn}:"
            # Calculate MD5 of file on device.
            new_sum=$(sudo pv "${fp}" | md5sum | awk '{print $1}')
            echo "MD5: ${new_sum}"
            if [ "${ref_sum}" == "${new_sum}" ]; then
                echo -e "${G_COL}CHECKSUM OK${NO_COL}\n\r"
            else
                echo -e "${R_COL}CHECKSUM ERROR${NO_COL}\n\r"
            fi
        else
            md5_err="true"
        fi
    done
    # Write error message into terminal window.
    if [ "${md5_err}" == "true" ]; then
        echo -e "${R_COL}General error. Files on device are missing.${NO_COL}"
    fi
    # Return exit status of function.
    return 0
}

# =====================
# Function move_files()
# =====================
function move_files() {
    # Set local variables.
    local src_fn=""
    local src_fp=""
    # Initialise destination file path.
    local dst_fp="${null_file}"
    # Set loop variable.
    local i=""
    # Loop over the testfiles.
    for i in $(seq "${devsize}"); do
        # Assign source file name.
        src_fn="${i}-${file_name}"
        # Assign source file path.
        src_fp="${media_path}/${src_fn}"
        # Write information into terminal window.
        echo "Move ${src_fn}:"
        # Move the testfiles from device to directory /tmp.
        rsync -a --no-R --no-implied-dirs --info=progress2 --remove-source-files "${src_fp}" "${dst_fp}" 2>/dev/null
        local status=$?
        # Write exit status into terminal window.
        echo -e "Move exit status: ${status}\n\r"
        # Change value of move flag on error.
        if [ "${status}" -ne 0 ]; then move_flag="1"; fi
        # Write cache to disk.
        sync
        # Remove null file.
        rm "${dst_fp}" -f 2>/dev/null
    done
    # Return exit status of function.
    return 0
}

# ====================
# Function date_time()
# ====================
function date_time() {
    # Get date and time.
    datetime=$(date +"%d.%m.%Y %H:%M:%S")
    # Write date and time into terminal window.
    echo -e "${M_COL}Date and time: ${datetime}${NO_COL}\n\r"
}

# Check if script was started as root.
chkroot

# Write header into terminal window.
write_header

# Write date and time into terminal window.
date_time

# Check user and permission
user_permission

# Check if the test file exists.
if [ -e "${file_name}" ] ; then
    # Get the size of the test file in Bytes.
    file_size=$(du -k "${file_name}" | cut -f 1)
    # Calculate the size of the test file in MB.
    file_size=$(echo "scale=0; ${file_size}/1024.0" | bc)
    # Check the size of the test file.
    if [ "${file_size}" != "1024" ]; then
        # Delete an existing test file of wrong size.
        sudo rm "${file_name}"
    fi
    # Ask the user whether the test file should be deleted or not.
    if [ "${file_size}" == "1024" ]; then
        # Make a decision.
        echo -e "Delete the existing test file?"
        echo -n "Enter [yes] or [no], followed by [ENTER]: "
        read -r choice
        # Evaluate the decision.
        if [ "${choice}" == "yes" ]; then
            # Delete the existing test file.
            sudo rm "${file_name}"
        elif [ "${choice}" == "no" ]; then
            # Do not do anything other than continue with the script.
            :
        else
            # Exit the script.
            exit 1
        fi
        # Write empty line into terminal window.
        echo -e "${cr}"
    fi
fi

# If the testfile doesn't exist or if the testfile has the wrong size create a new test file.
if [ ! -e "${file_name}" ] || [ "${file_size}" != "1024" ]; then
    # Input the file creation method.
    echo -e "File Creation"
    echo -e "=============${lfcr}"
    echo -e "Select zero or random number:"
    echo -e "  1  ->  /dev/zero"
    echo -e "  2  ->  /dev/urandom"
    echo -n "Make your decision followed by [ENTER]: "
    read -r input
    # Evaluation of user input.
    if [ "${input}" == "1" ]; then
        # Setting write method to zero number.
        write_method="/dev/zero"
    elif [ "${input}" == "2" ]; then
        # Setting write method to random number.
        write_method="/dev/urandom"
    else
        # On error exit script.
        exit 1
    fi
    # Write empty line into terminal window.
    echo -e "${cr}"
    # Write summary into terminal window.
    echo -e "=================="
    echo -e "File creation data"
    echo -e "==================${lfcr}"
    echo -e "Block size:    ${bsvar} Bytes"
    echo -e "Multiplicator: ${countvar}"
    echo -e "File size:     ${sizevar} MB"
    echo -e "Write method:  ${write_method}${lfcr}"
    # Write headline into terminal window.
    echo -e "=========================="
    echo -e "Write testfile to harddisk"
    echo -e "==========================${lfcr}"
    # Write comment into terminal window.
    echo -e "Write ${file_name}:"
    # Create test file on hard disk.
    sudo dd if="${write_method}" of="${file_name}" \
        bs="${bsvar}" count="${countvar}" iflag=fullblock status=progress
    # Write empty line into terminal window.
    echo -e "\r"
fi

# Write a headline into the terminal window.
str1="Mounted Devices"
str2="==============="
echo -e "${str1}${lfcr}${str2}${lfcr}"

# Write informations about the file system into the terminal window.
df -T -h | grep 'Dateisystem\|sd'

# Read the letter of a device from the keyboard.
str="Enter the letter of the device [a,b,c...z], followed by [ENTER]: "
echo -en "${lfcr}${str}"
read -r dl

# Write empty line into terminal window.
empty_line

# Set device variables.
sd0="sd${dl}"
sd1="sd${dl}1"

# Assemble path of the device.
device_path="/dev/${sd1}"

# Determine the media path of the device.
media_path=$(lsblk | grep "${sd1}" | awk '{print $7}')

# Get dir content.
dircontent=$(ls -A "${media_path}")

# Check if device is empty
if [ "${dircontent}" ]; then
    str="Device is not empty. Warning."
    echo -e "${Y_COL}${str}${NO_COL}${lfcr}"
else
    str="Device is empty. Ok."
    echo -e "${G_COL}${str}${NO_COL}${lfcr}"
fi

# Check if dev is a root file system.
if mount | grep "^${device_path}.* / " > /dev/null; then
    # Write message into terminal window.
    msg="The script refuses to run on a root filesystem."
    echo -e "${msg}${lfcr}"
    # Exit script.
    exit 1
fi

# Determine capacity of device.
devsize=$(df | grep "${sd1}" | awk '{print $2}')
devsize=$(echo "scale=2; (${devsize}/1024.0)/1024.0" | bc)
devsize=$(round "${devsize}" 0)

# Write capacity of device into terminal window.
echo -e "Determined capacity of device: ${devsize} GB${lfcr}"

# Set check result variable.
chkres="false"

# Check if capacity is valid.
for i in $(seq 1 16); do
    number=$(echo "scale=0; ((2.0)^${i})/1.0" | bc)
    if [ "$devsize" -eq "$number" ]; then
        chkres="true"
    fi
done

# Enter new capacity if capacity is not valid.
if [ "${chkres}" == "false" ]; then
    echo -e "Capacity mismatch. Possible values are 2, 4, 8, 16 etcetera."
    echo -n "Enter the correct capacity in gigabyte, followed by [ENTER]: "
    read -r real_size
    devsize="$real_size"
fi

# Write empty line into terminal window.
empty_line

# Set the strings of the headline.
hl1="======================="
hl2="Summary of Informations"
hl3="======================="
# Write the headline into the terminal window.
echo -e "${hl1}${lfcr}${hl2}${lfcr}${hl3}${lfcr}"

# Write media path into terminal window.
echo -e "Media device path: ${media_path}${lfcr}"

# Get size of device.
device_size=$(blockdev --getsize64 "/dev/${sd0}")
echo -e "Real size: ${device_size} Bytes"

# Calculate size of device in kilobytes.
device_size_kb=$(echo "scale=0; ${device_size}/1024.0" | bc)
echo -e "           ${device_size_kb} KB"

# Calculate size of device in megabytes.
device_size_mb=$(echo "scale=0; ${device_size_kb}/1024.0" | bc)
echo -e "           ${device_size_mb} MB"

# Write empty line into terminal window.
empty_line

# Calculate usable space in bytes.
free_size_bytes=$(df -B1 "/dev/${sd1}" |grep "/dev/${sd1}" |awk '{print $4}')
echo -e "Free size: ${free_size_bytes} Bytes"

# Calculate usable space in kilobytes.
free_size_kb=$(echo "scale=0; ${free_size_bytes}/1024.0" | bc)
echo -e "           ${free_size_kb} KB"

# Calculate usable space in megabytes.
free_size_mb=$(echo "scale=0; ${free_size_kb}/1024.0" | bc)
echo -e "           ${free_size_mb} MB"

# Write empty line into terminal window.
empty_line

# Ask if test file be performed.
if [ -e "${file_name}" ] ; then
    echo -e "Test the device now?"
    echo -n "Enter [yes] or [no], followed by [ENTER]: "
    read -r choice
    if [ "${choice}" != "yes" ]; then
        exit 1
    fi
fi

# Write empty line into terminal window.
empty_line

# Write date and time into terminal window.
# date_time

# Set start time.
START=$(date +%s)

# Set the strings of the headline.
hl1="========================"
hl2="Copy testfiles to device"
hl3="========================"
# Write the headline into the terminal window.
echo -e "${DG_COL}${hl1}${NO_COL}"
echo -e "${DG_COL}${hl2}${NO_COL}"
echo -e "${DG_COL}${hl3}${NO_COL}${lfcr}"

# Write test files to device.
write_files

# Set end time.
END=$(date +%s)

# Calculate difference in seconds.
DIFF=$((END - START))

# Write result into terminal window.
printf '\E[45mElapsed time: %d Hours %d Minutes %d Seconds\E[0m\n' $((DIFF/3600)) $((DIFF%3600/60)) $((DIFF%60))

# Write empty line into terminal window.
empty_line

# Set start time.
START=$(date +%s)

# Set the strings of the headline.
hl1="=========================="
hl2="Read testfiles from device"
hl3="=========================="
# Write the headline into the terminal window.
echo -e "${DG_COL}${hl1}${NO_COL}"
echo -e "${DG_COL}${hl2}${NO_COL}"
echo -e "${DG_COL}${hl3}${NO_COL}${lfcr}"

# Read files from device.
read_files

# Set end time.
END=$(date +%s)

# Calculate difference in seconds.
DIFF=$(( END - START ))

# Write result into terminal window.
printf '\E[45mElapsed time: %d Hours %d Minutes %d Seconds\E[0m\n' $((DIFF/3600)) $((DIFF%3600/60)) $((DIFF%60))

# Write empty line into terminal window.
empty_line

# Set start time.
START=$(date +%s)

# Set the strings of the headline.
hl1="=========================="
hl2="Verify testfiles on device"
hl3="=========================="
# Write the headline into the terminal window.
echo -e "${DG_COL}${hl1}${NO_COL}"
echo -e "${DG_COL}${hl2}${NO_COL}"
echo -e "${DG_COL}${hl3}${NO_COL}${lfcr}"

# Check md5 files.
check_files

# Get file system data.
df -T | grep 'Filesystem\|Dateisystem'
df -T | grep "${sd0}"

# Write empty line into terminal window.
empty_line

# Set end time.
END=$(date +%s)

# Calculate difference in seconds.
DIFF=$(( END - START ))

# Write result into terminal window.
printf '\E[45mElapsed time: %d Hours %d Minutes %d Seconds\E[0m\n' $((DIFF/3600)) $((DIFF%3600/60)) $((DIFF%60))

# Write empty line into terminal window.
empty_line

# Set start time.
START=$(date +%s)

# Set the strings of the headline.
hl1="=================================="
hl2="Move testfiles from device to /tmp"
hl3="=================================="
# Write the headline into the terminal window.
echo -e "${DG_COL}${hl1}${NO_COL}"
echo -e "${DG_COL}${hl2}${NO_COL}"
echo -e "${DG_COL}${hl3}${NO_COL}${lfcr}"

# Move testfiles from device to /tmp.
move_files

# Set end time.
END=$(date +%s)

# Calculate difference in seconds.
DIFF=$(( END - START ))

# Write empty line into terminal window.
empty_line

# Get file system data.
df -T | grep 'Filesystem\|Dateisystem'
df -T | grep "${sd0}"

# Write empty line into terminal window.
empty_line

# Clean up script.
rm "${temp_file}" -f 2>/dev/null
rm "${null_file}" -f 2>/dev/null

# Write result into terminal window.
printf '\E[45mElapsed time: %d Hours %d Minutes %d Seconds\E[0m\n' $((DIFF/3600)) $((DIFF%3600/60)) $((DIFF%60))

# Write comment into terminal window.
echo -e "======================="
echo -e "Summary of verification"
echo -e "=======================\n\r"

# Set string variables.
str0="ERROR"
str1="Okay"
str2="Error"

# Evaluate the write flag.
txtstr="Device write:"
case "${write_flag}" in
    0) echo -e "$txtstr ${str1}"
       ;;
    1) echo -e "$txtstr ${str2}"
       ;;
    *) echo "${str0}"; exit 1
       ;;
esac

# Evaluate the read flag.
txtstr="Device read:"
case "${read_flag}" in
    0) echo -e "$txtstr  ${str1}"
       ;;
    1) echo -e "$txtstr  ${str2}"
       ;;
    *) echo "${str0}"; exit 1
       ;;
esac

# Evaluate the move flag.
txtstr="Device move:"
case "${move_flag}" in
    0) echo -e "$txtstr  ${str1}"
       ;;
    1) echo -e "$txtstr  ${str2}"
       ;;
    *) echo "${str0}"; exit 1
       ;;
esac

# Write empty line into terminal window.
empty_line

# Write average write/read speeds into terminal window.
str0="MB/s"
str1="Average write speed:"
str2="Average read speed: "
echo -e "${str1} ${aws} ${str0}"
echo -e "${str2} ${ars} ${str0}${lfcr}"

# Write date and time into terminal window.
date_time

duration="$SECONDS"
echo -e "${M_COL}Duration of script: $((duration / 60)) minutes and $((duration % 60)) seconds elapsed.${NO_COL}${lfcr}"

# Exit script.
exit 0

}

# Execute main script.
main
