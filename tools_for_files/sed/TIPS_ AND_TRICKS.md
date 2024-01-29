# Tips and Tricks

<p align="justify">Make a backup of the original file automatically. To do this, a filename extension with a leading dot is added within single quotes to the <code>-i</code> option.</p> 

    sed -i'.bak' 'sed_cmd' textfile.txt

<p align="justify">Remove duplicate lines in a file. Without option <code>-i</code> the result is printed to the terminal window. Duplicates means duplicates up to a line with a different line content.</p> 

    sed '$!N; /^\(.*\)\n\1$/!P; D' textfile.txt

Print whole file content.

    sed -n 'p' testfile.bash

Print whole file content except first line.

    sed -n '1!p' testfile.bash

Print whole file content except first and second line.

    sed -n '1,2!p' testfile.bash

Print lines in file.

    sed -n '$=' testfile.txt
