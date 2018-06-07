
ip addr del 5.200.53.249/24 dev ens160 
ip rule del from 5.200.53.249/24 dev ens160 table 1000
ip rule del from 192.168.252.10 table 1000 
ip route del default via 5.200.53.1 dev ens160 table 1000 
iptables -t nat -D POSTROUTING -s 192.168.252.10 -o ens160 -j SNAT --to-source 5.200.53.249 
ip addr del 5.200.53.203/24 dev ens160 
ip rule del from 5.200.53.203/24 dev ens160 table 1001
ip rule del from 192.168.252.11 table 1001 
ip route del default via 5.200.53.1 dev ens160 table 1001 
iptables -t nat -D POSTROUTING -s 192.168.252.11 -o ens160 -j SNAT --to-source 5.200.53.203 
ip addr del 5.200.53.196/24 dev ens160 
ip rule del from 5.200.53.196/24 dev ens160 table 1002
ip rule del from 192.168.252.12 table 1002 
ip route del default via 5.200.53.1 dev ens160 table 1002 
iptables -t nat -D POSTROUTING -s 192.168.252.12 -o ens160 -j SNAT --to-source 5.200.53.196 
