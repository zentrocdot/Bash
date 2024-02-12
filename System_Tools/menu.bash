#!/usr/bin/bash
#
# Menu demo and user as well as system info
# Version 0.0.0.1
#
# shellcheck disable=SC2034
# shellcheck disable=SC2312
# shellcheck disable=SC2154

# Run an infinite loop
while :
do
    # Clear the screen.
    clear
    # Print a menu to the screen.
    echo -e "==============================="
    echo -e "       M A I N   M E N U       "
    echo -e "===============================\n"
    echo -e "1. Display date and time"
    echo -e "2. Display the server name"
    echo -e "3. Display the user name"
    echo -e "4. Display the processes of user ${SUDO_USER}"
    echo -e "5. Display the current network connections (tcp)"
    echo -e "6. Display the current network connections (udp)"
    echo -e "7. Exit\n"
    # Get input from the user
    read -r -p "Enter your choice followed by [ENTER]: " choice
    # Make a decision using case .. in .. esac
    case "${choice}" in
	1) echo -e "\nDate and time of today: $(date)\n"
           read -r -p "Press [Enter] key to continue ..." read_key;;
	2) echo -e "\nServer name: $(hostname)\n"
           read -r -p "Press [Enter] key to continue ..." read_key;;
	3) echo -e "\nUser name: ${SUDO_USER}\n"
           read -r -p "Press [Enter] to continue ... " read_key;;
	4) echo -e ""; w -h; echo -e ""
           read -r -p "Press [Enter] to continue ... " read_key;;
	5) echo -e ""; netstat -natp; echo -e ""
	   read -r -p "Press [Enter] to continue ... " read_key;;
	6) echo -e ""; netstat -naup; echo -e ""
	   read -r -p "Press [Enter] to continue ... " read_key;;
	7) echo "Have a nice day. Bye!"
           exit 1;;
	*) echo "Invalid option ERROR ..."
           read -r -p "Press [Enter] to continue ... " read_key;;
    esac
done

# Exit the script.
exit 0
