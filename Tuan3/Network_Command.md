#Một số lệnh về mạng
#I - ifconfig
* Lệnh ifconfig dùng để xem thông tin card mạng 
* Ngoài ra còn có thể set địa chỉ ip tỉnh cho máy,nhưng chỉ có hiệu lực tức thời.
* Xem thông tin tất cả các card mạng có trên máy
```sh
ifconfig -a
```

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
	* Card lo là card mạng loopback dùng để chỉ chính bản thân nó, có địa chỉ ip là 127.0.0.1.
	* Ta còn có 2 card mạng Ethernet.
		* card eno16777736 đang hoạt động, có địa chỉ ip là 192.168.1.69
		* card eno33554992 hiện không hoạt động.

* Set ip tỉnh cho máy
	* Cách 1: Chỉ có hiệu lực tức thời, sẽ mất khi khởi động lại
	```sh
	ifconfig eno16777736 10.30.255.100 netmask 255.255.0.0 up
	```
	=> Set card mạng eno16777736, dùng địa chỉ IP 10.30.255.100 và có netmask 255.255.0.0
	
	* Cách 2: Có hiệu lực mãi mãi.
	
	Thêm câu lệnh ở file /etc/network/interfaces

	```sh
	auto eno16777736

	iface eno16777736 inet static

	address 192.168.10.221

	netmask 255.255.255.0

	gateway 192.168.10.1

	nameserver 8.8.8.8
	```
	=> Set card mạng eno16777736, có địa chỉ ip 192.168.10.221, gateway 192.168.10.1 và dns server 8.8.8.8


#II - PING
* Lệnh Ping dùng để kiểm tra có thể kết nối đến một địa chỉ IP cụ thể nào không.
* Ping sử dụng ECHO_REQUEST datagram của giao thức ICMP để yêu cầu một ICMP ECHO_RESPONSE từ một host hoặc gateway nào đó.
* ECHO_REQUEST datagrams (“pings”) có một địa chỉ IP và ICMP header, theo sau đó là một struct timeval và cuối cùng là một vài ký tự hoặc chữ số ngẫu nhiên để lấp đầy gói tin sao cho vừa đủ dung lượng quy định của mỗi ICMP package.
* Ping được dùng cho mục đích kiểm tra, đo lường và quản lý hệ thống mạng. 
* Cú pháp
```sh
ping -option địa_chỉ
```
Các option:
	* -a: Bật âm thanh cho mỗi thông điệp ICMP phản hồi thành công.
	* -A: Gửi các gói tin cách nhau chưa tối 1ms (bình thường là 200ms).
	* -b: Cho phép ping địac hỉ Broadcast.
	* -B: Không cho phép lệnh Ping hoạt động khi thay đổi địa chỉ IP của máy phát đi thông điệp.
	* -c: ping 192.168.100.1 -c 10

		Có nghĩa là ping sẽ dừng lại sau khi gửi đi đủ 10 gói ECHO_REQUEST.
	* -w: ping 192.168.100.1 -w10
		
		Có nghĩa là ping sẽ dừng lại sau khi nhận đủ 10 gói ECHO_REPLY.
	* -f: Với mỗi thông điệp ECHO_REQUEST được gởi, một dấu chấm (.) được in ra màn hình, với mỗi ECHO_REPLY được biên nhận, một dấu cách (backspace) sẽ được in ra màn hình. Với cách thể hiện này sẽ cho người sử dụng có cái nhìn tổng quan về số gói tin đã được gửi tới destination và lượng gói bị hỏng giữa đường. Nếu tùy chọn interval (-i) không được kích hoạt, ping với tùy chọn -f sẽ thiết lập cho interval về 0 và bắn đi các gói tin nhanh nhất có thể hoặc bắn ra (hàng trăm phát)/(giây), nhìn chung là bắn với tiêu chí càng nhiều càng tốt.
	* -i: Thiết lập khoảng thời gian chờ giữa 2 lần gửi gói tin ECHO_REQUEST. Ở chế độ mặc định, thời gian chờ đợi là 1 giây, ở chế độ flood ping thời gian chờ đợi là 0. Chỉ super-user mới có quyền thiết lập interval về các giá trị nhỏ hơn 0.2 giây.
	* -I: Thiết lập địa chỉ gởi ECHO_REQUEST. Giá trị sau -I có thể là ID của thiết bị hoặc là IP đã được thiết lập cho thiết bị đó
	* -l: ping 192.168.100.1 -l 100

		ping gửi 100 gói tới 192.168.100.1 mà không cần chờ phản hồi ECHO_REPLY. Chỉ super-user mới có quyền thiết lập lớn hơn 3 gói tin. 
	* -n: Ví dụ: ping -n tinsang.net
	
		Rút gọn kết quả trả về chỉ bao gồm địa chỉ ip của tinsang.net mà không bao gồm tên dạng text của địa chỉ đó
	* -p: Đặt dạng thông điệp vào ICMP, nhằm chuẩn đoán tình trạng mạng. Sau -p các thông điệp buộc phải để ở dạng HEX.
	* -R: Với mỗi thông điệp ECHO_REQUEST, ngoài thông điêp ECHO_REPLY ping trả về thêm được bảng định tuyến của gói tin đó.
	* -s: Thiết lập dung lượng gói ICMP. Dung lượng lớn nhất có thể thiết lập là 65507
	* -t: Thiết lập time to live.
	* -v: Hiển thị chi tiết cấu trúc gói tin ICMP theo dung lượng các phần trong header.
	* -W: Thiết lập thời gian chờ gói tin phản hồi.
	

* **Ví dụ: Ping 5 gói tin đến dantri.com.vn**

**ping -c 5 dantri.com.vn**
```sh
PING dantri.com.vn (210.211.126.87) 56(84) bytes of data.
64 bytes from 210.211.126.87: icmp_seq=1 ttl=52 time=41.9 ms
64 bytes from 210.211.126.87: icmp_seq=2 ttl=53 time=4.64 ms
64 bytes from 210.211.126.87: icmp_seq=3 ttl=53 time=3.11 ms
64 bytes from 210.211.126.87: icmp_seq=4 ttl=53 time=6.11 ms
64 bytes from 210.211.126.87: icmp_seq=5 ttl=53 time=3.50 ms

--- dantri.com.vn ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4032ms
rtt min/avg/max/mdev = 3.118/11.865/41.951/15.079 ms
```

64 bytes from 210.211.126.87: icmp_seq=1 ttl=52 time=41.9 ms


Khi nhận được thông báo có dạng như trên thì có nghĩa là lệnh ping đã thực hiện thành công và hệ thống không có lỗi:
	
* 64 bytes: là kích thước của gói tin ICMP được gửi đi.
* Địa chỉ IP sau từ “from” cho biết máy nào đang gửi thông điệp trả lời.
* icmp_seq=1 là gói tin ICMP thứ 1.
* ttl=52 là giá trị "time to live" (thời gian sống) của gói tin ICMP. Hết thời gian này thì gói tin sẽ bị hủy.
* time=41.9 ms là thời gian của quá trình hồi đáp chỉ tốn 41.9 mili giây

=>Gửi 5 gói tin, nhận đầy đủ 5 gói tin, thời gian gửi 4032ms.

rtt: Round-trip time: là khoảng thời gian tính từ lúc client bắt đầu gửi request tới lúc nó nhận gói dữ liệu đầu tiên trả về, không bao gồm thời gian nhận đầy đủ dữ liệu.

min/avg/max/mdev: thời gian nhỏ nhất, thời gian trung bình, thời gian lớn nhất, thời gian độ lệch chuẩn (http://serverfault.com/questions/333116/what-does-mdev-mean-in-ping8)



* Thông báo: Request timed out: Không kết nối được với máy đích.
Nguyên nhân có thể là: 
	* Thiết bị định tuyến Router bị tắt.
	* Địa chỉ máy đích không có thật hoặc máy đích đang bị tắt, hoặc cấm ping.
	* Nếu máy đích khác đường mạng với máy nguồn thì nguyên nhân có thể do không có định tuyến ngược trở lại máy nguồn. Lúc này, nếu máy đích đang chạy, bạn có thể kiểm tra đường đi về của gói tin bằng cách xem lại thông số Default Gateway trên máy đích, máy nguồn và router kết nối các đường mạng.
	* Độ trễ của quá trình hồi đáp lớn hơn 1 giây. Phiên làm việc của lệnh ping mặc định là 1 giây. Nhưng nếu quá trình hồi đáp lớn hơn 1 giây mà gói tin vẫn chưa đến đích thì lệnh ping cũng thông báo lỗi trên.
	
* 3. Thông báo: Destination host unreachable:

	Thông báo cho biết không thể kết nối đến máy đích. Nguyên nhân gây ra lỗi này có thể là do cáp mạng bị đứt, không gắn cáp vào card mạng, card mạng bị tắt, Driver card mạng bị hư…


#III - NETSTAT
* Lệnh netstat trên là một lệnh nằm trong số các tập lệnh để giám sát hệ thống. 
* Netstat giám sát cả chiều in và chiều out kết nối vào server, hoặc các tuyến đường route, trạng thái của card mạng.
* Cú pháp
```sh
netstat -tùy chọn
```
Các tùy chọn:
	* a: Liệt kê tất cả các kết nối hiện tại.
	* n: Không phân giải địa chỉ ip thành tên miền.
	* t: Hiển thị kết nối TCP.
	* u: Hiển thị kết nối UDP.
	* s: Hiển thị thống kê của mỗi giao thức (TCP,UDP,ICMP,...) và thống kê các gói tin ra vào trên mạng.
	* o: Hiển thị thông tin về thời gian kết nối.
	* p: Hiển thị PID và chương trình đang kết nối. (Quyền root)
	* l: Hiển thị trạng thái cổng đang listen.
	* i: Hiển thị các cổng mạng đang hoạt động.
	* r: Hiển thị bảng định tuyến.
	* c: Tự động làm mới các kết quả trả về. Mặc định là 1s.

##3.1 Liệt kê ra tất cả các kết nối hiện tại

* netstat -an:
```sh
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN     
tcp        0      0 192.168.1.69:22         192.168.1.45:43151      ESTABLISHED
tcp6       0      0 :::80                   :::*                    LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
udp        0      0 0.0.0.0:64926           0.0.0.0:*                          
udp        0      0 0.0.0.0:68              0.0.0.0:*                          
udp6       0      0 :::40547                :::*                               
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  2      [ ACC ]     SEQPACKET  LISTENING     10408    /run/udev/control
unix  2      [ ]         DGRAM                    10396    /run/systemd/notify
unix  2      [ ACC ]     STREAM     LISTENING     10397    /run/systemd/private
unix  7      [ ]         DGRAM                    10409    /run/systemd/journal/dev-log
unix  2      [ ACC ]     STREAM     LISTENING     10413    /run/systemd/fsck.progress
unix  2      [ ACC ]     STREAM     LISTENING     10419    /run/systemd/journal/stdout
unix  6      [ ]         DGRAM                    10420    /run/systemd/journal/socket
unix  2      [ ]         DGRAM                    11043    /run/systemd/journal/syslog
unix  2      [ ACC ]     STREAM     LISTENING     12612    /var/run/dbus/system_bus_socket
unix  2      [ ACC ]     STREAM     LISTENING     12611    /run/uuidd/request
unix  2      [ ACC ]     STREAM     LISTENING     14362    /var/run/mysqld/mysqld.sock
unix  2      [ ]         DGRAM                    12154    
unix  3      [ ]         STREAM     CONNECTED     12129    
unix  3      [ ]         STREAM     CONNECTED     12659    /run/systemd/journal/stdout
unix  3      [ ]         DGRAM                    11191    
unix  3      [ ]         STREAM     CONNECTED     12840    
unix  3      [ ]         STREAM     CONNECTED     14552    
unix  2      [ ]         DGRAM                    11180    
unix  2      [ ]         DGRAM                    14513    
unix  3      [ ]         DGRAM                    12159    
unix  2      [ ]         DGRAM                    17744    
unix  3      [ ]         STREAM     CONNECTED     13216    
unix  3      [ ]         STREAM     CONNECTED     14530    
unix  3      [ ]         STREAM     CONNECTED     13229    /var/run/dbus/system_bus_socket
unix  2      [ ]         STREAM     CONNECTED     17724    
unix  3      [ ]         DGRAM                    12162    
unix  3      [ ]         STREAM     CONNECTED     13609    /run/systemd/journal/stdout
unix  2      [ ]         DGRAM                    11104    
unix  3      [ ]         STREAM     CONNECTED     13551    /var/run/dbus/system_bus_socket
unix  3      [ ]         STREAM     CONNECTED     13550    
unix  3      [ ]         STREAM     CONNECTED     12841    /run/systemd/journal/stdout
unix  3      [ ]         STREAM     CONNECTED     13870    /run/systemd/journal/stdout
unix  3      [ ]         STREAM     CONNECTED     12885    /run/systemd/journal/stdout
unix  2      [ ]         DGRAM                    13219    
unix  3      [ ]         STREAM     CONNECTED     13415    
unix  3      [ ]         STREAM     CONNECTED     13228    
unix  3      [ ]         DGRAM                    12160    
unix  3      [ ]         STREAM     CONNECTED     12797    
unix  3      [ ]         STREAM     CONNECTED     12131    /run/systemd/journal/stdout
unix  3      [ ]         DGRAM                    12161    
unix  3      [ ]         DGRAM                    11190    
unix  3      [ ]         STREAM     CONNECTED     11173    
unix  2      [ ]         DGRAM                    17727    
unix  3      [ ]         STREAM     CONNECTED     11186    /run/systemd/journal/stdout
unix  2      [ ]         DGRAM                    12515    
unix  3      [ ]         STREAM     CONNECTED     12756    
unix  3      [ ]         STREAM     CONNECTED     14553    /var/run/dbus/system_bus_socket
unix  3      [ ]         STREAM     CONNECTED     12798    /run/systemd/journal/stdout
unix  3      [ ]         STREAM     CONNECTED     13608    
unix  3      [ ]         STREAM     CONNECTED     14531    
unix  3      [ ]         STREAM     CONNECTED     12658    
unix  3      [ ]         STREAM     CONNECTED     13869    
unix  3      [ ]         STREAM     CONNECTED     12883    
unix  2      [ ]         DGRAM                    13543    
unix  3      [ ]         STREAM     CONNECTED     13230    /var/run/dbus/system_bus_socket
unix  3      [ ]         STREAM     CONNECTED     13227    
unix  3      [ ]         STREAM     CONNECTED     13416    /run/systemd/journal/stdout
```

**tcp        0      0 192.168.1.69:22         192.168.1.45:43151      ESTABLISHED**

Có một kết nối từ máy tính 192.168.1.45, cổng 43151, kết nối đến máy tính của chúng ta sử dụng cổng
22 (SSH), bằng giao thức TCP và kết nối đã được thiết lập.



##3.2 Kiểm tra các port đang sử dụng phương thức TCP
```sh
netstat -at


Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 *:ssh                   *:*                     LISTEN     
tcp        0      0 localhost:mysql         *:*                     LISTEN     
tcp        0      0 ubuntu:ssh              ADK:43151               ESTABLISHED
tcp6       0      0 [::]:http               [::]:*                  LISTEN     
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN     
```
##3.3 Kiểm tra các port sử dụng phương thức UDP
```sh
netstat -au

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
udp        0      0 *:64926                 *:*                                
udp        0      0 *:bootpc                *:*                                
udp6       0      0 [::]:40547              [::]:*                             
```
##3.4 Kiểm tra các port đang ở trạng thái listening(lắng nghe)
```sh
netstat -l

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 *:ssh                   *:*                     LISTEN     
tcp        0      0 localhost:mysql         *:*                     LISTEN     
tcp6       0      0 [::]:http               [::]:*                  LISTEN     
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN     
udp        0      0 *:64926                 *:*                                
udp        0      0 *:bootpc                *:*                                
udp6       0      0 [::]:40547              [::]:*                             
Active UNIX domain sockets (only servers)
Proto RefCnt Flags       Type       State         I-Node   Path
unix  2      [ ACC ]     SEQPACKET  LISTENING     10408    /run/udev/control
unix  2      [ ACC ]     STREAM     LISTENING     10397    /run/systemd/private
unix  2      [ ACC ]     STREAM     LISTENING     10413    /run/systemd/fsck.progress
unix  2      [ ACC ]     STREAM     LISTENING     10419    /run/systemd/journal/stdout
unix  2      [ ACC ]     STREAM     LISTENING     12612    /var/run/dbus/system_bus_socket
unix  2      [ ACC ]     STREAM     LISTENING     12611    /run/uuidd/request
unix  2      [ ACC ]     STREAM     LISTENING     14362    /var/run/mysqld/mysqld.sock
```
##3.5 Kiểm tra các port ở trạng thái listening sử dụng giao thức TCP
```sh
netstat -lt

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 *:ssh                   *:*                     LISTEN     
tcp        0      0 localhost:mysql         *:*                     LISTEN     
tcp6       0      0 [::]:http               [::]:*                  LISTEN     
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN     
```
##3.6 Kiểm tra các port ở trạng thái listening sử dụng giao thức UDP
```sh
netstat -lu

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
udp        0      0 *:64926                 *:*                                
udp        0      0 *:bootpc                *:*                                
udp6       0      0 [::]:40547              [::]:*                             
```
##3.7 Kiểm tra các ứng dụng có port đang lắng nghe, sử dụng giao thức TCP.
```sh
netstat -plnt

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      667/sshd        
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      1059/mysqld     
tcp6       0      0 :::80                   :::*                    LISTEN      1071/apache2    
tcp6       0      0 :::22                   :::*                    LISTEN      667/sshd        
```
##3.8 Hiển thị bảng định tuyến
```sh
netstat -rn

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG        0 0          0 eno16777736
192.168.1.0     0.0.0.0         255.255.255.0   U         0 0          0 eno16777736
```
##3.9 Hiển thị thống kê cho mỗi giao thức.
* netstat -s
```sh
Ip:
    2026 total packets received
    0 forwarded
    0 incoming packets discarded
    2024 incoming packets delivered
    1243 requests sent out
    40 outgoing packets dropped
Icmp:
    80 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
        destination unreachable: 80
    80 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        destination unreachable: 80
IcmpMsg:
        InType3: 80
        OutType3: 80
Tcp:
    1 active connections openings
    1 passive connection openings
    0 failed connection attempts
    0 connection resets received
    1 connections established
    1721 segments received
    1056 segments send out
    0 segments retransmited
    0 bad segments received.
    0 resets sent
Udp:
    40 packets received
    80 packets to unknown port received.
    0 packet receive errors
    120 packets sent
    IgnoredMulti: 103
UdpLite:
TcpExt:
    13 delayed acks sent
    414 packet headers predicted
    257 acknowledgments not containing data payload received
    630 predicted acknowledgments
    IPReversePathFilter: 2
    TCPRcvCoalesce: 3
    TCPOrigDataSent: 1011
IpExt:
    InBcastPkts: 103
    InOctets: 218790
    OutOctets: 188342
    InBcastOctets: 10591
    InNoECTPkts: 2026
```
##3.10 Hiển thị list các network interfaces.
* netstat -i
```sh
Kernel Interface table
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
eno16777736  1500 0      3176      0      0 0          1371      0      0      0 BMRU
lo        65536 0       160      0      0 0           160      0      0      0 LRU
```
##3.11 Giải thích các tham số:
* Proto: Cho biết giao thức kết nối: TCP hay UDP
* Local Address: Địa chỉ ip và số cổng kết nối của máy tính mình đang sử dụng. (Cổng chưa được thiết lập sẽ hiển thị dấu *)
* Foreign Address: Địa chỉ ip và số cổng kết nối của máy tính bên ngoài đang kết nối với máy tính mình.
* State: Cho biết trạng thái của cổng.
	* CLOSE_WAIT: Đóng và chờ.
	* CLOSED: Đã đóng.
	* ESTABLISHED: Kết nối được thiết lập
	* LISTEN: Lắng nghe.

## IV - Traceroute
###4.1 Traceroute:
* Traceroute là một ứng dụng giúp chúng ta xác định "đường đi" của các gói tin (packets) từ một máy này (host) đến một máy khác.
* Đường đi (path) ở đây được hiểu là một chuỗi gồm các trạm (IP-router) mà packets phải đi qua để đến được đích. 

###4.2 ICMP:
* ICMP – Internet Control Message Protocol. ICMP được dùng để thông báo các lỗi xảy ra trong quá trình truyền đi của các gói dữ liệu trên mạng. ICMP thuộc tầng vận huyển – Transpoort Layer!
* Tất cả các ICMP messages đều được chuyển đi cùng với các IP datagrams.
![](http://images.slideplayer.com/5/1485359/slides/slide_10.jpg)

	* Trường type có 15 giá trị khác nhau, tùy thuộc vào từng loại ICMP error message cụ thể. Ví dụ type=3 để chỉ định cho thông báo lỗi “Không đến được đích” – “Destination unreachable” error message!
	* Trường code = sub-error dùng để xác định chính xác lỗi đã xảy ra. Ví dụ, type=3 và code=0 nghĩa là “Network Unreachable”(không đến được mạng); nếu type=3, code=1 nghĩa là “Host Unreachable”(không đến được host)…
	
###4.3 TTL: Time-to-live 
* TTL là một trường 8 bit trong IP header, trường này được khởi tạo bởi bên gửi (sender). (Giá trị được khuyến cáo của trường này theo "Assigned Numbers - RFC" là 64).
* Mỗi một router khi xử lý IP-datagram sẽ giảm giá trị TTL của datagram này đi một. Mục đích của trường TTL là giúp cho datagram tránh đi vào những vòng lặp vô tận (infinite loops). Do hầu hết các bộ định tuyến -router- đều giữ các datagram không quá một giây, nên trường TTL cũng được dùng như một bộ đếm hop (hop counter). 

###4.4 Traceroute - TTL - ICMP 
* Khi một router nhận được một IP-datagram có giá trị TTL bằng 0 hoặc 1, nó không được phép chuyển datagram này đi tiếp. (Một host đích khi nhận được datagram như vậy, có thể chuyển datagram này tới ứng dụng tương ứng, vì datagram này không phải được tiếp tục "định tuyến". Nhưng thông thường không có hệ thống nào nhận được datagram có TTL bằng 0). Thay vào đó router sẽ bỏ qua (discard) datagram này và gửi trả lại cho host nguồn một thông báo lỗi ICMP time exceed (vượt thời hạn).
* Mấu chốt ở Traceroute chính là gói IP-datagram chứa ICMP nói trên sẽ cung cấp địa chỉ IP của router. Địa chỉ này nằm ở trường "địa chỉ nguồn" (source address - xem hình IP Header). 

###4.5 Traceroute - Cơ chế hoạt động
* Để xác định "đường đi" - path - của packets từ một host nguồn A đến một host đích B, đầu tiên traceroute sẽ gởi một IP-datagram có TTL=1 đến host B. Router đầu tiên xử lý datagram này sẽ giảm TTL đi một, bỏ qua (discard) datagram này và gửi trở lại A một datagram chứa ICMP time exceeded. Nhờ đó router đầu tiên thuộc path được định danh.
* Tiếp theo traceroute gửi một datagram có TTL=2 tới host B nhằm xác định địa chỉ IP của router thứ hai trên path. Router thứ nhất sẽ giảm TTL đi một (--> TTL lúc này sẽ bằng 1) và chuyển datagram đi tiếp. Router thứ 2 thấy TTL=1, giảm tiếp đi một, bỏ qua datagram này, gửi ICMP time exceeded trở lại A.
* Tương tự như vậy, quá trình trên được tiếp diễn cho đến khi datagram gặp được host đích B. Mặc dù gói datagram đến được đích có TTL=1, host B sẽ không loại bỏ datagram này và cũng không gửi ICMP time exceeded trở lại, bởi vì datagram này đã đến được nơi nó muốn đến. Vấn đề được đặt ra ở đây là làm sao traceroute biết được khi nào đã đến đích?
* Trong *nix, ở chế độ mặc định (default), traceroute gửi những gói UDP-datagram, nhưng nó sẽ chọn cổng UDP đích có giá trị lớn (lớn hơn 30.000), vì khó mà có một ứng dụng nào đó đang sử dụng cổng này, nghĩa là cổng đang đóng. Do đó, khi datagram đến, UDP-module ở host đích B sẽ phun ra ngay một thông báo lỗi ICMP "port unreachable" (không đến được cổng). Bây giờ traceroute chỉ việc phân biệt những ICMP mà nó nhận được để khẳng định đã đến điểm cuối trên path chưa (ICMP time exceed và ICMP port unreachable).

###4.6 Traceroute - Output

```sh
traceroute to vozforums.com (118.69.192.81), 30 hops max, 60 byte packets
 1  192.168.1.1 (192.168.1.1)  2.073 ms  1.959 ms  1.887 ms
 2  100.123.0.7 (100.123.0.7)  6.144 ms  6.110 ms  5.989 ms
 3  42.112.2.30 (42.112.2.30)  5.893 ms  5.778 ms  5.717 ms
 4  42.117.11.69 (42.117.11.69)  38.406 ms 183.80.133.150 (183.80.133.150)  33.794 ms  35.041 ms
 5  42.119.253.14 (42.119.253.14)  34.982 ms 118.69.252.158 (118.69.252.158)  34.907 ms 42.119.253.18 (42.119.253.18)  35.187 ms
 6  42.119.253.134 (42.119.253.134)  35.115 ms cache.google.com (42.119.253.166)  38.884 ms cache.google.com (42.119.253.138)  34.215 ms
 7  118.69.192.81 (118.69.192.81)  34.135 ms  55.683 ms  55.465 ms

```
* Dòng đầu tiên cho biết hostname và địa chỉ IP của hệ thống đích. Dòng này còn cho chúng ta biết thêm giá trị TTL<=30 và kích thước của datagram là 60 bytes.
* Dòng thứ 2 cho biết router đầu tiên nhận được datagram là 192.168.1.1, giá trị của TTL khi gởi đến router này là 1. Router này sẽ gởi trở lại cho chương trình traceroute một ICMP message error “Time Exceeded”. Traceroute sẽ gởi tiếp một datagram đến hệ thống đích.
* Dòng thứ 3, 100.123.0.7 nhận được datagram có TTL=1(router thứ nhất đã giảm một trước đó: TTL=2-1=1).
* Tương tự cho đến dòng thứ 7.
* Dòng thứ 8, 118.69.192.81 nhận được datagram có TTL = 1. Tuy nhiên, ở đây nó sẽ gởi trở lại cho traceroute một ICMP error message “Port Unreachable”. Khi nhận được ICMP message này, traceroute sẽ biết được đã đến được hệ thống đích và kết thúc.
* Trong trường hợp router không trả lời sau 5 giây, traceroute sẽ in ra một dấu sao “*”(không biết) và tiếp tục gởi datagram khác đến host đích!
* 3 Cột thời gian tiếp theo: Là khoảng thời gian để gói tin bắt đầu đi và quay trở lại máy tính của mình. (Đơn vị là phần nghìn giây). Có 3 cột thời gian vì traceroute gửi 3 gói tin hiệu riêng biệt.

##V - ROUTE
###5.1: Bảng định tuyến.
* Bảng định tuyến giống như là bảng chỉ đường, cho chúng ta biết muốn đi đến mạng nào, thì ta phải đi qua đâu, qua địa chỉ ip nào, qua card mạng nào.
* Để xem bảng định tuyến, ta sử dụng lệnh route -n
```sh
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 eno16777736
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eno16777736
```
Ví dụ, muốn đi đến các máy có địa chỉ mạng 192.168.1.0 thì phải đi qua card mạng eno16777736.

###5.2: Thêm 1 định tuyến mới.
Giả sử chúng ta muốn thêm một đinh tuyến mới cho phép server này truy cập đến các địa chỉ thuộc mạng 239.0.0.0 thì cần phải gõ lệnh sau:
* Cách 1: 	

	* Thêm mạng 239.0.0.0 ở card mạng eno16777736
	```sh
	ip route add 239.0.0.0/24 via 192.168.1.10 dev eno16777736
	hoặc
	route add -net 239.0.0.0 netmask 255.255.255.0 via 192.168.1.10 dev eno16777736
	```
	=> Tuy nhiên, cách này chỉ có hiệu lức tức thời, khởi động lại sẽ mất. Để khắc phục điều này, ta sử dụng cách 2.


* Cách 2:
Cách này sẽ có hiệu lực mãi mãi :D
	* Thêm lệnh định tuyến ở file /etc/network/interfaces
	```sh
	up route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.1.1
	```
	* Ví dụ
```sh
auto eth0
iface eth0 inet static
      address 192.168.1.2
      netmask 255.255.255.0
      up route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.1.1
      up route add -net 172.16.0.0 netmask 255.255.0.0 gw 192.168.1.1
```

##6 - NSLOOKUP
###6.1: Giới thiệu
* Là công cụ dùng để truy vấn DNS.
* Câu lệnh
```sh
nslookup [-option] host-to-find [server]
```
* host to find: Là địa chỉ domain mà mình muốn truy vấn.
* server: Chỉ định server DNS để truy vấn. (Ví dụ: 8.8.8.8 của google).
* Các tùy chọn:
	* -type = value: Truy vấn kiểu bản ghi nào (A, CNAME, NS, MX, PTR...). Nếu value = any thì sẽ truy vấn tất cả các giá trị bản ghi có sẵn.
	* -timeout=number: Thay đổi thời gian timeout. Mặc định là 5s
	* -port=value: Thay đổi cổng truy vấn DNS. (Mặc định là 53)
	* ................
* Ví dụ 1: 
```sh
nslookup -type=a dantri.com.vn
```
=>Truy vấn DNS của dantri.com.vn với kiểu A Record (Address Record): Dùng để Xác định địa chỉ IP của domain.

```sh
Server:		192.168.1.1
Address:	192.168.1.1#53

Non-authoritative answer:
Name:	dantri.com.vn
Address: 210.211.126.87
```
Đọc kết quả:

	* server DNS truy vấn: 192.168.1.1 (gateway), cổng 53
	* Non-authoritative answer: nghĩa là cái server mà mình hỏi nó không quản lý domain này, nó chỉ đi hỏi hộ mình thôi.
	* Sau khi truy vấn, ta được địa chi IP của dantri.com.vn là 210.211.126.87

* Ví dụ 2: 
```sh
nslookup -type=mx dantri.com.vn 8.8.8.8
```
=> Truy vấn DNS của dantri.com.vn với MX (Mail Exchange), sử dụng server DNS của google (8.8.8.8): Dùng để xác định mail server của dantri.com.vn

```sh
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
dantri.com.vn	mail exchanger = 10 aspmx5.googlemail.com.
dantri.com.vn	mail exchanger = 10 aspmx2.googlemail.com.
dantri.com.vn	mail exchanger = 1 aspmx.l.google.com.
dantri.com.vn	mail exchanger = 10 aspmx3.googlemail.com.
dantri.com.vn	mail exchanger = 5 alt1.aspmx.l.google.com.
dantri.com.vn	mail exchanger = 10 aspmx4.googlemail.com.
dantri.com.vn	mail exchanger = 5 alt2.aspmx.l.google.com.

Authoritative answers can be found from:
```

Đọc kết quả:
	* Server DNS truy vấn: 8.8.8.8, cổng 53.
	* Non-authoritative answer: nghĩa là cái server mà mình hỏi nó không quản lý domain này, nó chỉ đi hỏi hộ mình thôi.
	* Ta được kết quả là các mail server của dantri.com.vn

###6.2: Các lỗi khi truy vấn DNS.
* Timed out: Máy chủ không trả lời sau một khoảng thời gian nhất định. (Mặc định là 5s).
* No response from server: Không có dịch vụ DNS đang chạy trên server.
* No records: Máy chủ không có các bản ghi mà bạn truy vấn.
* Non-existent domain: Tên miền không tồn tại.
* Connection refused: Kết nối bị từ chối.
* Network is unreachable: Kết nối đến finger server không được vào lúc này. Lỗi này thường xảy ra với finger requests. (The connection to the name or finger server could not be made at
the current time.  This error commonly occurs with ls and fingerrequests.)
* Server failure: máy chủ đã được tìm thấy, nhưng có lỗi xung đột trong cơ sở dữ liệu, và không thể trả kết quả về.
* Refused: Server từ chối yêu cầu.
* Format error: Lỗi định dạng của gói tin.
	

###6.3: DNS Records
* 1. URL Redirect Record: Có nhiệm vụ chuyển URL của 1 hostname này sàng URL bất kỳ khác. URL Redirect Record thường xuất hiện trong các subdomain được cấp free trên mạng.
* 2. A Record (Address Record): Hay còn gọi là host A, có nhiệm vụ xác định một hostname cho 1 địa chỉ ip. A Record được dùng phổ biến trong các dịch vụ dynamic DNS. Với A Record bạn có thể cho nhiều hostname chạy trên nhiều địa chỉ IP khác nhau.
* 3. CNAME Record (Canonical Name Record): Là record có chức năng gán nhiều hostname cho 1 địa chỉ IP.
* 4. MX Record (Mail Exchange Record): Là record xác định 1 mail server (hay nhiều mail server) cho 1 domain hay 1 zone được xác định.
* 5. NS Record (Name Server Record): Dùng xác định DNS Server cho một Zone. Zone này phải chứa một NS Record cho mỗi DNS server (chính và phụ).
* 6. AAAA Record: Cũng giống như A Record nhưng đây là record được dùng khi bạn muốn một hostname được chỉ định chạy trên IPv6.
* 7. PTR (Pointer) : Phân giải địa chỉ IP sang hostname. 
* 8. SRV : Cung cấp cơ chế định vị dịch vụ, Active Directory sử dụng resource record này để xác định domain controllers, global catalog servers, Lightweight Directory Access Protocol (LDAP) servers. Các trường trong record SVR :
	* Tên dịch vụ service.
    * Giao thức sử dụng.
    * Tên miền (domain name).
    * TTL và class.
    * Priority.
    * weight (hỗ trợ load balancing).
    * Port của dịch vụ.
    * Target chỉ định FQDN cho host hỗ trợ dịch vụ.
* 9. SOA (Start of Authority) : Trong mỗi tập tin cơ sở dữ liệu DNS phải có một và chỉ một record SOA (Start of Authority). Bao gồm các thông tin về domain trên DNS Server, thông tin về zone transfer.





