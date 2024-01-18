#!/bin/bash

# ##############################################################################
# Local Transparent Proxy
# Copyright © 2018-2024, Dr. Peter Netz
#
# Notice:
#   This bash script is produced independently from the Tor® anonymity software
#   and carries no guarantee from The Tor Project about quality, suitability or
#   anything else.
#
# To-Do:
#   Revise helpful informations, comments and documentation.
#
# Exit Codes:
# -----------
# 0   : No error
# 1   : General error
# 8   : Exit on no root Permissions
# 132 : Exit on catched signal SIGINT
#
# References:
# -----------
# [1] https://trac.torproject.org/projects/tor/wiki/doc/TransparentProxy
# [2] https://forum.ubuntuusers.de/topic/dns-wechselt-nach-neustart-auf-127-0-1-1/
# [3] https://askubuntu.com/questions/627899/nameserver-127-0-1-1-in-resolv-conf-wont-go-away
#
# Abbreviations:
# --------------
# DIG  -> Domain Information Groper
# DNS  -> Domain Name System
# ICMP -> Internet Control Message Protocol
# NAT  -> Network Address Translation
# TCP  -> Transmission Control Protocol
# UDP  -> User Datagram Protocol
#
# Prerequisite:
# -------------
# sudo apt-get install tor
# sudo apt-get install tor-geoipdb
#
# Log file:
# ---------
# cat /var/log/kern.log | grep OUTPUT
# ##############################################################################

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Check if script was started as root.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Set the global error string.
ERR_STR="The program must be run as root!"

# Make sure that only root can run the script.
if [ "$(id -u)" != "0" ]; then
   # Write an error message into the terminal window.
   echo "${ERR_STR}" 1>&2
   # Exit script.
   exit 8
fi

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Set the global variables.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Your outgoing interface.
#_OUT_IF="wlan0"
_OUT_IF="wlp7s0"

# Tor's TransPort
_TRANS_PORT="9040"

# Tor's DNSPort
_DNS_PORT="5300"

# Tor's VirtualAddrNetworkIPv4
_VIRT_ADDR="10.192.0.0/10"

# LAN destinations that shouldn't be routed through Tor. Check the IANA reserved block.
_NON_TOR="127.0.0.0/8 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16"

# Other IANA reserved blocks (These are not processed by tor and dropped by default).
_RESV_IANA="0.0.0.0/8 100.64.0.0/10 169.254.0.0/16 192.0.0.0/24 192.0.2.0/24 192.88.99.0/24 198.18.0.0/15 198.51.100.0/24 203.0.113.0/24 224.0.0.0/3"

# The UID that Tor runs as (varies from system to system).
_TOR_UID=$(id -u debian-tor)

# Set the iptables variable.
IPT="/sbin/iptables"

# ==============================================================================
# Function get_set_windowname()
# ==============================================================================
function get_set_windowname() {
    # Set the local variables.
    local winid
    local maximized
    # Get the name of the active window.
    WINDOWNAME=$(xdotool getactivewindow getwindowname)
    # Set screen name
    xdotool getactivewindow set_window --name "Local Transparent Proxy"
    # Get the ID of the active window.
    winid=$(xdotool getactivewindow)
    # Get the number of maximized dimensions.
    maximized=$(xwininfo -id "${winid}" -all | awk '/Maximized/{print}' | wc -l)
    # Toggle the screen.
    if [[ "${maximized}" != "2" ]]; then
        # wmctrl -r :ACTIVE: -b toggle,fullscreen
        wmctrl -r :ACTIVE: -b toggle,maximized_vert,maximized_horz
    fi
    # Return the exit code.
    return 0
}

# ==============================================================================
# Function print_header()
# ==============================================================================
function print_header() {
    # Print the header into the terminal window.
    echo -e "\e[44m╔══════════════════════════════════════════════════════════════════════════════╗\e[49m"
    echo -e "\e[44m║                         Local Transparent Proxy                              ║\e[49m"
    echo -e "\e[44m║                                Version 0.0.3                                 ║\e[49m"
    echo -e "\e[44m║                          © 2018-2024, Dr. Peter Netz                         ║\e[49m"
    echo -e "\e[44m║                     Use the Bash script on your own risk                     ║\e[49m"
    echo -e "\e[44m╚══════════════════════════════════════════════════════════════════════════════╝\e[49m"
    echo -e "\n\e[48;5;202mPress CTRL+C to abort the script!\e[0m"
    # Return the exit code.
    return 0
}

# ==============================================================================
# Function trap_sigint()
# ==============================================================================
function trap_sigint() {
    # Set the local variables.
    local ch str
    # Set the character.
    ch=" "
    # Set the string.
    str=$(printf '%*s' 67 | tr ' ' "$ch")
    # Write message(s) into the terminal window.
    printf "\n\r%s%s" "SIGINT caught" "${str}"
    printf "\r%s\n" "You pressed CTRL+C"
    # Write a farewell message into the terminal window.
    echo -e "\nHave a nice day. Bye!"
    # Exit the script.
    exit 132
}

# ==============================================================================
# Function check_torrc()
# ==============================================================================
function check_torrc() {
    # Set the local variable.
    local _str match
    # Initialise the local variable.
    local fn="/etc/tor/torrc"
    # Initialise the local string array.
    local str_arr=()
    # Add strings to the string array.
    str_arr+=('Log notice file /var/log/tor/notices.log')
    str_arr+=('VirtualAddrNetworkIPv4 10.192.0.0/10')
    str_arr+=('AutomapHostsSuffixes .onion,.exit')
    str_arr+=('AutomapHostsOnResolve 1')
    str_arr+=('TransPort 9040')
    str_arr+=('DNSPort 5300')
    # Loop over the string array.
    for _str in "${str_arr[@]}"
    do
        # Search for the the strings in the array.
        match=$(grep "^[^#;]" "${fn}" | grep "${_str}")
        if [[ "${match}" == "" ]]; then
            echo "${_str}" >> "${fn}"
        fi
    done
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function resolvconf_recover()
#
# Reference:
# https://askubuntu.com/questions/54888/
# ==============================================================================
function resolvconf_recover() {
    # Remove the existing file.
    rm -f /etc/resolv.conf
    # Recreate the symlink.
    ln -s ../run/resolvconf/resolv.conf /etc/resolv.conf
    # Update the recreated symlink.
    resolvconf -u
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function resolvconf_modification()
#
# Configure the DNS resolver of the system to use the DNSPort of Tor on the
# loopback interface by modifying /etc/resolv.conf to nameserver 127.0.0.1.
# ==============================================================================
function resolvconf_modification() {
    # Set the local variable.
    local dt
    # Get current date and time.
    dt=$(date '+%Y-%m-%d %H:%M:%S')
    # Initialise the local variables.
    local fp="/etc/resolv.conf"
    local str0="# ${dt} modified by a script with"
    local str1="# the goal to torify all local network traffic."
    local str2="nameserver 127.0.0.1"
    # Remove the symlink.
    rm -f "${fp}"
    # Create a file.
    touch "${fp}"
    # Fill the file with content.
    echo "${str0}" >> "${fp}"
    echo "${str1}" >> "${fp}"
    echo "${str2}" >> "${fp}"
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function tornet_restart()
# ==============================================================================
function tornet_restart() {
    # Restart service (tor) as background process.
    # Redirect stdout and stderr to /dev/null.
    service tor restart >/dev/null 2>&1 &
    pid=$!
    wait ${pid}
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function proxy_stop()
# ==============================================================================
function proxy_stop() {
    # Flush the iptables *nat.
    "${IPT}" -t nat -F
    "${IPT}" -t nat -X
    # Flush the iptables *mangle.
    "${IPT}" -t mangle -F
    "${IPT}" -t mangle -X
    # Flush the iptables *raw.
    "${IPT}" -t raw -F
    "${IPT}" -t raw -X
    # Flush the iptables *filter.
    "${IPT}" -t filter -F
    "${IPT}" -t filter -X
    # Flush the iptables.
    "${IPT}" -F
    "${IPT}" -X
    # Set the default policies to ACCEPT.
    "${IPT}" -P INPUT ACCEPT
    "${IPT}" -P OUTPUT ACCEPT
    "${IPT}" -P FORWARD ACCEPT
    # Recover resolv.conf
    resolvconf_recover
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function proxy_start()
# ==============================================================================
function proxy_start() {
    # Modify the local file resolv.conf.
    resolvconf_modification
    # Restart the Tor network service.
    tornet_restart
    # Flush the iptables.
    "${IPT}" -F
    "${IPT}" -t nat -F
    # ++++++++++++++++++++++
    # Set the iptables *nat.
    # ++++++++++++++++++++++
    # Nat TCP requests to Tor.
    # --tcp-flags FIN,SYN,RST,ACK SYN => --syn (?)
    "${IPT}" -t nat -A OUTPUT -d "${_VIRT_ADDR}" -p tcp -m tcp --syn -j REDIRECT --to-ports "${_TRANS_PORT}"
    # Nat DNS requests to Tor.
    "${IPT}" -t nat -A OUTPUT -d 127.0.0.1/32 -p udp -m udp --dport 53 -j REDIRECT --to-ports "${_DNS_PORT}"
    # Don't nat the Tor process, the loopback, or the local network.
    "${IPT}" -t nat -A OUTPUT -m owner --uid-owner "${_TOR_UID}" -j RETURN
    "${IPT}" -t nat -A OUTPUT -o lo -j RETURN
    # Disallow outgoing connections on the predefined/reserved networks thru Tor.
    for _net in ${_NON_TOR} ${_RESV_IANA}
    do
        "${IPT}" -t nat -A OUTPUT -d "${_net}" -j RETURN
    done
    # Redirect whatever fell thru to Tor's TransPort.
    # --tcp-flags FIN,SYN,RST,ACK SYN => --syn (?)
    "${IPT}" -t nat -A OUTPUT -p tcp -m tcp --syn -j REDIRECT --to-ports "${_TRANS_PORT}"
    # Redirect output of ICMP traffic to the TransPort of Tor.
    "${IPT}" -t nat -A OUTPUT -p icmp -m icmp --icmp-type echo-request -j REDIRECT --to-ports "${_TRANS_PORT}"
    # +++++++++++++++++++++++++++++++++
    # Set the iptables *filter FORWARD.
    # +++++++++++++++++++++++++++++++++
    # The local machine is not a router. Drop every forward traffic.
    "${IPT}" -A FORWARD -j DROP
    # +++++++++++++++++++++++++++++++
    # Set the iptables *filter INPUT.
    # +++++++++++++++++++++++++++++++
    "${IPT}" -A INPUT -m state --state ESTABLISHED -j ACCEPT
    "${IPT}" -A INPUT -i lo -j ACCEPT
    # Allow ICMP connections.
    "${IPT}" -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
    # Don't forget to grant yourself ssh access for remote machines before the DROP.
    # iptables -A INPUT -i $_out_if -p tcp --dport 22 -m state --state NEW -j ACCEPT
    "${IPT}" -A INPUT -j DROP
    # ++++++++++++++++++++++++++++++++
    # Set the iptables *filter OUTPUT.
    # ++++++++++++++++++++++++++++++++
    # Possible leak fix.
    "${IPT}" -A OUTPUT -m state --state INVALID -j DROP
    "${IPT}" -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
    # allow Tor process output.
    "${IPT}" -A OUTPUT -o "${_OUT_IF}" -m owner --uid-owner "${_TOR_UID}" -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j ACCEPT
    # allow loopback output.
    "${IPT}" -A OUTPUT -d 127.0.0.1/32 -o lo -j ACCEPT
    # tor transproxy magic.
    "${IPT}" -A OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport "${_TRANS_PORT}" --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
    # Allow access to hosts in $_NON_TOR.
    for _net in ${_NON_TOR}
    do
        "${IPT}" -A OUTPUT -d "${_net}" -j ACCEPT
    done
    # Log & Drop everything else.
    "${IPT}" -A OUTPUT -j LOG --log-prefix "Dropped OUTPUT packet: " --log-level 7 --log-uid
    "${IPT}" -A OUTPUT -j DROP
    # +++++++++++++++++++++++++++++++++
    # Set the default policies to DROP.
    # +++++++++++++++++++++++++++++++++
    "${IPT}" -P INPUT DROP
    "${IPT}" -P FORWARD DROP
    "${IPT}" -P OUTPUT DROP
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function proxy_info()
# ==============================================================================
function proxy_info() {
    # Set the local variable.
    local heredoc
    # Initialise the local variable.
    local fn="/tmp/tmp.txt"
    # Read the heredoc into the local variable.
	read -r -d '' heredoc <<- \
	"HEREDOC"
        \rIntroduction:
        \r-------------
        \n\rThis script is a bash utility that transparently routes all TCP and all DNS traffic of the
        \roperating system under its control through the Tor network. Outgoing ICMP traffic is allowed.
        \n\rCheck Out:
        \r----------\n\r
        \rTor Project:             https://www.torproject.org/
        \rAnonymity (Tor):         https://check.torproject.org/
        \rAnonymity (JonDonym):    http://ip-check.info/
        \rBrowser Security:        http://browserspy.dk/
        \rBrowser Security:        https://browserleaks.com/
        \rDNS & WebRTC Security:   https://ipleak.net/
        \rLink to NoScript:        https://noscript.net/
        \rLink to EFF:             https://www.eff.org/
        \rDuckDuckGo (Deep Web):   https://3g2upl4pq6kufc4m.onion/
        \rTor Nodes:               https://torstatus.blutmagie.de/
        \rTor Exit Nodes:          https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1
        \n\rDNS resolve with Tor:
        \r---------------------\n\r
        \rtor-resolve ${hostname}
        \rtor-resolve -x ${ip-address}
        \n\rThe Firefox browser (Version 57.0 or higher) is recommended as Internet browser. To use Firefox
        \rfor the Deep Web the preference 'network.dns.blockDotOnion' has to be set to 'false'. To do this
        \rtype 'about:config' into the Firefox address bar followed by 'ENTER'.
	HEREDOC
    # Write the heredoc to a file.
    echo -e "${heredoc}" > "${fn}"
    # Show the dialog.
    dialog --backtitle "Helpful Informations" \
           --title " Helpful Informations " \
           --begin 4 6 --exit-label " Close " \
           --textbox "${fn}" 30 110
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function show_torlog()
# ==============================================================================
function show_torlog() {
    local fn="/var/log/tor/notices.log"
    dialog --backtitle "Log file" \
           --title " Log file " \
           --begin 4 6 --exit-label " Close " \
           --textbox "${fn}" 30 155
    # Return the exit status.
    return 0
}

# ==============================================================================
# Function main_menu()
# ==============================================================================
function main_menu() {
    # Run an infinite loop.
    while true
    do
        # Create the main menu.
        choice=$(dialog --backtitle "Local Transparent Proxy" \
                        --title " Main Script Menu " \
                        --ok-label     " Your Selection " \
                        --cancel-label "  Leave Script  " \
                        --menu "Possible selections:" 0 0 0 \
                 "1" "Start the local transparent proxy using Tor" \
                 "2" "Stop the local transparent proxy using Tor" \
                 "3" "Request a new identity from the Tor network" \
                 "4" "Start the local Tor service" \
                 "5" "Stop the local Tor service" \
                 "6" "Show the Tor log file" \
                 "7" "Show helpful informations" \
                 3>&1 1>&2 2>&3)
        # Evaluate the choice.
        case "${choice}" in
            1) proxy_start ;;
            2) proxy_stop ;;
            3) pidof tor | xargs sudo kill -HUP ;;
            4) service tor start >/dev/null 2>&1 ;;
            5) service tor stop >/dev/null 2>&1 ;;
            6) show_torlog ;;
            7) proxy_info ;;
            *) echo -e "\n\nHave a nice day. Bye!"; exit 0 ;;
        esac
        # Clear the screen.
        clear
    done
    # Return the exit status.
    return 0
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Main Script Section
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Reset the screen.
reset

# Make this script executable.
if [[ ! -x "$0" ]]; then chmod +x "$0"; fi

# Failsafe. Die if /sbin/iptables is not found.
[ ! -x "${IPT}" ] && { echo "$0: \"${IPT}\" command not found."; exit 1; }

# Trap the signal SIGINT.
trap 'trap_sigint' SIGINT

# Get and set the window name.
get_set_windowname

# Print header into the terminal window.
print_header

# Check the file torrc.
check_torrc

# Call the main menu.
main_menu

# Exit the script.
exit 0
