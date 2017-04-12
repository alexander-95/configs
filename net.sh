#!/bin/bash

netstats=/sys/class/net/enp0s25/statistics

units=(b kb mb gb tb)
i=0
j=0

#initial network usage
r1=$(cat $netstats/rx_bytes)
t1=$(cat $netstats/tx_bytes)

sleep 5

#usage after 5 more seconds
r2=$(cat $netstats/rx_bytes)
t2=$(cat $netstats/tx_bytes)

#network usage
rx=$(($r2 - $r1))
tx=$(($t2 - $t1))

#bytes to bits
rx=$(($rx * 8))
tx=$(($tx * 8))

#per 5 seconds to per 1 second
rx=$(($rx / 5))
tx=$(($tx / 5))

while [ $rx -gt 1024 ]
do
    rx=$(($rx / 1024))
    i=$(($i + 1))
done

while [ $tx -gt 1024 ]
do
    tx=$(($tx /1024))
    j=$(($j + 1))
done

echo -e '\U2B07' $rx ${units[i]}/s '\U2B06' $tx ${units[j]}/s
