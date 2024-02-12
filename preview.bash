#!/usr/bin/bash
#
# Create thumbnail from jpg images.

mkdir THUMB 2> /dev/null

for f in *.jpg
do
    convert -define jpeg:size=600x600 "${f}" -thumbnail '600x600>' -background azure \
            -pointsize 14 -fill white -annotate +30+30 'preview of original image'
            -gravity center -extent 600x600 "THUMB/${f%.*}_thump.jpg"
done

exit 0

