#!/usr/bin/bash
#
# Install GIMP
# Version 0.0.0.2
#
# References:
# www.gimp.org/
# gmic.eu/
#
# See also:
# github.com/LinuxBeaver/LinuxBeaver
# www.pcworld.com/article/398307/7-free-gimp-scripts-and-plug-ins-for-filters-brushes-textures-and-more.html

# Set the package name to check.
PKG="flatpak"

# Check if the package is installed.
dpkg -s "${PKG}" 2>/dev/null 1>&2
exit_code=$?

# Leave script if package is not installed.
if [[ "${exit_code}" -ne 0 ]]; then
    echo -e "Flatpack is NOT installed. Bye!"
fi

# Check if script is executed as root.
if [[ "$EUID" = 0 ]]; then
    echo -e "You are root. Okay!"
else
    sudo -k
    if sudo true; then
        echo -e "Correct password given. Okay!"
    else
        echo - e"Wrong password given. Bye!"
        exit 1
    fi
fi

# Write a message into the terminal window.
echo -e "\n# *******************"
echo -e "# Try to install GIMP"
echo -e "# *******************\n"

flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref

# If the installations fails, write a message.
if [[ $? -ne 0 ]]; then
    echo -e "\nNo installation done ..."
fi

# Write a message into the terminal window.
echo -e "\n# ********************"
echo -e "# Try to install G'MIC"
echo -e "# ********************\n"

flatpak install flathub org.gimp.GIMP.Plugin.GMic

# Write a message based on the exit code.
if [[ $? -ne 0 ]]; then
    echo -e "\nNo installation done ..."
else
    echo -e "\nInstallation okay ..."
fi

# Exit the script.
exit 0
