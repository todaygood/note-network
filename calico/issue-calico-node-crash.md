

[root@CNSZ332564 pingan]# vim calico.log
2020-11-12 03:52:16.897 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="mangle"
2020-11-12 03:52:16.899 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="filter"
2020-11-12 03:52:16.904 [INFO][77] int_dataplane.go 1176: Finished applying updates to dataplane. msecToApply=10.957243
2020-11-12 03:52:17.848 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:18.849 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:19.849 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:20.849 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:20.894 [INFO][77] int_dataplane.go 1162: Applying dataplane updates
2020-11-12 03:52:20.894 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="nat"
2020-11-12 03:52:20.894 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="raw"
2020-11-12 03:52:20.894 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="mangle"
2020-11-12 03:52:20.894 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="filter"
2020-11-12 03:52:20.895 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="nat"
2020-11-12 03:52:20.897 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="raw"
2020-11-12 03:52:20.898 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="mangle"
2020-11-12 03:52:20.900 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="filter"
2020-11-12 03:52:20.904 [INFO][77] int_dataplane.go 1176: Finished applying updates to dataplane. msecToApply=10.523193000000001
2020-11-12 03:52:21.850 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:22.850 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:23.513 [INFO][77] int_dataplane.go 1162: Applying dataplane updates
2020-11-12 03:52:23.513 [INFO][77] ipsets.go 223: Asked to resync with the dataplane on next update. family="inet"
2020-11-12 03:52:23.513 [INFO][77] ipsets.go 306: Resyncing ipsets with dataplane. family="inet"
2020-11-12 03:52:23.514 [INFO][77] ipsets.go 356: Finished resync family="inet" numInconsistenciesFound=0 resyncDuration=1.23724ms
2020-11-12 03:52:23.514 [INFO][77] int_dataplane.go 1176: Finished applying updates to dataplane. msecToApply=1.5572089999999998
2020-11-12 03:52:23.850 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:24.851 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:25.851 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:26.851 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:27.851 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:28.852 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:28.883 [INFO][77] int_dataplane.go 1162: Applying dataplane updates
2020-11-12 03:52:28.883 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="mangle"
2020-11-12 03:52:28.883 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="nat"
2020-11-12 03:52:28.885 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="mangle"
2020-11-12 03:52:28.887 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="nat"
2020-11-12 03:52:28.892 [INFO][77] int_dataplane.go 1176: Finished applying updates to dataplane. msecToApply=8.407237
2020-11-12 03:52:28.892 [INFO][77] int_dataplane.go 1162: Applying dataplane updates
2020-11-12 03:52:28.892 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="raw"
2020-11-12 03:52:28.892 [INFO][77] table.go 810: Invalidating dataplane cache ipVersion=0x4 reason="post update" table="filter"
2020-11-12 03:52:28.893 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="raw"
2020-11-12 03:52:28.894 [INFO][77] table.go 497: Loading current iptables state and checking it is correct. ipVersion=0x4 table="filter"
2020-11-12 03:52:28.900 [INFO][77] int_dataplane.go 1176: Finished applying updates to dataplane. msecToApply=7.6548240000000005
2020-11-12 03:52:29.852 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:30.852 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use
2020-11-12 03:52:31.853 [ERROR][77] health.go 246: Health endpoint failed, trying to restart it... error=listen tcp 127.0.0.1:9099: bind: address already in use

