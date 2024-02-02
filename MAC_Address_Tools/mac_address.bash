#/usr/bin/bash

STR="mac 28:EF:52:01:EB:84 address"

echo "${STR}" | sed -n -E 's/.*[[:blank:]](([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}[[:blank:]]).*/\1/p'

echo "${STR}" | sed -n 's/.*[[:blank:]]\(\([[:xdigit:]]\{2\}:\)\{5\}[[:xdigit:]]\{2\}[[:blank:]]\).*/\1/p'

exit 0
