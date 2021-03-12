

- name: IP value: "autodetect"
- name: CALICO_IPV4POOL_IPIP value
"interface=eth.*" # 

value: "interface=can-reach=www.baidu.com" # 新增部分结束 

kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=skip-interface=eth.*

kubectl set env daemonset/calico-node -n kube-system IP_AUTODETECTION_METHOD=interface=eth.*




[calico问题排查](https://zhuanlan.zhihu.com/p/98360450)
 


## calico 固定IP 

https://blog.csdn.net/wenwenxiong/article/details/106048632

单个pod固定IP

多pod固定IP池



