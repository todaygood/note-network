



[Linux traceroute 路由跟踪](https://blog.csdn.net/max18/article/details/8106141?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.control&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.control)





1) 使用UDP包(默认选项是－U)
2）使用TCP包 选项是－T
3）使用ICMP包 选项是－I
而且每个包traceroute都发3次。



Traceroute的实现原理

   Traceroute是我们经常用到的一个路由跟踪命令。
   它的实现原理如下：
   它发送一份 TTL字段为1的IP数据报给目的主机。处理这份数据报的第一个路由器将TTL值减 1,丢弃该数据报,并发回一份超时I C M P报文。这样就得到了该路径中的第一个路由器的地址。然后Traceroute程序发送一份T T L值为2的数据报,这样我们就可以得到第二个路由器的地址。继续这个过程直至该数据报到达目的主机。但是目的主机哪怕接收到TTL值为1的I P数据报,也不会丢弃该数据报并产生一份超时ICMP报文,这是因为数据报已经到达其最终目的地。那么我们该如何判断是否已经到达目的主机了呢?
   Traceroute程序发送一份 U D P数据报给目的主机,但它选择一个不可能的值作为 U D P端口号(大于 30 000),使目的主机的任何一个应用程序都不可能使用该端口。因为,当该数据报到达时,将使目的主机的 U D P模块产生一份“端口不可达”错误(见 6 . 5节)的ICMP报文。这样,Traceroute程序所要做的就是区分接收到的ICMP报文是超时还是端口不可达,以判断什么时候结束。





# 没那么简单！网络故障排除神器 traceroute 探秘



https://www.sohu.com/a/152330082_262549

不同的实现方式通常都会向每跳发送多个探测包，典型的Traceroute默认发送3个探测包，如果没有收到那一跳的回应，延时数据将会输出3个*号；MTR会循环发送无数个探测包；



## [网络路径排查工具使用/原理浅析(MTR、traceroute、tracepath、windows下besttrace)](https://www.cnblogs.com/zhangmingda/p/13704945.html)