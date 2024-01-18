# README

### ANSI Escape Sequences

> <p align="justify">ANSI Escape Sequences can be used to control the terminal window. Control of the cursor and the colored output of text are just two examples of many.</p>

> <p align="justify">In Bash scripts, the clear and reset commands can be replaced by ANSI escape sequences. On my laptop there is a significant difference in the execution time of e.g. <code>reset</code> or <code>tput reset</code> and the corresponding ANSI escape sequence.</p>

# Brief explanation

>  <p align="justify">An ANSI escape sequence consists of the so-called CSI (Control Sequence Introducer) followed by an expression which describes what should be done within the terminal.</p>

    ESC [ (written as \e[ or \033[    

CSI, commands, the ESC [ (written as \e[ or \033[ in several programming languages) is

### Usage

>  <p align="justify">E.g. a reset of a terminal window can be done using ANSI escape sequences in two ways:</p>

    echo -en "\033c"    or    echo -en "\ec"
    printf "\033c"      or    printf "\ec"


### References

[1] manpages.debian.org/bookworm/manpages-de/console_codes.4.de.html
[2] en.wikipedia.org/wiki/ANSI_escape_code#CSI_(Control_Sequence_Introducer)_sequences
    
