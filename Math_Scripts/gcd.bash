#!/usr/bin/bash

#a=2582
#b=1549

a=5184
b=3456

function gcd() {
    local x=$1
    local y=$2
    while [ $y -gt 0 ]; do
        local t=$x
        x=$y
        y=$((t%y))
    done
    echo $x
}



gcd $a $b

exit 1

m=$a
if [ $b -lt $m ]
then
m=$b
fi
while [ $m -ne 0 ]
do
x=`expr $a % $m`
y=`expr $b % $m`
if [ $x -eq 0 -a $y -eq 0 ]
then
echo gcd of $a and $b is $m
break
fi
m=`expr $m - 1`
done
