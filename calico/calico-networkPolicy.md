# k8s networkpolicy on calico

```bash
[root@node01 ~]# kubectl get pod -o wide |grep pod-
pod-blue                          1/1     Running             0          4h28m   172.16.140.87    node02   <none>           <none>
pod-no-color                      1/1     Running             0          4h10m   172.16.140.76    node02   <none>           <none>
pod-red                           1/1     Running             0          4h28m   172.16.186.248   node03   <none>           <none>
```

定义规则： pod with red 默认不接收任何来访流量，仅仅pod with blue 的可以。 

```bash
[root@node01 kubectl-networkpolicy]# cat red-pod-allow-blue.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: red-pod-allow-blue
spec:
  podSelector:
    matchLabels:
      color: red
  policyTypes:
  - Ingress
  ingress:
  - from:
     - podSelector:
        matchLabels:
          color: "blue"

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: red-pod-default-deny
spec:
  podSelector:
    matchLabels:
      color: red
  policyTypes:
  - Ingress

---
apiVersion: v1
kind: Pod
metadata:
  name: pod-blue-01
  annotations:
    reservedip.kmc.io/vpcID: "public"
  labels:
     color: blue
spec:
#  runtimeClassName: kata-containers
  containers:
  - name: nginx
    image: pastack-registry.paic.com.cn/centos7-nginx:1.1

---
apiVersion: v1
kind: Pod
metadata:
  name: pod-red-01
  annotations:
    reservedip.kmc.io/vpcID: "public"
  labels:
     color: red
spec:
  containers:
  - name: nginx
    image: pastack-registry.paic.com.cn/centos7-nginx:1.1

---
apiVersion: v1
kind: Pod
metadata:
  name: pod-no-color-01
  annotations:
    reservedip.kmc.io/vpcID: "public"
spec:
  containers:
  - name: nginx
    image: pastack-registry.paic.com.cn/centos7-nginx:1.1


```
这两条书写顺序，颠倒一下之后结果也是一样的，查询到都是这样：最后的效果也是一样的。

```bash
[root@node01 deny-egress]# kubectl get networkpolicy
NAME                   POD-SELECTOR   AGE
red-pod-allow-blue     color=red      58s
red-pod-default-deny   color=red      58s
```


测试结果：

```bash 
[root@node01 deny-egress]# kubectl exec -it pod-blue -- bash
[root@pod-blue /]# telnet 172.16.186.248 80
Trying 172.16.186.248...
Connected to 172.16.186.248.
Escape character is '^]'.
^]
telnet> quit
Connection closed.
[root@pod-blue /]# exit
exit


[root@node01 deny-egress]# kubectl exec -it pod-no-color -- bash
[root@pod-no-color /]# telnet 172.16.186.248 80
Trying 172.16.186.248...
^C
[root@pod-no-color /]# ping 172.16.186.248
PING 172.16.186.248 (172.16.186.248) 56(84) bytes of data.
^C
--- 172.16.186.248 ping statistics ---
6 packets transmitted, 0 received, 100% packet loss, time 5112ms

[root@pod-no-color /]#
```

