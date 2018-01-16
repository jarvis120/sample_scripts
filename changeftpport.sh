#/bin/bash
echo "checking  proftpd port"
grep 21 /etc/proftpd.conf
echo "taking back pf proftpd"
cp -prf /etc/proftpd.conf /etc/proftpd.conf_bak
echo "changing to port 1021"
sed -i 's/\<21\>/1021/g' /etc/proftpd.conf
echo "checking whether its changed in proftpd"
grep 1021 /etc/proftpd.conf
echo " taking back of services"
cp -prf /etc/services /etc/services_bak
echo "changing ftp port to 1021 in services"
sed -i 's/\<21\>/1021/g' /etc/services
echo "checking in /etc/services whether its  reflected"
grep 1021 /etc/services
echo "saving iptables"
iptables -A fw_hosting_protocols -p tcp -m multiport --dports 1021 -j fw_hosting_servers;service iptables save
echo "restarting xinted"
/etc/init.d/xinetd restart
echo "script ended"

