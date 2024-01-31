#!/usr/bin/bash
#
# Collection of methods to read a file.
#
# See also:
# mywiki.wooledge.org/BashFAQ/001
# lorem-ipsum.perbang.dk/
#
# shellcheck disable=SC2162
# shellcheck disable=SC2086
# shellcheck disable=SC2066

# Lorem ipsum heredoc.
IFS='' read -d '' -r HERESTR <<'HEREDOC'
Lorem ipsum dolor sit amet, consecetur sadipscing elit, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kas gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit
amet, consecetur sadipscing elit, sed diam nonumy eirmod tempor invidunt ut
labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam
et justo duo dolores et ea rebum. Stet clita kas gubergren, no sea takimata
sanctus est Lorem ipsum dolor sit amet.
HEREDOC

# Do not overwrite anexisting file.
set -o noclobber
echo -en "${HERESTR}" > "testfile_demo.txt"

# Set the filename. If not given use the heredoc.
FN=${1:-testfile_demo.txt}

echo -e "Version 0\n"

# Using a file descriptor. Use a number between 4 and 9 to avoid
# conflicts with the shell internal file descriptors.
while IFS= read -r -u4 line; do
    echo -e "${line}"
done 4< "${FN}"

echo -e "\nVersion 1\n"

while IFS= read -r line; do
    echo -e "$line"
done < <(cat "${FN}" )

echo -e "\nVersion 2\n"

while IFS= read -r line || [[ -n $line ]]; do
    echo -e "$line"
done <"${FN}"

echo -e "\nVersion 3\n"

while read line; do
  echo "${line}"
done <"${FN}"

echo -e "\nVersion 4\n"

for line in "$(cat ${FN})"; do
    echo "${line}"
done

echo -e "\nVersion 5\n"

file="$(cat "${FN}")"

for line in "${file}"
do
    echo -e "$line"
done

