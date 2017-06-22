#!/bin/bash

##initial reads and writes
r1=$(cat /sys/block/sda/stat | awk '{print $1}')
w1=$(cat /sys/block/sda/stat | awk '{print $5}')

sleep 5

##reads and writes after 5 seconds
r2=$(cat /sys/block/sda/stat | awk '{print $1}')
w2=$(cat /sys/block/sda/stat | awk '{print $5}')

r=$(($r2 - $r1))
w=$(($w2 - $w1))

#I/O per 5 seconds to per 1 second
r=$(($r / 5))
w=$(($w / 5))

echo -e '\U1F4BD' $r $w
