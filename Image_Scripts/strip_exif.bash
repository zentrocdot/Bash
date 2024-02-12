#!/bin/bash
# (c) 2022, Dr. Peter Netz

# Clear screen.
clear

# Collect graphic files of given type.
files=$(ls *.{jpeg,JPEG,jpg,JPG,png,PNG,gif,GIF} 2>/dev/null)

# Loop over list of graphic files.
for i in $files ; do
    # Check if file exists.
    [ -f "$i" ] || break
    # Print filename to screen.
    echo $i
    # Get basename and extension.
    base=${i%.*}
    ext=${i#$base.}
    # Remove all exif data.
    exiftool -all= "$i"
    # Calculate the md5 hash.
    md5hash=$(md5sum $i | awk '{print $1}')
    # Assemble new file name.
    newfn="$md5hash.$ext"
    # Print new filename to screen.
    echo $newfn
    # Move file.
    mv -n $i $newfn 2>/dev/null
    echo -e "\r"
done

# Exit without error.
exit 0
