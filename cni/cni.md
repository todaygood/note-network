
浅谈k8s cni 插件

https://segmentfault.com/a/1190000017182169


Packet_Walks_In_Kubernetes-v4.pdf
链接：https://pan.baidu.com/s/1lbQRCaV2uW0qj9JiF_6kBg 
提取码：5ee0


如何解决容器网络性能及复杂网络部署问题？
https://blog.csdn.net/imgxr/article/details/80128995



k8s-如何固定pod的ip，并且重启不会发生变化
https://www.oschina.net/question/1419308_2314514?sort=default

https://github.com/Comcast/kuberhealthy

OpenShift 中的容器多网络平面选型
https://developer.ibm.com/zh/depmodels/cloud/articles/cl-lo-container-multi-network-plane-selection-in-openshift/

开发环境下的 Kubernetes 容器网络演进之路
https://zhuanlan.51cto.com/art/201912/608117.htm

Kubernetes在信也科技的落地实战

https://www.modb.pro/db/32619

如何打通 K8s 虚拟网络（flannel vxlan 网络）和 K8s 2层网络（macvlan网络）

https://hansedong.github.io/2020/03/10/20/

kubernetes的clusterip机制调研及macvlan网络下的clusterip坑解决方案

https://zhuanlan.zhihu.com/p/67384482

https://github.com/openshift/sriov-network-operator.git

https://hicu.be/bridge-vs-macvlan

如何打通 K8s 虚拟网络（flannel vxlan 网络）和 K8s 2层网络（macvlan网络）
https://hansedong.github.io/2020/03/10/20/

**https://sreeninet.wordpress.com/2016/05/29/macvlan-and-ipvlan/
https://superuser.com/questions/1113812/how-to-configure-macvlan-interface-for-getting-the-ip

VLAN, http://www.dobitaobyte.com.br/configurar-vlans-em-linux/

AZURE K8S NETWROK 实战 https://www.cnblogs.com/wekang/p/8418303.html

技术实录 | 灵雀云基于 OVN 的 Kubernetes 网络架构解析 https://cloud.tencent.com/developer/article/1475916

禁用kube-proxy , https://www.projectcalico.org/eks-bottlerocket-and-calico-ebpf/

 Cluster Networking

 https://kubernetes.io/docs/concepts/cluster-administration/networking/

 基于k8s multus-cni插件实现灵活指定Pod网络类型的实践
 https://zhuanlan.zhihu.com/p/73863683

 微服务的未来——从单体服务角度看微服务与云计算DevOps结合的演进
 https://zhuanlan.zhihu.com/p/97170312

 https://www.zhihu.com/people/xin-he-78-81

  Calico 网络通信原理揭秘 https://www.cnblogs.com/ryanyangcs/p/11273040.html

  calico 网络模型 https://www.cnblogs.com/menkeyi/p/11364977.html

  修改k8s pod Ip地址段（pod-cidr） https://zhuanlan.zhihu.com/p/87791837

  kubernetes 会在每台主机上运行 Felix 作为Agent, 负责负责配置路由及ACLs等信息来确保Endpoint的连通状态

  kubernetes 创建容器时会调用CNI接口(/opt/cni/bin/calico & calico-ipam) 为 容器 创建 veth pair, 配置ip(从etcd存取)和路由信息(在主机删除时回收Ip),

  然后由BGP Client(BIRD) 将Felix写入Kernel的路由信息分发到Calico网络, 实现集群通信

  在大规模部署时, 使用BGP Route Reflector (BIRD) 完成集中的路由分发
  o

  cni 各种插件安装实验: https://blog.csdn.net/kwame211/article/details/100335273
