#!/usr/bin/env bash

# Set locale for the script execution.
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LANGUAGE=en_US.UTF-8

# References:
#   https://perlgeek.de/en/article/set-up-a-clean-utf8-environment
#   https://www.imagemagick.org/script/display.php

# Script variables.
TITLE="Image to Base64"
VERSION="Version 0.0.0.2"
COPYRIGHT="(c) 2016-2024, Dr. Peter Netz"

# Set header variables.
CHAR="#"
OLEN=70
ILEN=$((OLEN-2))

# Set the line feed and carriage return variable.
NL="\n\r"

# Set the space variable.
SPC="\040"

# Get filename from command line.
SOURCE="${1}"

# Set length of base64 line.
BASE64LEN=80

# Set leading number of spaces.
BASE64SPC=8

# set string with spaces.
SPACES=$( printf "%-${BASE64SPC}s" "")

# Set image viewer.
# 1. fbi (not working)
# 2. fim (fork of fbi)
# 3. display (part of ImageMagick)
# 4. eog
# 5. xdg-open
# 6. gnome-open
IMAGE_VIEWER="fim"

# ==============================================================================
# Function head_line
# ==============================================================================
function head_line {
    # Set local string.
    local s=$1
    # Calculate the length of the string.
    local slen=${#s}
    # Calculate the length of the substrings.
    local l=$(((ILEN - slen)/2))
    local r=$((ILEN - l - slen))
    # Return string.
    printf "%s%-${l}b%s%-${r}b%s%b" "${CHAR}" "${SPC}" "${s}" "${SPC}" "${CHAR}"
    # Return exit status 0.
    return 0
}

# ==============================================================================
# Function write_header
# ==============================================================================
function write_header {
    # Define border string.
    local b=''
    b=$(printf "%${OLEN}s" | tr "${SPC}" "${CHAR}")
    # Write header into the terminal window.
    printf "%s%b" "${b}" "${NL}"
    printf "%s%${ILEN}b%s%b" "${CHAR}" "${SPC}" "${CHAR}" "${NL}"
    printf "%s%b" "$(head_line "${TITLE}")" "${NL}"
    printf "%s%b" "$(head_line "${VERSION}")" "${NL}"
    printf "%s%b" "$(head_line "${COPYRIGHT}")" "${NL}"
    printf "%s%${ILEN}b%s%b" "${CHAR}" "${SPC}" "${CHAR}" "${NL}"
    printf "%s%b" "${b}" "${NL}"
    # Return exit status 0.
    return 0
}

# ==============================================================================
# Function identify_image
# ==============================================================================
function identify_image {
    # Assign function parameter to local variable.
    local fn="${1}"
    # Get image file types.
    imagetype=$( file "${fn}" | grep image )
    tmp=$( echo "${imagetype}" | cut -d ":" -f 2 )
    tmp=$( echo "${tmp}" | cut -d "," -f 1 )
    trimmed=$( echo "${tmp}" | xargs )
    tmp=$( echo "${trimmed}" | cut -d " " -f 1 )
    restype=$( echo "${tmp}" | tr '[:upper:]' '[:lower:]' )
    echo -n "${restype}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function command_existance
# ==============================================================================
function command_existance {
    # Set local variable.
    msgstr="Command '${IMAGE_VIEWER}' is not installed. Bye!"
    # Check if command exists. Send std out to null.
    chk_result=$( type "$1" &> /dev/null)
    # Store exit code.
    exit_code=$?
    # Evaluate the exit code.
    if [ $exit_code -eq 0 ]
    then
        # Output true (command exists).
        result=true
    else
         # Output false (command NOT exists).
        result=false
    fi
    # Check if command exists.
    if [[ "${result}" == "false" ]]
    then
        # Write error message into terminal window.
        printf "%b%s%b" "\n\r" "Command '${IMAGE_VIEWER}' is not installed. Bye!" "\n\n\r"
        # Exit script.
    exit 1
    fi
    # Return the exit status 0.
    return 0
}

# ##############################################################################
# Main script section
# ##############################################################################

# Reset the terminal window.
reset

# Write header into the terminal window.
write_header

# Check if viewer is installed.
command_existance "${IMAGE_VIEWER}"

# Get basename of image without extension.
filebasename=$( basename "${FILE}" | cut -d . -f 1 )

# Set new filename
DESTINATION="${filebasename}.exif"

# Copy file from source to destination.
cp ${SOURCE} "${DESTINATION}"

# Remove EXIF data from image.
echo -e "\r"
echo -e "\r"

# Encode the given image.
base64img="$(cat "${DESTINATION}" | base64 -w ${BASE64LEN})"

# Remove file.
rm "${DESTINATION}"

# Show base64 string.
echo "${base64img}\n\r"

# Save base64 image.
echo "${base64img}" > "base64img.txt"

# Decode base64 image.
base64 -d "base64img.txt" > "decoded_image.img"

# Copy file.
cp "base64img.txt" "base64img_${BASE64SPC}spaces.txt"

# Add spaces to file.
sed -i -e "s/^/${SPACES}/" "base64img_${BASE64SPC}spaces.txt"

# Identify type of image.
ext=$( identify_image "decoded_image.img" )

# Move file.
mv "decoded_image.img" "image.${ext}"

# Show image.
${IMAGE_VIEWER} "image.${ext}"

# Exit script.
exit 0
