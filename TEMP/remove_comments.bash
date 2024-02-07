#!/usr/bin/bash
#
# Remove Comments
# Version 0.0.0.5
# Copyright © 2024, Dr. Peter Netz
# Published under the MIT license.
#
# You are using the script on your own risk. If you have any doubts whether
# the script is working correctly, you should always make a backup copy of
# the file to be on the secure side.
#
# Description:
# The script removes all single-line and inline comments from a file that
# start with a hashtag #. Inline comments must be preceded by one or more
# spaces before the hashtag # for the inline comment to be valid as such.
# Regular comments are recognised with or without indentation.
#
# Explanation:
# First line is checked on the existence of a Shebang which is always
# introduced by '#!/' followed by different possible paths. If there is
# a Shebang, such a line is not a comment line. Regular comments are
# identified with or without indentation and than deleted. Inline comments
# starts with one or more space followed by a hashtag # with characters up
# to the end of the line and removed.
#
# Functionality Check:
# This script is used for the functionality check, based on the fact that in
# the sed command there is the hashtag three times and this are not comments.
#
# Possible usage of the hashtag # in Bash:
#   # Comment lines
#   echo "#"
#   printf "#"
#   var="#"
#   var='#'
#   array=('#')
#   dict=(["#"]="comment")
#   dict['#']='comment'
#   ${#len_of_str}
#   ${myvar#pattern}
#   ${myvar##pattern}
#   to be completed ...
#
# Limitation:
# If opening and closing expressions [{(<"'...'">)}] exists after a hashtag #,
# this comment will not be touched.
#
# To-Do:
# Check pattern matching of the inline comments and improve the recognition
# if necessary.
#
# See also:
# www.gnu.org/software/sed/manual/sed.html
# www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html
# unix.stackexchange.com/questions/230351/how-to-correctly-use-quotes-in-sed
# stackoverflow.com/questions/50167346/execute-remaining-commands-only-if-preceding-matched
# stackoverflow.com/questions/9053100/sed-regex-and-substring-negation
# stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split
# www.asciitable.com/

# Assign the command line argument to the global variable.
FN=$1 # comment for deletion

# Remove comments from a file.
# '0,/^#!\//p' -> Ignore line with Shebang
# '/^[[:blank:]]*#/d' -> Delete regular comment lines
# The second to fourth lines are removing inline comments.
sed -i -e '0,/^#!\//p' -e '/^[[:blank:]]*#/d' \
       -e 's/\(^.*\[.*[[:space:]].*#\+[[:space:]].*\]\)\(.*$\)/\1/g;t' \
       -e 's/\(^.*[\x22\x27\x28\x3C\x7B].*[[:space:]].*#\+[[:space:]].*[\x22\x27\x29\x3E\x7D]\)\(.*$\)/\1/g;t' \
       -e 's/[[:space:]]\+#\+.*$//g' \
       "${FN}" # comment for deletion
