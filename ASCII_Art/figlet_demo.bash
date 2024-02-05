#!/usr/bin/bash
#
# Figlet Demo
# Copyright © 2016-2024, Dr. Peter Netz
# Version 0.0.0.1

# loop over the installed fonts.
for font in `ls -1 /usr/share/figlet -w 80 | grep .flf | cut -d . -f 1`
do echo -e "$font:\n"
figlet -f $font Example Text; done

# Exit script.
exit 0
