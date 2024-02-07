#!/usr/bin/bash
#
# Create Shebang Line
# Version 0.0.0.1
#
# Description:
# First the path to the program is checked using the command which. Used on
# this the first Shebang line can be generated. Then it is checked in the
# same way where the command env can be found. Based on both information
# the Shebang line is proposed.
#
# See also:
# stackoverflow.com/questions/10376206/what-is-the-preferred-bash-shebang

PROG=$1

PROG_PATH=$(which $1)

ENV_PATH=$(which "env")

if [[ "${PROG_PATH}" != "" ]]; then
    printf '#!%s\n' "${PROG_PATH}"
fi

if [[ "${ENV_PATH}" != "" ]]; then
    printf '#!%s %s\n' "${ENV_PATH}" "${PROG}"
fi

exit 0


