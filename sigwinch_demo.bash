#!/bin/bash

function get_window_size() {
    _WINDOW_X=$(tput lines)
    _WINDOW_Y=$(tput cols)
    echo -e "X: ${_WINDOW_X}"
    echo -e "Y: ${_WINDOW_Y}"
    return 0
}

# trap when a user has resized the window
trap 'get_window_size' SIGWINCH

reset

echo "Change the size of this window."
echo "Press CTRL+C to leave the demo."

while true
do
    :
done

#while read ALINE
#do
#        echo "Read: '$ALINE'"
#done

exit 0
