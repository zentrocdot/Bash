# Helpful Informations

## Introductory Words

<p align="justify">Below is a list of information on programming in Bash that I have dealt with over the course of time. This serves once again to reflect on what I have learned.</p>

## Length of string

<p align="justify">Subsequently follows a collection of methods how the length of a string can be obtained.</p>

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

My preferred method is

    str="teststring"     
    echo ${#str}

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
    
## References

[1]  stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split

[2]  linuxsimply.com/bash-scripting-tutorial/expansion/parameter-expansion/

[3]  tecadmin.net/bash-parameter-expansion/

[4]  stackoverflow.com/questions/17368067/length-of-string-in-bash
 
[5]  www&#8203;.ubuntumint.com/find-longest-lines-file-linux/
