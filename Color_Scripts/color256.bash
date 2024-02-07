#!/usr/bin/bash
#
# version 0.0.0.1

# Reset the screen.
reset

# Loop over the foreground and the background color.
for fgbg in 38 48
do
    # Loop over 256 colors.
    for color in {0..255}
    do
        # Display a color and print the number of the color..
  	echo -en "\e[${fgbg};5;${color}m ${color} \e[0m\t"
        # Display 10 colors per lines
        if [ $((($color + 1) % 10)) == 0 ]
        then
            # Add a newline.
    	    echo -e "\r"
    	fi
    done
    # Add a newline.
    echo -e "\n"
done

# exit the script
exit 0


