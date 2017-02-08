#!/bin/bash
#@version 0.1
#@author qh

logpwd=/var/log/mislog/
[ ! -d $logpwd ] && mkdir -p $logpwd

log_1=(`cat $logpwd$1 |awk -F '.' '{print $1}' `)
log_2=(`cat $logpwd$2 |awk -F '.' '{print $1}' `)
log_0=(`cat $logpwd$1 |awk '{print $2}' `)

logline=$[${#log_1[@]}-1]

for i in `seq 0 $logline`
do
echo -e " \t${log_1[$i]} \t${log_2[$i]} \t$[${log_1[$i]}-${log_2[$i]}] \t${log_0[$i]}"
done
