#!/usr/bin/bash
#
# Disassemble the full path of a file

# Assign the command line argument to the global variable.
FP=${1:-/tmp/files/graphics/example_image.jpeg}

# Disassemble the full path of a file.
dirpath=${FP%/*}
basename=${FP##*/}
name=${basename%.*}
ext=${basename#*.}

# Print the summery of the operation.
printf "%-15s\x20%s%b" "Path:" "${dirpath}/" "\n"
printf "%-15s\x20%s%b" "Basename:" "${basename}" "\n"
printf "%-15s\x20%s%b" "File name:" "${name}" "\n"
printf "%-15s\x20%s%b" "File extension:" "${ext}" "\n"

# Exit script.
exit 0
