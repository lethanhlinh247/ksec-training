#NGINX

* Nginx là một HTTP web server và cũng có thể được dùng như “reverse proxy” hay “mail proxy server”.

* Nginx là một web server mã nguồn mở, sử dụng cơ cấu Epoll của linux để phục vụ người dùng, trái ngược với cơ cấu phân luồng threads của Apache.

* Nginx bắt đầu được sử dụng thay thế cho Apache rất nhiều do tốc độ nó mang lại; đang chiếm 13% thị phần web server và tăng trưởng không ngừng.

* Nginx có các tính năng như chứng thực người dùng, hỗ trợ HTTPS, virtual hosting, hỗ trợ FastGCI, hỗ trợ Ipv6…

![](http://oktot.com/Document/Images/Blog/2016/2/web/image004.jpg)

* Nginx là 1 trong số ít những máy chủ được viết để giải quyết vấn đề C10K.

Các máy chủ web truyền thống xử lý các yêu cầu dựa trên luồn (thread), tức là mỗi khi máy chủ web nhận được 1 yêu cầu mới, nó sẽ tạo ra 1 luồn xử lý mới để xử lý cho yêu cầu này, và cứ thế khi số lượng các yêu cầu gửi đến máy chủ web ngày càng nhiều thì số lượng các luồn xử lý này trong máy chủ sẽ ngày càng tăng.

Và điều này dẫn đến việc thiếu hụt tài nguyên cấp cho các luồn xử lý trên.

Không giống với các máy chủ web truyền thống,  Nginx không dựa trên luồn (thread) để xử lý yêu cầu.

Thay vào đó, nó sử dụng 1 kiến trúc bất đồng bộ hướng sự kiện linh hoạt . Kiến trúc này sử dụng ít, nhưng quan trọng hợn, là lượng bộ nhớ có thể dự đoán khi hoạt động.

##2. Cài đặt nginx

###2.1 Cài đặt từ repo

```sh
apt-get install nginx
```

###2.2 Cài đặt từ source
####2.2.1  CÀI ĐẶT THƯ VIỆN

* Cài đặt GCC | - GNU Compiler
```sh
apt-get install build-essential
```

* Cài đặt thư viện PCRE
```sh
apt-get install -y pcre pcre-devel
```

* Cài đặt thư viện zlib
```sh
apt-get install -y zlib zlib-devel
```

* Cài đặt OpenSSL
```sh
apt-get install -y openssl openssl-devel
```

* Cài đặt các thư viện khác
```sh
apt-get install -y libxml2 libxml2-devel libxslt libxslt-devel gd gd-devel perl-ExtUtils-Embed geoip geoip-devel
```

####2.2.2 CẤU HÌNH CÀI ĐẶT NGINX

* Các phiên bản của Nginx được chia làm 3 nhánh sau:

	* **Stable version:** là phiên bản ổn định nhất cho việc sử dụng trong thực tế, đa số các lỗi đã được phát hiện và xử lý đối với phiên bản này. Đây là phiên bản được đề nghị sử dụng. Phiên bản ổn định mới nhất là 1.4.7.
	* **Development version:** là phiên bản mới nhất cho phép download của Nginx, có thể sử dụng thực tế, tuy nhiên vẫn còn nhiều lỗi phát sinh chưa được xử lý. Đây là phiên bản dành cho các nhà phát triển dùng để kiểm tra các chức năng mới nhất của Nginx. Phiên bản phát triển mới nhất là 1.5.12.
	* **Legacy version:** Các phiên bản cũ của Nginx.

* Download Nginx
```sh
# wget http://nginx.org/download/nginx-1.8.1.tar.gz
# tar -xzvf nginx-1.8.1.tar.gz
# cd nginx-1.8.1
```

#### 2.2.3 CÁC TÙY CHỌN CẤU HÌNH
##### 2.2.3.1 TÙY CHỌN VỀ ĐƯỜNG DẪN:

|Tùy chọn|Ý nghĩa|Giá trị mặc định|
|--------|-------|-----------------|
| -prefix=... |thư mục nơi Nginx được cài đặt | /usr/local/nginx
| -sbin-path=... |Đường dẫn nơi các tập tin nhị phân của Nginx sẽ được cài đặt | <prefix>/sbin/nginx
| -conf-path=... |Đường dẫn tập tin cấu hình chính của Nginx | <prefix>/conf/nginx.conf
| -error-log-path=... |Vị trí lưu error log | <prefix>/logs/error.log
| -pid-path=... |Đường dẫn tập tin pid của Nginx | <prefix>/logs/nginx.pid
| -lock-path=... |Đường dẫn tập tin lock của Nginx | <prefix>/logs/nginx.lock
| -with-perl_modules_path=... |Định nghĩa đường dẫn của module Perl | 
| -with-perl=... |Đường dẫn đến tập tin nhị phân của Perl được dùng để thực thi các script Perl | 
| -http-log-path=... |Định nghĩa vị trị của access log | <prefix>/logs/access.log
| -http-client-body-temp-path=... |Thư mục được dùng để lưu trữ các tập tin tạm thời phát sinh bởi các yêu cầu người dùng | <prefix>/client_body_temp
| -http-proxy-temp-path=... |Vị trí các tập tin tạm được dùng bởi proxy | <prefix>/proxy_temp
| -http-fastcgi-temp-path=... |Vị trí các tập tin tạm được dùng bởi module HTTP FastCGI | <prefix>/fastcgi_temp
| -http-uwsgi-temp-path=... | Vị trí các tập tin tạm được dùng bởi module HTTP wWSGI | <prefix>/uwsgi_temp
| -http-scgi-temp-path=... | Vị trí các tập tin tạm được dùng bởi module HTTP SCI | <prefix>/scgi_temp
| -builddir=... |Vị trí để build ứng dụng | 

##### 2.2.3.2 TÙY CHỌN VỀ CHỨC NĂNG:
* Các module mặc định được enabled (Các tùy chọn biên dịch bên dưới cho phép chúng ta vô hiệu hóa các module này).

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -without-http_charset_module | Tắt chức năng Charset cho việc tái mã hóa trang web.
| -without-http_gzip_module | Tắt chức năng nén Gzip.
| -without-http_ssi_module | Tắt chức năng Server Side Include.
| -without-http_userid_module | Tắt chức năng User ID cung cấp việc chứng thực người dùng qua Cookies.
| -without-http_access_module | Disable module Access cho phép cấu hình truy cập cho các dãy địa chỉ IP.
| -without-http_auth_basic_module | Tắt chức năng chứng thực cơ bản.
| -without-http_autoindex_module | Tắt chức năng đánh chỉ mục tự động.
| -without-http_geo_module | Tắt chức năng Geo cho phép định nghĩa các biến dựa trên các dãy địa chỉ IP.
| -without-http_map_module | Tắt chức năng Map cho phép khai báo các khối ánh xạ.
| -without-http_referer_module | Tắt chức năng điều khiển Referer.
| -without-http_rewrite_module | Tắt chức năng Rewrite.
| -without-http_proxy_module | Tắt chức năng Proxy cho việc vận chuyển các yêu cầu đến các máy chủ khác.
| -without-http_fastcgi_module | Tắt chức năng FastCGI cho việc tương tác với các tiến trình FastCGI.
| -without-http_uwsgi_module |  Tắt chức năng uWSGI cho việc tương tác với các tiến trình uWSGI.
| -without-http_scgi_module |  Tắt chức năng SCGI cho việc tương tác với các tiến trình SCGI.
| -without-http_memcached_module | Tắt chức năng Memcached cho việc tương tác với dịch vụ memcached.
| -without-http_limit_conn_module | Tắt module giới hạn kết nối để chỉ định việc sử dụng tài nguyên theo những vùng được định nghĩa.
| -without-http_limit_req_module | Tắt chức năng giới hạn truy cập cho phép giới hạn số lượng truy cập trên mỗi người dùng.
| -without-http_empty_gif_module | Tắt chức năng Empty GIF cho việc phục vụ 1 hình ảnh GIF trống từ bộ nhớ.
| -without-http_browser_module | Tắt chức năng Browser cho việc thông dịch chuỗi User Agent.
| -without-http_upstream_ip_hash_module | Tắt chức năng Upstream cho việc cấu hình kiến trúc cân bằng tải.
| -without-http_upstream_least_conn_module | Tắt chức năng nhận diện kết nối ít nhất trên các Upstream.

* Các module mặc định được disabled (Các tùy chọn biên dịch bên dưới cho phép chúng ta làm cho các module này có hiệu lực).

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -with-http_ssl_module | Bật chức năng SLL cho việc phục vụ các trang web sử dụng HTTPS.
| -with-http_realip_module | Bật chức năng Real IP cho việc đọc địa chỉ IP thật từ dữ liệu header của truy cập web.
| -with-http_addition_module | Bật chức năng Addition cho phép thêm dữ liệu vào nội dung phản hồi.
| -with-http_xslt_module | Bật chức năng XSLT cho việc áp dụng biến đổi XSL thành các tài liệu XML (cần cài đặt các thư viện libxml2 và libxslt).
| -with-http_image_filter_module | Bật chức năng lọc hình ảnh cho phép áp dụng các tùy chỉnh lên hình ảnh (cần cài thư viện libgd)
| -with-http_geoip_module | Bật chức năng GeoIP cho việc lấy vị trí địa lý sử dụng cơ sở dữ liệu nhị phân GeoIP của MaxMind (cần cài đặt thư viện libgeoip)
| -with-http_sub_module | Bật chức năng  Substitution cho việc thay thế văn bản trong các trang web.
| -with-http_dav_module | Bật chức năng WebDAV (Distributed Authoring and Versioning via Web).
| -with-http_flv_module | Bật chức năng xử lý các tập tin .FLV.
| -with-http_mp4_module | Bật chức năng xử lý các tập tin MP4.
| -with-http_gzip_static_module | Bật chức năng Gzip Static để gửi các tập tin được nén trước.
| -with-http_random_index_module | Bật chức năng đánh chỉ mục ngẫu nhiên cho việc chọn 1 tập tin ngẫu nhiên như 1 chỉ mục thư mục.
| -with-http_secure_link_module | Bật chức năng Secure Link để kiểm tra sự có mặt của 1 từ khóa trong URL.
| -with-http_stub_status_module | Bật chức năng Stub Status mà khởi tạo 1 trang thông tin và thống kê máy chủ.
| -with-google_perftools_module | Bật chức năng Google Performance Tools.
| -with-http_degradation_module | Bật chức năng Degradation điều khiển hành vi của máy chủ dựa trên việc sử dụng tài nguyên hiện tại.
| -with-http_perl_module | Bật chức năng Perl cho phép chèn mã Perl trực tiếp vào tập tin cấu hình Nginx và để tạo các lời gọi Perl từ SSI.

##### 2.2.3.3 CÁC TÙY CHỌN KHÁC

* Mail server proxy

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -with-mail | Bật chức năng mail server proxy. Hỗ trợ POP3, IMAP4, SMTP. Mặc định tính năng này được tắt.
| -with-mail_ssl_module | Bật chức năng hỗ trợ SSL cho mail server proxy. Mặc định tính năng này được tắt.
| -without-mail_pop3_module | Tắt chức năng POP3 cho mail server proxy. Chức năng này được bật mặc định khi chức năng mail server proxy được bật.
| -without-mail_imap_module | Tắt chức năng IMAP4 cho mail server proxy. Chức năng này được bật mặc định khi chức năng mail server proxy được bật.
| -without-mail_smtp_module |  Tắt chức năng SMTP cho mail server proxy. Chức năng này được bật mặc định khi chức năng mail server proxy được bật.

* Quản lý sự kiện

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -with-rtsig_module | Bật chức năng rtsig để sử dụng rtsig như là cơ chế thông báo sự kiện.
| -with-select_module | Bật chức năng select để sử dụng select như là cơ chế thông báo sự kiện. Mặc định thì chức năng này được bật trừ khi 1 phương thức tốt hơn được tìm thấy trên hệ thống | -	kqueue, epoll, rtsig hoặc poll.
| -without-select_module | Tắt chức năng select.
| -with-poll_module |  Bật chức năng poll để sử dụng poll như là cơ chế thông báo sự kiện. Mặc định thì chức năng này được bật trừ khi 1 phương thức tốt hơn được tìm thấy trên hệ thống | -	kqueue, epoll, rtsig.
| -without-poll_module | Tắt chức năng poll.

* User và Group

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -user=... |Tài khoản người dùng mặc định cho việc bắt đầu các tiến trình worker của Nginx.
| -group=... |Nhóm người dùng mặc định cho việc bắt đầu các tiến trình worker của Nginx.

* Các tùy chọn khác

|Tùy chọn|Ý nghĩa|
|--------|-------|
| -with-ipv6 | Hỗ trợ IPv6.
| -without-http | Tắt chức năng máy chủ HTTP.
| -without-http-cache | Tắt chức năng HTTP caching.
| -add-module=PATH | Thêm 1 thành phần của hãng thứ 3 vào tiến trình cấu hình bằng việc chỉ rõ đường dẫn của nó.
| -with-debug | Thông tin debug sẽ được ghi nhận lại trong nhật ký.
| -with-file-aio | Hỗ trợ các hoạt động IO (đọc | -	ghi) bất đồng bộ trên đĩa cứng.

####2.2.3 CÀI ĐẶT NGINX 
* Tiến hành cấu hình cài đặt nginx với các tùy chọn ở trên.
* Ví dụ: 
```sh
# ./configure 
--user=nginx 
--group=nginx 
--conf-path=/etc/nginx/nginx.conf 
--pid-path=/var/run/nginx/nginx.pid 
--lock-path=/var/lock/subsys/nginx 
--with-http_ssl_module 
--with-http_realip_module 
--with-http_addition_module 
--with-http_xslt_module 
--with-http_image_filter_module 
--with-http_geoip_module 
--with-http_sub_module 
--with-http_dav_module 
--with-http_flv_module 
--with-http_mp4_module 
--with-http_gzip_static_module 
--with-http_random_index_module 
--with-http_secure_link_module 
--with-http_stub_status_module 
--with-http_perl_module 
--with-http_degradation_module
```

* Biên dịch và cài đặt Nginx
```sh
# make
# make install
# export PATH=$PATH:/usr/local/nginx/sbin
```

* Cấu hình Nginx như là 1 dịch vụ của hệ thống

	* Tạo file  /etc/init.d/nginx để nginx tự động chạy khi hệ thống khởi động. 
	```sh
	# vi /etc/init.d/nginx
	```
	
	* Nội dung file
	```sh
	#!/bin/sh
	#
	# nginx - this script starts and stops the nginx daemon
	#
	# chkconfig:   - 85 15 
	# description:  Nginx is an HTTP(S) server, HTTP(S) reverse \
	#               proxy and IMAP/POP3 proxy server
	# processname: nginx
	# config:      /etc/nginx/nginx.conf
	# config:      /etc/sysconfig/nginx
	# pidfile:     /var/run/nginx.pid

	# Source function library.
	. /etc/rc.d/init.d/functions

	# Source networking configuration.
	. /etc/sysconfig/network

	# Check that networking is up.
	[ "$NETWORKING" = "no" ] && exit 0

	nginx="/usr/local/nginx/sbin/nginx"
	prog=$(basename $nginx)

	NGINX_CONF_FILE="/etc/nginx/nginx.conf"

	[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx

	lockfile=/var/lock/subsys/nginx

	make_dirs() {
	   # make required directories
	   user=`$nginx -V 2>&1 | grep "configure arguments:" | sed 's/[^*]*--user=\([^ ]*\).*/\1/g' -`
	   if [ -z "`grep $user /etc/passwd`" ]; then
		   useradd -M -s /bin/nologin $user
	   fi
	   options=`$nginx -V 2>&1 | grep 'configure arguments:'`
	   for opt in $options; do
		   if [ `echo $opt | grep '.*-temp-path'` ]; then
			   value=`echo $opt | cut -d "=" -f 2`
			   if [ ! -d "$value" ]; then
				   # echo "creating" $value
				   mkdir -p $value && chown -R $user $value
			   fi
		   fi
	   done
	}

	start() {
		[ -x $nginx ] || exit 5
		[ -f $NGINX_CONF_FILE ] || exit 6
		make_dirs
		echo -n $"Starting $prog: "
		daemon $nginx -c $NGINX_CONF_FILE
		retval=$?
		echo
		[ $retval -eq 0 ] && touch $lockfile
		return $retval
	}

	stop() {
		echo -n $"Stopping $prog: "
		killproc $prog -QUIT
		retval=$?
		echo
		[ $retval -eq 0 ] && rm -f $lockfile
		return $retval
	}

	restart() {
		configtest || return $?
		stop
		sleep 1
		start
	}

	reload() {
		configtest || return $?
		echo -n $"Reloading $prog: "
		killproc $nginx -HUP
		RETVAL=$?
		echo
	}

	force_reload() {
		restart
	}

	configtest() {
	  $nginx -t -c $NGINX_CONF_FILE
	}

	rh_status() {
		status $prog
	}

	rh_status_q() {
		rh_status >/dev/null 2>&1
	}

	case "$1" in
		start)
			rh_status_q && exit 0
			$1
			;;
		stop)
			rh_status_q || exit 0
			$1
			;;
		restart|configtest)
			$1
			;;
		reload)
			rh_status_q || exit 7
			$1
			;;
		force-reload)
			force_reload
			;;
		status)
			rh_status
			;;
		condrestart|try-restart)
			rh_status_q || exit 0
				;;
		*)
			echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
			exit 2
	esac
	```

	* set quyền execute cho file.
	```sh
	# chmod +x /etc/init.d/nginx
	```
	
	* Cấu hình lại service để chạy nginx khi khởi động OS:
	```sh
	chkconfig --add nginx
	chkconfig --level 345 nginx on
	```
* Chạy nginx
```sh
# /etc/init.d/nginx start
```

##3. Các module trong nginx

nginx có rất nhiều modules cho phép bổ sung thêm nhiều tính năng cho web server.
Một số mmodules nổi tiếng của bên thứ 3 là:

* **[SPDY](https://en.wikipedia.org/wiki/SPDY)**:  đã được đóng gói kèm theo nginx từ phiên bản 1.5.0.
* **[google pagespeed(source)](http://ngxpagespeed.com/ngx_pagespeed_example/)**: tăng tốc website của bạn và giảm thời gian tải trang tự động bằng cách áp dụng các kỹ thuật cải thiện hiệu năng web và các tài nguyên đi kèm (CSS, Javascript, hình ảnh) mà không cần bạn phải thay đổi code, nội dung trang web.
* **[ModSecurity](http://www.modsecurity.org/projects/modsecurity/nginx/index.html)**: là một ứng dụng tường lửa mã nguồn mở cho web, giúp giảm được các nguy cơ tấn công phổ biến lên servers.
* **[TCP Proxy](https://github.com/yaoweibin/nginx_tcp_proxy_module)** cho phép nginx chạy proxy thông qua tcp server thay vì mặc định là kiểu socket.

* Các module khác bạn có thể tìm thấy ở trang
https://www.nginx.com/resources/wiki/modules/#
