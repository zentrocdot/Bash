# PROGRAMMING

## Introductory Words

<p align="justify">Below you will find a selected list of information on programming in Bash that I have dealt with over time. This serves me to reflect once again on what I have learned.</p>

<p align="justify">Based on the fact that I am programming in different programming languages like <code>Python</code>,<code>Perl</code>, <code>Ruby</code> and sometime <code>C/C++</code> and not programming the whole day in Bash I am forgetting some things about the timeline. Nevertheless I am quite fast back in Bash programming. This should serve as a brief introduction and memory aid.</p>

<p align="justify">I am using the well known shell script analysis tool Shellcheck for checking my Bash scripts. ShellCheck is very well suited for optimizing Bash scripts. The feedback from ShellCheck in the form of warnings are also always very helpful.</p>

## Invocation of a Bash script

<p align="justify">The synopsis for the invocation of a Bash script is:</p>

    [sudo] bash [options] [command_string | file]

## Shebang

<p align="justify">A Shebang is a script introducer which can be found in the first line of a script. The Shebang tells the operation system and the running shell which interpreter should be used to execute the in the file folowing commands of the script. This can be e.g. Shell, Bash or Python. A typical Bash Shegbang looks like:</p>

    #!/usr/bin/bash
    #!/usr/bin env

<p align="justify">Some option can be added to the command line invokation of the bash script or after the Shebang. In addition to this these option can be set by the command set.</p>
## Bash builtins

To print the Bash builtins use:

    compgen -b

## Special characters like <code>:</code>, <code>;</code> and <code>&bsol;</code> 

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
  
## Commands set and unset

To-do ...

## Incrementing and decrementing numbers

To-do ...

## Types of Loops

To-do ...

## Signal Processing

To-do ...

##  Trap Errors

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

##  Short Circuit Expressions

Short Circuit Evaluation of a Conditional.

To-do ...

## Short Circuit Evaluation of a Conditional.

To-do ...

##  Exit Conditions

To-do ...
    
## Resources 

### References:

[1]    www&#8203;.gnu.org/software/bash/manual/bash.html

[2]    www&#8203;.gnu.org/software/bash/manual/bash.pdf

[3]    &#8203;wiki.ubuntuusers.de/Shell/Bash-Skripting-Guide_für_Anfänger/

[4]    mywiki.wooledge.org/BashPitfalls

## See also:

[A1]    www&#8203;.gnu.org/software/bash/manual/

[B1]    stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split

[B2]    stackoverflow.com/questions/17368067/length-of-string-in-bash

[C1]    linuxsimply.com/bash-scripting-tutorial/expansion/parameter-expansion/

[D1]    tecadmin.net/bash-parameter-expansion/

[F1]    www&#8203;.ubuntumint.com/find-longest-lines-file-linux/

[G1]    www&#8203;.shellcheck.net/
  
<h2>Donation</h2>

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee.</p>

<pre>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7    (TRON)
DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX    (DOGE)
12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5    (BITCOIN)</pre>
    
<p align="justify">My wallet says thank you :smiley:</p>
