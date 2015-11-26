#Cấu hình mạng trên Linux
##1 - UBUNTU
###1.1 Xem cấu hình tất cả card mạng
```sh
ifconfig -a
```
Kết quả:
```sh
eno16777736 Link encap:Ethernet  HWaddr 00:0c:29:e3:25:80  
          inet addr:192.168.1.69  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fee3:2580/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:741 errors:0 dropped:0 overruns:0 frame:0
          TX packets:417 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:88231 (88.2 KB)  TX bytes:58028 (58.0 KB)

eno33554992 Link encap:Ethernet  HWaddr 00:0c:29:e3:25:8a  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:160 errors:0 dropped:0 overruns:0 frame:0
          TX packets:160 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:11840 (11.8 KB)  TX bytes:11840 (11.8 KB)


```
###1.2 Xem hostname
```sh
hostname
```
Sửa host name ở file
```sh
/etc/hostname
```
###1.3 File host
```sh
/etc/hosts 
```
###1.4 Cấu hình ip tĩnh, dns,..
Sửa file interfaces
```sh
/etc/network/interfaces
```
```sh
auto eno16777736

iface eno16777736 inet static

address 192.168.10.221

netmask 255.255.255.0

gateway 192.168.10.1

nameserver 8.8.8.8
```
###1.5 Restart Network Interface
```sh
/etc/init.d/networking restart
```



##2 - RedHat, CentOS
###2.1 Xem cấu hình tất cả card mạng
```sh
ifconfig -a
```
Kết quả:
```sh
eno16777736 Link encap:Ethernet  HWaddr 00:0c:29:e3:25:80  
          inet addr:192.168.1.69  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fee3:2580/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:741 errors:0 dropped:0 overruns:0 frame:0
          TX packets:417 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:88231 (88.2 KB)  TX bytes:58028 (58.0 KB)

eno33554992 Link encap:Ethernet  HWaddr 00:0c:29:e3:25:8a  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:160 errors:0 dropped:0 overruns:0 frame:0
          TX packets:160 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:11840 (11.8 KB)  TX bytes:11840 (11.8 KB)


```
###2.2 Hostname
```sh
/etc/sysconfig/network
```
```sh
NETWORKING=yes
HOSTNAME=prodnode02.acme.com
```
###2.3 File Host
```sh
/etc/hosts
```
```sh
192.168.0.0 prodnode01.acme.com
```
###2.4 Changing Network Configuration
Name server configuration is in 
```sh
/etc/resolv.conf:
```
```sh
search acme.com
nameserver 10.0.0.1
nameserver 8.8.8.8
```
Set ip static in
```sh
/etc/sysconfig/network-scripts/ifcfg-ethX
```
```sh
DEVICE="eth0"
BOOTPROTO="none"
ONBOOT="yes"
TYPE="Ethernet"
IPADDR=10.0.0.42
NETMASK=255.255.255.0
BROADCAST=10.0.0.255
GATEWAY=10.0.0.1
```