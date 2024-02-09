# PROGRAMMING

## Introductory Words

<p align="justify">Below you will find a selected list of information on programming in <code>Bash</code> that I have dealt with over time. This serves me to reflect once again on what I have learned. See also the references [1,2].</p>

<p align="justify">Based on the fact that I am programming in different programming languages like <code>Python</code>, <code>Perl</code>, <code>Ruby</code>, <code>Fortran</code>, <code>Pascal</code> and sometime <code>C/C++</code> and not programming the whole day in <code>Bash</code> I am forgetting some things about the timeline. Nevertheless I am quite fast back in <code>Bash</code> programming. This should serve as a brief introduction and memory aid.</p>

<p align="justify">I am using the well known shell script analysis tool <code>Shellcheck</code> for checking my <code>Bash</code> scripts. <code>ShellCheck</code> is very well suited for optimising <code>Bash</code> scripts. The feedback from <code>ShellCheck</code> in the form of infos, warnings and errors are also always very helpful.</p>

> [!NOTE]
> <p align="justify">The <code>Bash</code> version I am working with is <code>GNU Bash 5.1.16</code>. What I am presenting below is valid for the previous mentioned <code>Bash</code> version.</p>

## Writing Program Scripts

<p align="justify">In the simplest conceivable case, a script is nothing more than a list of system commands that are stored in a ASCII compatible text file. This saves the effort of having to re-enter this special sequence of system commands each time they are needed and they are called.</p>

<p align="justify">In the next step, we add a suitable first line to the file. This first line contains the so-called <code>Shebang</code> and the required interpreter for the script with the full path. In addition to the system commands, comments can be added to the file.</p>

<p align="justify">In the last step, control structures such as loops and if else statements can be added to the file. The result is a file that produces an executable program as a script.</p>

##  Command Line Interpreter Bash

<p align="justify"><code>Bash</code> is a so called shell and the command language interpreter or command line interpreter installed on an operating system like <code>Unix</code> or <code>Linux</code>. It runs within a terminal window or a virtual console. The name is an acronym for <code>Bourne-Again SHell</code>. It is an direct successor of the <code>Unix</code> or <code>Linux</code> shell <code>sh</code>. There are other shells next to Bash.</p>

<p align="justify">To get a list of available shells on the operating system use the the following command :</p>

    cat /etc/shells

With following commands it can be checked which shell are in use:

    echo $0

and

    echo $SHELL

## Invocation of a Bash Program Script

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

## Command line arguments

### Command line arguments explained

<p align="justify"></p>

To-do ...

### usage of the command shift

<p align="justify"></p>

To-do ...

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

<p align="justify">The semicolon is used as delimiter between command.</p>

<p align="justify">The backslash is used for multiline commands.</p>

further explanations to-do ...

## Variable assigment

<p align="justify"></p>

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

## Braces compendium

<p align="justify">A quite good reference is [9].</p>

To-do ...   

## The command set

<p align="justify"></p>

To-do ...

## The command unset

<p align="justify"></p>

To-do ...

## Incrementing and decrementing numbers

### Incrementing integer numbers 

<p align="justify">Subsequently there is a more or less complete list of methods for incrementing an integer number together with the time the execution takes for a maximum value of <code>n=100000</code>.</p>
    
    Expression              Execution Time
    ----------              -------------- 
    i=$((i+1))      	0m0,267s
    i=$((i+=1))     	0m0,323s
    ((i=i+1))       	0m0,237s
    ((i+=1))        	0m0,210s
    ((i++))         	0m0,197s
    ((++i))         	0m0,206s
    let "i=i+1"     	0m0,368s
    let "i+=1"      	0m0,322s
    let "i++"       	0m0,320s
    let "++i"       	0m0,304s
    let i=i+1       	0m0,340s
    let i+=1        	0m0,328s
    let i++         	0m0,314s
    let ++i         	0m0,284s
    declare -i i; i=i+1	0m0,412s
    declare -i i; i+=1	0m0,396s
    i=$(expr $i + 1)	0m53,121s

<p align="justify">As expected, ((++i)) and ((i++)) have the best performance. If you run more than one test with the test script, the performance of the two methods will change slightly per run between each other. The script for performing this test can be found in the Math_Scripts folder.</p>

> [!WARNING]
> The prefix increment <code>$((++i))</code> and the postfix increment <code>$((i++))</code> do not behave the same way. See also [8].

Try on the command line the following:

    ~$ i=0; echo $((i++))
    ~$ 0

versus

    ~$ i=0; echo $((++i))
    ~$ 1

a little more to-do ...

### Decrementing integer numbers 

<p align="justify">Subsequently there is a more or less complete list of methods for decrementing an integer number together with the time the execution takes for a maximum value of <code>n=100000</code>.</p>

    Expression              Execution Time
    ----------              -------------- 
    i=$((i-1))      	0m0,285s
    i=$((i-=1))     	0m0,291s
    ((i=i-1))       	0m0,208s
    ((i-=1))        	0m0,223s
    ((i--))         	0m0,212s
    ((--i))         	0m0,178s
    let "i=i-1"     	0m0,332s
    let "i-=1"      	0m0,300s
    let "i--"       	0m0,286s
    let "--i"       	0m0,322s
    let i=i-1       	0m0,301s
    let i-=1        	0m0,303s
    let i--         	0m0,291s
    let --i         	0m0,281s
    declare -i i; i=i-1	0m0,412s
    declare -i i; i-=1	failed
    i=$(expr $i - 1)	0m52,962s

<p align="justify">As expected, ((--i)) and ((i--)) have in principle again the best performance. If you run more than one test with the test script, the performance of the two methods will change slightly per run between each other. The script for performing this test can be found in the Math_Scripts folder.</p>

> [!WARNING]
> The prefix decrement <code>$((--i))</code> and the postfix decrement <code>$((i--))</code> do not behave the same way. See also [8].

Try on the command line the following:

    ~$ i=1; echo $((i--))
    ~$ 1

versus

    ~$ i=1; echo $((--i))
    ~$ 0

a little more to-do ...

## Reformatting between number formats

<p align="justify"></p>

To-do ...

## Types of loops

### Simple loop over a range of numbers

<p align="justify">For the next example is stated, that we want to run over a range from 0 to 16. The iteration step size can also be added.</p>

Case 1:

    start=0
    end=16
    
    for ((i=$start; i<=$end; i++))
    do
        echo -e "${i}"
    done

Case 2:

    for i in {0..16} 
    do
       echo -e "${i}"
    done

Case 3:

    start=0
    end=16
    
    for i in $(eval echo "{${start}..${end}")
    do
        echo -e "${i}"
    done

Case 4:

    start=0
    end=16
    
    i=${start}
    
    while [[ $i -le ${end} ]]
    do
        echo -e "${i}"
        ((i = i + 1))
    done

Case 5:

    start=0
    end=16

    for i in $(seq ${start} ${end})
    do
        echo -e "${i}
    done

<p align="justify"></p>

infos and so on to-do ...

## Looping over number ranges like decimal and hexadecimal numbers

<p align="justify"></p>

To-do ...

##  Piping of commands

<p align="justify"></p>

To-do ...    

## Hardware Interrupt versus Software Interrupt

<p align="justify">A distinction must be made between the hardware interrupt and the software interrupt. Simply spoken a hardware interrupt is an event triggered by the hardware and announced to the kernel. On the other hand a software interrupt 
is an event triggered by the kernel and announced to the running processes.</p>

<p align="justify">All Linux-based operating systems are interrupt-driven, which should be logical in itself.</p>

To-do ... 

## Signal Processing

<p align="justify">Signals are a kind of one-way communication between the operating system kernel and the running operating system processes. These signals can be seen as events that are triggered under certain conditions. In Bash scripts it is possible to listen to these signals to react correctly on these events.</p>

Some important signals are:

1. SIGINT
2. SIGQUIT
3. SIGHUP
4. SIGTERM
5. SIGKILL
6. SIGSTOP
7. SIGCONT
8. SIGWINCH
10. SIGUSR1
11. SIGUSR2
12. SIGPWR

Get the complete supported list:

    trap -l

Informations:

    man 7 signal

To-do ...

##  Trap Signals and Errors

### Trap signals

<p align="justify">It is possible to trap signals. This is an simple example:</p>

    # Trap signal when a user has resised the terminal window.
    trap 'get_window_size' SIGWINCH

    function get_window_size () {
        _WINDOW_X=$(tput lines)
        _WINDOW_Y=$(tput cols)
        echo -e "X: ${_WINDOW_X}"
        echo -e "Y: ${_WINDOW_Y}"
        return 0
    }

To-do ...    

### Trap errors

<p align="justify"></p>

To-do ...    

## Bash if else statement

<p align="justify">Like in other programming languages there is a if else statement which can be used for the query of conditional cases. A query of a conditional expression in <code>Bash</code> can look like:</p>

    if CONDITION; then
        COMMANDS
    elif CONDITION; then
        COMMANDS
    else
        COMMANDS
    fi

or 

    if CONDITION
    then
        COMMANDS
    elif CONDITION
    then
        COMMANDS
    else
        COMMANDS
    fi

<p align="justify">The if statement starts with the if keyword followed by the conditional expression and is followed by the then keyword separated by a semicolon. The block with all conditional expressions ends with an fi. Further conditional expressions can be considered by the elif statement. The else clause catches all the rest of the possible conditions. Nested if fi blocks are allowed.</p>

## Bash case statement

<p align="justify"></p>

To-do ...

##  Command break and continue

<p align="justify"></p>

To-do ...

## Short Circuit evaluation of a conditional

<p align="justify"></p>

To-do ...

##  Read from the command prompt

<p align="justify"></p>

To-do ... 

##  Functions in bash

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

##  Environmental variables

<p align="justify"></p>

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

<p align="justify">In the folder Unicode_Scripts there can be found a script which prints pretty well selected ranges of unicode characters.</p>

##  Zombie processes

<p align="justify"></p>

To-do ...

##  Interface programming

<p align="justify"></p>

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

[8]    tldp.org/LDP/abs/html/dblparens.html

[9]    www&#8203;.assertnotmagic.com/2018/06/20/bash-brackets-quick-reference/

## See also:

[A1]    www&#8203;.gnu.org/software/bash/manual/

[B1]    linuxize.com/post/bash-break-continue/

[B2]    linuxize.com/post/bash-check-if-file-exists/

[B3]    linuxize.com/post/bash-if-else-statement/

[C1]    linuxsimply.com/bash-scripting-tutorial/expansion/parameter-expansion/

[D1]    tecadmin.net/bash-parameter-expansion/

[E1]    www www&#8203;.redhat.com/sysadmin/exit-codes-demystified

[F1]    www&#8203;.ubuntumint.com/find-longest-lines-file-linux/

[G1]    www&#8203;.shellcheck.net/

[H1]    phoenixnap.com/kb/bash-if-statement

[H2]    phoenixnap.com/kb/change-bash-prompt-linux

[I1]    stackabuse.com/guide-to-parameter-expansion-in-bash/

[J1]    dev.to/awwsmm/101-bash-commands-and-tips-for-beginners-to-experts-30je

[K1]    linuxconfig.org/bash-prompt-basics

[S1]    stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split

[S2]    stackoverflow.com/questions/17368067/length-of-string-in-bash

[S3]    stackoverflow.com/questions/3826425/how-to-represent-multiple-conditions-in-a-shell-if-statement

[T1]    www&#8203;.thegeekstuff.com/2014/01/linux-interrupts/

[X1]    www&#8203;.geeksforgeeks.org/interrupts/

[Z1]    www&#8203;.geeksforgeeks.org/difference-between-hardware-interrupt-and-software-interrupt/

# Donation

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee. I drink a lot of coffee while programming and writing :smiley:.</p>

<pre>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7            (TRON)
DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX            (DOGE)
12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5            (BITCOIN)
0x31042e2F3AE241093e0387b41C6910B11d94f7ec    (Ethereum)</pre>
