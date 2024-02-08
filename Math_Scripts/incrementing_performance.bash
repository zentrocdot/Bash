#!/usr/bin/bash
#
# Incrementing NUMBER Performance

n=100000

EXP=('i=$((i+1))'
     'i=$((i+=1))'
     '((i=i+1))'
     '((i+=1))'
     '((i++))'
     '((++i))'
     'let "i=i+1"'
     'let "i+=1"'
     'let "i++"'
     'let "++i"'
     'let i=i+1'
     'let i+=1'
     'let i++'
     'let ++i'
     'declare -i i; i=i+1'
     'declare -i i; i+=1'
     'i=$(expr $i + 1)')

count=0

for exp in "${EXP[@]}"
do
    script="s${count}"
    echo -e "n="$n"\ni=0\nwhile [[ \$i != \$n ]]; do\n"${exp}"\ndone\necho \$i" > "${script}"
    printf "%-16s" "${exp}"
    inc_res=$(bash "$script")
    if [[ $inc_res == $n ]]; then
        { time bash "$script"; } |& grep user | sed 's/user//g'
    fi
    rm $script
    ((++count))
done

exit 0
