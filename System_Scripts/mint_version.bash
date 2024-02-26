#!/usr/bin/bash
# LSB = Linux Standard Base

echo -e "Debian version:"
cat /etc/debian_version

echo -e "\nMint version (long):"
cat /etc/os-release

echo -e "\nMint version (short):"
cat /etc/lsb-release

echo -e "\nMint release info:"
lsb_release -a 2> /dev/null
