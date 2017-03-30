#!/bin/bash

LOWER_THRESHOLD=$(($(nproc)/2))
UPPER_THRESHOLD=$(nproc)

output=""
for i in $(cat /proc/loadavg | cut -d ' ' -f 1-3)
do
    j=${i%.*}
    if [ $j -lt $LOWER_THRESHOLD ]
    then
	output=$output" #[fg=white]$i#[fg=white]"
    elif [ $j -gt $UPPER_THRESHOLD ]
    then
	output=$output" #[fg=red]$i#[fg=white]"
    else
	output=$output" #[fg=yellow]$i#[fg=white]"
    fi
done
echo "$output"
