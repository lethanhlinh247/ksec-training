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
```sh
sudo apt-get install build-essential libssl-dev libpcre3 libpcre3-dev \
libxml2-dev libxslt1-dev libgd2-xpm-dev libgeoip-dev libperl-dev
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
./configure \
--prefix=/usr/local/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
--http-log-path=/var/log/nginx/access.log \
--http-proxy-temp-path=/var/lib/nginx/proxy \
--http-scgi-temp-path=/var/lib/nginx/scgi \
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
--lock-path=/var/lock/nginx.lock \
--pid-path=/var/run/nginx.pid \
--with-pcre-jit \
--with-debug \
--with-http_addition_module \
--with-http_dav_module \
--with-http_geoip_module \
--with-http_gzip_static_module \
--with-http_image_filter_module \
--with-http_realip_module \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_sub_module \
--with-http_xslt_module \
--with-ipv6 \
--with-mail \
--with-mail_ssl_module \
--with-http_spdy_module
```

* Kết quả output ra terminal có thể trông như sau:
```sh
Configuration summary
  + using system PCRE library
  + using system OpenSSL library
  + md5: using OpenSSL library
  + sha1: using OpenSSL library
  + using system zlib library


  nginx path prefix: "/usr/local/nginx"
  nginx binary file: "/usr/local/nginx/sbin/nginx"
  nginx configuration prefix: "/etc/nginx"
  nginx configuration file: "/etc/nginx/nginx.conf"
  nginx pid file: "/var/run/nginx.pid"
  nginx error log file: "/var/log/nginx/error.log"
  nginx http access log file: "/var/log/nginx/access.log"
  nginx http client request body temporary files: "/var/lib/nginx/body"
  nginx http proxy temporary files: "/var/lib/nginx/proxy"
  nginx http fastcgi temporary files: "/var/lib/nginx/fastcgi"
  nginx http uwsgi temporary files: "/var/lib/nginx/uwsgi"
  nginx http scgi temporary files: "/var/lib/nginx/scgi"
```

* Tạo các thư mục tạm (temporary directories) phục vụ cho NginX
```sh
mkdir -p /var/lib/nginx/body
mkdir /var/lib/nginx/proxy
mkdir /var/lib/nginx/fastcgi
mkdir /var/lib/nginx/uwsgi
mkdir /var/lib/nginx/scgi
```


* Biên dịch và cài đặt Nginx
```sh
# make
# make install
```
####2.2.4 Cấu hình và khởi chạy NginX
* Tạo tài khoản nginx
```sh
adduser --system --home=/var/www/ \
--disabled-login \
--disabled-password \
--group nginx
```
* Cấu hình NginX bằng việc chỉnh sửa tập tin cấu hình chính như sau: `/etc/nginx/.conf`

	* Đổi user từ `nobody` thành `nginx`
	* Đường dẫn file error_log: `/var/log/error.log`
	* Đường dẫn file pid: `/var/run/nginx.pid`
	* Thêm đường dẫn chứa virtual host
		```sh
		include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
		```
	
	* thư mục chứ source code mặc định là `/usr/local/nginx/html`

* Tạo biến môi trường để bạn có thể gọi nginx mà không cần phải gõ đường dẫn đầy đủ:
```sh
sh -c "echo 'PATH=/usr/local/nginx/sbin:\$PATH' > /etc/profile.d/nginx.sh"
sh -c "echo 'export PATH' >> /etc/profile.d/nginx.sh"
ldconfig /usr/local/nginx/sbin/
```

*  Tạo thư mục lưu trữ các tập tin cấu hình virtual host
```sh
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
```


* Cấu hình Nginx như là 1 dịch vụ của hệ thống

	* Tạo file `nginx` trong thư mục `/etc/init.d/` để nginx tự động chạy khi hệ thống khởi động. 
	```sh
	# vi /etc/init.d/nginx
	```
	
	* Nội dung file
	```sh
	#!/bin/sh
	### BEGIN INIT INFO
	# Provides:          nginx
	# Required-Start:    $network $remote_fs $local_fs 
	# Required-Stop:     $network $remote_fs $local_fs
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	# Short-Description: Stop/start nginx
	### END INIT INFO

	# Author: Sergey Budnevitch <sb@nginx.com>

	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	DESC=nginx
	NAME=nginx
	CONFFILE=/etc/nginx/nginx.conf
	#DAEMON=/usr/sbin/nginx
	DAEMON=/usr/local/nginx/sbin/nginx
	DAEMON_ARGS="-c $CONFFILE"
	PIDFILE=/var/run/$NAME.pid
	SCRIPTNAME=/etc/init.d/$NAME

	[ -x $DAEMON ] || exit 0

	[ -r /etc/default/$NAME ] && . /etc/default/$NAME

	. /lib/init/vars.sh

	. /lib/lsb/init-functions

	do_start()
	{
		start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- \
			$DAEMON_ARGS
		RETVAL="$?"
		return "$RETVAL"
	}

	do_stop()
	{
		# Return
		#   0 if daemon has been stopped
		#   1 if daemon was already stopped
		#   2 if daemon could not be stopped
		#   other if a failure occurred
		start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --name $NAME
		RETVAL="$?"
		rm -f $PIDFILE
		return "$RETVAL"
	}

	do_reload() {
		#
		start-stop-daemon --stop --signal HUP --quiet --pidfile $PIDFILE --name $NAME
		RETVAL="$?"
		return "$RETVAL"
	}

	do_configtest() {
		if [ "$#" -ne 0 ]; then
			case "$1" in
				-q)
					FLAG=$1
					;;
				*)
					;;
			esac
			shift
		fi
		$DAEMON -t $FLAG -c $CONFFILE
		RETVAL="$?"
		return $RETVAL
	}

	do_upgrade() {
		OLDBINPIDFILE=$PIDFILE.oldbin

		do_configtest -q || return 6
		start-stop-daemon --stop --signal USR2 --quiet --pidfile $PIDFILE --name $NAME
		RETVAL="$?"
		sleep 1
		if [ -f $OLDBINPIDFILE -a -f $PIDFILE ]; then
			start-stop-daemon --stop --signal QUIT --quiet --pidfile $OLDBINPIDFILE --name $NAME
			RETVAL="$?"
		else
			echo $"Upgrade failed!"
			RETVAL=1
			return $RETVAL
		fi
	}

	case "$1" in
		start)
			[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC " "$NAME"
			do_start
			case "$?" in
				0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
				2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
			esac
			;;
		stop)
			[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
			do_stop
			case "$?" in
				0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
				2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
			esac
			;;
	  status)
			status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
			;;
	  configtest)
			do_configtest
			;;
	  upgrade)
			do_upgrade
			;;
	  reload|force-reload)
			log_daemon_msg "Reloading $DESC" "$NAME"
			do_reload
			log_end_msg $?
			;;
	  restart|force-reload)
			log_daemon_msg "Restarting $DESC" "$NAME"
			do_configtest -q || exit $RETVAL
			do_stop
			case "$?" in
				0|1)
					do_start
					case "$?" in
						0) log_end_msg 0 ;;
						1) log_end_msg 1 ;; # Old process is still running
						*) log_end_msg 1 ;; # Failed to start
					esac
					;;
				*)
					# Failed to stop
					log_end_msg 1
					;;
			esac
			;;
		*)
			echo "Usage: $SCRIPTNAME {start|stop|status|restart|reload|force-reload|upgrade|configtest}" >&2
			exit 3
			;;
	esac

	exit $RETVAL
	```

	* set quyền execute cho file.
	```sh
	# chmod +x /etc/init.d/nginx
	```
	
	* Cấu hình lại service để chạy nginx khi khởi động OS:
	```sh
	update-rc.d nginx defaults
	```
	
* Chạy nginx
```sh
# /etc/init.d/nginx start
hoặc
# service nginx start
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

##4. Cấu hình nginx với `nginx.conf` ở thư mục `/etc/nginx`
```sh
user  nginx;			# user 
worker_processes  1;		# Nếu cpu bạn có nhiều hơn 1 nhân, hãy thay đổi giá trị này để nginx được tối ưu hơn

error_log  /var/log/error.log;				# Đường dẫn file log
error_log  /var/log/error.log  notice;
error_log  /var/log/error.log  info;

pid        /var/run/nginx.pid;				# Đường dẫn file pid


events {
    worker_connections  1024;				# max_clients = worker_processes * worker_connections
}


http {
	include       mime.types;
	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;		 #là số giây timeout nếu không có request nào tiếp theo thì connection sẽ được đóng.
	# Keep alive: http://notes.viphat.work/keep-alive-la-gi-va-lam-the-nao-de-su-dung-no-de-toi-uu-web-performance/
	# Keep alive: Keep Alive là một phương thức cho phép sử dụng cùng một kết nối TCP
	# cho một chuỗi các phiên giao dịch HTTP thay vì cứ phải tạo mới từng connection cho mỗi một HTTP Request. 
	

    #gzip  on;				# Nén gzip

#####################################################	
    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   /var/www/html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

#######################################################
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

##########################################################
    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```

##5. Chạy php với nginx

Bản thân nginx không hỗ trợ xử lý php. Việc xử lý php sẽ do một service khác đảm nhận.

Nginx sẽ forward request đến service này và nhận kết quả về. Service này là php-fpm.

###5.1 Cài đặt php-fpm
```sh
apt-get instal php5-fpm
```

###5.2 Cấu hình php-fpm
* Cấu hình `/etc/php5/fpm/php-fpm.conf`

* Cấu hình `/etc/php5/fpm/pool.d/www.conf`
```sh
listen = /var/run/php5-fpm.sock
listen.owner = nginx
listen.group = nginx
```
Mình sẽ giải thích việc thay đổi các cấu hình ở trên. Khi PHP-FPM khởi động, file socket /var/run/php5-fpm.sock sẽ được tạo ra dưới quyền (permission) của user và group được chỉ định trong “listen.owner” và “listen.group“. Chỉ có user và group này mới được phép giao tiếp với file socket này. Nếu như bạn muốn Nginx sử dụng PHP-FPM thông qua unix socket, bạn phải set permissions cho file socket này. Đó là lý do tại sao bạn cần phải thay đổi các mục đó.

Nếu bạn không set permissions cho Nginx thì bạn sẽ gặp lỗi “502 Bad Gateway” vì Nginx không được phép giao tiếp với file socket..

```sh
An error occurred.

Sorry, the page you are looking for is currently unavailable.
Please try again later.

If you are the system administrator of this resource then you should check the error log for details.

Faithfully yours, nginx.
```

#####Chú ý: User và group ở đây chính là user được cấu hình trong file nginx.conf

* Khởi động lại php5-fpm: `service php5-fpm restart`

###5.3 Cấu hình nginx để chạy php-fpm
```
# pass the PHP scripts to FastCGI server listening on the php-fpm socket
        location ~ \.php$ {
                try_files $uri =404;
                root	/var/www/html;
			   #fastcgi_pass   127.0.0.1:9000;
				fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
                
        }
```
“fastcgi_pass   127.0.0.1:9000;” có nghĩa là Nginx sẽ giao tiếp với PHP-FPM thông qua một giao thức TCP ở địa chỉ 127.0.0.1 và port 9000.

Bạn nên sử dụng Unix socket để tăng hiệu suất cho các kết nối, kết nối của bạn sẽ nhanh hơn và bảo mật hơn. Để sử dụng Unix socket, bạn cần thay thế 127.0.0.1:9000 thành unix:/var/run/php5-fpm.sock:



* Khởi động lại nginx: `service nginx restart`


##6. Cấu hình virtual host
* Ví dụ tạo virtual host cho `system.ksec.com`

* Tạo sẵn một directory để chứa log nginx 
```sh
mkdir -p /var/log/nginx
chown -R nginx:nginx /var/log/nginx
```

* Tạo file `system.ksec.com.conf` nằm trong thự mục `sites-available`
```sh
server {
    listen       80;
    server_name system.ksec.com www.system.ksec.com;
    root /var/www/system.ksec.com;
    error_log  /var/log/nginx/system.ksec.com_error.log error;
    access_log  /var/log/nginx/system.ksec.com_access.log  main;
    index index.html index.php;
    location ~ \.php$ {
        try_files $uri =404;
        #root    /var/www/html;
        #fastcgi_pass   127.0.0.1:9000;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

* Symlink file `system.ksec.com.conf` đến thư mục sites-enabled
```sh
ln -s /etc/nginx/sites-available/system.ksec.com /etc/nginx/sites-enabled/system.ksec.com
```

* Tạo document root cho vhost system.ksec.com
```sh
mkdir -p /var/www/system.ksec.com
chown -R www-data:www-data /var/www/system.ksec.com
```
##7. Cấu hình nginx là Reverse proxy

* Tạo một file upstream. File này sẽ chứa thông tin về các cụm load balancer. Nội dung file này như sau:
```sh
upstream backend {
    server 192.168.3.241:80 weight=3 max_fails=3 fail_timeout=10s;
    server 192.168.3.242:80 max_fails=3 fail_timeout=10s;
}
```

Tôi có thể bổ sung thêm nhiều upstream khác nhau. Mỗi upstream là một cụm load balancer.

Mặc định nginx sẽ sử dụng giải thuật cân bằng tải round robin. Giải thuật này rất đơn giản.
Lần lượt các request được đẩy về từng backend server theo tỉ lệ 1:1

Trong file cấu hình upstream tôi có điều chỉnh chút ít khi đặt trọng số là 3 cho backend server thứ nhất. Khi đó tỉ lệ sẽ là 3:1.
Cứ sau 3 request liên tiếp đến 192.168.3.241 thì sẽ có tiếp đó một request đến 192.168.3.242

Các tham số max_fails và fail_timeout dùng để đảm bảo health check.
Kỹ thuật health check này sẽ loại bỏ backend server bị down sau một khoảng thời gian check thất bại và sẽ đưa backend server đó trở lại sau một khoảng thời gian check thành công.

* include file `upstream` vào file cấu hình `nginx.conf`

```sh
include /etc/nginx/upstream;
```

* Trong /etc/nginx/sites-available/vhost.example.com.conf, tôi bổ sung thêm các dòng sau:
```sh
location /{
        index index.html index.php;
        proxy_pass http://backend;
        proxy_set_header        Host $host;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
}
````

Tôi sẽ đi lần lượt vào từng dòng cấu hình

* `proxy_pass http://backend;` Các bạn có để ý là giá trị backend cũng được khai báo trong upstream file. Đây là một ánh xạ để load balancer tìm thấy các backend server cho vhost này.

* `proxy_set_header Host $host;` Dòng này cực kỳ quan trọng. Nếu không có dòng này, request dù được đẩy đi nhưng không thể được backend server nhận diện. Backend server sẽ trả về lỗi 404. Trong bài cấu hình nginx cơ bản - phần 2, khi giải thích cơ chế mà web server nhận diện một request thuộc về vhost nào tôi có đề cập đến trường Host nằm trong request header. Khi đi qua reverse proxy, mặc định trường Host này sẽ bị thay thế thành tên cụm backend server. Capture bằng tcpdump, tôi thấy request forward đến backend server có giá trị trường Host là Host: backend\r\n Rõ ràng là với trường Host này backend sẽ không biết phải xử lý thế nào. Tôi muốn giá trị Host của request được forward phải là: Host: vhost.example.com\r\n. Dòng cấu hình proxy_set_header Host $host; sẽ đơn giản set lại host header bằng đúng host header của request đến và thế là backend server sẽ biết được phải làm gì với các forwarded request này.

* `proxy_set_header X-Real-IP $remote_addr;` X-Real-IP là một trường cho biết IP của client đã kết nối đến proxy. Dòng cấu hình trên sẽ đặt IP của client vào trừong X-Real-IP trong request được forward đến backend server

* `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;` X-Forwarded-For là một trường cho biết danh sách gồm client ip và các proxy ip mà request này đã đi qua. Trường hợp có một proxy thì giá trị trường này cũng giống X-Real-IP. Dòng cấu hình trên sẽ đặt IP của client vào trừong X-Forwarded-For trong request được forward đến backend server

Một số forward proxy thực hiện chức năng ẩn danh sẽ hoàn toàn không set giá trị nào vào các trường X-Forwarded-For hay X-Real-IP. Do đó server nhận được request sẽ không thể nào biết client nào đang thực hiện request đằng sau proxy ( Đây là một đặc tính che dấu thông tin của proxy )

* `proxy_set_header X-Forwarded-Proto $scheme;` Dòng cấu hình trên sẽ đặt giao thức mà client dùng để kết nối với proxy. Trong demo đi kèm bài viết này thì giá trị đó là https.

* Bên cạnh các bổ sung, tôi có loại bỏ đi vài dòng như location ~ .php

Tại sao lại phải loại bỏ các location khác như location ~ .php

Bởi vì con web server này đang đóng vai trò load balancer cho vhost vhost.example.com Nó sẽ không xử lý các request đến vhost này nữa. Nếu tôi không loại bỏ các location đó thì load balancer tự phục vụ request luôn. Đây không phải là điều tôi mong muốn

* Một điều chỉnh nữa mà bạn có thể thực hiện dù cho nếu không làm thì load balancer vẫn hoạt động. Đó là 
xóa bỏ dòng root `/var/www/vhost.example.com;`
và xóa cả root web `/var/www/vhost.example.com;`

vì hiện tại web server không còn cần phục vụ request nữa. Nó chỉ forward request mà thôi.

Kết quả cuối cùng file này có nội dung như sau:

