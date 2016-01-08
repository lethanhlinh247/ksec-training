#DNS SERVER - BIND
BIND (Berkeley Internet Name Domain) là phần mềm miễn phí, nguồn mở sử dụng cho các máy chủ linux làm DNS Server.
#1. Cài Đặt
* Để cài đặt, ta sử dụng lệnh
```sh
apt-get install bind9
```
* Thư mục cấu hình của bind9: **/etc/bind**
* Các file trong thư mục */etc/bind*
	* bind.keys:
	* Các file cơ sở dữ liệu DNS mặc định: db.0; db.127; db. 255; db.empty; db.local; db.root
	* named.conf: là file cấu hình chính của bind. File này include các file cấu hình khác.
	* named.conf.default-zones: file cấu hình các zones mặc định.
	* named.conf.local: file mà chúng ta dùng để cấu hình zones.
	* named.conf.options: file chứa các tùy chọn của bind9.
		* directory "/var/cache/bind";
		* forwarders {
              0.0.0.0;
         };
		*  dnssec-validation auto;
        * auth-nxdomain no;    # conform to RFC1035
        * listen-on-v6 { any; };
        * allow-query {
                any;
		 };
        * allow-transfer {
                10.10.10.5;
         };
        * allow-update {
                10.10.10.5;
		 };

	* rndc.key:
	* zones.rfc1918
	
#2. Cấu hình Primary DNS Server
##2.1 Cấu hình tập tập named.conf.options

* Khai báo các địa chỉ IP sẽ tiếp nhận các yêu cầu.
```sh
listen-on port 53 { 127.0.0.1; 10.30.1.10; };
```
* Khai báo vị trí chứa các tập tin cấu hình zone.
```sh
directory       “/var/named”;
```
* Giới hạn các Client được được phép truy vấn DNS.
```sh
allow-query     { localhost; 10.30.1.0/24; };
```
* Sử dụng DNS đệ qui
```sh
recursion yes;
```
* Các Slave DNS có thể nhận tập tin cấu hình zone từ Primary DNS.
```sh
allow-transfer     { 10.30.1.11; };
```
##2.2. Cấu hình tập tin named.conf.local.

* Khai báo zone phân giải thuận cho miền ksec.com
```sh
zone “ksec.com” IN {
	type master;	//Trên Primary kiểu zone sẽ là master.
	file “db.ksec.com”;	//Tên tập tin cấu hình cho zone ksec.com.
	allow-update { none; };	//Tắt chức năng Dynamic update trong zone.
};
```
* Khai báo zone phân giải nghịch cho network 10.30.10.0
```sh
zone “10.10.10.in-addr.arpa” IN {
	type master;//Trên Primary kiểu zone sẽ là master.
	file “db.ksec.com.nghich”;	//Tên tập tin cấu hình cho zone 10.10.10.in-addr.arpa.
	allow-update { none; };	//Tắt chức năng Dynamic update trong zone.
};
```

##2.3. Tập tin cấu hình zone.

* Lần lượt tạo 2 tập tin db.ksec.com và db.ksec.com.nghich trong thư mục /etc/bind với nội dụng tương ứng với từng zone như sau:
	* file db.ksec.com
	```sh
	$TTL 1D
	@                   IN SOA  ns.ksec.com. root.ksec.com. (

	0       ; serial
	1D     ; refresh
	1H     ; retry
	1W    ; expire
	3H )   ; minimum

	ksec.com.	IN NS              ns.ksec.com.
	ksec.com	IN A                10.10.10.4
	ns			IN A                 10.10.10.2
	```
	* file db.ksec.com.nghich
	```sh
	$TTL 1D
	@                   IN SOA ns.ksec.com. root.ksec.com. (

	0       ; serial
	1D     ; refresh
	1H     ; retry
	1W    ; expire
	3H )   ; minimum

	ksec.com. IN NS            ns.ksec.com.
	2			IN PTR          ns.ksec.com.
	4			IN	PTR			ksec.com.
	```

#3. Cấu hình Slave DNS Server
##3.1 Cấu hình server Slave
###3.1.1 Cấu hình tập tập named.conf.options
* Khai báo các địa chỉ IP của Slave DNS Server sẽ nhận các yêu cầu truy vấn DNS.
```sh
listen-on port 53 { 127.0.0.1; 10.30.1.11; };
```
* Khai báo vị trí chứa các tập tin cấu hình zone.
```sh
directory       “/var/named”;
```
* Giới hạn các Client được truy vấn DNS.
```sh
allow-query     { localhost; 10.30.1.0/24; };
```
* Sử dụng DNS đệ qui.
```sh
recursion yes;
```
###3.1.2 Cấu hình tập tin named.conf.local.
* Khai báo zone phân giải thuận tên ksec.com
```sh
zone “ksec.com” IN {
	type slave;	//Trên Slave DNS Server kiểu zone sẽ là slave.
	file “db.ksec.com”;	//Tên vị trí lưu tập tin cấu hình zone sao chép từ Primary DNS Server.
	masters { 10.10.10.2; };	//Chỉ định Primary DNS Server để sao chép dữ liệu zone.
};
```
* Khai báo zone phân giải nghịch cho network 10.10.10.0

```sh
zone “10.10.10.in-addr.arpa” IN {
	type slave;	//Trên Slave DNS Server kiểu zone sẽ là slave.
	file “db.ksec.com.nghich”;	//Tên và vị trí lưu tập tin cấu hình zone sao chép từ Primary DNS Server.
	masters { 10.10.10.2; };	//Chỉ định Primary DNS Server để sao chép dữ liệu zone.

};
```
* khởi động lại dịch vụ DNS
```sh
service bind9 restart
```

##3.2 Cấu hình server Primary
###3.2.1 Cấu hình tập tập named.conf.options
* Các Slave DNS có thể nhận tập tin cấu hình zone từ Primary DNS.
```sh
allow-transfer     { 10.30.1.11; };
```
* khởi động lại dịch vụ DNS
```sh
service bind9 restart
```
Sau khi dịch vụ bind9 trên Slave DNS Server khởi chạy, Slave DNS Server sẽ tự động sao chép tập tin cấu hình zone từ Primary DNS Server về thư mục /etc/bind9

