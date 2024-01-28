# :card_file_box: Tools For Files

> [!NOTE]
> The existing scripts were tested with the OS Linux Mint 21.3 with the code name Virginia using the GNU Bash shell version 5.x.x in a GNOME-Terminal version 3.x.x.

### Introduction

<p align="justify">Standard tasks in daily work are the removal of blank lines and the removal of leading and trailing spaces in files. It can also be useful to remove comments from files. This can be done within a <code>Bash</code> script. But there are easier ways to work with file content.</p>

<p align="justify">In addition to <code>Bash</code> and its commands, <code>sed</code> or <code>awk</code> can also be used to manipulate data in files. Both are programming languages, even if they are often not seen as such. It should be noted that the latter two programming languages are also  Turing-complete.</p>

### The stream editor sed

<p align="justify">sed is the abbreviation for <b>s</b>tream <b>ed</b>itor. The stream editor <code>sed</code> can be used to perform manipulations on an input data stream. It is possible to write more or less complex programs with <code>sed</code>.</p>

### The scripting language awk

<p align="justify">awk is named after the surnames of the awk authors Alfred V. <b>A</b>ho, Peter J. <b>W</b>einberger und Brian W. <b>K</b>ernighan. It is also possible to write more or less complex programs with <code>awk</code>.</p>

### Scripts

<p align="justify">The scripts in the main folder have been tested and work as expected. The scripts in the <code>tmp</code> folder needs a little bit more work to get the expected results. They are intented for testing purposes.</p>

### References

[1] www&#8203;.gnu.org/software/bash/manual/bash.pdf

[2] www&#8203;.gnu.org/software/gawk/manual/gawk.html

[3] www&#8203;.gnu.org/software/sed/manual/sed.html

[4] manpages.ubuntu.com/manpages/jammy/en/man1/awk.1posix.html

[5] manpages.ubuntu.com/manpages/jammy/en/man1/sed.1.html

[6] www&#8203;.regular-expressions.info/

> [!WARNING]
> The streamline editor <code>sed</code> using the inline option <code>-i</code> maybe will damage a given file. Make a copy if you did not test a script beforehand.






