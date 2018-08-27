#!/bin/bash


## Settings
INT="ens3" #default int, if no int int ip.txt file

#FOR firstvds.com
DEF="188.120.239.254" #default route if no def_route int ip.txt file
MASK="20"  #default mask for public IP

#local ip base for openvpn, usually 192.168.
baseip="192.168."
#third octet of IP , 192.168.XXX
third="252"

# begin iproute2 table
table=1000
#Begin internal IP address 4th octet, like this  192.168.252.XX
begin_ip=5
#constant user part, like user_
preuser=""
#begin login number, user_X
user=1
#maximum address for prevouse octet increment 
maxip=254

#CUstomize routing (0|1), Warning! Use this only for several interfaces routing (PBR)
customize_route=0


IFS=$'\n'
#GET public ip addresses
ips=`cat ip.txt ` ## FORMAT IP,int(opt),def_route(opt),mac(opt)

#Clear files
echo > add_int.txt
echo > ipp.txt
echo > del_route.sh

##MINIMAL init iptables
cat  <<EOF >init_route.sh 
#!/bin/sh

iptables -F
iptables -X
iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 22,80,443 -j ACCEPT
iptables -A INPUT -i tun0 -j ACCEPT
EOF

#begin IP
i=$begin_ip
#hash array for user binding
declare -A bind_user

for item in $ips
do


echo $item
if [ "$i" -gt "$maxip" ]; then  #if last ip
((third++)) #increment 3-octet
    i=$begin_ip    # 4-octet
fi  
#parse ip,int,GW,username,int_ip
    ip=`echo "$item" | cut  -d "," -f 1`	#external IP
    int=`echo $item | cut -s -d "," -f 2`
    [[   -z  $int  ]] && int=$INT		#custom interface (opt)
    def=`echo $item | cut -s -d "," -f 3`
    [[   -z  $def  ]] && def=$DEF		#custom gateway  (opt)
    username=`echo $item | cut -s -d "," -f 4`
    [[   -z  $username  ]] && username=$user		#custom username (opt)
    intip=`echo $item | cut -s -d "," -f 5`
    [[   -z  $intip  ]] && intip="$baseip$third.$i" ##VPN IP
# OLD
#    intip="$baseip$third$table" ##VPN IP
# NEW
#    intip="$baseip$third.$i" ##VPN IP
    echo -e "up addr add $ip dev $int  " >>add_int.txt
#For openvpn ifconfig-pool-persist
    echo -e "$username,$intip" >>ipp.txt
#delete old ip
    echo -e 'echo del old ip from dev' >>init_route.sh
    echo -e "ip addr del $ip/$MASK dev $int " >> init_route.sh
#init new ip
    echo -e 'echo add new ip from dev' >>init_route.sh
    echo -e "ip addr add $ip/$MASK dev $int " >> init_route.sh
#Up new int
    echo -e "ip link set dev $int up" >> init_route.sh
#################################################################################
#Custom route for PBR

    if [ "$customize_route" -eq "1" ]; then

#Del old table
    echo -e 'echo del old route dev rule from table' >>init_route.sh
    echo -e "ip rule del from $ip dev $int table $table" >> init_route.sh
#Add new table, new interface  and external ip into table
    echo -e 'echo  add route dev rule from table' >>init_route.sh
    echo -e "ip rule add from $ip dev $int table $table" >> init_route.sh
#del old routes
    echo -e 'echo del old route rule from table' >>init_route.sh
    echo -e "ip rule del from $intip table $table " >> init_route.sh
#add new local route in table
    echo -e 'echo add route rule from table' >>init_route.sh
    echo -e "ip rule add from $intip table $table " >> init_route.sh
#del old default routes
    echo -e 'echo del old route in table' >>init_route.sh
    echo -e "ip route del default via $def dev $int table $table ">> init_route.sh
#add new default route in table
    echo -e 'echo add route in table' >>init_route.sh
    echo -e "ip route add default via $def dev $int table $table ">> init_route.sh
 fi   #if customize_route


#    echo -e "iptables -t nat -D POSTROUTING -o $int -j MASQUERADE">> init_route.sh
#    echo -e "iptables -t nat -A POSTROUTING -o $int -j MASQUERADE">> init_route.sh
#delete old SNAT rules
    echo -e 'echo delete old  nat ' >>init_route.sh

    echo -e "iptables -t nat -D POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh
#Add new SNAT rules
    echo -e 'echo install nat 2' >>init_route.sh
    echo -e "iptables -t nat -A POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh


#Create del all script 
    echo -e "ip addr del $ip/$MASK dev $int " >> del_route.sh
    echo -e "ip rule del from $ip/$MASK dev $int table $table" >> del_route.sh
    echo -e "ip rule del from $intip table $table " >> del_route.sh
    echo -e "ip route del default via $def dev $int table $table ">> del_route.sh
#    echo -e "iptables -t nat -D POSTROUTING -o $int -j MASQUERADE">> del_route.sh
    echo -e "iptables -t nat -D POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> del_route.sh


((table++))
((i++))
((user++))

done

echo -e "iptables -A FORWARD -o tun0 -j ACCEPT \niptables -A FORWARD -i tun0 -j ACCEPT\n" >>init_route.sh
echo -e "iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT \n" >>init_route.sh
echo -e "iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT \n" >>init_route.sh
echo -e "iptables -A OUTPUT -p tcp -m multiport --dports 22 -j LOG --log-prefix 'SSH OUTPUT: '\n" >>init_route.sh
echo -e "iptables -A OUTPUT -p tcp -m multiport --dports 22 -j DROP\n" >>init_route.sh
echo -e "iptables -A OUTPUT -p udp -m multiport --dports 443,80,53 -j ACCEPT\n" >>init_route.sh

echo -e "service fail2ban restart \n" >>init_route.sh

chmod 755 init_route.sh
