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

## Pitfall using arrays in functions

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
    ARR=$(foobar "${ARR[@]}")

    # Print array.
    for i in "${ARR[@]}"; do
        echo $i
    done

    # This approach will work.
    # Call function
    ARR=($(foobar "${ARR[@]}"))

    # Print array.
    for i in "${ARR[@]}"; do
        echo $i
    done

```

## Resources

[1]    www&#8203;.onlinegdb.com/online_bash_shell

[2]    www&#8203;.jdoodle.com/test-bash-shell-script-online/

[3]    www&#8203;.shellcheck.net/

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

