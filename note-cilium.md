# 安装使用cilium 

### 当前趋势

现代数据中心的应用系统已经逐渐转向基于微服务架构的开发体系，一个微服务架构的应用系统是由多个小的独立的服务组成，它们之间通过轻量通信协议如 HTTP、gRPC、Kafka 等进行通信。微服务架构下的服务天然具有动态变化的特点，结合容器化部署，时常会引起大规模的容器实例启动或重启。要确保这种向高度动态化的微服务应用之间的安全可达，既是挑战，也是机遇。

### 现有问题

传统的 Linux 网络访问安全控制机制（如 `iptables`）是基于静态环境的 IP 地址和端口配置网络转发、过滤等规则，但是 IP 地址在微服务架构下是不断变化的，非固定的；出于安全目的，协议端口(例如 HTTP 传输的 TCP 端口 80)也不再固定用来区分应用系统。为了匹配大规模容器实例快速变化的生命周期，传统网络技术需要维护成千上万的负载均衡规则和访问控制规则，并且需要以不断增长的频率更新这些规则，而如果没有准确的可视化功能，要维护这些规则也是十分困难，这些对传统网络技术的可用性和性能都是极大的挑战。比如**经常会有人对 `kube-proxy` 基于 `iptables` 的服务负载均衡功能在大规模容器场景下具有严重的性能瓶颈，同时由于容器的创建和销毁非常频繁，基于 IP 做身份关联的故障排除和安全审计等也很难实现。**

`Cilium` 作为一款 Kubernetes CNI 插件，从一开始就是为大规模和高度动态的容器环境而设计，并且带来了 API 级别感知的网络安全管理功能，**通过使用基于 Linux 内核特性的新技术 —— `BPF`，提供了基于 service/pod/container 作为标识，而非传统的 IP 地址，来定义和加强容器和 Pod 之间网络层、应用层的安全策略。**因此，`Cilium` 不仅将安全控制与寻址解耦来简化在高度动态环境中应用安全性策略，而且提供传统网络第 3 层、4 层隔离功能，以及基于 http 层上隔离控制，来提供更强的安全性隔离。

另外，由于 `BPF` 可以动态地插入控制 Linux 系统的程序，实现了强大的安全可视化功能，而且这些变化是不需要更新应用代码或重启应用服务本身就可以生效，因为 `BPF` 是运行在系统内核中的。

以上这些特性，使 `Cilium` 能够在大规模容器环境中也具有高度可伸缩性、可视化以及安全性。

## 使用hubble观测网络流量

```bash
[root@node1 cilium]# kubectl exec -n kube-system -t ds/cilium -- hubble observe
TIMESTAMP             SOURCE                                               DESTINATION                                          TYPE            VERDICT     SUMMARY
Dec 26 04:26:31.448   kube-system/coredns-57658b797f-sn6z5:53              default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:58279    to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.448   kube-system/coredns-57658b797f-sn6z5:53              default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:58279    to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.448   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49600    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:31.448   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49600    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:31.517   1.1.1.1:80                                           default/pod-to-external-1111-d5c7bb4c4-28g4x:37796   to-endpoint     FORWARDED   TCP Flags: ACK, FIN
Dec 26 04:26:31.518   default/pod-to-external-1111-d5c7bb4c4-28g4x:37796   1.1.1.1:80                                           to-stack        FORWARDED   TCP Flags: ACK
Dec 26 04:26:31.970   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:52892    kube-system/coredns-57658b797f-sn6z5:53              L3-L4           FORWARDED   UDP
Dec 26 04:26:31.970   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:52892    kube-system/coredns-57658b797f-sn6z5:53              to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.970   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:52892    kube-system/coredns-57658b797f-sn6z5:53              to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.970   kube-system/coredns-57658b797f-sn6z5:53              default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:52892    to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.970   kube-system/coredns-57658b797f-sn6z5:53              default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:52892    to-endpoint     FORWARDED   UDP
Dec 26 04:26:31.971   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49604    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:31.971   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49604    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:32.507   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49600    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:32.507   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49600    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:33.019   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49604    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:33.019   default/pod-to-a-denied-cnp-75cb89dfd-gmcgj:49604    default/echo-a-dc9bcfd8f-m75dn:8080                  Policy denied   DROPPED     TCP Flags: SYN
Dec 26 04:26:33.462   192.168.122.1:6443                                   kube-system/coredns-57658b797f-sn6z5:53758           to-endpoint     FORWARDED   TCP Flags: ACK, PSH
Dec 26 04:26:33.462   kube-system/coredns-57658b797f-sn6z5:53758           192.168.122.1:6443                                   to-stack        FORWARDED   TCP Flags: ACK
Dec 26 04:26:33.465   192.168.122.1:6443                                   kube-system/coredns-57658b797f-lfthz:43084           to-endpoint     FORWARDED   TCP Flags: ACK, PSH
```

## 取代kube-proxy

Cilium 另外一个很大的宣传点是宣称已经全面实现 kube-proxy 的功能，包括 `ClusterIP`, `NodePort`, `ExternalIPs` 和 `LoadBalancer`，可以完全取代它的位置，同时提供更好的性能、可靠性以及可调试性。当然，这些都要归功于 eBPF 的能力。

官方文档中提到，如果你是在先有 kube-proxy 后部署的 `Cilium`，那么他们是一个“共存”状态，`Cilium` 会根据节点操作系统的内核版本来决定是否还需要依赖 kube-proxy 实现某些功能，可以通过以下手段验证是否能停止 kube-proxy 组件：



[root@node1 k8s-about-project]# kubectl exec -it -n kube-system cilium-xxgxj -- cilium status
KVStore:                Ok   Disabled
Kubernetes:             Ok   1.19 (v1.19.2) [linux/amd64]
Kubernetes APIs:        ["cilium/v2::CiliumClusterwideNetworkPolicy", "cilium/v2::CiliumEndpoint", "cilium/v2::CiliumNetworkPolicy", "cilium/v2::CiliumNode", "core/v1::Namespace", "core/v1::Node", "core/v1::Pods", "core/v1::Service", "discovery/v1beta1::EndpointSlice", "networking.k8s.io/v1::NetworkPolicy"]
KubeProxyReplacement:   Probe   [wlp3s0 192.168.1.89, virbr0 192.168.122.1 (Direct Routing)]
Cilium:                 Ok      OK
NodeMonitor:            Listening for events on 4 CPUs with 64x4096 of shared memory
Cilium health daemon:   Ok
IPAM:                   IPv4: 12/255 allocated from 10.0.0.0/24,
BandwidthManager:       EDT with BPF   [wlp3s0, virbr0]
Host Routing:           Legacy
Masquerading:           BPF   [wlp3s0, virbr0]   10.0.0.0/24 [IPv4: Enabled, IPv6: Disabled]
Controller Status:      57/57 healthy
Proxy Status:           OK, ip 10.0.0.102, 3 redirects active on ports 10000-20000
Hubble:                 Ok              Current/Max Flows: 4095/4095 (100.00%), Flows/s: 19.97   Metrics: Disabled
Cluster health:         1/1 reachable   (2020-12-26T22:37:26Z)

[root@node1 k8s-about-project]# kubectl exec -it -n kube-system cilium-xxgxj -- cilium service list
ID   Frontend              Service Type   Backend
1    10.96.0.10:9153       ClusterIP      1 => 10.0.0.199:9153
                                          2 => 10.0.0.5:9153
2    10.96.0.10:53         ClusterIP      1 => 10.0.0.199:53
                                          2 => 10.0.0.5:53
3    10.107.233.143:8080   ClusterIP      1 => 10.0.0.195:8080
4    10.98.70.146:8080     ClusterIP      1 => 10.0.0.205:8080
5    0.0.0.0:31313         NodePort       1 => 10.0.0.205:8080
6    192.168.1.89:31313    NodePort       1 => 10.0.0.205:8080
7    192.168.122.1:31313   NodePort       1 => 10.0.0.205:8080
8    10.96.0.1:443         ClusterIP      1 => 192.168.122.1:6443
9    192.168.1.89:40000    HostPort       1 => 10.0.0.205:8080
10   192.168.122.1:40000   HostPort       1 => 10.0.0.205:8080
11   0.0.0.0:40000         HostPort       1 => 10.0.0.205:8080



```
# 检查Cilium对于取代kube-proxy的状态
$ kubectl exec -it -n kube-system [Cilium-agent-pod] -- cilium status | grep KubeProxyReplacement

# 默认是Probe状态
# 当Cilium agent启动并运行，它将探测节点内核版本，判断BPF内核特性的可用性，
# 如果不满足，则通过依赖kube-proxy来补充剩余的Kubernetess，
# 并禁用BPF中的一部分功能
KubeProxyReplacement:   Probe   [NodePort (SNAT, 30000-32767), ExternalIPs, HostReachableServices (TCP, UDP)]

# 查看Cilium保存的应用服务访问列表
# 有了这些信息，就不需要kube-proxy进行中转了
$ kubectl exec -it -n kube-system [Cilium-agent-pod] -- cilium service list
ID   Frontend              Service Type   Backend
1    10.96.0.10:53         ClusterIP      1 => 100.64.0.98:53
                                          2 => 100.64.3.65:53
2    10.96.0.10:9153       ClusterIP      1 => 100.64.0.98:9153
                                          2 => 100.64.3.65:9153
3    10.96.143.131:9090    ClusterIP      1 => 100.64.4.100:9090
4    10.96.90.39:9090      ClusterIP      1 => 100.64.4.100:9090
5    0.0.0.0:32447         NodePort       1 => 100.64.4.100:9090
6    10.1.1.179:32447      NodePort       1 => 100.64.4.100:9090
7    100.64.0.74:32447     NodePort       1 => 100.64.4.100:9090
8    10.96.190.1:80        ClusterIP
9    10.96.201.51:80       ClusterIP
10   10.96.0.1:443         ClusterIP      1 => 10.1.1.171:6443
                                          2 => 10.1.1.179:6443
                                          3 => 10.1.1.188:6443
11   10.96.129.193:12000   ClusterIP      1 => 100.64.4.221:12000
12   0.0.0.0:32321         NodePort       1 => 100.64.4.221:12000
13   10.1.1.179:32321      NodePort       1 => 100.64.4.221:12000
14   100.64.0.74:32321     NodePort       1 => 100.64.4.221:12000
15   10.96.0.30:3000       ClusterIP
16   10.96.156.253:3000    ClusterIP
17   100.64.0.74:31332     NodePort
18   0.0.0.0:31332         NodePort
19   10.1.1.179:31332      NodePort
20   10.96.131.215:12000   ClusterIP      1 => 100.64.4.221:12000

# 查看iptables是否有kube-proxy维护的规则
$ iptables-save | grep KUBE-SVC
<Empty> # 说明kube-proxy没有维护任何应用服务跳转，即可以停止它了。
```

榜样和陪伴；

我在看班会回访视频， 校长讲话很好， 周末及节假日 学校向 学生开放，要预约。 
你晚上也听一下，10分钟就够了，校长说 学校招生还是继续 小学4个班，初中8个班， 九年制这个不会变 

https://gitee.com/todaygoodhujun/os-init.git
git@github.com:todaygood/stock1.git
git@gitee.com:todaygoodhujun/stock0.git


[root@node5 ~]# docker pull k8s.gcr.io/ingress-nginx/controller:v0.44.0@sha256:3dd0fac48073beaca2d67a78c746c7593f9c575168a17139a9955a82c63c4b9a

# 问题



![image-20201227210859502](C:/Users/margi/AppData/Roaming/Typora/typora-user-images/image-20201227210859502.png)



```bash
[root@node1 cilium]# ip l  |grep -i cilium
8: cilium_net@cilium_host: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
9: cilium_host@cilium_net: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
10: cilium_vxlan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
[root@node1 cilium]# ip l  |grep -i lxc
12: lxc_health@if11: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
20: lxc6310668478aa@if19: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
22: lxc7ea90e9f385b@if21: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000

```

具体是什么作用？ 



#  k8s 命令积累

Get output from running 'date' command from the first pod of the deployment mydeployment, using the first container

by default
  kubectl exec deploy/mydeployment -- date

Get output from running 'date' command from the first pod of the service myservice, using the first container by

default
  kubectl exec svc/myservice -- date



# calium参考文档



被 Google 选择的下一代数据面 Cilium 是什么 - 上手实践
原创 张晋涛 MoeLove 9月3日 https://mp.weixin.qq.com/s/iYQyluuXB-9Z-VMV3gCKbQ

深入理解 Cilium 的 eBPF 收发包路径
ArthurChiao 云原生实验室 https://mp.weixin.qq.com/s/WFFW_A-e3J2D99N0kHtwig

最 Cool Kubernetes 网络方案 Cilium 入门教程
https://mp.weixin.qq.com/s/N5glBIVsFxXWXKD0_reMxQ