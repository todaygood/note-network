# 调试cni

https://blog.csdn.net/ChamPly/article/details/97641999?ops_request_misc=%25257B%252522request%25255Fid%252522%25253A%252522161093097516780265499188%252522%25252C%252522scm%252522%25253A%25252220140713.130102334.pc%25255Fall.%252522%25257D&request_id=161093097516780265499188&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_v2~rank_v29-1-97641999.first_rank_v2_pc_rank_v29&utm_term=k8s%20cni%E8%B0%83%E8%AF%95


在上面我们的cni版本是0.3.1,所以在查看 源码 的时候选择 spec-v0.3.1

在README.md里面有测试方法

$ CNI_PATH=$GOPATH/src/github.com/containernetworking/plugins/bin
$ cd $GOPATH/src/github.com/containernetworking/cni/scripts
$ sudo CNI_PATH=$CNI_PATH ./priv-net-run.sh ifconfig
eth0      Link encap:Ethernet  HWaddr f2:c2:6f:54:b8:2b  
          inet addr:10.22.0.2  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::f0c2:6fff:fe54:b82b/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:1 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:90 (90.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
其中我们只需要使用到 scripts下面的 priv-net-run.sh 和 exec-plugins.sh 这两个文件

把这两个文件下载到本地，然后添加可执行权限

添加/etc/cni/net.d/下面的cni配置，添加CNI_PATH

[root@10 tmp]# export CNI_PATH=/opt/cni/bin/
[root@10 tmp]# ./priv-net-run.sh
1
2
其中/opt/cni/bin就是 kubernetes-cni-0.7.5-0.x86_64.rpm 对应的插件目录，如果没有修改就是用这个就可以了

可以修改shell脚本来调试cni插件，比如我下面修改之后可以看到执行过程

[root@10 tmp]# ./priv-net-run.sh
add 7ac145c133dc63c2 /var/run/netns/7ac145c133dc63c2
netconf:/etc/cni/net.d/cni.conf
name:mynet
plugin:bridge
res:{
    "cniVersion": "0.3.1",
    "interfaces": [
        {
            "name": "cni0",
            "mac": "76:02:71:5b:9c:79"
        },
        {
            "name": "vetheb50e2bb",
            "mac": "76:02:71:5b:9c:79"
        },
        {
            "name": "eth0",
            "mac": "ce:bf:1f:fc:ff:d1",
            "sandbox": "/var/run/netns/7ac145c133dc63c2"
        }
    ],
    "ips": [
        {
            "version": "4",
            "interface": 2,
            "address": "10.13.3.23/22",
            "gateway": "10.13.3.254"
        }
    ],
    "routes": [
        {
            "dst": "0.0.0.0/0"
        },
        {
            "dst": "0.0.0.0/0",
            "gw": "10.13.3.254"
        }
    ],
    "dns": {}
}
No command specified
del 7ac145c133dc63c2 /var/run/netns/7ac145c133dc63c2
netconf:/etc/cni/net.d/cni.conf
name:mynet
plugin:bridge
res:
