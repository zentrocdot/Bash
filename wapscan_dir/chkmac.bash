#!/bin/bash

# (c) 2017, Dr. Peter Netz

# MAC (Media Access Control Address)
# <---------- 6 Octets ---------->
# <-- 3 Octets --><-- 3 Octets -->
# <---- OUI -----><---- NIC ----->

# https://en.wikipedia.org/wiki/MAC_address
# https://en.wikipedia.org/wiki/Bitwise_operation
# http://www.thegeekstuff.com/2012/10/bitwise-operators/

# FF:FF:FF:FF:FF:FF -> Broadcast Address
# DA-A1-19          -> Android 6.0+ MAC Address Randomization
# 33-33-xx-xx-xx-xx -> Multicast Address
# 01:00:5E:xx:xx:xx -> Multicast Address

# wget http://standards-oui.ieee.org/oui.txt

# Assign command line paramter to script variable.
MAC=$1

# Check length of MAC address.
if [[ "${#MAC}" != "17" ]]; then
    echo "Wrong MAC address format!"
    exit 1
fi

MA=("11:11:11:11:11:11" "22:22:22:22:22:22" "33:33:33:33:33:33"
    "44:44:44:44:44:44" "55:55:55:55:55:55")

# ==============================================================================
# function hex2dec()
# 1. dec=$((0x${hex}))
# 2. dec=$((16#${hex}))
# 3. dec=$(echo "ibase=16; ${hex}" | bc)
# ==============================================================================
function hex2dec() {
    # Assign the function parameter to a local variable.
    local hex=$1
    # Initialise the local variable.
    local dec=""
    # Convert hex value to dec value.
    dec=$((0x${hex}))
    # Output the decimal value.
    echo -n "${dec}"
    # Return exit status.
    return 0
}

# ==============================================================================
# function hex2bin()
# ==============================================================================
function hex2bin() {
    # Assign the function parameter to a local variable.
    local hex=$1
    # Initialise the local variables.
    local bin_raw=""
    local bin=""
    # Convert hex value to dec value.
    bin_raw=$(echo "obase=2; ibase=16; ${hex}" | bc)
    # Add leading zeros to the conversion result.
    printf -v bin "%08d" "${bin_raw}"
    # Output the formated binary value.
    echo -n "${bin}"
    # Return exit status.
    return 0
}

# Extract OUI and NIC from MAC address.
OUI=$(echo "${MAC:0:8}" | sed '{s/:/-/g; s/.*/\U&/g}')
NIC=$(echo "${MAC:9:8}" | sed '{s/:/-/g; s/.*/\U&/g}')

# Get vendor from database.
vendor=$(grep "${OUI}" oui.txt |
         awk -F ' ' '{$1=$2=""; print $0}' |
         sed '{s/^[[:space:]]*//g; s/[[:space:]]*$//g}')

# Handle empty vendor strings.
if [[ "${vendor}" == "" ]]; then
    vendor="n/a"
fi

# Get the most significant octet from OUI.
HEX=${OUI:0:2}

# Hexadecimal to decimal conversion.
DEC=$(hex2dec "${HEX}")

# Hexadecimal to binary conversion.
BIN=$(hex2bin "${HEX}")

# Mask bits 0 and 1.
testbit0=$((DEC & 1))
testbit1=$((DEC & 2))

# Reset screen.
reset

# Print header.
figlet "MAC Address Check" -w 120 | /usr/games/lolcat

# Write MAC, OUI and NIC into the terminal window.
printf "%-4s\n%s\n\n" "MAC:" "----"
printf "  %s\n\n" "${MAC}"

printf "  %-4s %s\n" "OUI:" "${OUI}"
printf "  %-4s %s\n" "NIC:" "${NIC}"

# Write vendor into the terminal window.
echo -e "\nVendor:"
echo -e "-------\n"
printf "  %s\n" "${vendor}"

# Write analysis result into the terminal window.
printf "\n%s\n" "Analysis of Most Significant OUI Octet:"
printf "%s\n\n" "---------------------------------------"
printf "%2s%-27s %s\n" "" "Hexadecimal Representation:" "${HEX}"
printf "%2s%-27s %s\n" "" "Decimal Representation:" "${DEC}"
printf "%2s%-27s %s\n\n" "" "Binary Representation:" "${BIN}"

if [[ "${testbit0}" == "1" ]]; then
    echo "  Bit B0=1 -> Multicast MAC Address"
else
    echo "  Bit B0=0 -> Unicast MAC Address"
fi

if [[ "${testbit1}" == "2" ]]; then
    echo "  Bit B1=1 -> Locally Administered Address (LAA)"
else
    echo "  Bit B1=0 -> Universally Administered Address (UAA)"
fi

echo

MSG0="-> DA:A1:19 Android 6.0 + Randomization Address"
if [[ "${OUI}" == "DA-A1-19" ]]; then
    vendor="${MSG0}"
    echo "${vendor}"
fi

tmp=${OUI:0:5}

if [[ "${tmp}" == "33-33" ]]; then
    echo "-> Multicast Address of Type 33:33:xx:xx:xx:xx"
fi

tmp=${OUI:0:8}

if [[ "${tmp}" == "01-00-5E" ]]; then
    echo "-> Multicast Address of Type 01:00:5E:xx:xx:xx"
fi

#for i in "${MA[@]}"; do
#    echo $i
#done

# Exit script.
exit 0
