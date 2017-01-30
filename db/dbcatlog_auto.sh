#!/bin/bash
#@version 0.1
#@author qh

while :
do 
logtime=`date +%y%m%d%H`
runuser -l oracle -c 'sqlplus "/as sysdba" @/home/oracle/auto/sql/query_1.sql'  2>/dev/null |  grep -v '10.2.0.1.0' |grep -E "[[:digit:]]+\.[[:digit:]]+\>"    > /var/log/mislog/$logtime 
sleep 10800
done