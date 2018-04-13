# ShareManyPublicIp

Generator for rules ipables and iproute2 for this:
thereis many Public IP. I want connect to server with OpenVPN and use ONLY one IP (my ip).


0. Pre. Create file ip.txt with this template:
IP,int(opt),def_route(opt),mac(opt)__
for example to customize out IP, out interface and outgoing gateway and link out ip to certanly interface with the MAC:<br />
2.3.4.5,eth12,2.3.4.1,00:01:00:01:00:01__
OR for customize out IP, out interface and outgoing gateway__
2.3.4.5,eth12,2.3.4.1__
OR  for customize only out IP and out interface __
2.3.4.5,eth12__
OR for customize only out IP__
2.3.4.5__
1. Install OpenVPN, iptables (install.sh automate all  - be carefull!)
2. copy openvpn.conf.template to /etc/openvpn/openvpn.conf (if nessesary, EDIT this!, generate keys and certs and check paths)
3. run init.sh. It generate init_route.sh (and del_route.sh for disabling all) and ipp.txt (for openvpn config). 
4. copy ipp.txt to /etc/openvpn and add to config (ifconfig-pool-persist /etc/openvpn/ipp.txt 0)
5. copy init_route.sh to /etc and add to /etc/rc.local string BEFORE "exit 0" : `bash /etc/init_route.sh`


##How it works - 

1. We enabled user-login auth for OpenVPN, but not check user-pass (script verify.sh only return 1. You can uncomment and use this any auth path if need)
2. user login (100,101,102) == CN, in file ipp.txt  we take user 100 ip 192.168.255.100, user 101 - 192.168.255.101 and etc..
3. using iproute2 and several route-tables (100,101,...) we link  out int, out ip, out gateway with source IP for client in range of certanly route-table. For simply, route-table number == clientID== login == 100,101...
4. if we have single interface with several public ip, we use iptables with SNAT to change out IP for packets

