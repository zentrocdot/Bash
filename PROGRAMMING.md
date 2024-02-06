# PROGRAMMING

## Introductory Words

<p align="justify">Below is a list of information on programming in Bash that I have dealt with over the course of time. This serves once again to reflect on what I have learned.</p>

<p align="justify">I am using the well known shell script analysis tool Shellcheck for checking my Bash scripts. ShellCheck is very well suited for optimizing Bash scripts. The feedback from ShellCheck in the form of warnings are also always very helpful.</p>

## Parameter Expansion

### The special character <code>$</code>

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

## Signal Processing

To-do ...

##  Trap Errors

To-do ...    

##  Short Circuit Expressions

Short Circuit Evaluation of a Conditional.

To-do ...
    
## Resources 

### References:

[1] www&#8203;.gnu.org/software/bash/manual/bash.html

[2] www&#8203;.gnu.org/software/bash/manual/bash.pdf

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
