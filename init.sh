#!/bin/bash


## Settings
INT="ens3" #default int, if no int int ip.txt file

#FOR firstvds.com
DEF="188.120.239.254" #default route if no def_route int ip.txt file
MASK="28"

#local ip base for openvpn
baseip="192.168."
#third octet of IP 
third="252"

IFS=$'\n'
ips=`cat ip.txt ` ## FORMAT IP,int(opt),def_route(opt),mac(opt)

echo > add_int.txt
echo > ipp.txt
echo > del_route.sh

##MINIMAL iptables
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

# begin table
table=1000
#Begin internal IP 4-octet
i=5
#constant user part, like user_
preuser=""
#begin login number, user_1
user=1
#maximum address
maxip=252

for item in $ips
do


echo $item
if [ "$i" -gt "$maxip" ]; then
((third++)) #increment 3-octet
    i=10    # 4-octet
fi

    ip=`echo "$item" | cut  -d "," -f 1`
    int=`echo $item | cut -s -d "," -f 2`
    [[   -z  $int  ]] && int=$INT
    def=`echo $item | cut -s -d "," -f 2`
    [[   -z  $def  ]] && def=$DEF
# OLD
#    intip="$baseip$third$table" ##VPN IP
# NEW
    intip="$baseip$third.$i" ##VPN IP
    echo -e "up addr add $ip dev $int  " >>add_int.txt
    echo -e "$user,$intip" >>ipp.txt
    echo -e "ip addr del $ip/$MASK dev $int " >> init_route.sh
    echo -e "ip addr add $ip/$MASK dev $int " >> init_route.sh
    echo -e "ip link set dev $int up" >> init_route.sh
    echo -e "ip rule del from $ip dev $int table $table" >> init_route.sh
    echo -e "ip rule add from $ip dev $int table $table" >> init_route.sh
    echo -e "ip rule del from $intip table $table " >> init_route.sh
    echo -e "ip rule add from $intip table $table " >> init_route.sh
    echo -e "ip route del default via $DEF dev $int table $table ">> init_route.sh
    echo -e "ip route add default via $DEF dev $int table $table ">> init_route.sh
#    echo -e "iptables -t nat -D POSTROUTING -o $int -j MASQUERADE">> init_route.sh
#    echo -e "iptables -t nat -A POSTROUTING -o $int -j MASQUERADE">> init_route.sh
    echo -e "iptables -t nat -D POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh
    echo -e "iptables -t nat -A POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh

    echo -e "ip addr del $ip/$MASK dev $int " >> del_route.sh

    echo -e "ip rule del from $ip/$MASK dev $int table $table" >> del_route.sh
    echo -e "ip rule del from $intip table $table " >> del_route.sh
    echo -e "ip route del default via $DEF dev $int table $table ">> del_route.sh
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
