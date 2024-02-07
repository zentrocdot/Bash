#!/bin/bash

reset

# Background
for clbg in {40..47} {100..107} 49 ; do
    # Foreground
    for clfg in {30..37} {90..97} 39 ; do
	# Formatting using attributes.
	for attr in 0 1 2 4 5 7 ; do
            # Print the result to screen.
	    echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
	done
        # New line
        echo -e "\r"
    done
done

# Loop over foreground and background.
for fgbg in 38 48 ; do
    for color in {0..256} ; do #Colors
	# Display the color and number.
	echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
	# Display 10 colors per lines.
	if [ $((($color + 1) % 10)) == 0 ] ; then
            # New line
            echo -e "\r"
	fi
    done
    # New line
    echo -e "\r"
done
