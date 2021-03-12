# calico原理

https://blog.csdn.net/ccy19910925/article/details/82423452

https://www.lijiaocn.com/%E9%A1%B9%E7%9B%AE/2017/04/11/calico-usage.html

https://docs.projectcalico.org/v2.1/reference/architecture/


[关于IP地址的全0与全1网段](https://www.cnblogs.com/hopeworld/archive/2009/08/27/1555285.html)



https://yuerblog.cc/2019/02/25/flannel-and-calico/
容器虚拟化网络方案，总体分为2种截然不同的发展路线：

基于隧道
基于路由


基于路由
路由方案性能最好，原因是该方案不需要封包和解包，所以没有隧道方案的劣势，网络性能很好。

常见的路由方案包括了flannel的host-gw模式，以及calico的bgp模式。

[大二层](https://forum.huawei.com/enterprise/zh/thread-333013.html)




[Linux 虚拟网络设备 veth-pair 详解，看这一篇就够了](https://www.cnblogs.com/bakari/p/10613710.html)


[记一次flannel vxlan的debug过程](https://nicksu86.github.io/2019/02/K8S-network-flannel-debug/)



