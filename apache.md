#Apache
Apache là một phần mềm Webserver mã nguồn mở, rất phổ biến trên thế giới hiện nay.
##1. Cài đặt Apache
```sh
apt-get install apache2
```
hoặc, có thể vào trang chủ (http://apache.org) ,  tải file cài đặt apache và tiến hành cài đặt.
* Chạy apache2.
```sh
/etc/init.d/apache2 start
service apache2 start
```
* Dừng apache
```sh
/etc/init.d/apache2 stop
service apache2 stop
```
* Khởi động lại apache
```sh
sudo /etc/init.d/apache2 restart
service apache2 restart
```
* Không muốn Apache tự khởi động cùng hệ thống:
```sh
update-rc.d -f apache2 remove
```
* Khởi động apache cùng hệ thống:
```sh
update-rc.d apache2 defaults
```
* Bật module
```sh
a2enmod ten_module
```
* Tắt module
```sh
a2dismod ten_module
```

##2. Cấu hình apache
Các file cấu hình của apache được đặt tại /etc/apache2

* /var/www/html : Thư mục mặc định chứa website

* apache2.conf: File cấu hình mặc định của Apache2
* mods-enabled: Thư mục chứa các module đang hoạt động của Apache module.
* mods-available: Thư mục chứa các file cấu hình module.
* conf-available: Chứa các file cấu hình khác.
* conf-enabled: chứa các file cấu hình khác đang hoạt động.
* sites-enabled: Thư mục chứa các cài đặt định danh cho các website (Virtual Host)
* ports.conf: chứa thông tin về cổng mà apache2 sẽ lắng nghe.
* envars: chứa các biến môi trường.



###2.1 Không hiển thị phiên bản apache.

Mở file */etc/apache2/conf-enabled/security.conf*:

	* **ServerTokens Prod:** Hiển thị "Server: Apache"
    * **ServerTokens Major:** Hiển thị "Server: Apache/2
    * **ServerTokens Minor:** Hiển thị "Server: Apache / 2.2″
    * **ServerTokens Min:** Hiển thị "Server: Apache/2.2.17″
    * **ServerTokens OS:** Hiển thị "Server: Apache/2.2.17 (Unix)”
    * **ServerTokens Full:** Hiển thị "Server: Apache/2.2.17 (Unix) PHP/5.3.5″ (Nếu bạn không chỉ định bất kỳ giá trị ServerTokens, đây là mặc định)

###2.2 Thêm các định dạng file index. (add file name that it can access only with directory's name)

Chỉnh sửa file **/etc/apache2/mods-enabled/dir.conf**
```sh
DirectoryIndex index.html index.htm
```
###2.3 Thay đổi email người quản lý trang web.

Chỉnh sửa file **/etc/apache2/sites-enabled/000-default.conf**
```sh
ServerAdmin webmaster@server.world
```
###2.4 Cấu hình file apache2.conf

* **#ServerRoot "/etc/apache2":** Cấu hình thư mục lưu trữ chính của Apache.
* **PidFile ${APACHE_PID_FILE}:** Chỉ đường dẫn đến file httpd.pid, là file lưu trữ process ID của Apache mỗi khi khởi chạy. 
* **Timeout 300:** Thời gian timeout cho hệ thống.
* **KeepAlive On:**  Là một hình thức có thể giúp tăng tốc độ tải trang khi không mở kết nối cho từng request một.
* **MaxKeepAliveRequests 100:** Số requests tối đa.
* **KeepAliveTimeout 5:**  Khoảng thời gian timeout để đợi request tiếp theo từ cùng 1 người dùng trên cùng 1 kết nối.
* **ErrorLog ${APACHE_LOG_DIR}/error.log:** Đường dẫn file log.
* **Include ports.conf:** Cấu hình các cổng lắng nghe, ờ file ports.conf


##3. Enabling module userdir.
* Module này có tác dụng là tạo mỗi thư mục web cho mỗi người sử dụng. 
* Bật module
```sh
a2enmod userdir 
```
* Sửa dòng lệnh php_admin_flag thành comment trong file /etc/apache2/mods-enabled/php5.conf 
```sh
#php_admin_flag engine Off 
```
* Khởi động lại dịch vụ apache2.
* Tạo thư mục public_html ở trong một user bất kỳ.
* Truy cập với địa chỉ ip/~user

##4. Configure virtual hostings. 
* Virtual Host là tính năng của Apache giúp ta duy trì nhiều hơn một web server trên một máy tính. 
* Tạo một file cấu hình Virtual Host mới, đặt tên là domain.com.conf
```sh
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/lethanhlinh.com.conf
```
* Chỉnh sửa file Virtual Host.
```sh
<VirtualHost *:80>
    ServerAdmin admin@lethanhlinh.com
    ServerName lethanhlinh.com
    ServerAlias www.test.com
    DocumentRoot /home/adk/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
* Bật cấu hình site domain.com và khởi động lại dịch vụ apache2.
```sh
sudo a2ensite lethanhlinh.conf
service apache2 restart
```
##5. Configure SSL.
##6. Enable Basic Authentication.
##7. Limit accesses on specific web pages and use OS users for authentication with SSL connection. 

