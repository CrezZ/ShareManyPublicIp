#!/bin/bash

##ADD THIS TO CRON FROM ROOT
#Create dynamically SNAT to external ip address from mysql ext_ip table

. /etc/openvpn/scripts/config.sh
. /etc/openvpn/scripts/functions.sh

IFS=$'\n'

#Select ext_ip static IP if present
user_ip2=$(mysql -h$HOST -P$PORT -u$USER -p$PASS $DB -sN -e  "select user_id, user_ip1, user_ip2 from user where user_ip1 IS NOT NULL")

#tfile=$(mktemp)

for item in $user_ip2
do

user_id=`echo "$item" | cut  -d$'\t' -f 1`        #user id
int_ip=`echo $item | cut -s -d$'\t' -f 2`
[[   -z  $int_ip  ]] && int_ip=''               #ip1 int
ext_ip=`echo $item | cut -s -d$'\t' -f 3`
[[   -z  $ext_ip  ]] && ext_ip=''               #ip2 ext

#echo $user_id $int_ip $ext_ip
if [ -n "$int_ip" ] && [ -n "$ext_ip" ]; then

#Get from iptables SNAT ip
iptable=$(iptables -t nat -S | grep "$int_ip/" )
if [ -z "$iptable" ]; then
iptable="-A POSTROUTING -s $int_ip/32 -o ens3 -j SNAT --to-source 0.0.0.0"
fi


current_int_to_ext=`echo "$iptable" | sed 's/.*--to-source \([0-9.]\+\)/\1/g' `

#echo "current" $int_ip $ext_ip $current_int_to_ext
#echo $iptable

#compare
  if [ "$current_int_to_ext" != "$ext_ip" ]; then
   #delete rule and insert new rule
    del=$(echo $iptable | sed 's/-A/-D/')
    add=$(echo $iptable | sed "s/-s \([0-9.]\+\)/-s $int_ip/" | sed "s/--to-source \([0-9.]\+\)/--to-source $ext_ip/")
    logger "del $del"
    logger "add iptables -t nat $add"
    cmd1="iptables -t nat $del"
    cmd2="iptables -t nat $add"
echo $cmd2 >1.txt

sh -c "$cmd1"
sh -c "$cmd2"

  fi


fi

done

