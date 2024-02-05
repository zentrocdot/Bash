# Tipps And Trick

## Length of string

Subsequently follows a collection of methods how the length of a string can be obtained.

Output with linebreak using echo and printf.

    echo "teststring" | awk '{print length}'

    printf "teststring" | awk '{print length}'

Output without linebreak using echo and printf.

    echo "teststring" | awk -v ORS= '{print length}'

    printf "teststring" | awk -v ORS= '{print length}' 

Other approaches.

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
