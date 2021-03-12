

# calicoctl 使用

[使用calicoctl](https://www.cnblogs.com/ding2016/p/10785892.html)



[root@node01 calico]# calicoctl get node
NAME
node01
node02
node03


[root@node01 calico]# calicoctl node status
Calico process is running.

IPv4 BGP status
+--------------+-------------------+-------+------------+-------------+
| PEER ADDRESS |     PEER TYPE     | STATE |   SINCE    |    INFO     |
+--------------+-------------------+-------+------------+-------------+
| 30.103.3.63  | node-to-node mesh | up    | 2021-01-06 | Established |
| 30.103.3.228 | node-to-node mesh | up    | 2021-01-06 | Established |
+--------------+-------------------+-------+------------+-------------+

IPv6 BGP status
No IPv6 peers found.


[root@node01 calico]# calicoctl get ipPool
NAME                  CIDR            SELECTOR
default-ipv4-ippool   172.16.0.0/16   all()

[root@node01 calico]# calicoctl get ipPool -o yaml
apiVersion: projectcalico.org/v3
items:
- apiVersion: projectcalico.org/v3
  kind: IPPool
  metadata:
    creationTimestamp: "2021-01-06T09:23:03Z"
    name: default-ipv4-ippool
    resourceVersion: "559"
    uid: 2dac7443-07f6-44b0-927a-c8dd4093e3f3
  spec:
    blockSize: 26
    cidr: 172.16.0.0/16
    ipipMode: Never
    natOutgoing: true
    nodeSelector: all()
    vxlanMode: Never
kind: IPPoolList
metadata:
  resourceVersion: "595268"



如果使用ipip mode ,则显示的是： ipipMode: Always




[root@node01 ~]# calicoctl ipam show
+----------+---------------+-----------+------------+--------------+
| GROUPING |     CIDR      | IPS TOTAL | IPS IN USE |   IPS FREE   |
+----------+---------------+-----------+------------+--------------+
| IP Pool  | 172.16.0.0/16 |     65536 | 5 (0%)     | 65531 (100%) |
+----------+---------------+-----------+------------+--------------+

[root@node01 ~]# calicoctl get node node01 -o yaml
apiVersion: projectcalico.org/v3
kind: Node
metadata:
  annotations:
    projectcalico.org/kube-labels: '{"beta.kubernetes.io/arch":"amd64","beta.kubernetes.io/os":"linux","kubernetes.io/arch":"amd64","kubernetes.io/hostname":"node01","kubernetes.io/os":"linux","node-role.kubernetes.io/master":""}'
  creationTimestamp: "2021-01-06T09:22:25Z"
  labels:
    beta.kubernetes.io/arch: amd64
    beta.kubernetes.io/os: linux
    kubernetes.io/arch: amd64
    kubernetes.io/hostname: node01
    kubernetes.io/os: linux
    node-role.kubernetes.io/master: ""
  name: node01
  resourceVersion: "612262"
  uid: 34c591d5-27fd-4477-b6e3-884563316ef6
spec:
  bgp:
    ipv4Address: 30.103.3.28/24

