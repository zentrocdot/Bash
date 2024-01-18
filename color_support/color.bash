#!/bin/env bash

# Ref.: http://misc.flogisoft.com/bash/tip_colors_and_formatting

# Clear screen.
clear
reset

# esc="\e"
# esc="\033"
esc="\x1B"

# Background colors.
bg_default="[49m"       # Default
bg_black="[40m"         # Black
bg_red="[41m"           # Red
bg_green="[42m"         # Green
bg_yellow="[43m"        # Yellow
bg_blue="[44m"          # Blue
bg_magenta="[45m"       # Magenta
bg_cyan="[46m"          # Cyan
bg_lightgray="[47m"     # Light Gray
bg_darkggray="[100m"    # Dark Gray
bg_lightred="[101m"     # Light Red
bg_lightgreen="[102m"   # Light Green
bg_lightyellow="[103m"  # Light Yellow
bg_lightblue="[104m"    # Light Blue
bg_lightmagenta="[105m" # Light Magenta
bg_lightcyan="[106m"    # Light Cyan
bg_white="[107m"        # White

# Foreground colors.
fg_default="[39m"       # Default
fg_black="[30m"         # Black
fg_red="[31m"           # Red
fg_green="[32m"         # Green
fg_yellow="[33m"        # Yellow
fg_blue="[34m"          # Blue
fg_magenta="[35m"       # Magenta
fg_cyan="[36m"          # Cyan
fg_lightgray="[37m"     # Light Gray
fg_darkggray="[90m"     # Dark Gray
fg_lightred="[91m"      # Light Red
fg_lightgreen="[92m"    # Light Green
fg_lightyellow="[93m"   # Light Yellow
fg_lightblue="[94m"     # Light Blue
fg_lightmagenta="[95m"  # Light Magenta
fg_lightcyan="[96m"     # Light Cyan
fg_white="[97m"         # White

# Reset attributes.
color_reset="[0m"

color0="${esc}${fg_lightred}${esc}${bg_black}"
color1="${esc}${color_reset}"
#
#echo -e "${color0}Hello World!${color1}"

#for i in {16..21} {21..16} ; do
#    echo -en "\e[38;5;${i}m#\e[0m" ;
#done

#Background
for clbg in {40..47} {100..107} 49 ; do
	#Foreground

    echo "Default      Bold        Dim        Underline    Blink      Reverse"

	for clfg in {30..37} {90..97} 39 ; do
		#Formatting



		for attr in 0 1 2 4 5 7 ; do
			#Print the result
			echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
		done
		echo #Newline
	done
done

# 256 colors
#for fgbg in 38  48 ; do # Foreground/Background
#	for color in {0..256} ; do # Colors
#		#Display the color
#		echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
#		# Display 8 colors per line.
#		if [ $((($color + 1) % 9 )) == 0 ] ; then
#			echo # New line
#		fi
#	done
#	echo # New line
#done

exit 0

