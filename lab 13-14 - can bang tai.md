#Lab tuần 13-14 - Cân bằng tải
##Yêu cầu
```sh
Triển khai cân bằng tải cho 2 web server wordpress dùng chung 1 DB
Y/c: Vẽ mô hình triển khai bằng Visio (các địa chỉ IP, card mạng)
Viết báo cáo các bước triển khai. Kết quả thu được
Test khả năng sẵn sàng, hiệu năng.. (các công cụ ab, jmeter)
Viết script tối ưu nhất
```
##Mô hình
![](http://i.imgur.com/qsbsc40.jpg)
```sh
10.10.10.4 - DNS Server
10.10.10.100 - Load balancer sử dụng HAproxy.
10.10.10.6 - Web server 1
10.10.10.10 - Web server 2
10.10.10.8 - Database server 
```
##Nhiệm vụ

* DNS Server phân giải system.ksec.com thành địa chỉ ip của load balancer (10.10.10.100).
* Load balancer sử dụng HAproxy với thuật toán roudrobin để cân bằng tải cho 2 web server system.ksec.com chạy wordpress
* Web server 1 chứa source code wordpress của system.ksec.com.
* Web server 2 chứa source code wordpress của system.ksec.com.
* Database server chứa database của system.ksec.com

###Cấu hình DNS Server
* File zone

![file zone](http://i.imgur.com/HNF2tC3.png)

* File database thuận

![file database thuan](http://i.imgur.com/NpX0vDL.png)

* File database nghịch

![file database nghich](http://i.imgur.com/EMMu8ZN.png)

### Cấu hình HAproxy
* File cấu hình HAproxy: /etc/haproxy/haproxy.cfg
![](http://i.imgur.com/tpGkUzo.png)


![](http://i.imgur.com/N3kNWYr.png)

### Cấu hình WEB server 1. (Web server 2 tương tự)

* System.ksec.com

![system.ksec.com](http://i.imgur.com/69vmnPx.png)

* Config wordpress system.ksec.com

![config wordpress system.ksec.com](http://i.imgur.com/AlO92eK.png)

### Cấu hình DB server
* Chỉnh sửa file cấu hình mysql
```sh
	bind-address=10.10.10.8		//Database Server IP, Chỉnh sửa trong file cấu hình mysql
```
* Tạo database và cấp quyền remote database cho webserver1
```sh
	Create database ksecsystem;	//tạo database system;
	GRANT ALL ON ksecsystem.* TO ksec@'10.10.10.6' IDENTIFIED BY 'ksec';	//cấp quyền remote database ksecsystem cho user ksec,password ksec, ip 10.10.10.6 (ip webserver1)
```	
* Cấp quyền remote database cho webserver2
```sh
create user 'ksec'@'10.10.10.10' IDENTIFIED by 'ksec';
use mysql;
GRANT ALL PRIVILEGES ON ksecsystem.* TO 'ksec'@'10.10.10.10';
```
![](http://i.imgur.com/WocXLe2.png)



* Sau khi đã cấu hình xong, thử truy cập database trên 2 web server:
![](http://i.imgur.com/2AsjTzI.png)
![](http://i.imgur.com/X6OvoGp.png)

## Kết quả
![](http://i.imgur.com/K2GdrD7.png)


