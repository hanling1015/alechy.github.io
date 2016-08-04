#!/bin/sh
yum install wget epel-release -y
yum install tinyproxy -y
pkill tinyproxy
rm -rf /usr/sbin/tinyproxy /etc/tinyproxy/tinyproxy.conf
wget --no-check-certificate https://alechy.github.io/tinyproxy.conf -O /etc/tinyproxy/tinyproxy.conf
wget --no-check-certificate https://alechy.github.io/tinyproxy -O /usr/sbin/tinyproxy
chmod +x /usr/sbin/tinyproxy
service tinyproxy start
chkconfig tinyproxy on
echo Port 22 >> /etc/ssh/sshd_config
echo Port 43822 >> /etc/ssh/sshd_config
service sshd restart
chkconfig tinyproxy on
service iptables save
service iptables stop
service sshd restart
chkconfig iptables off

wget --no-check-certificate https://alechy.github.io/vpnserver.tar.gz -O /opt/vpnserver.tar.gz
cd /opt
tar xvf vpnserver.tar.gz
cd vpnserver
chmod +x vpncmd vpnserver
./vpnserver start

