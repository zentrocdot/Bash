#!/usr/bin/bash
#
# Install GIMP
# Version 0.0.0.1
#
# References:
# www.gimp.org/
# gmic.eu/
#
# See also:
# github.com/LinuxBeaver/LinuxBeaver
# www.pcworld.com/article/398307/7-free-gimp-scripts-and-plug-ins-for-filters-brushes-textures-and-more.html

PKG="flatpak"

dpkg -s "${PKG}" 2>/dev/null 1>&2
exit_code=$?

if [[ "${exit_code}" -ne 0 ]]; then
    echo -e "Flatpack is NOT installed. Bye!"
fi

if [[ "$EUID" = 0 ]]; then
    echo -e "You are root. Okay!"
else
    sudo -k
    if sudo true; then
        echo "Correct password given. Okay!"
    else
        echo "Wrong password given. Bye!"
        exit 1
    fi
fi

echo -e "\n# *******************"
echo -e "# Try to install GIMP"
echo -e "# *******************\n"

flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref

if [[ $? -ne 0 ]]; then
    echo -e "\nNo installation done ..."
fi

echo -e "\n# ********************"
echo -e "# Try to install G'MIC"
echo -e "# ********************\n"

flatpak install flathub org.gimp.GIMP.Plugin.GMic

if [[ $? -ne 0 ]]; then
    echo -e "\nNo installation done ..."
else
    echo -e "\nInstallation okay ..."
fi

exit 0
