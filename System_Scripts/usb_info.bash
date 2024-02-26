#!/usr/bin/bash

# ==============================================================================
# (c) 2017-2024, Dr. Peter Netz, All Rights Reserved.
# ==============================================================================

# 1. sudo tail -n 0 -f /var/log/syslog
# 2. Remove usb device
# 3. Connect usb device

# Reset terminal window.
reset

echo -e "\n\rLSUSB:\n\r"

lsusb

echo -e "\n\rLSPCI:\n\r"

lspci

echo -e "\n\rKernel:\n\r"

uname -r

echo -e "\n\rCompiler:\n\r"

# cat /proc/version

gcc --version |grep gcc

echo -e "\r"

# Exiting script.
exit 1
