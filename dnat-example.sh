#!/bin/bash 



SIP=192.168.5.8
SPORT=20001

DIP=192.168.122.103
DPORT=20022

echo "client.xxx -> $SIP:$SPORT" 
echo "----to-----"
echo "client.xxx -> $DIP:$DPORT" 


iptables -t nat -I PREROUTING -p tcp -m tcp --dport $SPORT -j DNAT --to-destination $DIP:$DPORT

# delete command
# iptables -t nat -D PREROUTING -p tcp -m tcp --dport $SPORT -j DNAT --to-destination $DIP:$DPORT

echo "query"
iptables -t nat -nvL PREROUTING


# 抓包表达式，可以多学习一下。 

<<EOF
[root@node1 rc.d]# tcpdump -i any -enn net 192.168.0.0/16 and port 20001
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on any, link-type LINUX_SLL (Linux cooked), capture size 262144 bytes
11:30:00.498202  In 54:ee:75:aa:a8:4e ethertype IPv4 (0x0800), length 62: 192.168.5.10.5378 > 192.168.5.8.20001: Flags [P.], seq 1310142333:1310142335, ack 3745707738, win 256, length 2
11:30:00.499392 Out 00:27:13:66:d6:14 ethertype IPv4 (0x0800), length 56: 192.168.5.8.20001 > 192.168.5.10.5378: Flags [R], seq 3745707738, win 0, length 0
11:30:06.890781  In 54:ee:75:aa:a8:4e ethertype IPv4 (0x0800), length 68: 192.168.5.10.12189 > 192.168.5.8.20001: Flags [S], seq 402279829, win 8192, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
11:30:06.892136 Out 00:27:13:66:d6:14 ethertype IPv4 (0x0800), length 68: 192.168.5.8.20001 > 192.168.5.10.12189: Flags [S.], seq 409673154, ack 402279830, win 29200, options [mss 1460,nop,nop,sackOK,nop,wscale 7], length 0
11:30:06.898347  In 54:ee:75:aa:a8:4e ethertype IPv4 (0x0800), length 62: 192.168.5.10.12189 > 192.168.5.8.20001: Flags [.], ack 1, win 256, length 0
11:30:07.049277 Out 00:27:13:66:d6:14 ethertype IPv4 (0x0800), length 77: 192.168.5.8.20001 > 192.168.5.10.12189: Flags [P.], seq 1:22, ack 1, win 229, length 21
11:30:07.105057  In 54:ee:75:aa:a8:4e ethertype IPv4 (0x0800), length 62: 192.168.5.10.12189 > 192.168.5.8.20001: Flags [.], ack 22, win 256, length 0
^C
7 packets captured
10 packets received by filter
0 packets dropped by kernel
EOF


