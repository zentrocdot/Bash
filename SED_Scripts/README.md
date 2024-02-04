# :floppy_disk: README

### Motivation

<p align="justify">While using sed I decided to take a deeper look in the things which can be done with sed. This section is the result of my research.</p>

### Introduction

<p align="justify">I used the GNU sed tutorial to learn more about sed. In the references there are some helpful resources about sed scripts or one-liner. Some of them are more suitable for everyday use than others. Some of the one-liners are self-explanatory and commonplace. The references are initially a loose collection of sed one-liners. I have yet to make an exact evaluation. It seems that all or most of them are based on the work of Eric Pement.</p> 

### Introductory Words

<p align="justify">One disadvantage of sed is that it is not possible to hand over command line argument to the script. In awk this is not a problem at all. Nevertheless working with sed in Bash allows to use command line arguments. But one has to take care about single and double quotes.</p> 

> [!TIP]
> Use labels that are clearly different from sed options and sed commands. For example, the use of x as a label can be confused with the sed command x. Clear label naming also improve the readability of the script.

> [!IMPORTANT]
> Never use a label twice in a sed script. That will give funny results. And later debugging is considerably more difficult.

### To-Do

<p align="justify">Up to now I used the Bash script as container for the sed script. When I have spare time I will take a look if there are an advantage to run sed as stand alone script.</p> 


### Web-Links

<p align="justify">For me, weblinks are references as I also give them in a book, but in abbreviated form. Accordingly, I deliberately do not link through clickable links. I leave out the corresponding protocol, since the correct protocol is or should be recognised in a correct way on the server side.</p>

### References

[1]  &#8203;edoras.sdsu.edu/doc/sed-oneliners.html

[2]  &#8203;www.unixguide.net/unix/sedoneliner.shtml

[3]  &#8203;www.linux.org/threads/handy-one-liners-for-sed.42823/

[4]  &#8203;www.linuxhowtos.org/System/sedoneliner.htm

[5]  &#8203;catonmat.net/sed-one-liners-explained-part-one

[6]  &#8203;catonmat.net/sed-one-liners-explained-part-two

[7]  &#8203;catonmat.net/sed-one-liners-explained-part-three

[8]  &#8203;www.pement.org/sed/sed1line.txt

[9]   &#8203;wiki.ubuntuusers.de/sed/

[10]  &#8203;sed.sourceforge.io/

[11]  &#8203;github.com/aureliojargas/sed.sf.net

[12]  &#8203;sed.sourceforge.io/grabbag/scripts/

[13]  &#8203;sed.sourceforge.io/local/docs/emulating_unix.txt

[14]  &#8203;www.pement.org/sed/ifelse.txt

[15]  &#8203;www.pement.org/sed/index.htm

[16]    &#8203;www.gnu.org/software/sed/manual/sed.html

[17]    &#8203;www.grymoire.com/Unix/Sed.html

[18]  &#8203;www.regular-expressions.info/

[19]  &#8203;berkeley-scf.github.io/tutorial-using-bash/regex.html


  
