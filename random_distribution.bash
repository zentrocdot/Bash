#!/bin/bash
# shellcheck disable=SC2001
# shellcheck disable=SC2005

# Further reading:
# http://www.oemg.ac.at/Mathe-Brief/fba2014/3_Tiki_Schuelerpreis2014.pdf
# http://tldp.org/LDP/abs/html/randomvar.html

# Set the locale.
LANG=en_US.utf8

# Initialise the maximal number.
MAX=100

# Initialise the number of elements.
NUMELE=10

# Declare the associative array.
declare -A DIST

# Set the debug flag.
DEBUG="FALSE"
# DEBUG="TRUE"

# ==============================================================================
# Function seed()
#
# DESCRIPTION:
#     The function calculates a seed within the range of 0 to 32767. This
#     is done by getting nanoseconds from the Linux command date. Then the
#     nanoseconds are mapped to the range from 0 to 32767. Finally the value
#     of seed is rounded and converted to an integer.
#
# INPUT:  None   ->  No input from function parameter
# OUTPUT: $seed  ->  Value of seed
# RETURN: 0      ->  No error
#
# Last modified: 2018/08/01
# ==============================================================================
function seed() {
    # Declare the local variables.
    local maxint val nano seed
    # Initialise the local variables.
    maxint=32767; val=1000000000
    # Get nanoseconds from function date.
    nano=$(echo "$(date +%N)" | sed 's/^[0]*//g')
    # Calculate a floating point number in a range from 0 to 32767.
    seed=$(echo "scale=2; (${nano}*${maxint})/${val}" | bc -l)
    # Round the value of seed.
    seed=$(echo "(${seed}+0.5)/1" | bc)
    # Output the value of seed.
    printf "%d" "${seed}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function init_rand()
#
# INPUT:  None  ->  No input from function parameter
# Output: None  ->  No output
# RETURN: 0     ->  No error
#
# Last modified: 2018/08/01
# ==============================================================================
function init_rand() {
    # Declare the local variable.
    local newseed
    # Get new seed.
    newseed="$(seed)"
    # Set RANDOM with new seed.
    RANDOM="${newseed}"
    # Print seed to screen.
    [[ "${DEBUG}" == "TRUE" ]] && printf "%s\n" "Seed: ${newseed}" >/dev/tty
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function rand()
#
# FUNCTION CALL: init_rand
#
# INPUT:  $1  ->  Range of random numbers
# RETURN: 0   ->  No error
#
# Last modified: 2018/08/01
# ==============================================================================
function rand() {
    # Declare the local variables.
    local max r val maxrnd
    # Assign the function parameter to the local variable.
    val=$1
    # Initialise the local variable.
    maxrnd=32767
    # Calculate the maximal possible random number.
    max=$(( (maxrnd / val) * val ))
    # Initialise $RANDOM.
    init_rand
    # Get a random number.
    r=$RANDOM
    # Discard random numbers greater equal the maximal possible random number.
    while (( r > max )); do
        # Print random number to screen.
        [[ "${DEBUG}" == "TRUE" ]] && printf "%s\n" "r: ${r}" >/dev/tty
        # Initialise $RANDOM.
        init_rand
        # Get a random number.
        r=$RANDOM
    done
    # Output the random number.
    printf "%s" "$(( r % val ))"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function rand2ass()
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function rand2ass() {
    # Declare the local variables.
    local random count max
    # Initialise $RANDOM.
    init_rand
    # Assign the function parameter to the local variable.
    max=$1
    # Initialise $RANDOM.
    init_rand
    # Loop over the given range.
    for _ in $(seq 1 "${max}")
    do
        case "${METHOD}" in
            1) random=$(( RANDOM % ${NUMELE} ));;
            2) random=$(rand ${NUMELE});;
            3) random=$(( $(head -c 1 /dev/urandom | od -An -t u1) % ${NUMELE}));;
            4) random=$(shuf -i 0-$((NUMELE-1)) -n 1);;
            5) random=$(awk -v seed="$(seed)" -v range="${NUMELE}" 'BEGIN {srand(seed); printf("%d", rand()*range)}');;
        esac
        count="${DIST[${random}]}"
        (( count++ ))
        DIST["${random}"]="${count}"
    done
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function arr2rnd()
#
# INPUT:  None  ->  No input from function parameter
# RETURN: 0     ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function arr2rnd() {
    # Declare the local variables.
    local r sum temp
    sum=''
    for r in "${!DIST[@]}"; do
        temp="${DIST[$r]}"
        sum="$sum $temp"
    done
    # shellcheck disable=SC2086
    sum=$(echo ${sum} | sed 's/ /\n/g')
    echo "${sum}"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function barchart()
#
# OUTPUT: None  ->  No output
# RETURN: 0     ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function barchart() {
    # Declare the local variables.
    local r sum bm no max
    # Assign the function parameter to the local variable.
    max=$1
    FAC0=$(echo "scale=8; 100/${maxval}" | bc -l)
    FAC1=$(echo "scale=8; ${FAC0}*${MAX}" | bc -l)
    FAC3=$(echo "(${FAC1}+0.5)/1" | bc)
    # Loop over the number of elements.
    for r in $(seq 0 $((NUMELE-1))); do
        sum="${DIST[$r]:-0}"
        no=$(echo "scale=0; (${sum}*${FAC3})/${max}" | bc)
        no=$(echo "(${no}+0.5)/1" | bc)
        bm=$(printf "%${no}b" " " | sed 's/ /▭/g')
        printf "%-3s %-6s %b%s%b\n" "$r" "$sum" "\e[44m" "${bm}" "\e[49m"
    done
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function variance()
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function variance() {
    list=$1
    echo "$list" | \
    awk '
        BEGIN {}
        {
            a[NR]=$1               # Store the data in an array
            sum+=a[NR]             # Keep track of the sum
        }
        END {
            av=sum/NR              # Calculate the average value
            v=0                    # Reset the counter for the variance
            for (i=1;i<=NR;i++)    # Loop through all the values
                v+=(a[i]-av)^2     # Calculate the variance
            print int(v/NR)        # Print the result as integer
            }
        '
    # Return the exit status 0.
    return 0
}
# ==============================================================================
# Function standarddeviation()
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function standarddeviation() {
    list=$1
    echo "$list" | \
    awk '
        BEGIN {}
        {
            a[NR]=$1               # Store the data in an array
            sum+=a[NR]             # Keep track of the sum
        }
        END {
            av=sum/NR              # Calculate the average value
            v=0                    # Reset the counter for the variance
            for (i=1;i<=NR;i++)    # Loop through all the values
                v+=(a[i]-av)^2     # Calculate the variance
            print int(sqrt(v/NR))  # Print the result as integer
            }
        '
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function meanvalue()
#
# INPUT:  $1  ->  List with random values
# RETURN: 0   ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function meanvalue() {
    list=$1
    echo "$list" | \
    awk '
        BEGIN {}
        {
            a[NR]=$1         # Store data in an array
            sum+=a[NR]       # Keep track of the sum
        }
        END {
            av=sum/NR        # Calculate the mean value
            print int(av)    # Print the mean value as integer
        }
        '
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function minvalue()
#
# INPUT:  None    ->  No input from function parameter
# OUTPUT: minval  ->  Minimal value
# RETURN: 0       ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function minvalue() {
    echo -n "$(arr2rnd)" | sort -n | head -1
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function maxvalue()
#
# INPUT:  None    ->  No input from function parameter
# OUTPUT: maxval  ->  Maximal value
# RETURN: 0       ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function maxvalue() {
    echo "$(arr2rnd)" | sort -n | tail -1
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function header()
#
# INPUT:  None  ->  No input
# OUTPUT: None  ->  No output
# RETURN: 0     ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function header() {
    # Print the header into the terminal window.
    echo -e "########################"
    echo -e "# Random Function Demo #"
    echo -e "########################\n"
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function print_scale()
# GLOBAL VARIABLE:
#     $SD
#     $MW
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function print_scale() {
    # Declare the local variables.
    local factor sd av pos1 pos2 pos3 part no bm
    factor=$(echo "scale=8; 100/$maxval" | bc -l)
    sd=$(echo "scale=8; $factor*$SD" | bc -l)
    sd=$(echo "(${sd}+0.5)/1" | bc)
    av=$(echo "scale=8; $factor*$MW" | bc -l)
    av=$(echo "(${av}+0.5)/1" | bc)
    pos1=$(( av-sd ))
    pos2=$(( sd+2 ))
    pos3=$(( sd+2 ))
    printf "%-3s %-6s " " " " "
    printf "%${pos1}s%${pos2}s%${pos3}s\n" "▽" "▼" "▽"
    printf "%-3s %-6s %-10s" " " " " " "
    part=$(echo "scale=8; 100.0/10.0" | bc -l)
    part=$(echo "(${part}+0.5)/1" | bc)
    for i in $(seq 1 11)
    do
        no=$(echo "scale=8; $maxval/10.0" | bc -l)
        no=$(echo "scale=8; $no*$i" | bc -l)
        no=$(echo "(${no}+0.5)/1" | bc)
        printf "%-10s" "$no"
    done
    bm=$(printf "%${part}b" " " | sed 's/ /▯/g')
    printf "\n%-3s %-6s " " " " "
    for i in $(seq 1 6)
    do
        printf "%b%s%b" "\e[45m" "${bm}" "\e[49m"
        printf "%b%s%b" "\e[46m" "${bm}" "\e[49m"
    done
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Function chisquare
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function chisquare() {
    # Declare the local variable.
    local max
    # Assign the function parameter to the local variable.
    max=$1
    echo "$RANDVALS" | \
        awk -v n="${max}" -v quant="${NUMELE}" '
            BEGIN { expinc=(n/quant); charsum=0 } # Initialise the variables
            { sum+=(($1-expinc)^2)/expinc }       # Keep track of the sum
            END { print sum }'                    # Print the sum
    # Return the exit status 0.
    return 0
}

# ==============================================================================
# Funtion chic
#
# RETURN: 0  ->  No error
#
# Last modified: 2018/08/02
# ==============================================================================
function chic() {
    # Declare the local variables.
    local max chiw
    # Assign the function parameter to the local variable.
    max=$1
    awk -v chi="${sum}" -v max="${max}" '
        BEGIN {}
        END {
            result=(sqrt(chi/(chi*max)))
            printf("%.8f",result)
            }' /dev/null
    # Return the exit status 0.
    return 0
}

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Body of script starts here.
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Reset the terminal window.
reset

# Print header into the terminal window.
header

# Get user input.
printf "%s" "Amount of random numbers: "
read -r MAX

# Print an empty line into the terminal window.
printf "\n"

# Set the variable COLUMNS for the  formatting of the select menu.
COLUMNS=25

# Print the menu into the terminal window.
select _ in "Bash function \$RANDOM" "Function rand()" "Command urandom" "Command shuf" "Awk script"; do
    case $REPLY in
        1) METHOD=1; printf "\n%s\n\n" "Using: Bash function \$RANDOM"; break;;
        2) METHOD=2; printf "\n%s\n\n" "Using: User function random()"; break;;
        3) METHOD=3; printf "\n%s\n\n" "Using: Command urandom"; break;;
        4) METHOD=5; printf "\n%s\n\n" "Using: Command shuf";break;;
        5) METHOD=4; printf "\n%s\n\n" "Using: Awk script"; break;;
    esac
done

# Save the random numbers in an associative array.
rand2ass "${MAX}"

# Create a simple list with the random values.
RANDVALS="$(arr2rnd)"

# Calculate the max and min value.
minval=$(minvalue)
maxval=$(maxvalue)

# Calculate the average value.
MW=$(meanvalue "${RANDVALS}")

# Calculate the standard deviation.
SD=$(standarddeviation "${RANDVALS}")

# Calculate the maxval10
maxval10=$(echo "scale=8; $maxval/10.0" | bc -l)
maxval10=$(echo "(${maxval10}+0.5)/1" | bc )

# Print a separator line into the terminal window.
printf "\n%131b\n\n" "\u0020" | sed 's/ /▬/g'

# Print scale.
print_scale

# Print an empty line.
printf "\n\n"

# Print the bar chart into the terminal window.
barchart "${MAX}"

# Print a separator line into the terminal window.
printf "\n%131b\n" "\u0020" | sed 's/ /▬/g'

# Print the amount of random numbers into the terminal window.
echo -e "\nAmount of random numbers: $MAX\n"

# Print the min/max value into the terminal window.
echo -e "Minimal value: ${minval}"
echo -e "Maximal value: ${maxval}"

# Print the mean value into the terminal window.
echo -e "\nArithmetic mean value: $MW\n"

# Print the variance into the terminal window.
echo -e "Variance: $(variance "${RANDVALS}")\n"

# Print the standard deviation into the terminal window.
echo -e "Standard deviation: $SD\n"

# Calculate the weight.
weight=$(echo "scale=8; ($SD*100.0)/($MAX/10.0)" | bc -l)

# Print the weigth into the terminal window.
printf "%s %-.8f %s\n" "Standard deviation in percent relative to the expected mean value:" "${weight}" "%"

# Print a separator line into the terminal window.
printf "\n%131b\n\n" "\u0020" | sed 's/ /▬/g'

# Get the chi-square value.
sum=$(chisquare "$MAX")

# Print the chi-square value into the terminal window.
echo -e "Chi-square: $sum\n"

# Get the chi-square c value.
chiw=$(chic "$MAX")

# Print the weigted chi-square into the terminal window.
printf "%s %0.8f\n" "Weighted chi-square:" "${chiw}"

# Write the elapsed time into th terminal window.
OUT=$(date -d@"$SECONDS" -u +%H:%M:%S)

# Write elapsed time into the terminal window.
echo -e "\nElapsed time: $OUT"

# Exit the script.
exit 0
