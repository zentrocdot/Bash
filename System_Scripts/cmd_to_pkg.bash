#/usr/bin/bash
#
# Version 0.0.0.2
#
# dpkg -s coreutils
# compgen -b
#
# See also:
# www.gnu.org/software/bash/manual/bash.html
# wiki.ubuntuusers.de/Shell/Befehlsübersicht/
# linuxhandbook.com/shell-builtin-commands/
# en.wikipedia.org/wiki/List_of_GNU_Core_Utilities_commands
# www.cyberciti.biz/faq/linux-unix-bash-shell-list-all-builtin-commands/

# Assigne the command line argument to the global variable.
CMD=$1

# Define array.
BASH_CMD=("bat" "cat" "cp" "chmod" "chown" "date" "df" "dir" "exa" "egrep"
          "fgrep" "grep" "gzip" "ifconfig" "iwconfig" "locate" "ls" "mkdir"
          "mv" "mmv" "ping" "ps" "random" "reboot" "rename" "rgrep" "rm"
          "rmdir" "route" "shutdown" "sleep" "su" "tar" "touch" "which")

# Define array.
BUILT_IN=("alias" "bg" "bind" "break" "builtin" "caller" "case" "cd" "command"
          "compgen" "complete" "compopt" "continue" "coproc" "declare" "dirs"
          "disown" "do" "done" "echo" "elif" "else" "enable" "esac" "eval"
          "exec" "exit" "export" "false" "fc" "fg" "for" "function" "getopts"
          "hash" "help" "history" "if" "jobs" "kill" "let" "local" "logout"
          "mapfile" "popd" "pushd" "pwd" "read" "readarray" "readonly" "return"
          "select" "set" "shift" "shopt" "source" "suspend" "test" "times"
          "then" "trap" "true" "type" "typeset" "ulimit" "umask" "unalias"
          "unset" "until" "variables" "wait" "while")

RESERVED_WORDS=("if" "then" "elif" "else" "fi" "time" "for" "in" "until"
                "while" "do" "done" "case" "esac" "coproc" "select" "function"
                "{" "}" "[[" "]]" "!")

OTHERS=("." ":" ";" "\\" "[" "]")

# Define array.
COREUTILS=("dd" "uname")

CMD_PATH=$(which "${CMD}")

if [[ $? != 0 ]]; then
     CMD_PATH="n/a"
     echo -e "Path: $CMD_PATH"
     exit 1
fi
echo -e "Path: $CMD_PATH"

PKG=$(dpkg -S "${CMD_PATH}" 2> /dev/null)

exit_status=$?

if [[ $exit_status != 0 ]]; then
    echo -e "No related package path found which is matching the pattern."
    PKG="n/a"
fi

echo -e "Command: ${CMD}  ->  Package: ${PKG}"

if [[ $exit_status != 0 ]]; then
   if [[ " ${BUILT_IN[*]} " == *" ${CMD} "* ]]; then
       echo -e "Remark: $CMD -> Bash built-in command"
   fi
fi

if [[ $exit_status != 0 ]]; then
   if [[ " ${BASH_CMD[*]} " == *" ${CMD} "* ]]; then
       echo -e "Remark: $CMD -> Bash command"
   fi
fi

# Exit the script.
exit 0

