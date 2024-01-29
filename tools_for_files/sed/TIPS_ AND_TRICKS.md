# Tips and Tricks

<p align="justify">Make a backup of the original file automatically. To do this, a filename extension with a leading dot is added within single quotes to the -i option.</p> 

    sed -i'.bak' 'sed_cmd' textfile.txt
