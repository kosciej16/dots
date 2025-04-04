#!/bin/bash
#
tags=$(timew summary :ids | tail -n +4 | cut -d "@" -f 2 | cut -d" " -f2 | sort | uniq)
current=$(timew | head -1 | cut -d" " -f2)

res=""
for t in $tags ; do
    total=$(timew summary $t | tail -2 | awk '{$1=$1; print}')
    color=$COLOR_DEFAULT
    if [[ $t == $current ]] ; then
        color=$COLOR_GREEN
    fi
    total_hm=$(echo "$total" | cut -d ':' -f 1,2)
    res="$res ^fg($color)$t $total_hm^fg()"
done
echo $res
