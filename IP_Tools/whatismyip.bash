#!/usr/bin/bash
#
# Using curl together with an API url the IP of your own computer can be
# determined.
#
# List of some API urls:
# API_URL="api.ipify.org"
# API_URL="checkip.amazonaws.com"
# API_URL="icanhazip.com"
# API_URL="ifconfig.co"
# API_URL="ifconfig.me"
#
# Before using one of the listed services, read the 
# rules that apply to the respective service.

# Set API url.
API_URL="api.ipify.org"

# Get my IP address.
MY_IP=$(curl -s "${API_URL}")

# Print IP address.
echo "${MY_IP}"

# Exit script without error.
exit 0
