#<center>Lê Thanh Lĩnh - KSEC Club - KMA</center>

#Tuần 1: 
- Học cách sử dụng github
- Tìm hiểu mô hình OSI và TCP/IP
- Một số giao thức lớp Ứng dụng trong mô hình TCP/IP

https://github.com/hocchudong/git-github-for-sysadmin

http://4share.vn/f/2d1f14191d1e1415

http://4share.vn/f/794b404d494d4949

#Tuần 2:
- Tìm hiểu các sử dụng VMWare WorkStation
- Các chế độ card mạng trong VMWare WorkStation
- Cài đặt Ubuntu Server 14.04 hoặc 15.04
- Tìm hiểu cách sử dụng trình soạn thảo vi
- Một số lệnh cấu hình network trên ubuntu
- Phân tích gói tin IP datagram

#Tuần 3:
- Hoàn thành công việc chưa hoàn thành tuần 2
- Tạo sửa xóa user , group
- Linux : Phân quyền file , user
- Các câu lệnh tạo sửa xóa file , folder
- Phân tích gói tin TCP
- Các câu lệnh về network: netstat, traceroute, ....

#Tuần 4:
- Tìm hiểu cách cài đặt phần mềm trên các distro khác nhau
- Sự khác nhau giữa update, upgrade , dist-upgrade
- Tìm hiểu và cài đặt apache làm webserver
- Thiết lập 2 card mạng trong ubuntu
- Học lập trình bash

#Tuần 5:
- Đi sâu tìm hiểu file cấu hình apache .
- Nguyên tắc xử lý của web-server 
- Tim hiểu một số modual cơ bản 
	- Tìm hiểu name-base , ip-base 
	- Virtual Host 
	- Optimal. 

++++=====<TuManh>======+++

#Tuần 6:
- Nghiên cứu dịch vụ DNS
- Triển khai DNS sử dụng BIND
- Triển khai 2 DNS ( Master - Slave)
- Phân Giải demo cho 1 máy webserver 
- Yêu cầu triển khai xong quay màn hình video báo cáo LAB 
- Lý thuyết vẫn Báo cáo .md bình thường 

======++++++Tử Mạnh++++======

#Tuần 7-8
- Cài Đặt MySQL + PHP
- Học một số câu lệnh đơn giản MySQL: tạo database, bảng cột, select, set quyền user 
- Dựng website chạy wordpress hoặc joomla
- Tìm hiểu wordpress và joomla khác nhau như thế nào

#Tuần 9-10
- Viết script cài đặt wordpress trên ubuntu server 
- Tìm hiểu giao thức SSH.. 
- cấu hình SSH trên ubuntu server/ thực hiện ssh từ bên ngoài
- Tìm hiểu giao thức FTP / SFTP
- Cấu hình FTP cho ubuntu server , ftp site, phân quyền người dùng...

#Tuần 11-12
1. Thiết lập một hệ thống các mấy chủ Hosting với:
- 01 Máy chủ Linux chạy BIND làm DNS server
- 01 Máy chủ Linux chạy HTTP và apache làm Hosting server cho phép chạy ngôn ngữ lập trình PHP có kết nối đến Database MySQL làm Web Hosting server  
- 01 Máy chủ Linux chạy MySQL làm Database server 
trong đó:
1. Tên miền chính của máy chủ là ksec.com
2. Tạo các server với domain:
- ns.ksec.com : trỏ đến DNS/BIND server
- www.ksec.com: trỏ đến Web Hosting server
- db.ksec.com: trỏ đến Database server 
 
3. Tạo một domain và hosting riêng  tương ứng với tên miền: 
system.ksec.com với Document root là một thư mục nằm ngoài Document root của HTTP và apache

#Tuần 13-14
- Tìm hiểu khái niệm cân bằng tải
- Các thuật ngữ.
- Các thuật toán
- use case
- Các phần mềm triển khai
- Triển khai cân bằng tải cho 2 web server wordpress dùng chung 1 DB
- Y/c: Vẽ mô hình triển khai bằng Visio (các địa chỉ IP, card mạng)
- Viết báo cáo các bước triển khai. Kết quả thu được 
- Test khả năng sẵn sàng, hiệu năng.. (các công cụ ab, jmeter)
- Viết script tối ưu nhất

#Tuần 15:
- Tìm hiểu Nginx.. (các tính năng, ...)
- Cài đặt nginx từ repo các version, build từ source
- Tìm hiểu các module có thể build cùng
- Cài đặt wordpress trên nginx + php5-fpm + mysql

#Tuần 16:
Virtualization
- Tìm hiểu các loại ảo hóa (làm rõ)
- Tìm hiểu ảo hóa sử dụng KVM
- Dựng lab KVM 
- Cài ubuntu trên KVM
- Dựng webvirt


