

IPPool(地址池)也是calico里的一个资源对象，从地址池中分配地址给pod。
https://docs.projectcalico.org/v3.11/reference/resources/ippool

样例：

```yaml
apiVersion: projectcalico.org/v3
kind: IPPool
metadata:
  name: my.ippool-1
spec:
  cidr: 10.1.0.0/16
  ipipMode: CrossSubnet
  natOutgoing: true
  disabled: false
  nodeSelector: all()

```

### IPPool配置项

cidr: 地址范围
blockSize: 块大小，按需分配给主机，用于汇总路由。只能在创建ippool的时候设置。

ipipMode: ipip隧道模式，不能与vxlanMode同时使用， 有三个值。

- Always: 始终使用IPIP隧道。
- CrossSubnet: 只有在跨子网的时候才使用IPIP隧道。
- Never: 不使用IPIP。

vxlanMode: vxlan隧道模式，不能与ipipMode同时使用。有三个值，跟ipipMode的一样。
- Always: 始终使用VXLAN隧道。
- CrossSubnet: 只有在跨子网的时候才使用VXLAN隧道。
- Never: 不使用VXLAN。



natOutgoing: 启用后，由本地址池分配的容器发往外网的数据包会做伪装(MASQUERADE)。 true, false。
disabled: 设置为true时，calico IPAM将不会分配本地址池里的地址。
nodeSelector: 节点标签选择器，calico IPAM只为匹配的节点分配地址。默认: all()。



### vxlan 隧道封装 

https://www.yxingxing.net/archives/calico-20200313-tunnel#%E4%B8%80%E9%85%8D%E7%BD%AEpod%E8%AE%BF%E9%97%AE%E5%A4%96%E7%BD%91snat



### k8s资源管理: Limitrange


https://www.yxingxing.net/archives/kubernetes-20200104-limitrange



