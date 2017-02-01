#!/bin/bash
#@function checksurvival
#@filename chechsurvival
#@version 0.1
#@author qh

#@scriptname=catalog
#@scripttype=frequence
#@cdt=catalog day time
#@llh=log lasthour

#
usage()
{
case $1 in
        noarg)
        echo "Need a file path"
        ;;
        badarg)
        echo  "Log does not exist : $1  , or check wether is full path or not please."
        ;;
esac
exit 1
}

#lfp:log full path
[ ! -z $1 ] && lfp=$1 || usage noarg
[ ! -f $1 ] && usage badarg

#rfp:result full path
#[ ! -z $2 ] && rfp=$2 ;

## perpare date using 4 checking
cdt=`date -d -1hour +%F-%H`;
llh=`cat $1 | awk -F '[: ]' '{print $1"-"$2}' |grep $cdt | uniq -c |awk '{print $1}'`
logsize=`du -h $1|awk '{print $1}'`

## check 1st time
##
echo -n "survival check :" && [[ $llh -gt 0 ]] && echo "ok !! ${llh}L in last hour. ${logsize} " && exit 0 || echo "failed : ${logsize} "

## check 2nd time (if failed exist)
## exit0 (if success)
## exit2 (if failed)
[[ $llh -eq 0 ]] && [ -f $lfp.1 ] || exit 2 && echo "perpare to recheck ... " && $0 ${lfp}.1

##
exit 0