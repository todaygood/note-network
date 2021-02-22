
# 网络架构


## 叶脊(Spine-Leaf)网络拓扑


[【网络】叶脊(Spine-Leaf)网络拓扑下全三层网络设计与实践(一) - 叶脊网络架构简介](https://blog.csdn.net/m0_37904728/article/details/97940745?ops_request_misc=&request_id=&biz_id=102&utm_term=%25E4%25BA%25A4%25E6%258D%25A2%25E6%259C%25BA%25E4%25B8%259C%25E8%25A5%25BF%25E5%2590%2591%25E6%25B5%2581%25E9%2587%258F&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-8-97940745.first_rank_v2_pc_rank_v29_10)


传统网络采用STP协议，当一台设备故障时就会重新收敛，影响网络性能甚至发生故障，SPINE LEAF架构中一台设备故障时，不需重新收敛，流量继续在其他正常路径上通过，网络连通性不受影响，带宽也只减少一条路径的带宽，性能影响微乎其微；


SPINE数量：16台
每个SPINE的下联端口：48个 × 100G
SPINE上联端口：16个 × 100G
LEAF数量：48台
每个LEAF的下联端口：64个 × 25G
LEAF的上联端口： 16个 × 25G


[交换机广播抑制导致的虚拟机流量异常](https://blog.csdn.net/weixin_33924770/article/details/89701611?utm_medium=distribute.pc_relevant.none-task-blog-OPENSEARCH-3.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-OPENSEARCH-3.control)

## STP协议
