
ip addr del 188.120.238.41/28 dev ens3 
ip rule del from 188.120.238.41/28 dev ens3 table 1000
ip rule del from 192.168.252.5 table 1000 
ip route del default via 188.120.239.254 dev ens3 table 1000 
iptables -t nat -D POSTROUTING -s 192.168.252.5 -o ens3 -j SNAT --to-source 188.120.238.41 
ip addr del 188.120.229.117/28 dev ens3 
ip rule del from 188.120.229.117/28 dev ens3 table 1001
ip rule del from 192.168.252.6 table 1001 
ip route del default via 188.120.239.254 dev ens3 table 1001 
iptables -t nat -D POSTROUTING -s 192.168.252.6 -o ens3 -j SNAT --to-source 188.120.229.117 
#ip addr del 188.120.227.150/28 dev ens3 
ip rule del from 188.120.227.150/28 dev ens3 table 1002
ip rule del from 192.168.252.7 table 1002 
ip route del default via 188.120.239.254 dev ens3 table 1002 
iptables -t nat -D POSTROUTING -s 192.168.252.7 -o ens3 -j SNAT --to-source 188.120.227.150 
