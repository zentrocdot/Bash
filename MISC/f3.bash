#!/bin/bash

# ########################
# (c) 2016, Dr. Peter Netz
# ########################

# Clear terminal window.
clear

# Setting standard esc color sequences.
R_COL='\E[41m' # Red
G_COL='\E[42m' # Green
Y_COL='\E[43m' # Yello
B_COL='\E[44m' # Blue
M_COL='\E[45m' # Magenta
C_COL='\E[46m' # Cyan
NOCOL='\E[0m'  # No Color

# Setting locale environment variable.
LC_NUMERIC=C

# Check if script was started as root.
if [ "$(id -u)" != "0" ]; then
    echo "Sorry, you have no root rights!"
    exit 1
fi

# Check logon and permission.
whor=`whoami`
whol=`who |awk '{print $1}'`

# Write logon and permission into terminal window.
echo -e "Logon: "$whol
echo -e "Permission: "$whor"\n\r"

devsize=$(echo "scale=32; 32*(1000^3)" | bc)
result0=$(echo "scale=2; $devsize/(1024^3)" | bc)
echo -e "Correct size: "$result0" GB"

devsize=`blockdev --getsize64 /dev/sdb`
result1=$(echo "scale=2; $devsize/(8^10)" | bc)
echo -e "Real size:    "$result1" GB\n\r"

result=$(echo "scale=2; $result0-$result1" | bc)
printf "%s%.2f%s\n\n\r" "Difference:    " $result " GB"

# User defined function f3info.
f3info() {
    nbs="\u00A0"
    pre="f3: command is"
    post1="installed"
    post2="NOT installed"
    pmsg=$pre$nbs$post1
    nmsg=$pre$nbs$post2
    if hash f3write 2>/dev/null && hash f3read 2>/dev/null; then
        f3ver=`dpkg -l f3 | grep -E "^ii" | tr -s ' ' | cut -d' ' -f3`
        str="f3: version" 
        echo -e $pmsg
        echo -e $str$nbs$f3ver
        dpkg -S $(which f3write)
        dpkg -S $(which f3read)
    else
        echo -e $nmsg
        exit 1
    fi
}

# Call user defined function f3inf0.
f3info

# Write comments into terminal window.
echo -e "\r\nThe device must be totally empty before the command f3 can be applied.\n\r"
echo -e "A) Display and manipulate the disk partition table."
echo -e "B) Build the MS-DOS filesystem."
echo -e "C) Check and repair the MS-DOS filesystem."
echo -e "\r\nInterrupt the execution of the script with [CTRL+C]."

# Write empty line into terminal window.
echo -e "\n\rFile system disk space usage:"
echo -e "=============================\n\r"

# Write the info about the file system into the terminal window.
df -T -h

# Read the letter of the device from the keyboard.
echo -en "\n\rInput the letter of the device [a,b,c...z]:"
read dl

# Assemble device file path.
basepath="/dev/sd"
filepath=$basepath$dl

# Store device file in variable.
path1=`df -T |grep $filepath |awk '{print $1}'`
echo -e "\r\nDevice file: "$path1

# Store mount point in variable.
path7=`df -T |grep $filepath |awk '{print $7}'`
echo -e "\rMount point: "$path7

# Setting search pattern.
searchpattern="/media/"

# Look for search pattern.
if [[ ! $path7 == *$searchpattern* ]]
then
  echo -e "\n\rNot allowed.\n\rBye.\n\r";
  exit 1
fi

# Try to unmount device file.
sudo umount $path1
status=$?

# Check exit status.
if [ "$status" -eq 0 ]; then
    echo -e "\n\r"$G_COL"Device successfully unmounted."$NOCOL
else
    echo -e "\n\rError occurred.\n\rBye.\n\r";
    exit 1
fi

# Query user input.
echo -en "\n\rExecute the command cfdisk?\n\r[y]es or [n]o:"
read ui

# Execute the command cfdisk when the variable answer is equal y.
if [ "$ui" = "y" ]; then
    sudo cfdisk $path1
elif [ "$ui" = "n" ]; then
    echo -e "\n\r"$C_COL"The execution of cfdisk is skipped."$NOCOL
else
    echo -e "\n\rWrong input.\n\rBye.\n\r"
    exit 1
fi

# Query user input.
echo -en "\n\rExecute the command mkfs?\n\r[y]es or [n]o:"
read ui

# Execute the command cfdisk when the variable answer is equal y.
if [ "$ui" = "y" ]; then
    sudo mkfs --verbose -t vfat $path1
elif [ "$ui" = "n" ]; then
    echo -e "\n\r"$C_COL"The execution of mkfs is skipped."$NOCOL
else
    echo -e "\n\rWrong input.\n\rBye.\n\r"
    exit 1
fi

# Query user input.
echo -en "\n\rExecute the command dosfsck?\n\r[y]es or [n]o:"
read ui

# Execute the command dosfsck when the variable answer is equal y.
if [ "$ui" = "y" ]; then
    sudo dosfsck -t -a -w -v $path1
elif [ "$ui" = "n" ]; then
    echo -e "\n\r"$C_COL"The execution of dosfsck is skipped."$NOCOL
else
    echo -e "\n\rWrong input.\n\rBye.\n\r"
    exit 1
fi

# Get the label of device.
label=`ls -l /dev/disk/by-uuid/ | grep sdb |awk '{print $9}'`

devpath="/media/"$whol"/"$label

sudo mkdir $devpath > /dev/null 2>&1
# sudo mkdir $devpath
status=$?

# Check exit status.
if [ "$status" -eq 0 ]; then
    echo -e "\n\r"$G_COL"Directory successfully created."$NOCOL
else
    echo -e "\n\r"$R_COL"Directory NOT created."$NOCOL
fi

# Mount device file.
sudo mount -v -t vfat $path1 $devpath > /dev/null 2>&1
# sudo mount -v -t vfat $path1 $devpath
status=$?

# Check exit status.
if [ "$status" -eq 0 ]; then
    echo -e "\n\r"$G_COL"Device successfully mounted."$NOCOL
else
    echo -e "\n\r"$R_COL"Device NOT mounted."$NOCOL
fi

# Query user input.
echo -en "\n\rExecute command f3?\n\r[y]es or [n]o:"
read ui

# Execute the command f3 when the variable answer is equal y.
if [ "$ui" = "y" ]; then
    sudo f3write $devpath

    sync

    echo -e "\r"
    sudo f3read $devpath

    sync

elif [ "$ui" = "n" ]; then
    echo -e "\n\r"$C_COL"The execution of f3 is skipped."$NOCOL
else
    echo -e "\n\rWrong input.\n\rBye.\n\r"
    exit 1
fi

# Change directory.
echo -e "\n\rDirectory path:"
cd $devpath

pwd

echo -e "\n\rDirectory content:"
ls 

# Write empty line into terminal window.
echo -e "\r"

echo -e "Remove existing files:"
rm -I *.*

# End of script.
echo -e "\n\rScript successfully finished."
