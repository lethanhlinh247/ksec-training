#Cấu trúc gói tin TCP
Một gói tin TCP bao gồm 2 phần
* Header
* Dữ liệu

![](http://data.sinhvienit.net/2010/T02/img/SinhVienIT.Net---vne001801.JPG)
##1. Header

* **Source port:** Số hiệu của cổng tại máy tính gửi. 

* **Destination port:** Số hiệu của cổng tại máy tính nhận.

* **Sequence number:** Trường này có 2 nhiệm vụ. Nếu cờ SYN bật thì nó là số thứ tự gói ban đầu và byte đầu tiên được gửi có số thứ tự này cộng thêm 1. Nếu không có cờ SYN thì đây là số thứ tự của byte đầu tiên.

* **Acknowledgement number:** Nếu cờ ACK bật thì giá trị của trường chính là số thứ tự gói tin tiếp theo mà bên nhận cần.

* **Data offset:** Trường có độ dài 4 bít quy định độ dài của phần header (tính theo đơn vị từ 32 bít). Phần header có độ dài tối thiểu là 5 từ (160 bit) và tối đa là 15 từ (480 bít).

* **Reserved:** Dành cho tương lai và có giá trị là 0.

* **Flags (hay Control bits):** Bao gồm 6 cờ:

    * URG: Cờ cho trường Urgent pointer: Lá cờ đại diện cho rằng dữ liệu này cần được ưu tiên hơn các dữ liệc khác khi được truyền đi.
    * ACK: Cờ cho trường Acknowledgement: Lá cờ đại diện cho sự gửi lại thông tin báo là đã nhận được dữ liệu từ host gửi. Điều này được gửi trong suốt phần thứ hai của thiết lập kết nối, đáp ứng yêu cầu SYN của host gửi.
    * PSH: Hàm Push: Lá cờ được sử dụng khi host gửi yêu cầu dữ liệu phải được đưa trực tiếp cho các ứng dụng nhận được, và không để vào bộ đệm.
    * RST: Lá cờ đại diện cho ý định của người gửi để xác lập lại kết nối.
    * SYN: Lá cờ đại diện cho phần đầu tiên của thiết lập kết nối. Việc đồng bộ hóa thông thường sẽ có trong gói đầu tiên của việc truyền tin.
    * FIN: Lá cờ đại diện cho ý định của người gửi muốn chấm dứt các thông tin liên lạc trong phiên làm việc.

* **Window:** Số byte có thể nhận bắt đầu từ giá trị của trường báo nhận (ACK)

* **Checksum:** 
    16 bít kiểm tra cho cả phần header và dữ liệu. 
```sh
16 bít của trường kiểm tra là bổ sung của tổng tất cả các từ 16 bít trong gói tin. Trong trường hợp số octet (khối 8 bít) của header và dữ liệu là lẻ thì octet cuối được bổ sung với các bít 0. Các bít này không được truyền. Khi tính tổng, giá trị của trường kiểm tra được thay thế bằng 0
```
Nói một cách khác, tất cả các từ 16 bít được cộng với nhau. Kết quả thu được sau khi đảo giá trị từng bít được điền vào trường kiểm tra. Về mặt thuật toán, quá trình này giống với IPv4.

Điểm khác nhau chỉ ở chỗ dữ liệu dùng để tính tổng kiểm tra.

* **Urgent pointer:** Nếu cờ URG bật thì giá trị trường này chính là số từ 16 bít mà số thứ tự gói tin (sequence number) cần dịch trái.

* **Options:** Đây là trường tùy chọn. Nếu có thì độ dài là bội số của 32 bít.

##2. Dữ liệu

Trường cuối cùng không thuộc về header. Giá trị của trường này là thông tin dành cho các tầng trên (trong mô hình 7 lớp OSI). Thông tin về giao thức của tầng trên không được chỉ rõ trong phần header mà phụ thuộc vào cổng được chọn.

##3. Khi Client muốn thực hiện một kết nối TCP với Server đầu tiên:
![](http://data.sinhvienit.net/2010/T02/img/SinhVienIT.Net---vne001802.JPG)
* Bước I: Client bắn đến Server một gói tin SYN

	- SYN: các chương trình máy con (ví dụ yêu cầu từ browser, ftp client) bắt đầu connection với máy chủ bằng cách gửi một packet với cờ "SYN" đến máy chủ.

	- SYN packet này thường được gửi từ các cổng cao (1024 - 65535) của máy con đến những cổng trong vùng thấp (1 - 1023) của máy chủ. Chương trình trên máy con sẽ hỏi hệ điều hành cung cấp cho một cổng để mở connection với máy chủ. Những cổng trong vùng này được gọi là "cổng máy con" (client port range). Tương tự như vậy, máy chủ sẽ hỏi HĐH để nhận được quyền chờ tín hiệu trong máy chủ, vùng cổng 1 - 1023. Vùng cổng này được gọi là "vùng cổng dịch vụ" (service port).

	- Ví dụ (mặc định):
		* Web Server sẽ luôn chờ tín hiệu ở cổng 80 và Web browser sẽ connect vào cổng 80 của máy chủ.
		* FTP Server sẽ lắng ở port 21.
 
	- Ngoài ra trong gói dữ liệu còn có thêm địa chỉ IP của cả máy con và máy chủ.

* Bước II: Server trả lời tới Client một gói tin SYN/ACK.
	
	- Khi yêu cầu mở connection được máy chủ nhận được tại cổng đang mở, server sẽ gửi lại packet chấp nhận với 2 bit cờ là SYN và ACK.
	
	- SYN/ACK packet được gửi ngược lại bằng cách đổi hai IP của server và client, client IP sẽ thành IP đích và server IP sẽ thành IP bắt đầu. Tương tự như vậy, cổng cũng sẽ thay đổi, server nhận được packet ở cổng nào thì cũng sẽ dùng cổng đó để gửi lại packet vào cổng mà client đã gửi.
	
	- Server gửi lại packet này để thông báo là server đã nhận được tín hiệu và chấp nhận connection, trong trường hợp server không chấp nhận connection, thay vì SYN/ACK bits được bật, server sẽ bật bit RST/ACK (Reset Acknowledgement) và gởi ngược lại RST/ACK packet.
	
	- Server bắt buộc phải gửi thông báo lại bởi vì TCP là chuẩn tin cậy nên nếu client không nhận được thông báo thì sẽ nghĩ rằng packet đã bị lạc và gửi lại thông báo mới.
* Bước III: Khi Client nhận được gói tin SYN/ACK sẽ gửi lại server một gói ACK – và quá trình trao đổi thông tin giữa hai máy bắt đầu.
	- Khi client nhận được SYN/ACK packet thì sẽ trả lời bằng ACK packet. Packet này được gởi với mục đích duy nhất là báo cho máy chủ biết rằng client đã nhận được SYN/ACK packet và lúc này connection đã được thiết lập và dữ liệu sẽ bắt đầu lưu thông tự do.
	- Đây là tiến trình bắt buộc phải thực hiện khi client muốn trao đổi dữ liệu với server thông qua giao thức TCP.

##4. Khi Client muốn kết thúc một phiên làm việc với Server
![](http://data.sinhvienit.net/2010/T02/img/SinhVienIT.Net---vne001803.JPG)

* Bước I: Client gửi đến Server một gói tin FIN ACK
	* FIN = 1: Session sẽ được giới hạn.
	* ACK = 1: Đây là một số ack, dựa trên thông tin hiện tại.
	* Sequence Number (FIN number) = s: s là một giá trị dựa trên thông tin hiện tại) 
	* Acknowledgement Number = p: p là một giá trị dựa trên thông tin hiện tại) 


* Bước II: Server nhận từ client và gửi lại cho Client một gói tin ACK
	* FIN = 0: Segment này không yêu cầu termination của session. 
	* ACK = 1: Segment bao gồm một số ack. 
	* Sequence Number = Not Present: Do không có FIN, nên không có sequence number được yêu cầu. 
	* Acknowledgement Number = s + 1: Đây là response tới FIN của Host A FIN.

* Bước III: Server lại gửi cho Client một gói FIN ACK
	* FIN = 1: Session sẽ được giới hạn.
	* ACK = 1: Đây là một số ack.
	* Sequence Number = p: p là một giá trị dựa trên thông tin hiện tại.
	* Acknowledgement Number = s + 1: Tương tự như trong segment trước. 

* Bước IV: Client nhận từ server và gửi lại cho Server gói ACK và quá trình ngắt kết nối giữa Server và Client được thực hiện.
	* FIN = 0: Segment không yêu cầu một termination, không có SYN. 
	* ACK = 1: Segment bao gồm một số ack.
	* Sequence Number = Not Present.
	* Acknowledgement Number = p + 1: Đây là số sequence number của Host C được công thêm 1.

Lúc này liên kết truyền thông giữa 2 host đã kết thúc.
##5. Điểm yếu trong cơ chế bắt tay 3 bước và cách thức tấn công:
###5.1: Điểm yếu
* Điểm yếu thứ 1: Không hoàn thành quá trình bắt tay 3 bước.
	* Khi Client gửi yêu cầu khởi tạo kết nối (SYN) đến Server. Sau khi nhận được được yêu cầu tử Client,
 Server sẽ kiểm tra tài nguyên để đáp ứng nhu cầu của client, nếu đáp ứng được, server lập tức dành phần
 tài nguyên (bộ nhớ) và mở port để phục vụ kết nối này, kể cả khi chưa kết nối thành công.
	* Lợi dụng điều này, hacker sẽ gửi những gói tin giả mạo khởi tạo kết nối đến Server, Server ngay lập tức
 dành phần tài nguyên và mở port cho kết nối này, kể cả khi chưa kết nối thành công. Trong khi đó, hacker lại không 
 hoàn thành quá trình bắt tay 3 bước, mà lại tiếp tục gửi gói tin giả mạo khác đến Server. Cứ như thế
 làm Server cạn kiệt tài nguyên và không thể đáp ứng được nhu cầu của người dùng bình thường.
**=> Được Lợi dụng trong tấn công SYN Flood**
 
* Điểm yếu thứ 2: Tạo vòng lặp vô hạn.
	* Client gửi yêu cầu khởi tạo kết nối (SYN) đến server, nhưng lại sử dụng chính địa chỉ ip của server
 làm địa chỉ nguồn (source) trong gói tin TCP => Tạo nên vòng lặp vô hạn trong chính hệ thống của server.
	* Server sẽ không thể gửi đi thông tin phản hồi cho client, đồng thời chính server lại đang cần nhận thông tin phản hồi từ Client.

	**=> Được lợi dụng trong tấn công Land Attack**

* Điểm yếu thứ 3: Không thể sắp xếp các gói dữ liệu
	* Tất cả các dữ liệu chuyển đi trên mạng từ hệ thống nguồn đến hệ thống đích đều phải trải qua 2 quá trình :
		* Dữ liệu sẽ được chia ra thành các mảnh nhỏ ở hệ thống nguồn, mỗi mảnh đều phải có một giá trị offset nhất định để xác định vị trí của mảnh đó trong gói dữ liệu được chuyển đi.
		* Khi các mảnh này đến hệ thống đích, hệ thống đích sẽ dựa vào giá trị offset để sắp xếp các mảnh lại với nhau theo thứ tự đúng như ban đầu. 
	* Lợi dụng sơ hở đó , ta chỉ cần gởi đến hệ thống đích một loạt gói packets với giá trị offset chồng chéo lên nhau. Hệ thống đích sẽ không thể nào sắp xếp lại các packets này, nó không điều khiển được và có thể bị crash, reboot hoặc ngừng hoạt động nếu số lượng gói packets với giá trị offset chồng chéo lên nhau quá lớn!

	**=> Được lợi dụng trong tấn công Teardrop**

###5.2: Cách thức tấn công
####5.2.1: SYN Flood
![](http://www.cisco.com/web/about/security/images/csc_child_pages/white_papers/ddos_fig07.jpg)
 
* Có 2 cách để server không nhận được gói tin với cờ ACK là:

	* Client không gửi gói tin với cờ ACK.
	* Giả mạo địa chỉ nguồn trong gói tin đầu tiên (cờ SYN).

	=>Trong cả 2 trường hợp server đều không bao giờ nhận được gói tin với cờ ACK.
	
* Nếu quá trình thiết lập kết nối TCP chưa hoàn thành (server chưa nhận được gói tin chứa cờ ACK cuối cùng) mà server đã cấp phát tài nguyên cho kết nối này (gọi là half-open connection) thì tài nguyên của server nhanh chóng bị cạn kiệt và không có khả năng phục vụ các kết nối của người dùng hợp pháp khác thậm chí còn phá hủy các chức năng khác của hệ thống.
	
* **Cách thức tấn công thường được sử dụng:** Làm giả mạo 1 địa chỉ IP Client , liên tục làm "Bước 1 - Gửi yêu cầu khởi tạo kết nối SYN" mà không cần sự hồi đáp lại "Bước 2 - Nhận gói tin SYN/ACK" của server, tức là client liên tục gửi hàng ngàn gói tin SYN đến server, dẫn đến tình trạng server xử lý không kịp và có thể bị sập.

####5.2.2 Land Attack
![](https://www.juniper.net/techpubs/images/land_attack.gif)

* Tấn công tương tự SYN Flood, tuy nhiên không giả mạo địa chỉ ip của client(hacker) mà sử dụng chính địa chỉ ip của server
làm địa chỉ ip của client. 
=> Tạo nên vòng lặp vô hạn trong hệ thống của server (victim). Làm hệ thống chậm lại hoặc treo hoàn toàn,
vì server cố gắng khởi tạo kết nối với chính nó trong một vòng lặp vô tận.

####5.2.3 Teardrop

* Một loạt gói packets với giá trị offset chồng chéo lên nhau được gởi đến hệ thống đích. Hệ thống đích sẽ không thể nào sắp xếp lại các packets này, nó không điều khiển được và có thể bị crash, reboot hoặc ngừng hoạt động nếu số lượng packets với giá trị offset chồng chéo lên nhau quá lớn! 

![](http://flylib.com/books/1/36/1/html/2/images/07fig08.jpg)
 


##6. Cơ chế hoạt động của traceroute:
###6.1 Traceroute:
* Traceroute là một ứng dụng giúp chúng ta xác định "đường đi" của các gói tin (packets) từ một máy này (host) đến một máy khác.
* Đường đi (path) ở đây được hiểu là một chuỗi gồm các trạm (IP-router) mà packets phải đi qua để đến được đích. 

###6.2 ICMP:
* ICMP – Internet Control Message Protocol. ICMP được dùng để thông báo các lỗi xảy ra trong quá trình truyền đi của các gói dữ liệu trên mạng. ICMP thuộc tầng vận huyển – Transpoort Layer!
* Tất cả các ICMP messages đều được chuyển đi cùng với các IP datagrams.
![](http://images.slideplayer.com/5/1485359/slides/slide_10.jpg)

	* Trường type có 15 giá trị khác nhau, tùy thuộc vào từng loại ICMP error message cụ thể. Ví dụ type=3 để chỉ định cho thông báo lỗi “Không đến được đích” – “Destination unreachable” error message!
	* Trường code = sub-error dùng để xác định chính xác lỗi đã xảy ra. Ví dụ, type=3 và code=0 nghĩa là “Network Unreachable”(không đến được mạng); nếu type=3, code=1 nghĩa là “Host Unreachable”(không đến được host)…
	
###6.3 TTL: Time-to-live 
* TTL là một trường 8 bit trong IP header, trường này được khởi tạo bởi bên gửi (sender). (Giá trị được khuyến cáo của trường này theo "Assigned Numbers - RFC" là 64).
* Mỗi một router khi xử lý IP-datagram sẽ giảm giá trị TTL của datagram này đi một. Mục đích của trường TTL là giúp cho datagram tránh đi vào những vòng lặp vô tận (infinite loops). Do hầu hết các bộ định tuyến -router- đều giữ các datagram không quá một giây, nên trường TTL cũng được dùng như một bộ đếm hop (hop counter). 

###6.4 Traceroute - TTL - ICMP 
* Khi một router nhận được một IP-datagram có giá trị TTL bằng 0 hoặc 1, nó không được phép chuyển datagram này đi tiếp. (Một host đích khi nhận được datagram như vậy, có thể chuyển datagram này tới ứng dụng tương ứng, vì datagram này không phải được tiếp tục "định tuyến". Nhưng thông thường không có hệ thống nào nhận được datagram có TTL bằng 0). Thay vào đó router sẽ bỏ qua (discard) datagram này và gửi trả lại cho host nguồn một thông báo lỗi ICMP time exceed (vượt thời hạn).
* Mấu chốt ở Traceroute chính là gói IP-datagram chứa ICMP nói trên sẽ cung cấp địa chỉ IP của router. Địa chỉ này nằm ở trường "địa chỉ nguồn" (source address - xem hình IP Header). 

###6.5 Traceroute - Cơ chế hoạt động
* Để xác định "đường đi" - path - của packets từ một host nguồn A đến một host đích B, đầu tiên traceroute sẽ gởi một IP-datagram có TTL=1 đến host B. Router đầu tiên xử lý datagram này sẽ giảm TTL đi một, bỏ qua (discard) datagram này và gửi trở lại A một datagram chứa ICMP time exceeded. Nhờ đó router đầu tiên thuộc path được định danh.
* Tiếp theo traceroute gửi một datagram có TTL=2 tới host B nhằm xác định địa chỉ IP của router thứ hai trên path. Router thứ nhất sẽ giảm TTL đi một (--> TTL lúc này sẽ bằng 1) và chuyển datagram đi tiếp. Router thứ 2 thấy TTL=1, giảm tiếp đi một, bỏ qua datagram này, gửi ICMP time exceeded trở lại A.
* Tương tự như vậy, quá trình trên được tiếp diễn cho đến khi datagram gặp được host đích B. Mặc dù gói datagram đến được đích có TTL=1, host B sẽ không loại bỏ datagram này và cũng không gửi ICMP time exceeded trở lại, bởi vì datagram này đã đến được nơi nó muốn đến. Vấn đề được đặt ra ở đây là làm sao traceroute biết được khi nào đã đến đích?
* Trong *nix, ở chế độ mặc định (default), traceroute gửi những gói UDP-datagram, nhưng nó sẽ chọn cổng UDP đích có giá trị lớn (lớn hơn 30.000), vì khó mà có một ứng dụng nào đó đang sử dụng cổng này, nghĩa là cổng đang đóng. Do đó, khi datagram đến, UDP-module ở host đích B sẽ phun ra ngay một thông báo lỗi ICMP "port unreachable" (không đến được cổng). Bây giờ traceroute chỉ việc phân biệt những ICMP mà nó nhận được để khẳng định đã đến điểm cuối trên path chưa (ICMP time exceed và ICMP port unreachable).

###6.6 Traceroute - Output

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

##7. Sliding Window 
![](http://www.highteck.net/images/66-TCP-acknowledgement.jpg)

Giao thức cửa sổ trượt cho phép bên gửi có thể gửi nhiều khung dữ liệu đồng thời.

###7.1: Cách hoạt động

* 1: Squence number của gói tin TCP ở người gửi là y.
* 2: Người nhận chỉ định kích thước cửa sổ của mỗi gói tin là x. Giá trị này được quy định bởi hệ điều hành hoặc
ứng dụng sử dụng. Mặc định là 536 bytes.
* 3: Người gửi gói tin datagram với kích thước x, và chờ đợi gói tin ACK từ người nhận. 
* 4: Người nhận gửi gói tin ACK có giá trị bằng y+x. Có nghĩa là x bytes đầu tiên đã được nhận thành công
và người nhận chờ 1 gói dữ liệu khác, bắt đầu từ y+x bytes.
* 5: Sau khi nhận thành công, kích thước cửa sổ tăng thêm x lần. (Đấy chính là Slow Start: Gia tăng tốc độ theo hàm mủ).
* 6: Người gửi gửi gói tin khác với kích thước 2x bytes, 3x bytes cho đến khi đạt giá trị MSS.(MSS (Maximum Segment Size) là kích thước mảnh dữ liệu (data) lớn nhất). 
* 7: Nếu người nhận có bộ nhớ đệm đầy, kích thước cửa sổ sẽ được đặt = 0. Người gửi không thể gửi thêm dữ liệu nào
cho đến khi nhận được gói tin từ máy nhận báo kích thước cửa sổ lớn hơn 0.
* 8: Nếu dữ liệu không được nhận, thì nó được thiết lập ngay sau khi nhận được một ACK, sau đó kích thước cửa sổ sẽ bị giảm đi một nửa.
* 9: Ở lần truyền thành công tiếp theo, kích thước sẽ lại được bắt đầu từ x.

###7.2: Window Size
* Trường này được sử dụng bởi người nhận để chỉ ra rằng người gửi chỉ được gửi lượng dữ liệu là bao nhiêu. Bất kể người gửi hoặc người nhận là ai, thì trường này luôn tồn tại và được sử dụng.
* Trường Window Size sử dụng đơn vị đo là byte
* Khi lượng dữ liệu được truyền bằng giá trị Window Size hiện tại, người gửi sẽ mong đợi 1 giá trị Window Size mới từ người nhận, cùng với 1 báo nhận cho giá trị Window Size vừa nhận được.

![](http://3.bp.blogspot.com/-QEWmsb6n9Ww/UcbxDw_4m_I/AAAAAAAAAJ4/nmODTuoCplk/s1600/tcp-analysis-section-5-3.gif)

###7.3: TCP Sequence Prediction Attack

* Host A và Host B đang kết nối với nhau. Hacker đang cố theo dõi các gói tin trao đổi giữa A và B.
* Cách hacker thực hiện:
	* Hacker muốn tấn công host A.
	* Hacker sẽ làm ngập lụt host B, ngăn chặn host B giao tiếp với host A.
	* Bây giờ, kẻ tấn công sẽ dự đoán sequence number của gói tin B gửi cho A.
	* Kẻ thấn công chuyển bị các gói dữ liệu và gửi đến host A.
	* Host A vẫn cứ nghĩ kẻ tấn công là host B.
	* Bây giờ, gói tin mà kẻ tấn công đã gửi có thể là chấm dứt kết nối, hoặc chạy 1 số lệnh, script độc hại.
	
