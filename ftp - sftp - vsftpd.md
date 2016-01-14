# FTP - SFTP - Vsftpd
FTP (File Transfer Protocol) thường được dùng để trao đổi tập tin qua mạng lưới truyền thông dùng giao thức TCP/IP.
##1 FTP - SFTP
###1.1 Cách hoạt động của FTP
* Trong phiên làm việc của FTP, người dùng làm việc trên máy tính của mình và trao đổi file với một máy tính ở chỗ khác. Để truy cập tới máy tính khác, người dùng phải đăng nhập thông qua việc cung cấp định danh người dùng và mật khẩu.

	Sau khi những thông tin này được kiểm chứng thì công việc truyền file từ hệ thống file trên máy tính của mình đến hệ thống file ở đầu kia mới có thể được thực hiện.

* FTP sử dụng hai kết nối TCP song song, một đường truyền thông tin điều khiển (control connection) và một đường truyền dữ liệu (data connection).

	Các thông tin điều khiển như thông tin định danh người dùng, mật khẩu truy nhập, lệnh thay đổi thư mục, lệnh “PUT” hoặc “GET” file giữa hai máy tính được trao đổi qua đường truyền thông tin điều khiển.

	Đường truyền dữ liệu để truyền file dữ liệu thực sự.

	Vì FTP phân biệt luồng thông tin điều khiển với luồng dữ liệu nên nó dược gọi là gửi thông tin điều khiển out-of-band.

* FTP gồm 2 kết nối điều khiển và dữ liệu

	Khi người dùng bắt đầu một phiên làm việc FTP, đầu tiên FTP sẽ thiết lập một đường kết nối thông tin điều khiển TCP qua cổng 21 .
	
	Phía client của giao thức FTP truyền thông tin về định danh người dùng và mật khẩu cũng như lệnh thay đổi thư mục qua kết nối này.
	
	Khi người dùng có một yêu cầu trao đổi file (truyền từ/đến máy người dùng), FTP mở một kết nối TCP để truyền dữ liệu qua cổng 20. FTP truyền đúng một file qua kết nối này và ngay sau khi truyền xong thì đóng kết nối lại.
	
	Nếu trong cùng phiên làm việc người dùng có yêu cầu truyền file thì FTP sẽ mở một kết nối khác. Như vậy với FTP, luồng thông tin điều khiển được mở và tồn tại trong suốt phiên làm việc của người dùng, nhưng mỗi kết nối dữ liệu được tạo ra cho mỗi một yêu cầu truyền file (kết nối dữ liệu là không liên tục).

	Trong suốt phiên làm việc, FTP server phải giữ lại các thông tin về trạng thái của người dùng, đặc biệt nó phải kết hợp các thông tin điều khiển với tài khoản của người dùng. Server cũng lưu giữ thư mục hiện thời mà người dùng truy cập cũng như cây thư mục của người dùng. Ghi lại các thông tin trạng thái của mỗi phiên làm việc hạn chế đáng kể tổng số phiên làm việc đồng thời.

####Các loại FTP
![](http://ngoctu.net/wp-content/uploads/2013/11/active-and-passive-ftp.png)

**1/Active FTP**

Client chỉ bắt đầu một phiên giao dịch

* Client gửi yêu cầu tạo phiên kết nối từ port 1024+ (port bất kỳ trong khoảng 1025-65536) đến port 21 của server;
* Server nhận được yêu cầu và gửi trả 1 ACK tới client. Client sẽ lắng nghe tại port 1024+, chờ tín hiệu từ Server;
* Sau khi thiết lập được kết nối, server truyền dữ liệu từ port 20 đến port 1024+ đang lắng nghe tại client;
* Một vấn đề xảy ra cho phía client là firewall. Client không là phía bắt đầu phiên truyền dữ liệu mà chỉ lắng nghe tin hiệu từ server trên port 1024+ và với firewall, việc một tín hiệu từ bên ngoài cố gắng kết nối vào bên trong sẽ bị deny!!!
* Active FTP giúp đơn giản cấu hình Firewall trên server.

**2/Passive FTP**

* Khi khởi tạo kết nối, client đồng thời tạo ra 2 port 1024+, một dùng để kết nối tới port 21 của server, một dùng để truyền dữ liệu
* Port thứ nhất liên lạc với server qua port 21 và báo cho server biết đây là passive mode! Khi đó, server sẽ lắng nghe ở port 1024+ mà không phải là port 20 và sẽ gửi lại thông tin cho client biết mình đang lắng nghe ở port nào.
* Sau khi biết port lắng nghe từ server, client dùng port 1024+ thứ hai để kết nối tới port 1024+ mới được tạo ra trên server;
* Server gửi trả 1 gói ACK để chấp thuận và phiên truyền dữ liệu được thực hiện. Như vậy, client là kẻ bắt đầu ở cả hai phiên giao dịch, do đó, giải quyết được vấn đề chặn kết nối từ Firewall! Một lưu ý nhỏ là Windows mặc định Active Mode, còn Linux là Passive Mode, do đó, có thể bạn phải sự dụng cả hai hình thức khi xem xét đến một chính sách bảo mật cho FTP Server.

###1.2 Dạng thức của dữ liệu
Có hai chế độ được dùng để truyền tải dữ liệu qua mạng lưới truyền thông: 
   
   * Chế độ ASCII

    * Chế độ Nhị phân
	
Hai chế độ này khác nhau trong cách chúng gửi dữ liệu: 
* **Chế dộ ASCII:** Khi một tập tin được truyền dùng chế độ ASCII, mỗi một chữ, mỗi con số, và mỗi ký tự đều được gửi trong dạng mã ASCII. Máy nhận tin lưu trữ chúng trong một tập tin văn bản thường, dưới dạng thức thích hợp (chẳng hạn, một máy dùng Unix sẽ lưu trữ nó trong dạng thức của Unix, một máy dùng Macintosh sẽ lưu trữ nó trong dạng thức của Mac).
	
	Vì thế, khi chế độ ASCII được dùng trong một cuộc truyền tải dữ liệu, phần mềm FTP sẽ tự cho rằng các dữ liệu được truyền gửi có dạng thức văn bản thường (plain text), và lưu trữ trên máy nhận theo dạng thức của máy.
	
	Chuyển đổi giữa các dạng thức văn bản thường bao gồm việc, thay thế mã kết dòng và mã kết tập tin, từ những mã tự được dùng ở máy nguồn, sang những mã tự được dùng ở máy đích, chẳng hạn một máy dùng hệ điều hành Windows, nhận một tập tin từ một máy dùng hệ điều hành Unix, máy dùng Windows sẽ thay thế những chữ xuống dòng (carriage return) bằng một cặp mã, bao gồm mã xuống dòng và mã thêm hàng (carriage return and line feed pairs).
	
	Tốc độ truyền tải tập tin dùng mã ASCII cũng nhanh hơn một chút, vì bit ở hàng cao nhất của mỗi byte của tập tin bị bỏ [1].

* **Chế độ nhị phân:** Máy gửi tập tin gửi từng bit một sang cho máy nhận. Máy nhận lưu trữ dòng bit, y như nó đã được gửi sang. Nếu dữ liệu không phải ở dạng thức văn bản thường, thì chúng ta phải truyền tải chúng ở chế độ nhị phân, nếu không, dữ liệu sẽ bị thoái hóa, không dùng được.

=>Theo như cài đặt sẵn, phần lớn các trình khách FTP dùng chế độ ASCII khi khởi công. Một số trình khách FTP xét nghiệm tên và nội dung của tập tin được gửi, để xác định chế độ cần phải dùng.

###1.3 Các mã hồi âm của FTP

Mã hồi âm của trình chủ FTP chỉ định hiện trạng của trình, sau khi đã hoạt động, bằng giá trị của con số trong vị trí của nó. Nghĩa của những con số và vị trí có thể được lược giải như sau:

* 1xx: Hồi âm sơ bộ tích cực. Đề nghị thao tác đã bắt đầu khởi hành, song chương trình còn phải đợi một thông điệp hồi âm nữa, trước khi đề nghị thao tác được tiến hành.
* 2xx: Hồi âm hoàn thành tích cực. Đề nghị thao tác đã hoàn thành. Trình khách có thể tiếp tục gửi dòng lệnh mới sang.
* 3xx: Hồi âm trung gian tích cực. Dòng lệnh đã được thao tác và xử lý thành công, song trình chủ còn phải đợi một dòng lệnh khác nữa, trước khi toàn bộ đề nghị được giải quyết.
* 4xx: Hồi âm phủ quyết tạm thời. Dòng lệnh không được thao tác và xử lý, song trình khách có thể gửi yêu cầu sang một lần nữa, vì sự thất bại trong việc xử lý dòng lệnh đầu tiên chỉ là tạm thời.
* 5xx: Hồi âm phủ quyết toàn phần. Dòng lệnh không được xử lý, và trình khách không nên gửi lại yêu cầu ấy thêm một lần nào nữa.
* x0z: Sự thất bại xảy ra vì lỗi trong cú pháp.
* x1z: Thông điệp trả lời là hồi âm của một yêu cầu về tin tức.
* x2z: Thông điệp trả lời là hồi âm về tin tức liên quan đến liên kết (connection).
* x3z: Thông điệp trả lời là hồi âm liên quan đến trương mục và quyền hạn.
* x4z: Không rõ.
* x5z: Thông điệp trả lời là hồi âm liên quan đến hệ thống tập tin.

###1.4 Nhược điểm của FTP

* Mật khẩu và nội dung của tập tin được truyền qua đường cáp mạng ở dạng văn bản thường (clear text), vì vậy chúng có thể bị chặn và nội dung bị lộ ra cho những kẻ nghe trộm. Hiện nay, người ta đã có những cải tiến để khắc phục nhược điểm này.

* Cần phải có nhiều kết nối TCP/IP: một dòng dành riêng cho việc điều khiển kết nối, một dòng riêng cho việc truyền tập tin lên, truyền tập tin xuống, hoặc liệt kê thư mục. Các phần mềm bức tường lửa cần phải được cài đặt thêm những lôgic mới, đế có thể lường trước được những kết nối của FTP.

* Việc thanh lọc giao thông FTP bên trình khách, khi nó hoạt động ở chế độ năng động, dùng bức tường lửa, là một việc khó làm, vì trình khách phải tùy ứng mở một cổng mới để tiếp nhận đòi hỏi kết nối khi nó xảy ra. Vấn đề này phần lớn được giải quyết bằng cách chuyển FTP sang dùng ở chế độ bị động.

* Người ta có thể lạm dụng tính năng ủy quyền, được cài đặt sẵn trong giao thức, để sai khiến máy chủ gửi dữ liệu sang một cổng tùy chọn ở một máy tính thứ ba. Xin xem thêm về FXP.

* FTP là một giao thức có tính trì trệ rất cao (high latency). Sự trì trệ gây ra do việc, nó bắt buộc phải giải quyết một số lượng lớn các dòng lệnh khởi đầu một phiên truyền tải.

* Phần nhận không có phương pháp để kiểm chứng tính toàn vẹn của dữ liệu được truyền sang. Nếu kết nối truyền tải bị ngắt giữa lưng chừng thì không có cách gì, trong giao thức, giúp cho phần nhận biết được rằng, tập tin nhận được là hoàn chỉnh hay còn vẫn còn thiếu sót. Sự hỗ trợ bên ngoài, như việc dùng kiểm tra tổng MD5, hoặc dùng kiểm độ dư tuần hoàn (cyclic redundancy checking) là một việc cần thiết.

##1.5 sFTP

* sFTP là chữ viết tắt của (Secure File Transfer Protocol hoặc SSH File Transfer Protocol), tức nó là một giao thức trao đổi dữ liệu giữa máy khách và máy chủ nhưng các dữ liệu được trao đổi sẽ bị mã hóa trước khi chuyển đến máy chủ hoặc máy khách, hoạt động như một bản mở rộng (extension) của SSH để thay thế cho FTP vốn không an toàn.

##2. Cài đặt và cấu hình Vsftpd trên ubuntu server

VSFTP là một dịch vụ FTP server chạy trên linux, chúng ta sẽ dùng hệ thống VSFTP để có thể chia sẻ tài liệu (tài nguyên) cho người khác.

###2.1 Cài đặt
```sh
apt-get install vsftpd
```
###2.2 Cấu hình Vsftpd: File cấu hình **/etc/vsftpd.conf**
```sh
# Example config file /etc/vsftpd.conf

listen=NO	// đây là 1 option rât quan trọng dùng để bật tắt chế độ Standalone, mặc định Option này là NO. Tuy nhiên đối với tất cả các máy chạy VsFTP đơn lẻ nhất thiết phải thiết lấp option listen=YES , nếu không thiết lập Server VsFTP sẽ không khởi động được.

listen_ipv6=YES		//sử dụng ipv6

anonymous_enable=NO		// Không cho phép mọi người có thể truy cập.

local_enable=YES		//Cho phép người dùng cục bộ truy cập

write_enable=YES		//Cho phép quyền ghi.

#local_umask=022		//Default umask .

anon_upload_enable=YES		//cho phép mọi người upload file

anon_mkdir_write_enable=YES	//Cho phép mọi người có quyền tạo thư mục

dirmessage_enable=YES		//active dir messages

use_localtime=YES	//sử dụng thời gian

xferlog_enable=YES	//Cấu hình log khi up hay down file

connect_from_port_20=YES	//Cho phép kết nối data qua port 20
#
# If you want, you can arrange for uploaded anonymous files to be owned by
# a different user. Note! Using "root" for uploaded files is not
# recommended!
#chown_uploads=YES
#chown_username=whoever

#xferlog_file=/var/log/vsftpd.log		//Đường dẫn file log.

#xferlog_std_format=YES		/format log.

#idle_session_timeout=600		//Thời gian timeout cho 1 connection, được tính bằng giây

#data_connection_timeout=120	//Thời gian tối đa để thực hiện việc truyền dữ liệu, quá thời gian này sẽ bị cắt khi truyền. Tính bằng giây. 
#
# It is recommended that you define on your system a unique user which the
# ftp server can use as a totally isolated and unprivileged user.
#nopriv_user=ftpsecure
#
# Enable this and the server will recognise asynchronous ABOR requests. Not
# recommended for security (the code is non-trivial). Not enabling it,
# however, may confuse older FTP clients.
#async_abor_enable=YES
#

#ascii_upload_enable=YES	//Cho phép upload

#ascii_download_enable=YES	// Cho phép download

#ftpd_banner=Welcome to blah FTP service.	// lời chào khi đăng nhập :v

#deny_email_enable=YES		//từ chối email

#banned_email_file=/etc/vsftpd.banned_emails	//danh sách email bị banned.

# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
#chroot_local_user=YES		//tất cả người dùng có trong hệ thống sẽ chỉ có quyền truy cập đối với thư mục home của user đó mà không truy cập được vào bất kỳ phần nào khác của máy chủ.
#
# You may specify an explicit list of local users to chroot() to their home
# directory. If chroot_local_user is YES, then this list becomes a list of
# users to NOT chroot().
# (Warning! chroot'ing can be very dangerous. If using chroot, make sure that
# the user does not have write access to the top level directory within the
# chroot)
#chroot_local_user=YES
#chroot_list_enable=YES
# (default follows)
#chroot_list_file=/etc/vsftpd.chroot_list
#
# You may activate the "-R" option to the builtin ls. This is disabled by
# default to avoid remote users being able to cause excessive I/O on large
# sites. However, some broken FTP clients such as "ncftp" and "mirror" assume
# the presence of the "-R" option, so there is a strong case for enabling it.
#ls_recurse_enable=YES
#
# Customization
#
# Some of vsftpd's settings don't fit the filesystem layout by
# default.
#
# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
secure_chroot_dir=/var/run/vsftpd/empty
#
# This string is the name of the PAM service vsftpd will use.
pam_service_name=vsftpd
#
# This option specifies the location of the RSA certificate to use for SSL
# encrypted connections.
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
```

Cho phép vsftpd chạy khi khởi động, dùng lệnh sau
```sh
sudo chkconfig vsftpd on
```

