# PROGRAMMING

## Introductory Words

<p align="justify">Below you will find a selected list of information on programming in <code>Bash</code> that I have dealt with over time. This serves me to reflect once again on what I have learned. See also the references [1,2].</p>

<p align="justify">Based on the fact that I am programming in different programming languages like <code>Python</code>, <code>Perl</code>, <code>Ruby</code>, <code>Fortran</code>, <code>Pascal</code> and sometime <code>C/C++</code> and not programming the whole day in <code>Bash</code> I am forgetting some things about the timeline. Nevertheless I am quite fast back in <code>Bash</code> programming. This should serve as a brief introduction and memory aid.</p>

<p align="justify">I am using the well known shell script analysis tool <code>Shellcheck</code> for checking my <code>Bash</code> scripts. <code>ShellCheck</code> is very well suited for optimizing <code>Bash</code> scripts. The feedback from <code>ShellCheck</code> in the form of infos, warnings and errors are also always very helpful.</p>

## Invocation of a Bash script

<p align="justify">The synopsis for the invocation of a <code>Bash</code> script is:</p>

<pre>[sudo] bash [options] {command_string | script_file}</pre>

<p align="justify">The content in square brackets is optional and the content in the curly braces is required. One needs a command string or a script file, otherwise the command bash makes no sense. No sense is in this context to seen relative here. With the command execution without options and string or file we are opening a new bash session, which we can leave again with exit. I will explain later on how we can get PID and PPID of these processes.</p>

For more informations about <code>bash</code> type at the command prompt:

    man bash
    
or

    info bash 

## Shebang

### Reason and usage

<p align="justify">A <code>Shebang</code> line is a script introducer which can be found in the first line of a script. The Shebang line tells the operation system and the running shell which interpreter should be used to execute the commands which are following of the script in a file. This can be e.g. <code>Shell</code>, <code>Bash</code> or <code>Python</code> and so on. A typical Bash <code>Shebang line</code> looks like:</p>

<pre>#!/usr/bin/bash
#!/usr/bin/env bash</pre>

<p align="justify">The <code>Shebang</code> in the classic sense consists only of two characters:</p>

<pre>#!</pre>

<p align="justify">When I am talking about the Shebang I am meaning the whole Shebang line or Shebang directive which is:</p>

<pre>#!interpreter [options/arguments]</pre>

or in our case e.g.
     
<pre>#!/usr/bin/bash -x 
#!/usr/bin/env bash -x</pre>

<p align="justify">It should be noted that the option may work as expected in the second case, but this must be checked on a case by case basis.</p>

### History and background

<p align="justify">In the early computer age, when we talk about <code>Unix</code> and the incorporated <code>Shell</code> environment the Shebang <code>#!</code> was a magic number <code>0x23</code> <code>0x21</code> which told the shell or operating system which programm should be used for execution.<p>

Early Shebang directives looked like:

    #! /bin/sed -f

<p align="justify">I am using the last example related to sed, as this directive can still be found as a relic in many sed scripts.<p>

### Origin of the name Shebang

<p align="justify">In the explanation where the name Shebang comes from I am missing an explanation for the <kbd>e</kbd>. From my point of view It could be interpreted as as SHell Executes BANG, SHarp Executes BANG or haSH Excecutes BANG. It is undisputed in the sources that bang stands for The exclamation mark [to-do: add reference].</p>

### Modern usage of the Shebang

<p align="justify">In the modern computer age, it no longer makes sense to view the Shebang #! separately from the interpreter. Especially as the Shebang is used to executes scripts via interpreters like Python, Perl, Ruby, awk and sed etc. in the shell environment. The lost space character is a good example of the correctness of this statement. The shebang should be seen as a collective term for the first line in an executable script. In the shell, a script is executed by an interpreter, so the shebang is still correct. To be precise there should be of course nothing after the Shebang until the line break.<p>

## Bash builtins

To print the <code>Bash builtins</code> use:

    compgen -b

further explanations to-do ...

## Comments in scripts

<p align="justify">Comments in Bash scripts are introduced using the special characteror hashtag <code>#</code>. Other denotations are hash tag, hash mark, hash sign or pound symbol.</p>

<p align="justify">A distinction is made between single-line comments and inline comments.</p>

    #!/usr/bin/bash              # The Shebang is not a comment.
    # shellcheck disable=SC2034  # No comment in the true sense of the word.
                                 # This disables infos, warnings and errors when using shellcheck.
                                 # Last and this line are single-line comments.

    # Print 'Hello World' into the terminal window.  # This line is a single-line comment.
    # printf "%s\n" "Hello World!                    # This line is a single-line comment.
    echo -e "Hello World!"                           # This text is an inline comment.

    # Print a farewell message.                            # This is a single-line comment.
    echo -e "Goodbye!"  # echo -e "Have a nice day. Bye!"  # These texts are an inline comment.

    # Exit script.  # This line is a single-line comment.
    #exit 42        # This line is a single-line comment.
    exit 0

<p align="justify">A single line comment starts at the end of the line or have an indentation. An inline-comment follows the last command in a line. Everything after a hashtag # in a line is interpreted as comment.</p>

further explanations to-do ...

## Special characters like <code>:</code>, <code>;</code> and <code>&bsol;</code> 

<p align="justify">The no-op (no-operation) command in Bash is the : (single colon). Sometimes it is helpful to have a command which does nothing. This is true especially in if else statements. This is comparable to the pass command of Python. The return status of the command : is zero.</p>

To-do ...

## Parameter Expansion

### Special character <code>$</code>

<p align="justify">The special character <code>$</code> allows the so called parameter expansion, a command substitution or an arithmetic expansion. The basic form of a parameter expansion is <code>${parameter}</code> where the value of the parameter is substituted. The curly braces can be omitted when e.g. <code>$parameter</code> is surounded by spaces. The curly braces are required when e.g. a parameter is followed by a character that is not to be interpreted as part of the parameter.<p>

<p align="justify">Assignment of a value to a variable example:</p>

    COMMAND_LINE_ARGUMENT=$0               # $0 represents the name of the script itself 

    FILENAME=$COMMAND_LINE_ARGUMENT        # ShellCheck will issue a warning
    FILENAME=${COMMAND_LINE_ARGUMENT}      # ShellCheck will issue a warning
    FILENAME="${COMMAND_LINE_ARGUMENT}"    # Best practice

<p align="justify">I always use the last variant without exception, unless I have to omit the double quotes within an expression. On the other hand, command line arguments are used by me in the rule without double quotes and curly braces.</p>

### Length of string

<p align="justify">My preferred method is the one using the parameter expansion in following form:</p>

    str="string length example"    # String to measure
    echo "${str}"                  # Print the string
    len=${#str}                    # Get the length
    echo "${len}"                  # Print the length 

<p align="justify">The only disadvantage is that we cannot assign the length of a given string to a variable directly. This example will fail:</p>

    len=${#string length example} 
    echo "${len}"

<p align="justify">Subsequently follows a collection of other methods how the length of a string can be obtained.</p>

<p align="justify">The commands <code>echo</code> and <code>printf</code> together with <code>awk</code> can be used to print the length of a string with a newline into the terminal window.</p>

    echo "teststring" | awk '{print length}'

    printf "teststring" | awk '{print length}'

<p align="justify">The commands <code>echo</code> and <code>printf</code> together with <code>awk</code> can be used to print the length of a string without a newline into the terminal window.</p>

    echo "teststring" | awk -v ORS= '{print length}'

    printf "teststring" | awk -v ORS= '{print length}'

The last one can be used to store the length in a variable.    

Other approaches are following listed.

    expr length "teststring"
    
    echo -n "teststring" | wc -m

    str="teststring"

    echo "$teststring" | perl -nle "print length"

<p align="justify">It is also possible to get the number of chars by incrementing each char.</p>

    str="teststring"
    n=0
    while read -n1 character; do
        ((n++)) 
    done < <(echo -n "$str")
    #echo -n "$n"               # Print without linebreak
    echo "$n"                   # Print with linebreak

<p align="justify">One senseless method can be used to demonstrate how my preferred method works in a loop. In addition to this it can be demonstrated how a number can be incremented.</p>

    str="teststring"
    n=0
    for ((i=0; i<${#string}; i++)); do
        #n=$((n+1))
        #((n=n+1))
        #((n+=1))
        ((n++))
    done
    #echo -n "$n"
    echo "$n"
    
Subsequently an overview of some parameter expansion modes:
    
    ${VAR#pattern}     # Delete shortest match of pattern from the beginning
    ${VAR##pattern}    # Delete longest match of pattern from the beginning
    ${VAR%pattern}     # Delete shortest match of pattern from the end
    ${VAR%%pattern}    # Delete longest match of pattern from the end

Examples:

    VAR="This is a long test example."
    echo ${VAR#* }   ->  is a long test example.
    echo ${VAR##* }  ->  example.
    echo ${VAR% *}   ->  This is a long test
    echo ${VAR%%* }  ->  This

##  Command substitution

<p align="justify"></p>

To-do ...    

## Command set

<p align="justify"></p>

To-do ...

## Command unset

<p align="justify"></p>

To-do ...

## Incrementing and decrementing numbers

<p align="justify"></p>

To-do ...

## Types of Loops

<p align="justify"></p>

To-do ...

##  Piping of commands

<p align="justify"></p>

To-do ...    

## Signal Processing

<p align="justify"></p>

To-do ...

##  Trap signal and errors

<p align="justify"></p>

To-do ...    

## Bash if else Statement

<p align="justify">Like in other programming languages there is a if else statement which can be used for the query of conditional cases. A query of a conditional expression in Bash can look like:</p>

    if [[ -f "$filename" ]]; then
        echo "Regular file exists.!"
    elif [[ -e "$filename" ]]; then
        echo "File NOT exists!"
    else
        echo "File NOT exists!"
    fi

<p align="justify">The if statement starts with the if keyword followed by the conditional expression and is followed by the then keyword separated by a semicolon. The block with all conditional expressions ends with an fi. Further conditional expressions can be considered by the elif statement. The else clause catches all the rest of the possible conditions. Nested if fi blocks are allowed.</p>

##  Command break and continue

<p align="justify"></p>

To-do ...

## Short Circuit evaluation of a conditional

<p align="justify"></p>

To-do ...

##  Read from the command prompt

<p align="justify"></p>

To-do ... 

##  Write to files

<p align="justify"></p>

To-do ... 

##  Concepts of heredocs and herestrings

<p align="justify"></p>

To-do ... 

##  Redirections

<p align="justify"></p>

To-do ... 

##  Exit Codes

<p align="justify">The available exit code numbers are depending on the command which is used. The usual exit codes are 0 and 1. The exit code 0 means successful execution of the command and the exit code 1 is a general error while executing the command. For more informations use [7].</p>

<p align="justify">A distinction must be made between command execution and script execution.</p>

To-do ...

##  PID and PPID

<p align="justify"></p>

To-do ... 

##  Command prompt

You can easily change the commad prompt [5,6]. The next command is changing the color of my command prompt:

    PS1="\e[1;36m\u@\h\e[0m:\e[1;34m\W\e[0m\$ "

As long as you do not change your configuration this is valid up to the moment when you close the terminal window.

To-do ...

##  Color support

<p align="justify"></p>

To-do ...

##  ANSI-C / ASCII

<p align="justify"></p>

To-do ...

##  Unicode support

<p align="justify">Unicode characters can be given in two ways:</p>

    echo -e '\u262e'        # \u uses four hexadecimal digits

Using former code results in the peace sign ☮.

    echo -e '\U0001f5fd'    # \U uses eight hexadecimal digits

Using former code results in the statue of liberty 🗽.

<p align="justify">The unicode support of <code>Bash</code> allow funny things to use and to print like a teddy bear or a upside down smiley:</p>

    echo -e '\U0001f9f8'

Using former code results in a teddy bear :teddy_bear:.

    echo -e '\U0001f643'
    
Using former code results in a upside down smiley :upside_down_face:.

To-do ...
    
## Resources

<p align="justify">In addition to the books and literature I own, I use websites and forums as sources of information. I like to use good internet sources again and again. I check all information several times and carry out cross-checks.</p>

### References:

[1]    www&#8203;.gnu.org/software/bash/manual/bash.html

[2]    www&#8203;.gnu.org/software/bash/manual/bash.pdf

[3]    &#8203;wiki.ubuntuusers.de/Shell/Bash-Skripting-Guide_für_Anfänger/

[4]    mywiki.wooledge.org/BashPitfalls

[5]    phoenixnap.com/kb/change-bash-prompt-linux

[6]    misc.flogisoft.com/bash/tip_colors_and_formatting

[7]    tldp.org/LDP/abs/html/exitcodes.html

## See also:

[A1]    www&#8203;.gnu.org/software/bash/manual/

[B1]    linuxize.com/post/bash-break-continue/

[B2]    linuxize.com/post/bash-check-if-file-exists/

[B3]    linuxize.com/post/bash-if-else-statement/

[C1]    linuxsimply.com/bash-scripting-tutorial/expansion/parameter-expansion/

[D1]    tecadmin.net/bash-parameter-expansion/

[E]    www www&#8203;.redhat.com/sysadmin/exit-codes-demystified

[F1]    www&#8203;.ubuntumint.com/find-longest-lines-file-linux/

[G1]    www&#8203;.shellcheck.net/

[H1]    phoenixnap.com/kb/bash-if-statement

[H2]    phoenixnap.com/kb/change-bash-prompt-linux

[I1]    stackabuse.com/guide-to-parameter-expansion-in-bash/

[J1]    dev.to/awwsmm/101-bash-commands-and-tips-for-beginners-to-experts-30je

[S1]    stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split

[S2]    stackoverflow.com/questions/17368067/length-of-string-in-bash

[S3]    stackoverflow.com/questions/3826425/how-to-represent-multiple-conditions-in-a-shell-if-statement

# Donation

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee. I drink a lot of coffee while programming and writing.</p>

<pre>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7            (TRON)
DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX            (DOGE)
12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5            (BITCOIN)
0x31042e2F3AE241093e0387b41C6910B11d94f7ec    (Ethereum)</pre>
    
<p align="justify">My wallet says thank you :smiley:</p>
