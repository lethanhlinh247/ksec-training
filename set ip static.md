#Config IP Static, DNS on Ubuntu Server

##Edit file /etc/network/interfaces

auto eno16777736

iface eno16777736 inet static

address 192.168.10.221

netmask 255.255.255.0

gateway 192.168.10.1

nameserver 8.8.8.8

#Restart Network Interface
/etc/init.d/networking restart