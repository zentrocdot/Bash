# Tips and Tricks

<p align="justify">Make a backup of the original file automatically. To do this, a filename extension with a leading dot is added within single quotes to the <code>-i</code> option.</p> 

    sed -i'.bak' 'sed_cmd' 

<p align="justify">Remove duplicate lines in a file. Without option <code>-i</code> the result is printed to the terminal window. Duplicates means duplicates up to a line with a different line content.</p> 

    sed '$!N; /^\(.*\)\n\1$/!P; D' textfile.txt
