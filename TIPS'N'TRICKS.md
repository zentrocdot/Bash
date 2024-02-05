# Tips And Tricks

## Length of string

<p align="justify">Subsequently follows a collection of methods how the length of a string can be obtained.</p>

<p align="justify">The commands <code>echo</code> and <code>printf</code> together with <code>awk</code> can be used to print the length of a string with a newline into the terminal window.</p>

    echo "teststring" | awk '{print length}'

    printf "teststring" | awk '{print length}'

<p align="justify">The commands <code>echo</code> and <code>printf</code> together with <code>awk</code> can be used to print the length of a string without a newline into the terminal window.</p>

    echo "teststring" | awk -v ORS= '{print length}'

    printf "teststring" | awk -v ORS= '{print length}'

The last one can be used to store the length in a variable.    

Other approaches are following.

    expr length "teststring"
    
    echo -n "teststring" | wc -m

    str="teststring"
    
    echo ${#str}

    echo "$teststring" | perl -nle "print length"

Doing it in a loop

    str="teststring"
    n=0
    while read -n1 character; dostring='Hello, Bash!'
        #n=$((n+1)) 
        ((n++)) 
    done < <(echo -n "$str")
    #echo -n "$n"
    echo "$n" 

or a senseless method

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

## References

[1]  stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split
