#!/bin/bash


## Settings
INT="ens3" #default int, if no int int ip.txt file

#FOR firstvds.com
DEF="10.0.0.1" #default route if no def_route int ip.txt file

#local ip base for openvpn
baseip="192.168.255."

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
iptables -A INPUT -p tcp -m multiport --dports 22,80 -j ACCEPT

EOF


table=100
for item in $ips
do


echo $item
    ip=`echo "$item" | cut  -d "," -f 1`
    int=`echo $item | cut -s -d "," -f 2`
    [[   -z  $int  ]] && int=$INT
    def=`echo $item | cut -s -d "," -f 2`
    [[   -z  $def  ]] && def=$DEF
    intip="$baseip$table" ##VPN IP
    echo -e "up addr add $ip dev $int  " >>add_int.txt
    echo -e "$table,$intip" >>ipp.txt
    echo -e "ip addr del $ip dev $int " >> init_route.sh
    echo -e "ip addr add $ip dev $int " >> init_route.sh
    echo -e "ip link set dev $int up" >> init_route.sh
    echo -e "ip rule del from $ip dev $int table $table" >> init_route.sh
    echo -e "ip rule add from $ip dev $int table $table" >> init_route.sh
    echo -e "ip rule del from $intip table $table " >> init_route.sh
    echo -e "ip rule add from $intip table $table " >> init_route.sh
    echo -e "ip route del default via $def dev $int table $table ">> init_route.sh
    echo -e "ip route add default via $def dev $int table $table ">> init_route.sh
#    echo -e "iptables -t nat -D POSTROUTING -o $int -j MASQUERADE">> init_route.sh
#    echo -e "iptables -t nat -A POSTROUTING -o $int -j MASQUERADE">> init_route.sh
    echo -e "iptables -t nat -D POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh
    echo -e "iptables -t nat -A POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> init_route.sh

    echo -e "ip rule del from $ip dev $int table $table" >> del_route.sh
    echo -e "ip rule del from 192.168.255.$table table $table " >> del_route.sh
    echo -e "ip route del default via $def dev $int table $table ">> del_route.sh
#    echo -e "iptables -t nat -D POSTROUTING -o $int -j MASQUERADE">> del_route.sh
    echo -e "iptables -t nat -D POSTROUTING -s $intip -o $int -j SNAT --to-source $ip ">> del_route.sh


((table++))
done

echo -e "iptables -A FORWARD -o tun0 -j ACCEPT \niptables -A FORWARD -i tun0 -j ACCEPT\n" >>init_route.sh
echo -e "iptables -A INPUT -p tcp -m multiport --dports 443,1194 -j ACCEPT \n" >>init_route.sh
echo -e "iptables -A INPUT -p udp -m multiport --dports 443,1194 -j ACCEPT \n" >>init_route.sh


