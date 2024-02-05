# Tipps And Trick

## Length of string

Output with linebreak using echo and printf.

    echo "teststring" | awk '{print length}'

    printf "teststring" | awk '{print length}'

Output without linebreak using echo and printf.

    echo "teststring" | awk -v ORS= '{print length}'

    printf "teststring" | awk -v ORS= '{print length}' 

Other approaches.

    expr length "teststring"

## References

[1]  stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split
