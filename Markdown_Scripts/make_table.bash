#!/usr/bin/bash
#
# Make a markdown table from raw data
# Version 0.0.0.1
#
# docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-tables

# shellcheck disable=SC2034
# shellcheck disable=SC2312

# Set the file names.
FN="raw_in.txt"

# shellcheck disable=SC2250
FN_IN=${1:-$FN}
FN_OUT="md_out.txt"
FN_TMP="tmp.txt"

# Sort the file content.
sort "${FN_IN}" > "${FN_TMP}"

# Set the variables.
WIDTH1=24
WIDTH2=52

# Set the char.
CHR="|"

# Set the strings.
STR1="Abbreviation or Acronym"
STR2="Description"

# Set the description.
str1=${2:-$STR1}
str2=${3:-$STR2}

# ###############
# Function filler
# ###############
filler () {
    local num chr
    num=$1; chr=$2
    echo -e "$(for i in $(eval echo "{1..${num}}"); do echo -n "${chr}"; done)"
    return 0
}

# ###############
# Function header
# ###############
header () {
    len1=${#str1}
    len2=${#str2}
    dif1=$((WIDTH1-len1-1))
    dif2=$((WIDTH2-len2-1))
    dif3=$((WIDTH1-2))
    dif4=$((WIDTH2-2))
    if [[ "${dif1}" -gt 0 ]]; then
        spc1=$(filler "${dif1}" "\x20")
    else
        spc1=''
    fi
    if [[ "${dif2}" -gt 0 ]]; then
        spc2=$(filler "${dif2}" "\x20")
    else
        spc2=''
    fi
    fil3=":$(filler "${dif3}" "-")"
    fil4=":$(filler "${dif4}" "-")"
    # Print header to file.
    printf "| %s%s | %s%s |%b" "${str1}" "${spc1}" "${str2}" "${spc2}" "\n" > "${FN_OUT}"
    printf "| %s | %s |%b" "${fil3}" "${fil4}" "\n" >> "${FN_OUT}"
}

# ###########
# Print table
# ###########
print_table () {
# Read the data and format the data.
    while IFS= read -r line; do
        # Ignore empyty lines.
        if [[ "${line}" != "" ]]; then
            # Get left part.
            prt1=$(echo "${line}" | awk -F ';' '{print $1}' | sed 's/^ *//;s/ *$//')
            len1=${#prt1}
            dif1=$((WIDTH1-len1))
            spc1=$(filler "${dif1}" "\x20")
            # Get right part.
            prt2=$(echo "${line}" | awk -F ';' '{print $2}' | sed 's/^ *//;s/ *$//')
            len2=${#prt2}
            dif2=$((WIDTH2-len2))
            spc2=$(filler "${dif2}" "\x20")
            # Print line to file.
            printf "| %s%s| %s%s|\n" "${prt1}" "${spc1}" "${prt2}"  "${spc2}" >> "${FN_OUT}"
        fi
    done < "${FN_TMP}"
}

# ++++++++++++
# Main section
# ++++++++++++

# Reset screen.
reset

# Print head line.
header

# Print table.
print_table

# Remove temporary file.
rm "${FN_TMP}"

# Print file content to screen.
cat "${FN_OUT}"

# Exit script.
exit 0
