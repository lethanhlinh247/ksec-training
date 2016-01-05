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


![](http://www.opensourceforu.efytimes.com/wp-content/uploads/2010/08/figure-1-Apache-web-architecture-590x435.jpg)

###1.1 Apache core được tổ chức như sau:
* **http_protocol.c:** chứa các procedure để giao tiếp với client thông qua giao thức http. Mọi thứ trao đổi với client do thằng này đảm nhiệm.
* **http_main.c:** khởi động server, tạo vòng lặp chính để đợi + chấp nhận các kết nối, và quản lý toàn bộ timeout
* **http_request.c:** quản lý tiến trình xử lý bản tin request, đảm bảo chuyển các bản tin điều khiển tới các modul phù hợp theo đúng thứ tự + quản lý lỗi xảy ra trên server
* **http_core.c:** triển khai các chức năng cơ bản nhất trên Apache
* **alloc.c:** kiểm soát việc phân chia tài nguyên và lưu trữ các thông tin về sự phân chia đó
* **http_config.c:** xử lý file cấu hình và hỗ trợ virtual host + liệt kê các modul sử dụng trong apache

###1.2 Request processing – luồng request, cách xử lý một request từ phía client của webserver apache

Khi có một request từ phía client đến, webserver apache sẽ thực hiện xử lý các công việc theo trình tự sau:

    * Phân giải địa chỉ
    * Kiểm tra truy cập và cấp quyền truy cập đến những tài nguyên cần thiết
    * Xác định MIME (Multipurpose Internet Mail Extensions) của đối tượng truy vấn. Tức là thông tin về kiểu định dạng của tài nguyên trên server được gọi tên trong gói HTTP Request
    * Chỉnh sửa lại một số thông tin ( ví dụ thay đổi Alisa thành một đường dẫn thực – định nghĩa trong modul alisa thuộc phần mod_alisa)
    * Gửi lại dữ liệu cho client
    * Ghi lại log

###1.3 Communicating between modules – giao tiếp giữa các module
Trong webserver apache, các modules không giao tiếp trực tiếp với nhau mà thông qua apache core.

###1.4 Handler
* Handler là một hành động được Apache định nghĩa riêng cho từng loại file nhất định. Mặc định, tùy loại file mà sẽ được xử lý theo các cách khác nhau
* Handler có thể được cấu hình dựa trên phần mở rộng của file hoặc theo từng thư mục
* Mặc định, có 7 loại handler:
    * **Send-as-is:** dùng trong module mod_asis, dùng để gửi trả gói tin cho client mà không sử dụng đầy đủ HTTP header
    * **Cgi-script:** coi file là một cgi-script (tương ứng modul: mod_cgi)
    * **Imap-file:** sử dụng chung với mod_imagemap
    * **Server-info:** lấy thông tin về cấu hình của server
    * **Server-status:** lấy thông tin về trạng thái của server
    * **Type – map:** sử dụng cùng với module mod_negotiation
    * **Default-handler:** gửi file sử dụng default_handler()

###1.5 Modules
* Các mdoul được cài đặt sẵn trong quá trinh buil Apache, hoặc có thể add thêm.
* Mặc định sẵn sẽ có các modules như sau – các modul này sẽ hoạt động lần lượt theo request của người dùng (6 bước, xem lại ở mục 2 – request processing)

    * Chuyển đổi giữa các URL thành filename trên server:
        * **Mod_userdir:** chuyển thư mục home cho từng user
        * **Mod_rewrite:** điều chỉnh lại đường dẫn URL
    * Giai đoạn Xác thực/ Phân quyền:
        * **Mod_ahth, mod_auth_anon, mod_auth_db, mod_ahth_dbm:** các kiểu xác thực người dùng
        * **Mod_access:** kiểm soát truy cập theo từng host
    * Xác định MIME của đối tượng được truy vấn:
        * **Mod_mime:** xác định loại file bằng cách dựa vào phần mở rộng
        * **Mod_mime_magic:** xác định loại file bằng cách sử dụng magic number
    * Chỉnh sửa đường dẫn:
        * **Mod_alias:** thay thế alias bằng đường dẫn thực trên server
        * **Mod_env:** thay đổi các tham số hệ thống dựa trên thông tin trong file cấu hình
        * **Mod_spelling:** tự động sửa lỗi trông URL
    * Gửi trả lại cho client
        * **Mod_actions:** các scrip cho từng loại file sẽ được thực thi
        * **Mod_asis:** gửi file nguyên dạng
        * **Mod_autoindex:**
        * **Mod_cgi:** gọi scrip CGI và trả lại kết quả
        * **Mod_include:**
        * **Mod_dir:** xử lý về thư mục
        * **Mod_imap:** xử lý về image-map file
    * Ghi log:
        * **Mod_log_*:** các modul log khác nhau

###1.6 Apache configuration File
* Khi một request đến Apache server mà không được virtual host nào xử lý thì các thông số này sẽ quyết định hành động của ApacheServer. Các tham số này cũng đồng thời xác lập các giá trị mậc định cho tất cả các Virtual host
* Gồm 3 thành phần chính:
	* Global Evironment: các thông số để cấu hình điều khiển hoạt động của toàn bộ ApacheServer
    * Các directive định nghĩa các thông số của “main” hay “default” server
    * Các tham số riêng cho từng virtual host

####1.6.1 Config/ Global enviroment:
* ServerToken & ServerSignature: Giảm nguy cơ bị lộ thông tin về phiên bản Apache đang chạy trên server.
```sh
	ServerSignature Off
	ServerTokens Prod
```
* Server Root: cấu hình thư mục lưu trữ chính của Apache.
* PidFile: thông số này lưu trữ đường dẫn đến file httpd.pid, là file lưu trữ process ID của Apache mỗi khi khởi chạy. Mặc định, file này nằm ở /etc/httpd/run/httpd.pid và trong đó chỉ có 1 con số (ví dụ: 1231)
* Timeout: thời gian tim out cho hệt hống, giá trị mặc định
* KeepAlive: KeepAlive là một hình thức có thể giúp tăng tốc độ tải trang khi không mở kết nối cho từng request một. Tuy nhiên, khi bị tấn công Ddos, thì nên tắt chắc năng này để giảm thiểu ảnh hưởng tới hệ thống. Nhưng với CDN thì có lẽ nên bật vì số lượng Edge rõ lắm. Thông số KeepAlive cho phép kiểu kết nối này được bật hay không.
	Thông số KeepAliveTimeOut
* Listen: cấu hình địa chỉ IP và port để Apache nhận các gói request
* LoadModul: gọi modul nào sẽ khởi động cùng hệ thống
* Include: cấu hình thư mục chứa file config

####1.6.2 Config/ Main Server Configuration

* ServerAdmin: cấu hình địa chỉ email của người quản trị, sẽ hiển thị trên một số trang (như trang báo lỗi 404)
* UseCanonicalName: thông thường, khi sử dụng Name-based Virutal Host thì nên set là off – không hỉu
* DocumentRoot: thư mục lưu trữ các đường dẫn chứa mã nguồn của website, các requet từ client sẽ chỉ truy xuất thông tin từ thư mục này.
    * Windows: c:/wampp/www
    * Centos: /var/www/html/
* DirectoryIndex: chỉ định file mặc định được trả về cho client khi có request tới một thư mục nào đó, thông thường các file như index.html, index.php sẽ được sử dụng.
	* **Ví dụ:** DirectoryIndex index.htm index.html index.html.var
* AccessFileName: chỉ định file bổ sung các cấu hình riêng cho từng thư mục nhất định. Thông thường sẽ là file “.htaccess” – file này trong mỗi virutalhost sẽ có, nói lên việc truy cập, blah blah…
* TypesConfig: chỉ đường dẫn tới file mime.types. File này sẽ giúp cho Apache tra cứu phần mở rộng của file để xác định MIME type trong HTTP Header (xem lại phần ví dụ handler)
	* **Ví dụ:** DefaultType  text/plain
	
	Mặc định, MIME type cho các file apache không xác định được sẽ là kiểu file text

* HostnameLookups: cấu hình ghi log tên hostname của client hay chỉ đại chỉ IP của client (thường mặc định để off)
* ErrorLog: cấu hình đường lưu trữ Error của hệ thống
* LogLevel: mức độ ghi log. Giống như syslog, log trong Apache cũng được ghi thành 7 mức độ khác nhau từ cao xuống thấp là:
    * Emergency
    * Alert
    * Critical
    * Error
    * Warning
    * Notification
    * Information
    * Debug

* Log

####1.6.3 Một số trường – cấu hình apache webserver
* Các thông số trong http.conf


    Server Root: chỉ dẫn vị trí cài đặt Apache

=> Cú pháp : ServerRoot <vị trí cài đặt Apache>

    Listen : quy định địa chỉ IP hoặc cổng mà Apache nhận kết nối từ client

=> Cú pháp: listen <port/IP>

    Server Admin:địa chỉ mail của người quản trị hệ thống

=> Cú pháp: ServerAdmin <địa chỉ email>

    Server name: tên máy tính của server

=> Cú pháp: ServerName <tên máy server>ort

    DocumentRoot: lưu trữ nội dung của website, web server lấy lấy những tập tin trong thư mục (htdocs) phục vụ cho yêu cầu của client

=> Cú pháp: DocumentRoot <đường dẫn thư mục>

    DirectoryIndex:các tập tin mặc định được truy vấn khi truy cập web

=> Cú pháp: DirectoryIndex <danh sách các tập tin>

    Error Log :chỉ ra tập tin để server ghi vào những lỗi mà nó gặp phải

=> Cú pháp:ErrorLog <vị trí log>

    Alias:ánh xạ đường dẫn cục bộ(không nằm trong document) thành đường dẫn địa chỉ URL

=> Cú pháp:alias<đường dẫn http><đường dẫn cục bộ>

###1.7    Mutiprocessing
Có 2 khái niệm về khả năng xử lý của webserver
* Single-threaded web server: không có khả năng xử lý đồng thời nhiều request một lúc
* Multi-thread web server: có khả năng xử lý nhiều request một lúc, gồm 2 kĩ thuật chính là :
    * Multi-process: tạo process cho từng request, có 2 loại chủ yếu
		* Moudle: Prefork: tạo các process riêng biệt. Lỗi trên 1 process không gây ảnh hưởng tới process khác
    * Multi-thread: tạo Thread mới cho từng request
        * Module: Worker: tạo các thread riêng biệt cho request, hợp với đa lõi, nhưng nếu có 1 thread bị lỗi sẽ có thể gây ảnh hưởng tới các thread trong cùng process đó

=> Đánh giá chung: Thread thì tiết kiệm tài nguyên hơn là Process. Nhưng còn tùy thuộc vào các yếu tố khác nhau, ví dụ PHP thì nên dùng Prefork, vì nó không ổn định với hình thức chia sẻ bộ nhớ chung (Process thì sẽ tạo tài nguyên riêng cho từng process, nên sẽ không bị ảnh hưởng khi dùng PHP). (Thread dùng chung bộ nhớ, tài nguyên là ảnh hưởng)

###1.8 Các file cấu hình apache
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

###1.9 Cấu hình file apache2.conf

* **#ServerRoot "/etc/apache2":** Cấu hình thư mục lưu trữ chính của Apache.
* **PidFile ${APACHE_PID_FILE}:** Chỉ đường dẫn đến file httpd.pid, là file lưu trữ process ID của Apache mỗi khi khởi chạy. 
* **Timeout 300:** Thời gian timeout cho hệ thống.
* **KeepAlive On:**  Là một hình thức có thể giúp tăng tốc độ tải trang khi không mở kết nối cho từng request một.
* **MaxKeepAliveRequests 100:** Số requests tối đa trong 1 connect.
* **KeepAliveTimeout 5:**  Khoảng thời gian timeout để đợi request tiếp theo từ cùng 1 người dùng trên cùng 1 kết nối.
* **ErrorLog ${APACHE_LOG_DIR}/error.log:** Đường dẫn file log.
* **Include ports.conf:** Cấu hình các cổng lắng nghe, ờ file ports.conf


##2. Configure virtual hostings. 
* Virtual Host là tính năng của Apache giúp ta duy trì nhiều hơn một web server trên một máy tính.
Nhiều tên cùng chia sẻ một địa chỉ IP gọi là named-based virtual hosting, và sử dụng những địa chỉ IP khác nhau cho từng domain gọi là IP-based virtual hosting. 
###2.1 Named-based virtual hosting
* Nhiều website sử dụng chung 1 IP. Server sẽ phân tích http header từ client yêu cầu để ánh xạ đến đúng website được chỉ định theo tên miền.
* Vì vậy Name-Based rất được ưa chuộng dùng để quản lý nhiều website trên cùng 1 máy chủ và trong thời buổi thế giới đang cạn kiệt IP Public cũng như sử dụng tối đang tài nguyên sẵn có.*
* Nhược điểm lớn nhất là khi IP dùng chung gặp vấn đề thì tất cả các website bên trong đều sẽ bị ảnh hưởng.
![](http://babalaz.com/wp-content/uploads/Name-basedVHost.jpg)

* Tạo một file cấu hình Virtual Host mới, đặt tên là domain.com.conf
```sh
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/lethanhlinh.com.conf
```
* Chỉnh sửa file Virtual Host.
```sh
<VirtualHost *:80>	#Cấu hình ip mặc định.
    ServerAdmin admin@lethanhlinh.com	#Địa chỉ email của admin.
    ServerName lethanhlinh.com	#domain.
    DocumentRoot /home/adk/public_html	#Đường dẫn chứa thư mục gốc.
    ErrorLog ${APACHE_LOG_DIR}/error.log	#file log.
    CustomLog ${APACHE_LOG_DIR}/access.log combined		#File log.
</VirtualHost>
```
* Bật cấu hình site domain.com và khởi động lại dịch vụ apache2.
```sh
sudo a2ensite lethanhlinh.com.conf    => Lệnh này apache sẽ tạo 1 file trong sites-enabled và file này symlink đến file lethanhlinh.com.conf trong sites-avilable.
service apache2 restart
```
###2.2  Ip-base virtual hosting
*  Một IP sử dụng cho 1 Website. Web Server sẽ ánh xạ IP được yêu cầu đến đúng website mong muốn.
* Nên mỗi website sẽ được định nghĩa bởi 1 IP duy nhất giúp giảm thiểu tối đa sự cố xảy ra cho Website liên quan đến địa chỉ IP. Tuy nhiên IP-Based (dùng trên 1 máy chủ) cần thiết lập Virtual Interface trên 1 máy chủ để có thể sử dụng được nhiều IP.
* Tuy nhiên, nó sẽ bất lợi hơn nếu so sánh với Name-Based Virtual Hosts.
![](http://babalaz.com/wp-content/uploads/IP-BasedVHost.jpg)
* Đầu tiên, chúng ta cũng tạo một file cấu hình virtual host mới, đặt tên là dmoain.com.conf
```sh
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/lethanhlinh.com.conf
```
* Chỉnh sửa file Virtual Host.
```sh
<VirtualHost 192.168.1.100:80	#Địa chỉ ip card mạng ảo mình vừa tạo.
    ServerAdmin admin@nhoclinh.com	#Địa chỉ email của admin.
    ServerName nhoclinh.com		#Domain.
    DocumentRoot /home/adk/public_html	#Đường dẫn thư mục gốc.
    ErrorLog ${APACHE_LOG_DIR}/error.log	#Đường dẫn file log.
    CustomLog ${APACHE_LOG_DIR}/access.log combined	#Đường dẫn file log.
</VirtualHost>
```
* Bật cấu hình site domain.com và khởi động lại dịch vụ apache2.
```sh
sudo a2ensite nhoclinh.com.conf    => Lệnh này apache sẽ tạo 1 file trong sites-enabled và file này symlink đến file lethanhlinh.com.conf trong sites-avilable.
service apache2 restart
```
