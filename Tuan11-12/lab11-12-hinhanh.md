#LAB Hình Ảnh tuần 11-12

##Yêu cầu:

1. Thiết lập một hệ thống các mấy chủ Hosting với:
- 01 Máy chủ Linux chạy BIND làm DNS server
- 01 Máy chủ Linux chạy HTTP và apache làm Hosting server cho phép chạy ngôn ngữ lập trình PHP
 có kết nối đến Database MySQL làm Web Hosting server  
- 01 Máy chủ Linux chạy MySQL làm Database server 
trong đó:
	1. Tên miền chính của máy chủ là ksec.com
	2. Tạo các server với domain:
		- ns.ksec.com : trỏ đến DNS/BIND server
		- www.ksec.com: trỏ đến Web Hosting server
		- db.ksec.com: trỏ đến Database server  
	3. Tạo một domain và hosting riêng  tương ứng với tên miền: 
	system.ksec.com với Document root là một thư mục nằm ngoài Document root của HTTP và apache

##Mô hình:

![Mô hình](http://i.imgur.com/mCVYNA7.png)

## Nhiệm vụ:

![Nhiệm vụ](http://i.imgur.com/7oOvrEH.png)

### Cấu hình DNS server

* File zone

![file zone](http://i.imgur.com/YgTDxTB.png)

* File database thuận

![file database thuan](http://i.imgur.com/ugoOYGW.png)

* File database nghịch

![file database nghich](http://i.imgur.com/odMwA1N.png)

### Cấu hình WEB server

* System.ksec.com

![system.ksec.com](http://i.imgur.com/69vmnPx.png)

* Config wordpress system.ksec.com

![config wordpress system.ksec.com](http://i.imgur.com/AlO92eK.png)

* web1.ksec.com

![web1.ksec.com](http://i.imgur.com/cZuEADa.png)

* web2.ksec.com

![web2.ksec.com](http://i.imgur.com/cXUJnJJ.png)

### Cấu hình DB server

```sh
	bind-address=10.10.10.8		//Database Server IP, Chỉnh sửa trong file cấu hình mysql
	Create database ksecsystem;	//tạo database system;
	GRANT ALL ON ksecsystem.* TO ksec@'10.10.10.6' IDENTIFIED BY 'ksec';	//cấp quyền remote database ksecsystem cho user ksec, ip 10.10.10.6 (ip webserver)
```	

* Sau khi đã cấu hình xong, thử truy cập

![remote database](http://i.imgur.com/uBQOjL9.png)

## Kết quả

![ket qua](http://i.imgur.com/8bOFBe0.png)