#!/usr/bin/bash
# shellcheck disable=SC2312
#
# Identify Magic Numbers
# Version 0.0.0.2
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
# Vesion 0.0.0.1
#
# Collection of magic numbers:
# AI           -> 25 50 44 46             -> Adobe Illustrator
# ARJ          -> 60 EA                   -> arj file format
# AVI          -> 52 49 46 46             -> Audio Video Interleave
# BMP          -> 42 4D                   -> Bitmap graphic
# BZ2          -> 42 5A 68                -> Bzip2 compressed file
# CAB          -> 4D 53 43 46             -> Microsoft Cabinet
# CDR          -> 45 52 02 00 00 00       -> Disc image
# CDR          -> 45 52 02 00 00 70       -> Disc image
# CDR          -> 52 49 46 46             -> Corel Draw
# DEB          -> 21 3C 61 72 63 68 3E 0A -> Linux deb file
# DMG          -> 6B 6F 6C 79             -> Apple Disk Image
# DOC/XLS      -> D0 CF 11 E0 A1 B1 1A E1 -> Word Document, Excel Document, Office Doc
# DOCX         -> 50 4B 03 04             -> Office 2010
# DRW          -> 01 FF 02 04 03 02       -> Micrografx vector graphic file
# DWG          -> 41 43                   -> Generic AutoCAD drawing file
# EXE          -> 4D 5A                   -> DOS MZ executable
# EXE          -> 5A 4D                   -> DOS ZM executable
# FLV          -> 46 4C 56                -> Flash Video file
# GIF          -> 47 49 46 38 37 61       -> GIF87a / Graphics Interchange Format
# GIF          -> 47 49 46 38 39 61       -> GIF89a / Graphics Interchange Format
# GZIP         -> 1F 8B                   -> GZIP compressed file
# ICO          -> 00 00 01 00             -> Computer icon encoded in ICO file format
# IMG          -> 51 46 49 FB             -> Disk image file
# JPE/JPG/JPEG -> FF D8 FF E0 00 10 4A 46 -> Joint Photographic Experts Group
# JPG/JPEG     -> FF D8 FF E1 87 90 45 78 -> Joint Photographic Experts Group
# JPG/JPEG     -> 45 78 69 66 00          -> Joint Photographic Experts Group
# JPG/JPEG     -> 49 46 00 01	          -> Joint Photographic Experts Group
# JPG/JPEG     -> FF D8 FF EE             -> Joint Photographic Experts Group
# JPG/JPEG     -> FF D8 FF E0             -> Joint Photographic Experts Group
# JPG/JPEG     -> 69 66 00 00             -> Joint Photographic Experts Group
# LWP          -> 57 6F 72 64 50 72 6F    -> Lotus word processor
# LZH          -> 2D 68 6C 30 2D          -> Lempel Ziv Huffman archive file
# LZH          -> 2D 68 6C 35 2D          -> Lempel Ziv Huffman archive file
# MID/MIDI     -> 4D 54 68 64             -> Midi sound file
# MOV          -> 6D 6F 6F 76             -> MOV video file
# MPG/MPEG     -> 00 00 01 BA             -> MPEG
# MP3          -> 49 44 33                -> MPEG-1 Layer 3
# MP4          -> 66 74 79 70 69 73 6F 6D -> MPEG-4
# MP4          -> 66 74 79 70 4D 53 4E 56 -> MPEG-4
# ORC          -> 4F 52 43	          -> Apache ORC (Optimized Row Columnar) file format
# OTF          -> 4F 54 54 4F             -> OpenType font
# PCX          -> 0A 00 01                -> ZSOFT Paintbrush file
# PCX          -> 0A 02 01                -> ZSOFT Paintbrush file
# PCX          -> 0A 03 01                -> ZSOFT Paintbrush file
# PCX          -> 0A 04 01                -> ZSOFT Paintbrush file
# PCX          -> 0A 05 01                -> ZSOFT Paintbrush file
# PDF          -> 25 50 44 46             -> Portable Document Format
# PNG          -> 89 50 4E 47 0D 0A 1A 0A -> Portable Network Graphic
# PS           -> 25 21 50 53             -> PostScript document
# PSD          -> 38 42 50 53             -> Adobe Photoshop
# RTF          -> 7B 5C 72 74 66 31       -> Rich Text Format
# SWF          -> 43 57 53                -> Adobe Flash
# SWF          -> 46 57 53                -> Adobe Flash
# TIF/TIFF     -> 49 20 49                -> Tag(ged) Image File Format
# TIF/TIFF     -> 49 49 2A 00             -> Tag(ged) Image File Format
# TIF/TIFF     -> 4D 4D 00 2B             -> Tag(ged) Image File Format
# TTF          -> 00 01 00 00 00          -> Tag(ged) Image File Format
# WMF	       -> D7 CD C6 9A             -> Windows Meta File
# XCF          -> 67 69 6D 70 20 78 63 66 -> Gimp xcf file
# ZIP          -> 50 4B 03 04             -> Zip file
# 7Z           -> 37 7A BC AF 27 1C       -> 7-Zip File Format
#
# SCRIPT       -> 23 21
#
# XPM          -> 2F 2A 20 58 50 4D 20 2A 2F
#
# CR2          ->  49 49 2A 00 10 00 00 00 43 52
#
# JPEG 2000    ->  00 00 00 0C 6A 50 20 20 0D 0A 87 0A
# JPEG 2000    ->  FF 4F FF 51
#
# See also:
# asecuritysite.com/forensics/magic
# de.wikipedia.org/wiki/Magische_Zahl_(Informatik)
# en.wikipedia.org/wiki/List_of_file_signatures
# en.wikipedia.org/wiki/List_of_file_formats
# en.wikipedia.org/wiki/Magic_number_(programming)
# gist.github.com/leommoore/f9e57ba2aa4bf197ebc5
# www.garykessler.net/library/file_sigs.html
# www.garykessler.net/library/magic.html

# Get the file name from the command line argument.
FN=$1

# Declare the magic numbers dictionary.
declare -A magic_numbers=()

# Define the magic numbers dictionary.
magic_numbers=(["25504446"]="AI"
               ["424D"]="BMP"
               ["474946383761"]="GIF"
               ["474946383961"]="GIF"
               ["00000100"]="ICO"
               ["49460001"]="JPG/JPEG"
               ["69660000"]="JPG/JPEG"
               ["FFD8FFE0"]="JPG/JPEG"
               ["FFD8FFEE"]="JPG/JPEG"
               ["4578696600"]="JPG/JPEG"
               ["FFD8FFE187904578"]="JPG/JPEG"
               ["FFD8FFE000104A46"]="JPE/JPG/JPEG"
               ["0A0201"]="PCX"
               ["0A0301"]="PCX"
               ["0A0401"]="PCX"
               ["0A0501"]="PCX"
               ["89504E470D0A1A0A"]="PNG"
               ["492049"]="TIF/TIFF"
               ["49492A00"]="TIF/TIFF"
               ["4D4D002B"]="TIF/TIFF"
               ["67696D7020786366"]="XCF"
               ["504B0304"]="ZIP")

# Set the number of octets to read
OCTET=16

# Set the flag if magic number is known.
IS_IN_DICT=false

# Get the file extension.
EXT="${FN#*.}"
EXT=${EXT^^}
echo -e "File extension found: ${EXT}"

# Extract the first interesting octets from file.
hex=$(xxd -g 0 -l "${OCTET}" "${FN}" 2> /dev/null | awk -F " " '{print $2}')
hex=${hex^^}
printf "%s\n" "Extracted hex number: ${hex}"

# ****************************
# Function format_magic_number
# ****************************
function format_magic_number () {
    # Set the local variables.
    local hexstr=$1
    local outstr=''
    # Loop over the chars of the hex string.
    for ((i=0; i<${#hexstr}; i++))
    do
       outstr+="${hexstr:${i}:1}"
       if [[ $((i%2)) -eq 1 ]]; then
           outstr+=" "
       fi
    done
    echo -e "${outstr}"
    # Return the exit status.
    return 0
}

#for key in "${!magic_numbers[@]}"
#do
#    echo -e "${key}"
#done

# ***************************
# Function check_magic_number
# ***************************
check_magic_number () {
    # Assign the local variables.
    local hex=$1
    # Run over the dictionary.
    for mn in "${!magic_numbers[@]}"
    do
        # Get the file type to a magic number.
        ft=${magic_numbers["${mn}"]}
        # Check if hex starts with the magic number.
        if [[ "${hex}" =~ ^"${mn}" ]]; then
            echo -e "File type: ${ft}"
            mn=$(format_magic_number "${mn}")
            echo -e "Magic number: ${mn}"
            IS_IN_DICT=true
            break
        fi
    done
    if [[ "${IS_IN_DICT}" = false ]] ; then
        echo 'File type is not known!'
    fi
}

# Call function.
check_magic_number "${hex}"

# Print farewell message.
echo -e "Have a nice day. Bye!"

# Exit the script.
exit 0
