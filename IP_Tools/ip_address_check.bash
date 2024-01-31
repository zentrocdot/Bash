#!/usr/bin/bash

# Clear screen.
printf "\033c"

# Name of bash script: ip_address_check.bash
# Purpose: Check if an IP is valid. Check also if it is a public, private or special IP address.

# tuxgraphics.org/toolbox/network_address_calculator_add.html
# tools.ietf.org/html/rfc5735

# IP Address Assignments
# ======================
#
# Reference: tools.ietf.org/html/rfc5735
#
# Address Block       Present Use                Reference
# ------------------------------------------------------------------------
# 0.0.0.0/8           This Network               RFC 1122, Section 3.2.1.3
# 10.0.0.0/8          Private-Use Networks       RFC 1918
# 127.0.0.0/8         Loopback                   RFC 1122, Section 3.2.1.3
# 169.254.0.0/16      Link Local                 RFC 3927
# 172.16.0.0/12       Private-Use Networks       RFC 1918
# 192.0.0.0/24        IETF Protocol Assignments  RFC 5736
# 192.0.2.0/24        TEST-NET-1                 RFC 5737
# 192.88.99.0/24      6to4 Relay Anycast         RFC 3068
# 192.168.0.0/16      Private-Use Networks       RFC 1918
# 198.18.0.0/15       Network Interconnect
#                     Device Benchmark Testing   RFC 2544
# 198.51.100.0/24     TEST-NET-2                 RFC 5737
# 203.0.113.0/24      TEST-NET-3                 RFC 5737
# 224.0.0.0/4         Multicast                  RFC 3171
# 240.0.0.0/4         Reserved for Future Use    RFC 1112, Section 4
# 255.255.255.255/32  Limited Broadcast          RFC 919, Section 7
#                                                RFC 922, Section 7
#
# Abbreviations:
#  IANA = Internet Assigned Numbers Authority
#  IETF = Internet Engineering Task Force
#  RFC  = Request for Comments
#
# Reference:
#   www.rfc-editor.org/materials/abbrev.expansion.txt
#
# Network Address:    xxx.xxx.xxx.0
# Broasdcast Address: xxx.xxx.xxx.255
#
# Private Address Space:
# ----------------------
#
# 10.0.0.0    - 10.255.255.255   (10.0.0.0/8)
# 172.16.0.0  - 172.31.255.255   (172.16.0.0/12)
# 192.168.0.0 - 192.255.255.255  (192.168.0.0/16)
#
# Special Address Space:
# ----------------------
#
# 0.0.0.0         - 0.255.255.255   (0.0.0.0/8)
# 127.0.0.0       - 127.255.255.255 (127.0.0.0/8)
# 169.254.0.0     - 169.254.255.255 (169.254.0.0/16)
# 192.0.0.0       - 192.0.0.255     (192.0.0.0/24)
# 192.0.2.0       - 192.0.2.255     (192.0.2.0/24)
# 192.88.99.0     - 192.88.99.255   (192.88.99.0/24)
# 198.18.0.0      - 198.19.255.255  (198.18.0.0/15)
# 198.51.100.0    - 198.51.100.255  (198.51.100.0/24)
# 203.0.113.0     - 203.0.113.255   (203.0.113.0/24)
# 224.0.0.0       - 239.255.255.255 (224.0.0.0/4)
# 240.0.0.0       - 255.255.255.255 (240.0.0.0/4)
# 255.255.255.255 - 255.255.255.255 (255.255.255.255/32)

echo -e "################################################################################"
echo -e "#                                                                              #"
echo -e "#                             IP ADDRESS Analysis                              #"
echo -e "#                        (c) 2016-2024, Dr. Peter Netz                         #"
echo -e "#                                                                              #"
echo -e "################################################################################"
echo -e "\r"

# IP to check.
ip2check=$1
if [ $ip2check=="" ]; then
    ip2check="10.0.0.1"
fi

# Expression for three decimal numbers followed by a dot.
nr_000_000d="[0]."                                                           # Number Range 0 - 0
nr_002_002d="[2]."                                                           # Number Range 2 - 2
nr_010_010d="[1][0]."                                                        # Number Range 10 - 10
nr_051_051d="[5][1]."                                                        # Number Range 51 - 51
nr_088_088d="[8][8]."                                                        # Number Range 88 - 88
nr_099_099d="[9][9]."                                                        # Number Range 99 - 99
nr_018_019d="[1][8-9]."                                                      # Number Range 18 - 19
nr_100_100d="[1][0][0]."                                                     # Number Range 100 - 100
nr_113_113d="[1][1][3]."                                                     # Number Range 113 - 113
nr_127_127d="[1][2][7]."                                                     # Number Range 127 - 127
nr_169_169d="[1][6][9]."                                                     # Number Range 169 - 169
nr_172_172d="[1][7][2]."                                                     # Number Range 172 - 172
nr_192_192d="[1][9][2]."                                                     # Number Range 192 - 192
nr_198_198d="[1][9][8]."                                                     # Number Range 198 - 198
nr_203_203d="[2][0][3]."                                                     # Number Range 203 - 203
nr_224_224d="[2][2][4]."                                                     # Number Range 224 - 224
nr_240_240d="[2][4][0]."                                                     # Number Range 240 - 240
nr_254_254d="[2][5][4]."                                                     # Number Range 254 - 254
nr_224_239d="[2][3][0-9].|[2][2][4-9]."                                      # Number Range 224 - 239
nr_240_255d="[2][5][0-5].|[2][4][0-9]."                                      # Number Range 240 - 255
nr_016_031d="[3][0-1].|[2][0-9].|[1][6-9]."                                  # Number Range 16 - 31
nr_168_255d="[2][5][0-5].|[2][0-4][0-9].|[1][7-9][0-9].|[1][6][8-9]."        # Number Range 168 - 255
nr_000_255d="[2][5][0-5].|[2][0-4][0-9].|[1][0-9][0-9].|[1-9][0-9].|[0-9]."  # Number Range 0 - 255
# Expression for three decimal numbers followed by nothing else.
nr_000_255n="[2][5][0-5]|[2][0-4][0-9]|[1][0-9][0-9]|[1-9][0-9]|[0-9]"       # Number Range 0 - 255

# Setting test pattern list array.
test_pattern=()

test_pattern[0]="(^$nr_010_010d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"   # 10.0.0.0     - 10.255.255.255   prefix 8
test_pattern[1]="(^$nr_127_127d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"   # 127.0.0.0    - 127.255.255.255  prefix 8
test_pattern[2]="(^$nr_169_169d)($nr_254_254d)($nr_000_255d)($nr_000_255n)$"   # 169.254.0.0  - 169.254.255.255  prefix 16
test_pattern[3]="(^$nr_172_172d)($nr_016_031d)($nr_000_255d)($nr_000_255n)$"   # 172.16.0.0   - 172.31.255.255   prefix 12
test_pattern[4]="(^$nr_192_192d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"   # 192.0.0.0    - 192.0.0.255      prefix 24
test_pattern[5]="(^$nr_192_192d)($nr_000_000d)($nr_002_002d)($nr_000_255n)$"   # 192.0.2.0    - 192.0.2.255      prefix 24
test_pattern[6]="(^$nr_192_192d)($nr_088_088d)($nr_099_099d)($nr_000_255n)$"   # 192.88.99.0  - 192.88.99.255    prefix 24
test_pattern[7]="(^$nr_192_192d)($nr_168_255d)($nr_000_255d)($nr_000_255n)$"   # 192.168.0.0  - 192.255.255.255  prefix 16
test_pattern[8]="(^$nr_198_198d)($nr_018_019d)($nr_000_255d)($nr_000_255n)$"   # 198.18.0.0   - 198.19.255.255   prefix 15
test_pattern[9]="(^$nr_198_198d)($nr_051_051d)($nr_100_100d)($nr_000_255n)$"   # 198.51.100.0 - 198.51.100.255   prefix 24
test_pattern[10]="(^$nr_203_203d)($nr_000_000d)($nr_113_113d)($nr_000_255n)$"  # 203.0.113.0  - 203.0.113.255    prefix 24
test_pattern[11]="(^$nr_224_239d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"  # 224.0.0.0    - 239.255.255.255  prefix 4
test_pattern[12]="(^$nr_240_255d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"  # 240.0.0.0    - 255.255.255.255  prefix 4

# Setting pattern string list array.
pattern_string=()

pattern_string[0]="Type: Private --> RFC: Private-Use Networks"
pattern_string[1]="Type: Local --> RFC: Loopback"
pattern_string[2]="Type: Local --> RFC: Link Local"
pattern_string[3]="Type: Private --> RFC: Private-Use Networks"
pattern_string[4]="Type: Other --> RFC: IETF Protocol Assignments"
pattern_string[5]="Type: Other --> RFC: TEST-NET-1"
pattern_string[6]="Type: Other --> RFC: 6to4 Relay Anycast"
pattern_string[7]="Type: Private --> RFC: Private-Use Networks"
pattern_string[8]="Type: Other --> RFC: Network Interconnect Device Benchmark Testing"
pattern_string[9]="Type: Other --> RFC: TEST-NET-2"
pattern_string[10]="Type: Other --> RFC: TEST-NET-3"
pattern_string[11]="Type: Other --> RFC: Multicast"
pattern_string[12]="Type: Other --> RFC: Reserved for Future Use"

# =======================================
# User defined function ip_format_check()
# =======================================
function ip_format_check() {
  # Setting return value to NULL.
  local ret_val=""
  # Setting test pattern.
  local pattern="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"
  # Check given IP address string with given pattern.
  local check_result=$(echo "$1" | grep -E $pattern)
  # On successful check return IP address.
  if [ ! "$check_result" == "" ]; then
    ret_val=$check_result
  fi
  # Return result of IP address check.
  echo "$ret_val"
}

# =======================================
# User defined function ip_number_check()
# =======================================
function ip_number_check() {
  # Setting return value to NULL.
  local ret_val=""
  # Setting test pattern.
  local test_pattern="(^$nr_000_255d)($nr_000_255d)($nr_000_255d)($nr_000_255n)$"
  # Check given IP address string with given pattern.
  local check_result=$(echo "$1" | grep -E $test_pattern)
  # On successful check return IP address.
  if [ ! "$check_result" == "" ]; then
    ret_val=$check_result
  fi
  # Return result of IP address check.
  echo "$ret_val"
}

# ========================================
# User defined function ip_address_check()
# ========================================
function ip_address_check() {
  for i in `seq 0 11`; do
    check_result=$(echo "$1" | grep -E ${test_pattern[$i]})
    if [ ! "$check_result" == "" ]; then
      test=${pattern_string[$i]}
      printf "%s: %s --> %s" "Valid IP address" "$check_result" "$test"
    fi
  done
}

printf "Given IP address string: %s%b" "$ip2check" "\r\n\r\n"

test_level0=$(ip_format_check "$ip2check")
if [ ! "$test_level0" == "" ]; then
  test_level1=$(ip_number_check "$ip2check")
  if [ ! "$test_level1" == "" ]; then
    ip_address_check "$ip2check"
  else
    echo "No valid IP address numbering!"
  fi
else
  echo "No valid IP address format!"
fi

printf "%b" "\r\n\r\n"

# Exit script.
exit 0
