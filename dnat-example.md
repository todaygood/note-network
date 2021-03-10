#!/bin/bash 



SIP=192.168.5.8
SPORT=20001

DIP=192.168.122.103
DPORT=20022

echo "client.xxx -> $SIP:$SPORT" 
echo "----to-----"
echo "client.xxx -> $DIP:$DPORT" 


iptables -t nat -I PREROUTING -p tcp -m tcp --dport $SPORT -j DNAT --to-destination $DIP:$DPORT


echo "query"
iptables -t nat -nvL PREROUTING


# 抓包表达式，可以多学习一下。 


tcpdump -i any -enn net 192.168.0.0/16 and port 20001
