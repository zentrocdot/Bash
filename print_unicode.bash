#!/usr/bin/bash
#
# Print formatted unicode chars
#
# Version 0.0.0.1

COUNT=0

NUMCHR=40

print_unicode_char () {
    char=$1
    spc=''
    uc=$(printf '%b' "${char}")
    len=$(echo "${uc}" | wc -L)
    if [[ "${len}" -gt 0 ]]; then
        if [[ "${len}" -eq 1 ]]; then spc=' '; fi
        printf "%b%s" "${uc}" "${spc}"
        ((COUNT+=1))
    fi
    return 0
}

# Various technical signs.
#start=0x2300
#end=0x23ff

# Frame symbols.
#start=0x2500
#end=0x257f

# Various symbols.
#start=0x2600
#end=0x26ff

# Dingbats.
#start=0x2700
#end=0x27bf

# Various symbols and pictograms.
#start=0x1f300
#end=0x1f5ff

# Traffic and map symbols.
#start=0x1f680
#end=0x1f700

# Chess symbols.
start=0x1fa00
end=0x1fa6d

# Symbols and pictograms, extension A
#start=0x1fa70
#end=0x1faf6

echo -e ""

for (( i="${start}"; i<="${end}"; i++ )); do
    # Add a newline after a given number of printed chars.
    n=$((COUNT%NUMCHR))
    if [[ "${n}" == 0 ]] && [[ "${COUNT}" != 0 ]]; then
        printf "\n"
    fi
    # Get the hex number without the '0x'.
    hex=$(printf '%#x' "${i}" | sed 's/^0x//g')
    # Decide if we have to use \U or \u for the unicode representation.
    if [[ ${#hex} -gt 4 ]]; then
        char=$(echo -en "\U${hex}")
    else
        char=$(echo -en "\u${hex}")
    fi
    print_unicode_char "${char}"
done

echo -e "\n"

exit 0
