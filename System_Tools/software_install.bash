#!/usr/bin/bash
#
# Basic software installation
# version 0.0.1.1
#
# www.google.com/search?client=firefox-b-lm&q=flogisoft
# itsfoss.com/install-microsoft-fonts-ubuntu/
# snapcraft.io/docs/installing-snap-on-linux-mint
#
# sudo add-apt-repository ppa:libreoffice/ppa
# sudo add-apt-repository ppa:team-xbmc/ppa
#
# echo "imagemagick hold" | dpkg --set-selections
# dpkg --get-selections imagemagick
# echo "imagemagick install" | dpkg --set-selections

# Define the package arrays.
pkg_install=("snapd" "flatpak" "gnome-software-plugin-flatpak" "python3-pip" "python3-setuptools" "npm")
pkg_audio=("espeak" "sox")
pkg_webcam=("cheese" "guvcview")
pkg_photo=("gimp" "rawtherapee" "fim")
pkg_graphic=("inkscape" "pdf2svg" "img2pdf" "exif" "converseen" "imagemagick" "libltdl-dev")
pkg_cad=("librecad")
pkg_video=("smplayer" "vlc" "mplayer" "mpv" "kazam" "simplescreenrecorder")
pkg_multimedia=("kodi" "ffmpeg")
pkg_ripper=("lame" "vorbis-tools" "libopus0" "opus-tools" "flac" "asunder" "ripperx")
pkg_pdf=("evince" "okular" "qpdfview" "ghostscript" "gv" "mupdf" "lyx")
pkg_md=("retext" "pandoc" "texlive-latex-base" "texlive-fonts-recommended" "texlive-extra-utils" "texlive-latex-extra" "texlive-xetex")
pkg_qr=("qrencode" "qtqr" "qreator" "barcode" "zbar-tools")
pkg_gnuplot=("gnuplot" "gnuplot-x11" "gnuplot-doc")
pkg_scan=("simple-scan" "gscan2pdf" "tesseract-ocr" "tesseract-ocr-deu" "lios")
pkg_filemanager=("pluma" "nautilus" "nemo" "mc")
pkg_editor=("gedit" "nano" "vim")
pkg_hexeditor=("bless" "ghex" "xxd" "hexedit")
pkg_htmleditor=("bluefish")
pkg_math=("bc" "geogebra" "scilab")
pkg_terminal=("gnome-terminal" "xterm" "roxterm")
pkg_browser=("firefox" "chromium-browser" "epiphany-browser")
pkg_internet=("filezilla" "ftp" "telnet" "traceroute")
pkg_anonymity=("tor" "tor-geoipdb" "torsocks" "proxychains" "proxychains4")
pkg_network=("fping" "etherape" "tshark" "nmap" "tcpdump" "mtr" "wavemon")
pkg_office=("libreoffice" "libreoffice-l10n-de" "scribus" "calibre")
pkg_system=("gparted" "parted" "gnome-disk-utility" "samba" "brasero" "resolvconf")
pkg_recovery=("testdisk" "gddrescue" "smartmontools")
pkg_tools=("htop" "f3" "tree" "pv" "xdotool")
pkg_webserver=("apache2" "php" "php-fpm" "php-cgi" "php-cli" "php-imagick")
pkg_programming=("ruby" "perl" "python3" "git" "tcl" "tk" "fp-compiler" "fp-ide")
pkg_security=("fail2ban" "openssl" "hydra" "aircrack-ng" "macchanger" "gtkhash")
pkg_linux=("neofetch" "linuxlogo")
pkg_asciiart=("figlet" "boxes" "toilet" "lolcat" "asciiart" "jp2a" "cowsay" "aewan")
pkg_fun=("sl" "cbonsai" "cmatrix")
pkg_support=("software-properties-common" "build-essential")
pkg_pack=("p7zip-full" "gzip" "unzip" "bzip2")
pkg_linter=("shellcheck" "pylint")
pkg_gnome=("language-pack-gnome-de")
pkg_user_interaction=("ttf-mscorefonts-installer" "wireshark")
pkg_misc=("jq" "x11-utils" "python3-rpy2" "gnome-language-selector")  # python3-rpy2 is required for SageMath

# Merge all previous defined arrays.
pkg_array=("${pkg_install[@]}" "${pkg_audio[@]}" "${pkg_webcam[@]}"
           "${pkg_photo[@]}" "${pkg_graphic[@]}" "${pkg_cad[@]}"
           "${pkg_video[@]}" "${pkg_multimedia[@]}" "${pkg_ripper[@]}"
           "${pkg_pdf[@]}" "${pkg_md[@]}" "${pkg_qr[@]}" "${pkg_gnuplot[@]}"
           "${pkg_scan[@]}" "${pkg_filemanager[@]}" "${pkg_editor[@]}"
           "${pkg_hexeditor[@]}" "${pkg_htmleditor[@]}" "${pkg_math[@]}"
           "${pkg_terminal[@]}" "${pkg_browser[@]}" "${pkg_internet[@]}"
           "${pkg_anonymity[@]}" "${pkg_network[@]}" "${pkg_fonts[@]}"
           "${pkg_office[@]}" "${pkg_system[@]}" "${pkg_recovery[@]}"
           "${pkg_tools[@]}" "${pkg_webserver[@]}" "${pkg_programming[@]}"
           "${pkg_security[@]}" "${pkg_linux[@]}" "${pkg_asciiart[@]}"
           "${pkg_fun[@]}" "${pkg_support[@]}" "${pkg_pack[@]}"
           "${pkg_linter[@]}" "${pkg_gnome[@]}" "${pkg_misc[@]}"
           "${pkg_user_interaction[@]}")

# Set the error array.
err_arr=()

# ************************************
# Create a string from a repeated char
# ************************************
repchr() {
    for chr in {1..80}
    do
        echo -n "$1"
    done
}

# **************************************
# Create an empty string of given length
# **************************************
spcstr() {
    for i in $(eval echo {1..$1})
    do
        echo -n " "
    done
}

# ***************************************
# Print a header into the terminal window
# ***************************************
header() {
    pkg=$1
    txtstr="Installation of package:"
    pkglen=${#pkg}
    bline=$(repchr "*")
    spclen=$((80-25-pkglen))
    spcstr=$(spcstr ${spclen})
    echo -e "\e[44m${bline}\e[49m"
    echo -e "\e[44m${txtstr} ${pkg}${spcstr}\e[49m"
    echo -e "\e[44m${bline}\e[49m"
}

# *********************************
# Function installation of packages
# *********************************
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
            err_arr+=("${pkg}")
        fi
        echo -e "\r"
    done
}

# ***********************************
# Function print failed installations
# ***********************************
print_missing() {
    echo -e "Failed installation:"
    echo -e "--------------------\n"
    if (( ${#err_arr[@]} == 0 )); then
        echo -e "NONE"
    else
        for pkg in "${err_arr[@]}"
        do
            echo -e "${pkg}"
        done
    fi
}

# Run the main functions.
pkg_install
print_missing

# Exit the script.
exit 0
