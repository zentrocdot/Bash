{.buttonless button {
display: none;
}}

# PROGRAMMING

## Introductory Words

<p align="justify">Below you will find a selected list of information on programming in <code>Bash</code> that I have dealt with over time. This serves me to reflect once again on what I have learned. See also the references [1,2].</p>

<p align="justify">Based on the fact that I am programming in different programming languages like <code>Python</code>, <code>Perl</code>, <code>Ruby</code>, <code>Fortran</code>, <code>Pascal</code> and sometime <code>C/C++</code> and not programming the whole day in <code>Bash</code> I am forgetting some things about the timeline. Nevertheless I am quite fast back in <code>Bash</code> programming. This should serve as a brief introduction and memory aid.</p>

<p align="justify">I am using the well known shell script analysis tool <code>Shellcheck</code> for checking my <code>Bash</code> scripts. <code>ShellCheck</code> is very well suited for optimising <code>Bash</code> scripts. The feedback from <code>ShellCheck</code> in the form of infos, warnings and errors are also always very helpful.</p>

> [!NOTE]
> <p align="justify">The <code>Bash</code> version I am working with is <code>GNU Bash 5.1.16</code>. What I am presenting below is valid for the previous mentioned <code>Bash</code> version.</p>

## Writing Program Scripts

<p align="justify">In the simplest conceivable case, a script is nothing more than a list of system commands that are stored in a <code>ASCII</code> compatible text file. This saves the effort of having to re-enter this special sequence of system commands each time they are needed and they are called.</p>

<p align="justify">In the next step, we add a suitable first line to the file. This first line contains the so-called <code>Shebang</code> and the required interpreter for the script with the full path. In addition to the system commands, comments can be added to the file content.</p>

<p align="justify">In the last step, control structures such as loops and if else statements can be added to the file. The result is a file that produces an executable program as a script.</p>

##  Command Line Interpreter Bash

<p align="justify"><code>Bash</code> is a so called shell and the <code>command language interpreter</code> or <code>command line interpreter</code> installed on an operating system like <code>Unix</code> or <code>Linux</code>. It runs within a terminal window or a virtual console. The name is an acronym for <code>Bourne-Again SHell</code>. It is an direct successor of the <code>Unix</code> or <code>Linux</code> shell <code>sh</code>. There are a bunch of other shells next to <code>Bash</code>.</p>

<p align="justify">To get a list of available shells on the operating system use the the following command :</p>

    cat /etc/shells

<p align="justify">With following commands it can be checked which shell are in use:</p>

    echo $0        # Command line argument

and

    echo $SHELL    # Environmental variable

<p align="justify">This is the first time that we are getting in touch with <code>command line arguments</code> and <code>environmental variables</code>code>. Later on we will see that both commands are dealing with variables and the so-called <code>parameter expansion</code>.</p>

<p align="justify">Try out in this context the command:</p>

    printenv

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

<p align="justify">Command line arguments are of the type $0, $1, $2, $3 etc. $@ is the array of all the given parameters. $# is the total number of arguments.</p>

| Special Variable | Explanation                                 |
| ---------------- | ------------------------------------------- |
| $1 … $n          | Positional argument from 1 ... n            |
| $0               | Name of the shell script                    |
| $@               | Array with all arguments                    |
| $*               | Double-quoted arguments                     |
| $#               | Total number of arguments                   |
| $$               | Process ID (PID) of the current shell       |
| $?               | Exit status ID                              |
| $!               | Last command process ID                     |

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

## Infinite loops

<p align="justify">Sometimes loops are needed that would run indefinitely.</p>

    Example 1:

    while :
    do
        :
    done

    Example 2
    
    while true
    do
        :
    done

    Example 3:

    while false
    do
        :
    done

    Example 4:

    while true; do
        :
    done

    Example 5:
    
    while true; do :; done

    Example 6:
    
    sed ':x;bx' <<< $''

    Example 7:

    for ((;;))
    do
        :
    done

some more explanation to-do ...

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

## Short Circuit test or evaluation of a conditional expression

<p align="justify">A <code>short circuit test</code> looks like the expressions shown below. These are combinations of AND and OR operators. The AND operator is && and the OR operator is ||.</p>

     COMMAND1 && COMMAND2 || COMMAND3    or
     EXPRESSION1 && EXPRESSION2 || EXPRESSION

     COMMAND1 || COMMAND2 && COMMAND3    or
     EXPRESSION1 || EXPRESSION2 && EXPRESSION

<p align="justify">The introduced formulation of short circiut tests is not limited to 3 commands or 3 expressions. Subsequently I am presenting some examples at the command prompt.</p>

    ~$ a=0
    ~$ b=1

    ~$ [[ $a > $b ]] && echo "True" || echo "False"
    ~$ False

     ~$ [[ $a < $b ]] && echo "True" || echo "False"
     ~$ True

<p align="justify">One can check the values of the set variables:</p>

    ~$ echo $a $b
    ~$ 0 1

<p align="justify">For our next example we delete the values of the variables.</p>

    ~$ unset a b    # Here we see, why we deal wit the parameter expansion. We unset a and b not $a and $b                         
<p align="justify">Next example:</p>

    ~$ a=1
    ~$ b=2
    ~$ c=3

    ~$ [[ $a > $b ]] || [[ $b > $c ]] && echo "True" || echo "False"
    ~$ False

    ~$ [[ $a < $b ]] || [[ $b > $c ]] && echo "True" || echo "False"
    ~$ True

<p align="justify">Please note that every expression has it own exit status which will be linked to the previous one. So it is not a valid approach to use short circuit expressions as a substitute of an <code>if … then … else … fi</code> statement.</p>

> [!CAUTION]
> <p align="justify">See also reference [4] section '22. cmd1 && cmd2 || cmd3'. There the pitfall of misleading usage of short-circuit evaluations will be shown and explained.</p>

a little bit more explanations to-do ...

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

### Heredocs

<p align="justify"></p>

To-do ... 

### Herestrings

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

<p align="justify">A zombie process is sometimes also referred to as defunct or dead process. This is a process that has completed his execution, but his entry is not removed from the process table. How to handle this is following.</p>

To-do ...

##  Interface programming

<p align="justify">For GUI programming one can use dialog or zenity.</p>

To-do ...

##  Terminal size

<p align="justify">A recurring task is determining the size of the terminal window. Within the terminal window using <code>Bash</code> the environmental variables COLUMNS and LINES can be used.</p>

    echo "Cols: ${COLUMNS}"
    echo "Rows: ${LINES}"

<p align="justify">Within a script both variables are empty. The trick to get the environmental variables working is using the command shopt.</p>

    shopt -s checkwinsize  # Enable option checkwinsize.
    cat /dev/null          # Refresh LINES and COLUMNS.
    shopt -u checkwinsize  # Disable option checkwinsize

<p align="justify">A good explanation why this is working can be found in [12]. See also [13] for a short introduction in the command shopt. Use following for help:</p>

    shopt --help
    shopt           # Listed all the options.    

or in

    man bash

The command resize can be used to get rows and cols.


<pre>
    ```Bash
    ~$ resize 
    ~$ COLUMNS=80;
    ~$ LINES=40;
    ~$ export COLUMNS LINES;
    ```
</pre>


If wee need informations about the window we can use:
    
    xwininfo
    
To-do ...

##  Number system conversion

<p align="justify">Number systems that are used in the context with computer technology are decimal, hexadecimal, octal and binary. Decimal is 10 based, hexadecimal is 16 based, octal is 8 based and Binary is 2 based. Hindu presented the first known description of a binary system.</p>

<p align="justify">Sidenotes: The Babylonian number system used base 60 (sexagesimal) instead of 10. Hawaiians used a base 4 number system. Pacific nations such as Papua New Guinea used also base 4. Mayans used base 20 both for astronomical reasons. There are a lot of other examples. So it makes sense think about more than the earlier listed 4 number systems.</p>

# Decimal to binary

<p align="justify">Decimal to binary conversion using pure bash:</p>

    DEC2BIN=(
    {0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}\
    {0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}
    )

    DEC=65535    # Max value for this approach.  

    echo ${DEC2BIN[DEC]}

or rewritten using a hack with backticks:

    DEC2BIN=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}\
    `       `{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
            
    DEC=65535

    echo ${DEC2BIN[DEC]}

<p align="justify">The expression between the backticks open a subshell with nothing in it. The expression in backticks is then processed before the expansion is provcessed. This way the expansion just sees nothing than an empty space.</p>

# Decimal to hex

<p align="justify"></p>

dec2hex

    printf '%x' ${decimal}
    printf '%X' ${decimal}

    echo "obase=16; 15" | bc
    
To-do ...

# Decimal to octal

<p align="justify"></p>

dec2oct

    printf '%o' $number

    echo "obase=8; 15" | bc
    echo "obase=8; ibase=10; 15" | bc

To-do ...

# Ternary operator

<p align="justify">A <code>ternary operator</code> can be written in generalized notation as follows:</p>

    z = expression ? value1 : value2

<p align="justify">This syntax is similar to an if else conditional expression. If the expression is true, value1 is assigned to z, otherwise value2 is assigned to z.</p>

Now we fill the equation with life

   expression = a > b
   value1 = a
   value2 = b

The <code>ternary operator</code> is written as if-else statement e.g.:

    if [ "$a" -gt "$b" ]; then z="${a}"; else z="${b}"; fi

or 

    z=$(( a > b ? a : b ))

    ((z = a > b ? a : b))

To-do ...

## Abbreviations

<p align="justify">A list with abbreviations and acronyms can be found here:</p>

    <a href="/DOCUMENTS/Abbreviations_and_acronyms.md">Abbreviations and Acronyms</a>

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

[10]    www&#8203;.shellcheck.net/

[11]    www&#8203;.shellcheck.net/wiki/

[12]    stackoverflow.com/questions/1780483/lines-and-columns-environmental-variables-lost-in-a-script

[13]   www&#8203;.howtogeek.com/691980/how-to-customize-the-bash-shell-with-shopt/

<hr width="100%" size="1">

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee :coffee:. I drink a lot of coffee while programming and writing  :smiley:.</p>

<hr width="100%" size="1">

<p align="center">
<a href="https://www.buymeacoffee.com/zentrocdot" target="_blank"><img src="\IMAGES\greeen-button.png" alt="Buy Me A Coffee" height="41" width="174"></a>
</p>

<p align="center">I loved the time when you could get also a hamburger :hamburger: for one euro!</p>

<hr width="100%" size="1">

<p align="justify">Here are some other good ways to simply donate a coffee to me via my favourite coins :moneybag:.</p>

<table>
  <tbody>
    <tr>
      <td>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7</td>
      <td>Tron</td>
    </tr>
    <tr>
      <td>DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX</td>
      <td>Doge</td>
    </tr>
    <tr>
      <td>12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5</td>
      <td>Bitcoin</td>
    </tr>
    <tr>
      <td>0x31042e2F3AE241093e0387b41C6910B11d94f7ec</td>
      <td>Ethereum</td>
    </tr>
  </tbody>
</table>

<hr width="100%" size="1">

<p align="center">File last modified 10/02/2024</p>
