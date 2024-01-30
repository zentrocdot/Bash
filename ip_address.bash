#/usr/bin/bash

STR="inet 192.168.172.1 net"

echo "${STR}" | sed -n -E 's/.*[[:blank:]]([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})[[:blank:]].*/\1/p'

echo "${STR}" | sed -n 's/.*[[:blank:]]\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)[[:blank:]].*/\1/p'

STR="net 77.250.36.22 inet"

echo "${STR}" | sed -n -E 's/.*[[:blank:]](([0-9]{1,3}\.){3}[0-9]{1,3})[[:blank:]].*/\1/p'

echo "${STR}" | sed -n 's/.*[[:blank:]]\(\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}\)[[:blank:]].*/\1/p'

STR="mac 28:EF:52:01:EB:84 address"

echo "${STR}" | sed -n -E 's/.*[[:blank:]](([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}[[:blank:]]).*/\1/p'

echo "${STR}" | sed -n 's/.*[[:blank:]]\(\([[:xdigit:]]\{2\}:\)\{5\}[[:xdigit:]]\{2\}[[:blank:]]\).*/\1/p'

exit 0
