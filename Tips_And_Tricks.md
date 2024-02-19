# Tips and Tricks

<p align="justify">You will gradually find useful tips and tricks here. As these are separate from the actual programming activities, I have created a separate file for this purpose.</p>

> [!Note]
> Subsequently ~$ represents the command prompt in the terminal window. 

## Prevent overwriting files

<p align="justify">To prevent overwriting files the command <code>set</code> can be used.</p>

```bash
    ~$ echo "foo" > "bar"
    ~$ set -o noclobber                          # This line is the trick.
    ~$ echo "foo" > "bar"
    ~$ bash: bar: cannot overwrite existing file
```

<p align="justify">The former foo and bar are so-called common metasyntactic variables.</p>

## Prime numbers

<p align="justify">Prime numbers can be determined with a bash script or with the command factor.</p>

```bash
    ~$ factor 32
    ~$ 32: 2 2 2 2 2
```

<p align="justify">To get only the prime numbers, use the following command.</p>

```bash
    ~$ factor 32 | sed 's/^.*: \(.*\)/\1/'
    ~$ 2 2 2 2 2
```

## Incrementing and decrementing numbers

### Incrementing integer numbers 

<p align="justify">Subsequently there is a list of methods for incrementing an integer number together with the time the execution takes for a maximum value of <code>n=100000</code>.</p>
    
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

<p align="justify">It should be noted that <code>expr</code> should not be used. The script for performing this test can be found in the Math_Scripts folder.</p>

> [!WARNING]
> The prefix increment <code>$((++i))</code> and the postfix increment <code>$((i++))</code> do not behave the same way.

Try on the command line the following:

    ~$ i=0; echo $((i++))
    ~$ 0

versus

    ~$ i=0; echo $((++i))
    ~$ 1

### Decrementing integer numbers 

<p align="justify">Subsequently there is a list of methods for decrementing an integer number together with the time the execution takes for a maximum value of <code>n=100000</code>.</p>

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

<p align="justify">It should be noted that <code>expr</code> should not be used. The script for performing this test can be found in the Math_Scripts folder.</p>

> [!WARNING]
> The prefix decrement <code>$((--i))</code> and the postfix decrement <code>$((i--))</code> do not behave the same way.

Try on the command line the following:

    ~$ i=1; echo $((i--))
    ~$ 1

versus

    ~$ i=1; echo $((--i))
    ~$ 0
    
## Greatest common divisor of a number

<p align="justify">The following snippet calculates the greatest common divisor of a number quite fast.</p>

```bash
    #!/usr/bin/bash

    a=5184
    b=3456

    while [[ "${b}" -gt 0 ]]; do
        n="${a}"
        a="${b}"
        b=$((n%b))
    done
    echo "${a}"
```
<p align="justify">Use e.g. [1,2] for a verification how the snippet works. ShellCheck is used to check the code [3].</p>

## Functions

<p align="justify">Both tips are uncommen but somehow helpful. First make variables in a function local if they are not global. Second declare all the used variables in a suitable manner.</p>

<p align="justify">Use the return statement as it is intended. The return statement is intended for the return of an exit code that can be queried via the system variable <code>$?</code>. Functions that return <code>true</code> which is 0 and <code>false</code> which is unequal 0 are fine.</p>

<p align="justify">Functions that return numeric values (strings will raise an error) use the return statement at least unusually with various negative side effects.</p>

## Arrays

<p align="justify">This is an array with 10 elements:</p>

```bash
    # Array with ten elements.
    ARR=("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")
```

<p align="justify">This is an array with 1 element:</p>

```bash
    # Array with one element.
    ARR=("1 2 3 4 5 6 7 8 9 0")
```

<p align="justify">To get an array with 10 elements one can do.:</p>

```bash
    # Now it will become an array with 10 elements.
    ARR=($ARR)
```

## Pitfall using arrays in functions

<p align="justify">In the next example we are adding two values to an array within a function.</p>

```bash
    # Declare an indexed array.
    declare -a ARR
    ARR=(1 2 3 4 5 6 7 8 9 0)

    # Add foo and bar to the array.
    foobar () {
        local arr=("$@")
        arr+=("foo" "bar")
        echo "${arr[@]}"
    }

    # This approach will fail.
    # Call function.
    ARR=$(foobar "${ARR[@]}")      # Wrong!

    # Print array.
    for i in "${ARR[@]}"; do
        echo $i
    done

    # This approach will work.
    # Call function
    ARR=($(foobar "${ARR[@]}"))    # Right!

    # Print array.
    for i in "${ARR[@]}"; do
        echo $i
    done
```

<p align="justify">The round brackets around the command substitution are the step needed to get back the array in the expected manner.</p>

```bash
    TMP=$(foobar "${ARR[@]}")    # Command substitution.
    ARR=(${TMP})                 # Create an array again.  
```

## Remove numbers from array

<p align="justify">Some proposed ways for removing elements from an arrays will work in special cases and for stings. The way using indexing is working well, but one needs a loop over all elements. I figured out a way, which works well so far.</p>

```bash
    # Declare the array. 
    declare -a ARR

    # Create an array with 20 numbers.
    for ((i=1; i<=20; i++)); do ARR+=("${i}"); done

    # Remove numbers 2...19 from array. 
    for element in $(seq 2 19); do
        ARR=($(sed 's/^/ /;s/$/ /;s/ '"${element}"' / /' <<<${ARR[*]}))
    done
```

<p align="justify">The proposed way uses the Bash properties of arrays and sed for removing elements in a onliner.</p>

## Print empty lines

<p align="justify">A blank line is sometimes required for the output on the screen. Here are some ways to print a newline.</p>

```bash
    # Using command echo and an empty space.
    # -e expands escape sequences.

    echo
    echo ''
    echo ""
    echo -e ''
    echo -e ""

    # Using command echo and carriage return (CR) and line feed (LF).
    # -n suppresses the printing of a new line.

    echo -n -e "\n"    or    echo -n -e "\r\n"
    echo -e -n "\n"    or    echo -e -n "\r\n"
    echo -en "\n"      or    echo -en "\r\n"
    echo -ne "\n"      or    echo -ne "\r\n"

    echo -ne "\0013"   or    echo -ne "\0013\0015"
    echo -ne "\x0A"    or    echo -ne "\x0D\x0A"
    echo -ne "\015"    or    echo -ne "\015\012"

    echo -ne \\x0A     or    echo -ne \\x0D\\x0A
    echo -ne \\015     or    echo -ne \\015\\012

    echo -n $'\x0A'    or    echo -n $'\x0D\x0A'
    echo -n $'\015'    or    echo -n $'\015\012'

    echo -ne $'\cJ'    or    echo -ne $'\cM\cJ'

    # Using command printf.

    printf "%b" \\0013     or    printf "%b" \\0015\\0013
    printf "%b" "\0013"    or    printf "%b" "\0015\0013"
    printf "%b" \\x0A      or    printf "%b" \\x0A\\x0D
    printf "%b" "\x0A"     or    printf "%b" "\x0A\x0D"
    printf "%b" \\012      or    printf "%b" \\012\\015
    printf "%b" "\012"     or    printf "%b" "\012\015"

    printf "\x0A"          or    printf "\x0A\x0D"
    printf "\012"          or    printf "\012\015"

    printf $'\cJ'          or    printf $'\cM\cJ'
    printf "%s" $'\cJ'     or    printf "%s" $'\cM\cJ'
    printf "%b" $'\cJ'     or    printf "%b" $'\cM\cJ'

    printf "\n"            or    printf "\r\n"
    printf "%b" "\n"       or    printf "%b" "\r\n"
```

<p align="justify">I currently prefer the last method presented.</p>

## Resources

[1]    www&#8203;.onlinegdb.com/online_bash_shell

[2]    www&#8203;.jdoodle.com/test-bash-shell-script-online/

[3]    www&#8203;.shellcheck.net/

[4]    tldp.org/LDP/abs/html/

[5]    www&#8203;.gnu.org/software/bash/manual/bash.html

[6]    mywiki.wooledge.org/BashPitfalls

[7]    www&#8203;.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html

[8]    en.wikipedia.org/wiki/C0_and_C1_control_codes

[9]    en.wikipedia.org/wiki/Newline

[10]     www&#8203;.unicode.org/standard/reports/tr13/tr13-5.html

[11]    www&#8203;.geeksforgeeks.org/control-characters/

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
      <td>2JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5</td>
      <td>Bitcoin</td>
    </tr>
    <tr>
      <td>0x31042e2F3AE241093e0387b41C6910B11d94f7ec</td>
      <td>Ethereum</td>
    </tr>
  </tbody>
</table>

<hr width="100%" size="1">

<p align="center">File last modified 14/02/2024</p>

