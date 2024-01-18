#/usr/bin/bash

reset

boxes -l

txtstr="This is a demo of one\n\texample called cat usingf\n\tboxes from the command line"
echo -e "${txtstr}" | boxes -d cat -a c

