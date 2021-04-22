

Enable SR-IOV

Given Intel ixgbe NIC on CentOS, Fedora or RHEL:

# vi /etc/modprobe.conf
options ixgbe max_vfs=8,8
# reboot
or

# cd /sys/class/net/enp129s0f0/device
# echo 8 > sriov_numvfs
