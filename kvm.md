# Ảo hóa KVM – Kernel-Based Virtual Machine
![](http://i1.wp.com/blogit.edu.vn/wp-content/uploads/2015/08/download.jpg?resize=270%2C187)

* KVM ra đời phiên bản đầu tiên vào năm 2007 bởi công ty Qumranet tại Isarel, KVM được tích hợp sẵn vào nhân của hệ điều hành Linux bắt đầu từ phiên bản 2.6.20.
Năm 2008, RedHat đã mua lại Qumranet và bắt đầu phát triển, phổ biến KVM Hypervisor.

* Một số đặc điểm của KVM:
	* Là giải pháp ảo hóa dạng toàn phần và hoàn toàn nguồn mở, miễn phí.
	* Hỗ trợ các loại công nghệ phần cứng đa dạng và thông dụng như Intel-VT, AMD-V.	
	* Cung cấp các máy ảo đa dạng, hỗ trợ nhiều loại hệ điều hành và không cần tinh chỉnh lại các ảnh của hệ điều hành
	* Sử dụng cơ chế quản lý vùng nhớ của Linux (KSM) và các cơ chế bảo mật có sẵn của Linux (SELinux)

![Kiến trúc KVM](http://i2.wp.com/blogit.edu.vn/wp-content/uploads/2015/08/Kien-truc-KVM.jpg?resize=597%2C345)

* Với ưu điểm nguồn mở và độ tùy biến cao, KVM hypervisor được lựa chọn là nền tảng ảo hóa chính khi lựa chọn công nghệ ảo hóa nguồn mở.
KVM cũng đồng thời là nền tảng của giải pháp điện toán đám mây nguồn mở nổi tiếng nhất hiện nay là OpenStack.

![ Mô hình quản lý tập trung và phân phối tài nguyên nhiều máy chủ KVM trong hệ thống điện toán đám mây nguồn mở OpenStack](http://i1.wp.com/blogit.edu.vn/wp-content/uploads/2015/08/KVM-OpenStack.jpg?resize=414%2C295)

* KVM là công nghệ ảo hóa phần cứng và đòi hỏi CPU trên máy tính phải được hỗ trợ một trong các công nghệ sau: Intel VT hoặc AMD-V.

* Trong kiến trúc KVM, máy ảo là một tiến trình Linux, được lập lịch bởi chuẩn Linux scheduler. Trong thực tế mỗi CPU ảo xuất hiện như là một tiến trình Linux. Điều này cho phép KVM sử dụng tất cả các tính năng của Linux kernel.

![](https://lh3.googleusercontent.com/0ViyDYBAxr5Q0ZZZ8bZphK4CX3oCYUzDCiMV4RwTfpK8d-ELmoJZv3avEEVZ1vtOQgiArZE3Xnd47waf3kdLAJQOuNZbBB4tO8MW4OB5HL9B9NEVIbw0M3Vqjk1W8aWNUgwnjq76fl4)

* Chính sách bảo mật và thực thi độc lập sử dụng KVM

![](https://lh5.googleusercontent.com/y9Fqpw95n-XA5TIb1m5ADeRwOpMbGVJzyH7_awf4TTgBHTJ4i-0uSJnxjZMaGGyWBfc4iuBc3nk3uGK8z1932cwhMjLPpOJbeekSnmUGZnQSIj869d-8B6hxXSPQTZISJEWvZuNthLQ)


* KVM thừa kế tính năng quản lý bộ nhớ mạnh mẽ của linux. Khi chạy một máy ảo trên KVM thì bộ nhớ(Memory) của nó được lưu trữ như là bộ nhớ của bất kỳ một tiến trình nào chạy trên linux, và chúng có thể trao đổi được với nhau, mà về vấn đề quản lý bộ nhớ thì chúng ta cũng đã có sẵn các tài liệu từ các trang web uy tín, điều đó giúp cho việc quản lý bộ nhớ đạt được hiệu năng tốt nhất, các tập tin về đĩa có thể chia sẽ hoặc hỗ trợ cho bộ nhớ của máy ảo.

![](https://lh5.googleusercontent.com/t7ioB4cXpSUQWAssd20q6sX0iltnEodeyUoWtdsIULpVIiTpZQgk-4CuisOToE-Vugbvs7PdId8fINNFhEqMBono1fK3TwDzp_8wzfNjnL5Xyx7w0xSSN7RI2gDm9SLfD8hHqjKcyQ4)

* Lưu trữ trên KVM

![](https://lh4.googleusercontent.com/KgD-dRGdW50_inhyWJBuY3RwdUEIKWa2zUoiKlYf8vrUUhkcXJD0DoTH6enPWdpglDuxMHrTCWoQik_zbZQ1zYVK_TZG2eUXR5BtFvlqe3BcATchYa3YVeLcgsUwPi6f3pwiCYKV5oM)

* KVM hỗ trợ live migration cho phép di chuyển máy ảo đang chạy giữa các host vật lý khác nhau mà không bị gián đoạn dịch vụ. Nó trong suốt với người sử dụng cuối(end user). Máy ảo vẫn ở trạng thái running, các kết nối network vẫn hoạt động và ứng dụng của người dùng vẫn chạy trong khi máy ảo di chuyển sang một host vật lý mới.

![](https://lh3.googleusercontent.com/VaM2L6XyiM6BqGcs949pwyUVC-9yDocHYm5gZa8rgERRsqcTs_APfdEs6EJWaGoinREzoi2Kq6yI0Jd6GBMtsqO3umNyM727Gug_-M1CDxNidJdjodz0HV_ZCJmKUjz-UvsWaO7r1lM)


##1. Cài đặt các gói cần thiết.
```sh
install qemu-kvm libvirt-bin virtinst bridge-utils 
```
##2. Cấu hình Bridge networking. 
```sh
vi /etc/network/interfaces 
```
* change like follows
```sh
iface eth0 inet manual
#iface eth0 inet static
#address 10.0.0.30
#network 10.0.0.0
#netmask 255.255.255.0
#broadcast 10.0.0.255
#gateway 10.0.0.1
#dns-nameservers 10.0.0.30 
```
* add bridge interface
```sh
iface br0 inet static
address 10.0.0.30
network 10.0.0.0
netmask 255.255.255.0
broadcast 10.0.0.255
gateway 10.0.0.1
dns-nameservers 10.0.0.30
bridge_ports eth0
bridge_stp off
auto br0 
```

* Khởi động lại card mạng
```sh
service networking restart
```

* ifconfig -a
```sh
br0       Link encap:Ethernet  HWaddr 00:0c:29:e3:25:80  
          inet addr:192.168.1.188  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:29ff:fee3:2580/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:183 errors:0 dropped:0 overruns:0 frame:0
          TX packets:142 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:53296 (53.2 KB)  TX bytes:22197 (22.1 KB)

eno16777736 Link encap:Ethernet  HWaddr 00:0c:29:e3:25:80  
          inet6 addr: fe80::20c:29ff:fee3:2580/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:184 errors:0 dropped:0 overruns:0 frame:0
          TX packets:150 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:55950 (55.9 KB)  TX bytes:22953 (22.9 KB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:176 errors:0 dropped:0 overruns:0 frame:0
          TX packets:176 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:13196 (13.1 KB)  TX bytes:13196 (13.1 KB)

virbr0    Link encap:Ethernet  HWaddr 52:54:00:d7:7d:33  
          inet addr:192.168.122.1  Bcast:192.168.122.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

virbr0-nic Link encap:Ethernet  HWaddr 52:54:00:d7:7d:33  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

```

##3.Create Virtual Machine
```sh
install libguestfs-tools virt-top 
```

* create a storage pool
```sh
mkdir -p /var/kvm/images 
```
* install
```sh
 virt-install \
--name template \
--ram 1024 \
--disk path=/var/kvm/images/template.img,size=10 \
--vcpus 1 \
--os-type linux \
--os-variant ubuntuutopic \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'http://vn.archive.ubuntu.com/ubuntu/dists/vivid/main/installer-amd64/' \
--extra-args 'console=ttyS0,115200n8 serial'
```

* after installation, back to KVM host and shutdown the guest like follows
```sh
virsh shutdown template 
```
* mount guest's disk and enable a service like follows
```sh
root@dlp:~# guestmount -d template -i /mnt
root@dlp:~# ln -s /mnt/lib/systemd/system/getty@.service /mnt/etc/systemd/system/getty.target.wants/getty@ttyS0.service
root@dlp:~# umount /mnt 
```

* start guest again, if it's possible to connect to the guest's console, it's OK all
```sh
virsh start template --console 
```
* Move to GuestOS to HostOS with `Ctrl + ]` key.
* Move to HostOS to GuestOS with a command `virsh console (name of virtual machine)`. 

##4. Một số câu lệnh 
* Start Virtual Machine 
```sh
virsh start ubuntu 
```
* start and connect to console of 'ubuntu'
```sh
virsh start ubuntu --console 
```

* stop Virtual Machine 'ubuntu'
```sh
virsh shutdown ubuntu 
```
* stop fourcely Virtual Machine 'ubuntu'
```sh
virsh destroy ubuntu 
```

* enable auto-start for 'ubuntu'
```sh
virsh autostart ubuntu 
```
* disable auto-start for 'ubuntu'
```sh
virsh autostart --disable ubuntu 
```

* List all Virtual Machines 
```sh
virsh list 
```

* list all Virtual Machines include inactives
```sh
virsh list --all 
```

*  	Switch console,
	* Move to GuestOS to HostOS with `Ctrl + ]` key.

	* Move to HostOS to GuestOS with a command `virsh console (name of virtual machine)`.

* For Other options, There are many options, please try to execute them.
```sh
virsh --help 
```

##5. Management tools: Install useful tools for virtual machine management. 
* Install tools. 
```sh
apt-get install libguestfs-tools virt-top 
```

* "ls" a directory in a virtual machine
```sh
virt-ls -l -d ubuntu /root 
```

* "cat" a file in a virtual machine
```sh
virt-cat -d ubuntu /etc/passwd 
```

* Edit a file in a virtual machine
```sh
virt-edit -d ubuntu /etc/fstab 
```
* Display disk usage in a virtual machine 
```sh
virt-df -d ubuntu 
```
* Mount a disk for a virtual machine
```sh
guestmount -d ubuntu -i /mnt
ll /mnt 
```
* Display the status of virtual machines 
```sh
virt-top 
```

##5. Install WebVirtMgr
###5.1 Installation Only web panel
####5.1.1 Installation
```sh
$ sudo apt-get install git python-pip python-libvirt python-libxml2 novnc supervisor nginx 
```

####5.1.2 Install python requirements and setup Django environment
```sh
$ git clone git://github.com/retspen/webvirtmgr.git
$ cd webvirtmgr
$ sudo pip install -r requirements.txt
$ ./manage.py syncdb
$ ./manage.py collectstatic
```

```sh
* Enter the user information:

You just installed Django's auth system, which means you don't have any superusers defined.
Would you like to create one now? (yes/no): yes (Put: yes)
Username (Leave blank to use 'admin'): admin (Put: your username or login)
E-mail address: username@domain.local (Put: your email)
Password: xxxxxx (Put: your password)
Password (again): xxxxxx (Put: confirm password)
Superuser created successfully.

```


* Adding additional superusers
```sh
Run:
$ ./manage.py createsuperuser
```

####5.1.3 Khởi chạy 
```sh
$ ./manage.py runserver 0:8000
```

###5.1 Setup host server (Server for VM's)
* Install packages libvirt-bin, KVM, sasl2-bin
```sh
$ sudo apt-get install kvm libvirt-bin sasl2-bin
```

* Add the option `-l` in the file `/etc/default/libvirt-bin`
```sh
libvirtd_opts="-d -l"
```

* The file `/etc/libvirt/libvirtd.conf` uncomment the line
```sh
listen_tls = 0
listen_tcp = 1
```

* Restart the daemon libvirtd, because after installation it runs automatically
```sh
$ sudo service libvirt-bin restart
```

* Adding users and setting their passwords is done with the saslpasswd2 command. When running this command it is important to tell it that the appname is libvirt. As an example, to add a user fred, run
```sh
$ sudo saslpasswd2 -a libvirt fred
Password: xxxxxx
Again (for verification): xxxxxx
```

* To see a list of all accounts the `sasldblistusers2` command can be used. This command expects to be given the path to the libvirt user database, which is kept in `/etc/libvirt/passwd.db`
```sh
$ sudo sasldblistusers2 -f /etc/libvirt/passwd.db
fred@webvirtmgr.net: userPassword
```

* To disable a user's access, use the command `saslpasswd2` with the `-d`
```sh
$ sudo saslpasswd2 -a libvirt -d fred
```

* Configuring the firewall

	* Create a file `/etc/ufw/applications.d/libvirtd` and it add the following lines
	```sh
	[Libvirt]
	title=Virtualization library
	description=Open port for WebVirtMgr
	ports=16509/tcp
	```
	* Add a firewall rule in the chain
	```sh
	$ sudo ufw allow from any to any app Libvirt
	```
* Test connection
```sh
virsh -c qemu+tcp://IP_address/system nodeinfo
```





https://www.webvirtmgr.net/docs/



