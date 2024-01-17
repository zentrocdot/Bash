#!/bin/bash
# shellcheck disable=SC2001

################################################################################
# tor_check version 0.0.2
# Copyright © 2018-2024, Dr. Peter Netz
#
# The icons for the notification are stored in the temporary system directory
# /tmp.
#
# Exit node list changes.
#
# BUGFIX:
#   GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown:
#   The name org.freedesktop.Notifications was not provided by any .service files
#
#   sudo nano /usr/share/dbus-1/services/org.freedesktop.Notifications.service
#
#   [D-BUS Service]
#   Name=org.freedesktop.Notifications
#   Exec=/usr/lib/notification-daemon/notification-daemon
#
#   See also:
#   askubuntu.com/questions/1447877/why-do-i-get-gdbus-errororg-freedesktop-
#   dbus-error-serviceunknown-with-notify-s
################################################################################

# Make this script executable.
if [[ ! -x "$0" ]]; then chmod +x "$0"; fi

# Base64 encoded green onion icon.
read -r -d '' PICA <<'EOF'
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
EOF

# Base64 encoded red onion icon.
read -r -d '' PICB <<'EOF'
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
tBnzKZsmxu8AAAAASUVORK5CYII=
EOF

# Base64 encoded red error icon.
read -r -d '' PICE <<'EOF'
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
EOF

# Set the temporary path.
TMPPATH="/tmp"

# Set the filenames of the images.
ERRIMG=errimg.png
GONION=gonion.png
RONION=ronion.png

# Define the global strings.
STRING1='Congratulations. You are using Tor.'
STRING2='Sorry. You are NOT using Tor.'

# Set some global variables.
FP="${TMPPATH}/tor_exit_nodes_list.txt"
UA='Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0'
TORURL='https://check.torproject.org'

# Set the domain name.
DOMAINNAME='www.icann.org'

# Set the message color.
ESC="\e["
FG=15
BG0=22
BG1=124
MSG0="${ESC}0;38;5;${FG};48;5;${BG0}m"
MSG1="${ESC}0;38;5;${FG};48;5;${BG1}m"
RESC="${ESC}0m"

# ==============================================================================
# Function header()
# ==============================================================================
function header() {
# Declare the local variables.
local fg=15
local bg=202
local msgcol="\e[0;38;5;${fg};48;5;${bg}m"
local rstcol="\e[0m"
# Set color.
echo -ne "\e[44m"
# Show heredoc.
cat << "HEREDOC"
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃        _                   _               _           ┃
┃       | |_ ___  _ __   ___| |__   ___  ___| | __       ┃
┃       | __/ _ \| '__| / __| '_ \ / _ \/ __| |/ /       ┃
┃       | || (_) | |   | (__| | | |  __/ (__|   <        ┃
┃        \__\___/|_|____\___|_| |_|\___|\___|_|\_\       ┃
┃                  |____|                                ┃
┃                 tor_check version 0.0.1                ┃
┃         copyright © 2018-2024, Dr. Peter Netz          ┃
┃                                                        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
HEREDOC
# Reset color.
echo -ne "\e[44m"
# Write message into the terminal window.
#echo -e "\n\e[46mExit the program with CTRL+C\e[49m\n"
echo -e "\n${msgcol}Exit the program with CTRL+C${rstcol}\n"
# Return the exit code 0.
return 0
}

# ==============================================================================
# Function trap_sigint()
# The function is called by trap
# ==============================================================================
function trap_sigint() {
    # Declare the local variables.
    local ch
    local str
    # Set the filler character.
    ch='\u0020'
    # Set the filler string.
    str=$(printf '%*b' 80 | tr ' ' "${ch}")
    # Write two messages into the terminal window.
    printf "\r%s%s" "SIGINT caught" "${str}"
    printf "\r%s\n" "You pressed CTRL+C"
    # Exit script with exit code 130.
    exit 130
}

# ==============================================================================
# Function make_errimg()
# ==============================================================================
function make_errimg() {
    # Declare the local variables.
    local pic="${TMPPATH}/${ERRIMG}"
    local cs0
    local cs1
    cs0=$(echo "${PICE}" | base64 --decode | shasum | awk -F ' ' '{print $1}')
    cs1=$(shasum "${pic}" 2>/dev/null | awk -F ' ' '{print $1}')
    if [[ "${cs0}" != "${cs1}" ]]; then
        # Decode the base64 image and store it.
        echo "${PICE}" | base64 --decode > "${pic}"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function make_gonion()
# ==============================================================================
function make_gonion() {
    # Declare the local variables.
    local pic="${TMPPATH}/${GONION}"
    local cs0
    local cs1
    cs0=$(echo "${PICA}" | base64 --decode | shasum | awk -F ' ' '{print $1}')
    cs1=$(shasum "${pic}" 2>/dev/null | awk -F ' ' '{print $1}')
    if [[ "${cs0}" != "${cs1}" ]]; then
        # Decode the base64 image and store it.
        echo "${PICA}" | base64 --decode > "${pic}"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function make_ronion()
# ==============================================================================
function make_ronion() {
    # Declare the local variables.
    local pic="${TMPPATH}/${RONION}"
    local cs0
    local cs1
    cs0=$(echo "${PICB}" | base64 --decode | shasum | awk -F ' ' '{print $1}')
    cs1=$(shasum "${pic}" 2>/dev/null | awk -F ' ' '{print $1}')
    if [[ "${cs0}" != "${cs1}" ]]; then
        # Decode the base64 image and store it.
        echo "${PICB}" | base64 --decode > "${pic}"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function curllist()
# ==============================================================================
function curllist() {
    # Declare the local variable status.
    local status
    # Set the local variable url.
    #local url='https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1'
    local url='https://check.torproject.org/torbulkexitlist'
    # Try to download the TOR exit node list.
    timeout 5s curl -s -A "${UA}" "${url}" -o "${FP}"
    # Store the exit code of the last operation.
    status=$?
    # Evaluate the exit code. 124 from timeout. All other from curl.
    if [[ "${status}" == "124" ]]; then
        echo -e "CURL timeout. TOR exit node list could not be downloaded!\n"
        # Leave the function with an error.
        return 1
    elif [[ "${status}" != 0 ]]; then
        echo -e "CURL error. TOR exit node list could not be downloaded!\n"
        # Leave the function with an error.
        return 1
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function tor_exit_nodes_list()
# ==============================================================================
function tor_exit_nodes_list() {
    # Check if the file with the tor exit nodes list not exist.
    if [ -f "${FP}" ]; then
        # Get the date.
        dateo=$(sed -n '3p' "${FP}" | awk -F ' on ' '{print $2}' | sed 's/#$//')
        # Convert the date.
        odate=$(date -d"${dateo}" "+%Y%m%d %H:%M:%S" 2>/dev/null)
        # Get the date.
        daten=$(timeout 5s curl -s -I "${url}" | grep "Last-Modified" | awk -F ': ' '{print $2}')
        # Convert the date.
        ndate=$(date -d"${daten}" "+%Y%m%d %H:%M:%S" 2>/dev/null)
        # Compare the dates.
        if [[ ( "${odate}" != "" ) && ( "${odate}" != "${ndate}" ) ]]; then
            curllist
        fi
    else
        curllist
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function curlerr()
#
# References:
# http://tldp.org/LDP/abs/html/exitcodes.html
# https://curl.haxx.se/libcurl/c/libcurl-errors.html
# ==============================================================================
function curlerr() {
    # Assign the function parameter to a local variable.
    local errorcode=$1
    # Declare the local variables.
    local output='n/a'
    # Check the exit code.
    case "${errorcode}" in
        0)  output='CURLE_OK (0)';;
        1)  output='CURLE_UNSUPPORTED_PROTOCOL (1)';;
        2)  output='CURLE_FAILED_INIT (2)';;
        3)  output='CURLE_URL_MALFORMAT (3)';;
        4)  output='CURLE_NOT_BUILT_IN (4)';;
        5)  output='CURLE_COULDNT_RESOLVE_PROXY (5)';;
        6)  output='CURLE_COULDNT_RESOLVE_HOST (6)';;
        7)  output='CURLE_COULDNT_CONNECT (7)';;
        8)  output='CURLE_FTP_WEIRD_SERVER_REPLY (8)';;
        9)  output='CURLE_REMOTE_ACCESS_DENIED (9)';;
        10) output='CURLE_FTP_ACCEPT_FAILED (10)';;
        11) output='CURLE_FTP_WEIRD_PASS_REPLY (11)';;
        12) output='CURLE_FTP_ACCEPT_TIMEOUT (12)';;
        13) output='CURLE_FTP_WEIRD_PASV_REPLY (13)';;
        14) output='CURLE_FTP_WEIRD_227_FORMAT (14)';;
        15) output='CURLE_FTP_CANT_GET_HOST (15)';;
        16) output='CURLE_HTTP2 (16)';;
        17) output='CURLE_FTP_COULDNT_SET_TYPE (17)';;
        18) output='CURLE_PARTIAL_FILE (18)';;
        19) output='CURLE_FTP_COULDNT_RETR_FILE (19)';;
        20) output='n/a';;
        21) output='CURLE_QUOTE_ERROR (21)';;
        30) output='CURLE_FTP_PORT_FAILED (30)';;
        31) output='CURLE_FTP_COULDNT_USE_REST (31)';;
        32) output='n/a';;
        33) output='CURLE_RANGE_ERROR (33)';;
        34) output='CURLE_HTTP_POST_ERROR (34)';;
        35) output='CURLE_SSL_CONNECT_ERROR (35)';;
        36) output='CURLE_BAD_DOWNLOAD_RESUME (36)';;
        37) output='CURLE_FILE_COULDNT_READ_FILE (37)';;
        38) output='CURLE_LDAP_CANNOT_BIND (38)';;
        39) output='CURLE_LDAP_SEARCH_FAILED (39)';;
        40) output='n/a';;
        41) output='CURLE_FUNCTION_NOT_FOUND (41)';;
        42) output='CURLE_ABORTED_BY_CALLBACK (42)';;
        43) output='CURLE_BAD_FUNCTION_ARGUMENT (43)';;
        44) output='n/a';;
        45) output='CURLE_INTERFACE_FAILED (45)';;
        46) output='n/a';;
        47) output='CURLE_TOO_MANY_REDIRECTS (47)';;
        48) output='CURLE_UNKNOWN_OPTION (48)';;
        49) output='CURLE_TELNET_OPTION_SYNTAX (49)';;
        50) output='n/a';;
        51) output='CURLE_PEER_FAILED_VERIFICATION (51)';;
        52) output='CURLE_GOT_NOTHING (52)';;
        53) output='CURLE_SSL_ENGINE_NOTFOUND (53)';;
        54) output='CURLE_SSL_ENGINE_SETFAILED (54)';;
        55) output='CURLE_SEND_ERROR (55)';;
        56) output='CURLE_RECV_ERROR (56)';;
        57) output='n/a';;
        58) output='CURLE_SSL_CERTPROBLEM (58)';;
        59) output='CURLE_SSL_CIPHER (59)';;
        60) output='CURLE_SSL_CACERT (60)';;
        61) output='CURLE_BAD_CONTENT_ENCODING (61)';;
        62) output='CURLE_LDAP_INVALID_URL (62)';;
        63) output='CURLE_FILESIZE_EXCEEDED (63)';;
        64) output='CURLE_USE_SSL_FAILED (64)';;
        65) output='CURLE_SEND_FAIL_REWIND (65)';;
        66) output='CURLE_SSL_ENGINE_INITFAILED (66)';;
        67) output='CURLE_LOGIN_DENIED (67)';;
        68) output='CURLE_TFTP_NOTFOUND (68)';;
        69) output='CURLE_TFTP_PERM (69)';;
        70) output='CURLE_REMOTE_DISK_FULL (70)';;
        71) output='CURLE_TFTP_ILLEGAL (71)';;
        72) output='CURLE_TFTP_UNKNOWNID (72)';;
        73) output='CURLE_REMOTE_FILE_EXISTS (73)';;
        74) output='CURLE_TFTP_NOSUCHUSER (74)';;
        75) output='CURLE_CONV_FAILED (75)';;
        76) output='CURLE_CONV_REQD (76)';;
        77) output='CURLE_SSL_CACERT_BADFILE (77)';;
        78) output='CURLE_REMOTE_FILE_NOT_FOUND (78)';;
        79) output='CURLE_SSH (79)';;
        80) output='CURLE_SSL_SHUTDOWN_FAILED (80)';;
        81) output='CURLE_AGAIN (81)';;
        82) output='CURLE_SSL_CRL_BADFILE (82)';;
        83) output='CURLE_SSL_ISSUER_ERROR (83)';;
        84) output='CURLE_FTP_PRET_FAILED (84)';;
        85) output='CURLE_RTSP_CSEQ_ERROR (85)';;
        86) output='CURLE_RTSP_SESSION_ERROR (86)';;
        87) output='CURLE_FTP_BAD_FILE_LIST (87)';;
        88) output='CURLE_CHUNK_FAILED (88)';;
        89) output='CURLE_NO_CONNECTION_AVAILABLE (89)';;
        90) output='CURLE_SSL_PINNEDPUBKEYNOTMATCH (90)';;
        91) output='CURLE_SSL_INVALIDCERTSTATUS (91)';;
        92) output='CURLE_HTTP2_STREAM (92)';;
        93) output='CURLE_RECURSIVE_API_CALL (93)';;
        *)  output='UNKNOWN_CURL_ERROR';;
    esac
    # Output the curl error variable.
    echo -n "${output}"
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function geolocdata0()
# ==============================================================================
function geolocdata0() {
    # Assign the function parameter to the local variable.
    local ipaddr=$1
    # Declare the local variabes.
    local response
    local validdata
    # Try to get the geolocation data.
    response=$(timeout 20s curl -s "ip-api.com/${ipaddr}")
    if [[ "${response}" == "" ]]; then
        echo ""
        return 1
    fi
    # Check if the data are valid.
    validdata=$(echo "${response}" | grep -i -o "country")
    if [[ "${validdata}" != "" ]]; then
        # Remove color escape sequences from the data.
        output=$(echo "${response}" | sed -r 's/\x1b\[[0-9;]*m?//g')
        # Remove curly braces, double quotes, leading spaces and trailing comma.
        output=$(echo "${output}" | \
                 sed 's/[{}]/''/g; s/["]/''/g; s/^[ \t]*/    /; s/,$//')
        # Change the first character from lower case to upper case.
        output=$(echo "${output}" | sed 's/\b\(.\)/\u\1/g')
        # Output the data.
        echo "$output"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function geolocdata1()
# ==============================================================================
function geolocdata1() {
    # Assign the function parameter to the local variable.
    local ipaddr=$1
    # Declare the local variabes.
    local response
    local validdata
    # Try to get the geolocation data.
    response=$(curl -s "ipinfo.io/${ipaddr}")
    # Check if the data are valid.
    validdata=$(echo "${response}" | grep -i -o "country")
    if [[ "${validdata}" != "" ]]; then
        # Remove color escape sequences from the data.
        output=$(echo "${response}" | sed -r 's/\x1b\[[0-9;]*m?//g')
        # Remove curly braces, double quotes, leading spaces and trailing comma.
        output=$(echo "${output}" | \
                 sed 's/[{}]/''/g; s/["]/''/g; s/^[ \t]*/    /; s/,$//')
        # Change the first character from lower case to upper case.
        output=$(echo "${output}" | sed 's/\b\(.\)/\u\1/g')
        # Output the data.
        echo "$output"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function geolocdata2()
# ==============================================================================
function geolocdata2() {
    # Assign the function parameter to the local variable.
    local ipaddr=$1
    # Declare the local variabes.
    local response
    local validdata
    # Try to get the geolocation data.
    response=$(curl -s "extreme-ip-lookup.com/json/${ipaddr}")
    # Check if the data are valid.
    validdata=$(echo "${response}" | grep -i -o "country")
    if [[ "${validdata}" != "" ]]; then
        # Remove color escape sequences from the data.
        output=$(echo "${response}" | sed -r 's/\x1b\[[0-9;]*m?//g')
        # Remove curly braces, double quotes, leading spaces and trailing comma.
        output=$(echo "${output}" | \
                 sed 's/[{}]/''/g; s/["]/''/g; s/^[ \t]*/    /; s/,$//')
        # Change the first character from lower case to upper case.
        output=$(echo "${output}" | sed 's/\b\(.\)/\u\1/g')
        # Output the data.
        echo "$output"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function getipaddr()
# ==============================================================================
function getipaddr() {
    # Assign the function parameter to the local variable.
    local html=$1
    local pattern2='Your IP address appears to be:'
    local status
    local line=$(echo "$html" | grep "$pattern2")
    local ip="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$line")"
    echo -e "\n\e[45mYour IP address appears to be: $ip\e[49m"
    local exitn=$(grep "${ip}" "${FP}")
    if [[ "${exitn}" == "${ip}" ]]; then
        printf "\n    %-17s%s\n" "Exitnode (IP):" "$exitn"
        res=$(tor-resolve -x "${exitn}" 2>/dev/null)
        status=$?
        if [[ ${status} == 0 ]]; then
            printf "    %-17s%s\n" "Exitnode (HOST):" "$res"
        else
            printf "    %-17s%s\n" "Exitnode (HOST):" "n/a"
        fi
    else
        echo -e "\n${MSG1}Exit node could not be verified!${RESC}"
    fi
    geolocdata0 "${ip}"
    #geolocdata1 "${ip}"
    #geolocdata2 "${ip}"
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function gethtml()
# ==============================================================================
function gethtml() {
    # Declare the local variable html.
    local html=''
    local icon="${TMPPATH}/${ERRIMG}"
    local string="Unexpected CURL Error:"
    # Curl the html data.
    html=$(curl -s -A "${UA}" "${TORURL}")
    # Store the exit code of the last command.
    status=$?
    if [ ${status} -ne 0 ]; then
        str0=$(printf %40s ' ')
        # Output error message.
        local exp=''
        exp=$(curlerr ${status})
        echo -e "\n\e[41mUnexpected CURL Error: ${exp}\e[49m"
        DISPLAY=:0 sudo -u "${SUDO_USER}" \
        notify-send -t 5000 -i "$icon" "${string}$str0" "${exp}" 2>/dev/null
        # Return exit code.
        return 1
    fi
    # Output the html data.
    echo "${html}"

    echo "PETER"
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function check_tor()
# ==============================================================================
function check_tor() {
    # Declare the local variable.
    local html
    local status
    # Define the search pattern ot interest.
    local pattern0='Congratulations. This browser is configured to use Tor.'
    local pattern1='Sorry. You are not using Tor.'
    # Get the html data from the torproject website.
    html=$(gethtml)
    # Grep the search pattern and store the exit code.
    echo "${html}" | grep -o -q "${pattern0}"
    status=$?
    if [ ${status} -eq 0 ]; then
        getipaddr "$html"
        echo -e "\e[42m${STRING1}\e[49m"
        DISPLAY=:0 sudo -u "${SUDO_USER}" \
            notify-send -t 5000 -i "$TMPPATH/$GONION" "$STRING1" '' 2>/dev/null
        return 0
    fi
    # Grep the search pattern and store the exit code.
    echo "${html}" | grep -o -q "${pattern1}"
    status=$?
    if [ ${status} -eq 0 ]; then
        getipaddr "$html"
        echo -e "\e[41m${STRING2}\e[49m"
        DISPLAY=:0 sudo -u "${SUDO_USER}" \
            notify-send -t 5000 -i "$TMPPATH/$RONION" "$STRING2" 2>/dev/null
        return 0
    fi
    # Unknown error handling.
    local msgp1="An unexpected error has occurred."
    local msgp2="TOR probably won't work."
    echo -e "\e[41m${msgp1} ${msgp2}\e[49m"
    DISPLAY=:0 sudo -u "${SUDO_USER}" \
        notify-send -t 5000 -i "$TMPPATH/$ERRIMG" "${msgp1}" "${msgp2}" \
        2>/dev/null
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function check_dns()
# ==============================================================================
function check_dns() {
    # Declare the local variables.
    local status
    local domain
    local ipaddr
    # Get the answwer from dig.
    ipaddr=$(dig +short "${DOMAINNAME}")
    # Use only IP addresses.
    ipaddr=$(echo "${ipaddr}" | \
             grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
    if [[ "${ipaddr}" != "" ]]; then
        echo -e "${MSG0}DNS is working!${RESC}"
        printf "    %s -> %s\n" "${DOMAINNAME}" "${ipaddr}"
    else
        echo -e "${MSG1}DNS is NOT working!${RESC}"
        return 1
    fi
    # Reverse lookup.
    domain=$(nslookup "${ipaddr}" | grep name | \
             awk -F 'name = ' '{print $2}' | sed 's/.$//')
    if [[ $domain != "" ]]; then
        printf "    %s -> %s\n" "${ipaddr}" "${domain}"
    else
        printf "    %s -> %s\n" "${ipaddr}" "n/a"
    fi
    if [[ "${DOMAINNAME}" == "${domain}"  ]]; then
        printf "    ${MSG0}%s${RESC}\n" "Domain name resolution is OK"
    else
        printf "    ${MSG1}%s${RESC}\n" "Domain name resolution is NOT OK"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function check_tordns()
# ==============================================================================
function check_tordns() {
    # Declare the local variables.
    local ipaddr status domain
    # Set the local variables.
    local str0="Domain name resolution is OK"
    local str1="Domain name resolution is NOT OK"
    # Set the local unicode character.
    local char='\u0020'
    # Create the fill string.
    fill=$(printf "${char}%.0s" {1..4})
    # Get the IP address. Store the exit code.
    ipaddr=$(timeout 30 tor-resolve "${DOMAINNAME}" 2>/dev/null)
    status=$?
    if [[ "${status}" == "0" ]]; then
        echo -e "${MSG0}TorDNS is working!${RESC}"
        printf "    %s -> %s\n" "${DOMAINNAME}" "${ipaddr}"
    else
        echo -e "${MSG1}TorDNS is NOT working!${RESC}\n"
        return 1
    fi
    # Reverse lookup.
    domain=$(tor-resolve -x "${ipaddr}" 2>/dev/null | xargs)
    status=$?
    if [[ "${status}" == "0" ]]; then
        printf "${fill}%s -> %s\n" "${ipaddr}" "${domain}"
    else
        printf "${fill}%s -> %s\n" "${ipaddr}" "n/a"
    fi
    if [[ "${DOMAINNAME}" == "${domain}"  ]]; then
        printf "    ${MSG0}%s${RESC}\n\n" "${str0}"
    else
        printf "    ${MSG1}%s${RESC}\n\n" "${str1}"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function perfom_pings()
# ==============================================================================
function perform_pings() {
    # Declare the local variables.
    local fill answer status domain
    # Set the local strings.
    local str0="Name resolution is OK"
    local str1="Name resolution is NOT OK"
    # Set the local unicode character.
    local char='\u0020'
    # Create the fill string.
    fill=$(printf "${char}%.0s" {1..4})
    # Perform 5 pings. Ignore error messages. Store the exit code.
    answer=$(ping -c 5 "${DOMAINNAME}" 2>/dev/null)
    status=$?
    # Evaluate the value of the exit code.
    if [ ${status} -eq 0 ]; then
        echo -e "\n${MSG0}PING is working!${RESC}"
        # Remove empty lines. Remove the ping responses. Remove
        # the statistics headline. Add 4 spaces to each line.
        answer=$(echo "${answer}" | \
                 sed '/^\s*$/d; /statistics/d; /from/d; s/^/    /')
        echo -e "${answer}"
        domain=$(echo "${answer}" | grep PING | awk -F ' ' '{print $2}')
        if [[ "${DOMAINNAME}" != "${domain}"  ]]; then
            printf "${fill}\e[100mNotice: %s = %s\e[49m\n" "${domain}" "${DOMAINNAME}"
        fi
    else
        echo -e "\n${MSG1}PING is NOT working!${RESC}"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function TorInitStatus()
# ==============================================================================
function TorInitStatus() {
    # Declare the local variable.
    local reqstat
    # Initialise some local variables.
    local prev='The TOR service has'
    local post='been initiated at boot!'
    # Request informations about the TOR service.
    reqstat=$(service tor 2>&1 | grep -o "unrecognized service")
    # Check if the TOR service has been initiated.
    if [[ "${reqstat}" == "" ]]; then
        # Write a message into the terminal window.
        echo -e "${MSG0}${prev} ${post}${RESC}\n"
    else
        # Write a message into the terminal window.
        echo -e "${MSG1}${prev} NOT ${post}${RESC}\n"
    fi
    # Return the exit code 0.
    return 0
}

# ==============================================================================
# Function isTorRunning()
# ==============================================================================
function isTorRunning() {
    # Declare some local variables.
    local reqstat
    # Initialise some local variable.
    local prev='The TOR service is'
    local post='running!'
    local str0="tor is running"
    local str1="tor is not running"
    # Request the status of the tor service.
    reqstat=$(service tor status)
    status=$?
    # Evaluate the exit status of the tor service.
    if [[ ( "${status}" == "0" ) || ( "${status}" == "3" ) || ( "${status}" == "4" ) ]]; then
        (echo "${reqstat}" | grep -o -q "${str0}"; exit "${PIPESTATUS[1]}")
        status=$?
        if [[ "${status}" == "0" ]]; then
            echo -e "${MSG0}${prev} ${post}${RESC}\n"
        fi
        (echo "${reqstat}" | grep -o -q "${str1}"; exit "${PIPESTATUS[1]}")
        status=$?
        if [[ "${status}" == "0" ]]; then
            echo -e "${MSG1}${prev} NOT ${post}${RESC}\n"
        fi
    fi
    # Return the exit code 0.
    return 0
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Main Script Section
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Trap SIGINT.
trap 'trap_sigint' SIGINT

# Clear screen
reset

# Call function.
header

# Download the newest tor exit nodes list.
tor_exit_nodes_list

# Check if the TOR service has been initiated.
TorInitStatus

# Check if the TOR service is running.
isTorRunning

# Check TorDNS.
check_tordns

# Check DNS.
check_dns

# Check ping.
perform_pings

# Make the images.
make_errimg
make_gonion
make_ronion

# Call the function.
check_tor

# Print elapsed time to screen.
echo -e "\nElapsed time: $SECONDS Seconds"

# Farewell message.
echo -e "\nHave a nice day. Bye!"

# Exit the script.
exit 0
