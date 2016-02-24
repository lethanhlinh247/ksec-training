http://www.tecmint.com/install-haproxy-load-balancer-in-linux/

https://www.digitalocean.com/community/tutorials/how-to-use-haproxy-to-set-up-http-load-balancing-on-an-ubuntu-vps
#HAProxy
HAProxy: High Availability proxy, là một phần mềm mã nguồn mở, được viết bằng ngôn ngữ C.

HAProxy là một phần mềm cân bẳng tải trên nền TCP/HTTP.

HAProxy là giải pháp cân bằng tải cho các web server, database server và nhiều môi trường khác.

HAProxy được sử dụng phổ biến trên thế giới với các tổ chức lớn như Twitter, Reddit, Github, Amazon.

HAProxy thích hợp trên các nền tảng Linux, BSD, Solaris, AIX.

![](http://www.tecmint.com/wp-content/uploads/2015/02/Install-HAProxy-in-Linux-620x293.jpg)

## Cài đặt HAProxy
```sh
#yum install haproxy 			[On RedHat based Systems]
# apt-get install haproxy		[On Debian based Systems]
```

## Cấu hình HAProxy
* Đường dẫn file cấu hình: 
```sh
# vim /etc/haproxy/haproxy.cfg
```
* Nội dung file cấu hình: 
```sh
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3

defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http
backend web_backend 10.10.10.100:80
	mode http
	balance roundrobin
	server web1 10.10.10.6:80 check
	server web2 10.10.10.10:80 check
	stats enable
	stats uri /haproxy?stats
	stats realm Strictly\ Private
	stats auth adk:votinhkhoc
frontend web_frontend 10.10.10.100:80
#	bind 10.10.10.100:80
	default_backend web_backend
```

## Hướng dẫn cấu hình
### Phần Global
```sh
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3
```
* `log`: Cấu hình log của HAProxy
* `chroot`: Phân quyền cho thư mục haproxy
* `stats socket`:
* `stats timeout`: 
* `	user haproxy
	group haproxy`
Tên user và group  của haproxy. không nên thay đổi.
* `daemon`: 
* Những dòng còn lại liên quan đến phần cấu hình SSL.

### Phần Default
```sh
defaults
	log	global
	mode	http
	option	httplog
	option	dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
	errorfile 400 /etc/haproxy/errors/400.http
	errorfile 403 /etc/haproxy/errors/403.http
	errorfile 408 /etc/haproxy/errors/408.http
	errorfile 500 /etc/haproxy/errors/500.http
	errorfile 502 /etc/haproxy/errors/502.http
	errorfile 503 /etc/haproxy/errors/503.http
	errorfile 504 /etc/haproxy/errors/504.http
```
* `log global`: phần log cấu hình ở trên phần global.
* `mode http`: kiểu http.
* `timeout connect 5000`: thời gian tối đa để kết nối đến server.
* `timeout client
	timeout server`: The client and server timeouts apply when the client or server is expected to acknowledge or send data during the TCP process. 
* `errorfile`: Đường dẫn các file thông báo lỗi.

###Cấu hình backend
```sh
backend web_backend 10.10.10.100:80
	mode http							
	balance roundrobin
	server web1 10.10.10.6:80 check
	server web2 10.10.10.10:80 check
	stats enable
	stats uri /haproxy?stats
	stats realm Strictly\ Private
	stats auth adk:votinhkhoc
```
* `backend web_backend 10.10.10.100:80`: tên backend: web_backend, địa chỉ ip haproxy server.
* `mode http`: kiểu http.
* `balance`: thuật toán.
* `	server web1 10.10.10.6:80 check
	server web2 10.10.10.10:80 check`: Có 2 server backend là web1, web2 với địa chỉ ip tương ứng. Tùy chọn `check` dùng để kiểm tra kết nối đến các server đó. 
* `stats enable`: Bật xem thống kê trên web.
* `stats uri /haproxy?stats`: đường dẫn xem thống kê.
* `stats realm Strictly\ Private`: 
* `stats auth adk:votinhkhoc`: tên đăng nhập và mật khẩu để xem thống kê.

###Cấu hình frontend
```sh
frontend web_frontend 10.10.10.100:80
	default_backend web_backend
```
* `frontend web_frontend 10.10.10.100:80`: địa chỉ ip haproxy server (lắng nghe trên địa chỉ này)
* `default_backend web_backend`: sau khi tiếp nhận request thì sẽ chuyển sang backend (web_backed) để xử lý.