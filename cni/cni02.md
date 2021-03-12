

把容器加入到网络

调用插件的时候，这些参数会通过环境变量进行传递：

CNI_COMMAND：要执行的操作，可以是 ADD（把容器加入到某个网络）、DEL（把容器从某个网络中删除）
CNI_CONTAINERID：容器的 ID，比如 ipam 会把容器 ID 和分配的 IP 地址保存下来。可选的参数，但是推荐传递过去。需要保证在管理平台上是唯一的，如果容器被删除后可以循环使用
CNI_NETNS：容器的 network namespace 文件，访问这个文件可以在容器的网络 namespace 中操作
CNI_IFNAME：要配置的 interface 名字，比如 eth0
CNI_ARGS：额外的参数，是由分号;分割的键值对，比如 “FOO=BAR;hello=world”
CNI_PATH：CNI 二进制查找的路径列表，多个路径用分隔符 : 分隔
网络信息主要通过标准输入，作为 JSON 字符串传递给插件，必须的参数包括：

cniVersion：CNI 标准的版本号。因为 CNI 在演化过程中，不同的版本有不同的要求
name：网络的名字，在集群中应该保持唯一
type：网络插件的类型，也就是 CNI 可执行文件的名称
args：额外的信息，类型为字典
ipMasq：是否在主机上为该网络配置 IP masquerade
ipam：IP 分配相关的信息，类型为字典
dns：DNS 相关的信息，类型为字典
