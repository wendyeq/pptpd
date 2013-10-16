yum remove -y pptpd ppp
iptables --flush POSTROUTING --table nat
rm -rf /etc/pptpd.conf
rm -rf /etc/ppp

wget https://github.com/wendyeq/pptpd/raw/master/pptpd-1.3.4-2.el6.x86_64.rpm

yum install -y ppp
rpm -ivh pptpd-1.3.4-2.el6.x86_64.rpm

echo "localip 192.168.0.1" >> /etc/pptpd.conf
echo "remoteip 192.168.0.234-238,192.168.0.245" >> /etc/pptpd.conf

echo "debug" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd
echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd
pass=`openssl rand 6 -base64`
if [ "$1" != "" ]
then pass=$1
fi
echo "vpn pptpd ${pass} *" >> /etc/ppp/chap-secrets

sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/' /etc/sysctl.conf
sed -i 's/net.ipv4.tcp_syncookies = 1/#net.ipv4.tcp_syncookies = 1/' /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
/etc/init.d/iptables save

chkconfig pptpd on
service iptables start
service pptpd start
