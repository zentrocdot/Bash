#!/usr/bin/bash
#
# Add copyright:
# exiftool -IPTC:CopyrightNotice="Copyright (c) <year>, <author>" male_cat.jpg

FN=$1

AUTHOR=${2:-Unknown Artist}

exiftool -artist="${AUTHOR}" $FN
