#!/bin/bash
#@version 0.2
#@author qh
#@192.168.1.66

## =======1st query=======
## su - oracle
## query the infomation
## sqlplus '/as sysdba' @/home/oracle/auto/catlog.sql
## exit

## 
echo -e " \n\n status of free_space: "
runuser -l oracle -c 'sqlplus "/as sysdba" @/home/oracle/auto/sql/query_1.sql' 2>/dev/null |sed -n 11,49p
sleep 5


## =======2nd query=======
## calc UTC time
NOW=$(date +%s)
LAST_TEN_MINUTE=$(($NOW-600))

## make query_2.sql
cat <<EOF >/home/oracle/auto/sql/query_2.sql
select count(*) from mcc_last_pos t where t.utc > $LAST_TEN_MINUTE;
exit;
EOF

## 
#echo time stamp $LAST_TEN_MINUTE before $NOW
echo -e "\n\nselect count(*) from mcc_last_pos t where t.utc > ${LAST_TEN_MINUTE}; \n "
runuser -l oracle -c 'sqlplus "smartgps2006/mcctaxi" @/home/oracle/auto/sql/query_2.sql' 2>/dev/null | grep -A2 COUNT