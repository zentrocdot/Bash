#!/usr/bin/bash
#
# Basic software installation
# version 0.0.0.1
#
# www.google.com/search?client=firefox-b-lm&q=flogisoft
# itsfoss.com/install-microsoft-fonts-ubuntu/
# snapcraft.io/docs/installing-snap-on-linux-mint

# Define the package arrays.
pkg_installation=("snapd" "flatpak")
pkg_audio=("espeak")
pkg_graphic=("inkscape" "gimp" "rawtherapee" "librecad" "imagemagick" "pdf2svg")
pkg_video=("smplayer" "vlc" "mplayer")
pkg_multimedia=("ffmpeg" "kodi")
pkg_scan=("simple-scan" "gscan2pdf")
pkg_pdf=("evince")
pkg_filemanager=("pluma" "nautilus" "nemo" "mc")
pkg_editor=("gedit" "nano")
pkg_hexeditor=("bless" "ghex" "xxd" "hexedit")
pkg_html=("bluefish")
pkg_math=("bc" "gnuplot" "geogebra")
pkg_terminal=("gnome-terminal" "xterm")
pkg_internet=("apache2" "fping")
pkg_browser=("firefox" "chromium-browser" "epiphany-browser")
pkg_tor=("tor" "tor-geoipdb" "torsocks")
pkg_network=("etherape" "wireshark" "nmap" "tcpdump" "mtr")
pkg_tools=("htop")
pkg_fonts=("ttf-mscorefonts-installer")
pkg_office=("libreoffice")
pkg_recovery=("testdisk" "openssl")
pkg_linux=("neofetch" "linuxlogo")
pkg_support=("software-properties-common")
pkg_system=("gparted" "gnome-disk-utility")
pkg_asciiart=("figlet" "toilet" "lolcat" "asciiart" "jp2a" "cowsay" "aewan")
pkg_fun=("sl" "cbonsai" "cmatrix")
pkg_prog=("perl" "python3")
pkg_qr=("qrencode" "qtqr" "qreator")
pkg_misc=("f3" "p7zip-full" "fail2ban" "pv")

# Merge all previous defined arrays.
pkg_array=("${pkg_installation[@]}" "${pkg_audio[@]}" "${pkg_graphic[@]}"
           "${pkg_video[@]}" "${pkg_multimedia[@]}" "${pkg_scan[@]}"
           "${pkg_pdf[@]}" "${pkg_filemanager[@]}" "${pkg_editor[@]}"
           "${pkg_hexeditor[@]}" "${pkg_html[@]}" "${pkg_math[@]}"
           "${pkg_terminal[@]}" "${pkg_internet[@]}" "${pkg_browser[@]}"
           "${pkg_tor[@]}" "${pkg_network[@]}" "${pkg_tools[@]}"
           "${pkg_fonts[@]}" "${pkg_office[@]}" "${pkg_recovery[@]}"
           "${pkg_linux[@]}" "${pkg_support[@]}" "${pkg_system[@]}"
           "${pkg_asciiart[@]}" "${pkg_fun[@]}" "${pkg_prog[@]}"
           "${pkg_qr[@]}" "${pkg_misc[@]}")

# Create a string from a repeated char.
repeat() {
    for chr in {1..80}; do echo -n "$1"; done
}

# Create an empty string of given length.
spcstr() {
    for i in $(eval echo {1..$1}); do echo -n " "; done
}

# Print a header into the terminal window.
header() {
    pkg=$1
    txtstr="Installation of package:"
    pkglen=${#pkg}
    bline=$(repeat "*")
    spclen=$((80-25-${pkglen}))
    spcstr=$(spcstr ${spclen})
    echo -e "\e[44m${bline}\e[49m"
    echo -e "\e[44m${txtstr} ${pkg}${spcstr}\e[49m"
    echo -e "\e[44m${bline}\e[49m"
}

# Function for installation of packages.
pkg_install() {
    msgstr1="ERROR"
    txtstr="Return code:"
    msgstr0="SUCCESS"
    # Run an loop over the array.
    for pkg in "${pkg_array[@]}"
    do
        header "${pkg}"
        apt-get install -y "${pkg}"
        retval=$?
        if [ ${retval} -eq 0 ]; then
            echo -e "\e[42m${txtstr} ${retval}: ${msgstr0}\e[49m"
        else
            echo -e "\e[41m${txtstr} ${retval}: ${msgstr1}\e[49m"
        fi
        echo -e "\r"
    done
}

# Run main function.
pkg_install
