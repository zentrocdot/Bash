#!/bin/bash
# (c) 2022, Dr. Peter Netz

for i in *.svg; do
    [ -f "$i" ] || break
    echo "$i"
    #exiftool -all= "$i"
    base=${i%.*}
    ext=${i#$base.}
    #echo $base
    #echo $ext
    #md5hash=$(printf '%s' "$i" | md5sum | awk '{print $1}')
    #md5hash=$(md5sum $i | awk '{print $1}')
    #echo $md5hash
    #cairosvg $i -f PNG -d 300  -o "$base.png"
    #inkscape --without-gui $i -w 600 -h 600 --export-png="$base.png"
    inkscape --without-gui $i --export-background=000000FF --export-dpi=300 --export-png="$base.png"
    #newfn="$md5hash.$ext"
    #echo $newfn
    #mv -n $i $newfn 2>/dev/null
done

# Exit without error.
exit 0
