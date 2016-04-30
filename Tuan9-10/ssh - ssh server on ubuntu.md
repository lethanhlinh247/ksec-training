#SSH - SSH trên Ubuntu Server
SSH (Secure Shell) là một giao thức mạng dùng để thiết lập kết nối mạng một cách bảo mật. SSH hoạt động ở lớp trên trong mô hình phân lớp TCP/IP.

Các công cụ SSH (như là OpenSSH,...) cung cấp cho người dùng cách thức để thiết lập kết nối mạng được mã hoá để tạo một kênh kết nối riêng tư. Hơn nữa tính năng tunneling của các công cụ này cho phép chuyển tải các giao vận theo các giao thức khác.

Do vậy có thể thấy khi xây dựng một hệ thống mạng dựa trên SSH, chúng ta sẽ có một hệ thống mạng riêng ảo VPN đơn giản.

Mỗi khi dữ liệu được gửi bởi một máy tính vào mạng, SSH tự động mã hoá nó. Khi dữ liệu được nhận vào, SSH tự động giải mã nó.

Kết quả là việc mã hoá được thực hiện trong suốt: người dùng có thể làm việc bình thường, không biết rằng việc truyền thông của họ đã được mã hoá an toàn trên mạng.

##1. Các đặc điểm của SSH
###1.1 Tính bí mật (Privacy): bảo vệ dữ liệu không bị phơi bày
SSH cung cấp tính bí mật bằng việc mã hoá dữ liệu đi qua mạng. Đó là việc mã hoá hai đầu dựa trên khoá ngẫu nhiên (sinh ra để phục vụ cho một phiên kết nối và được huỷ đi khi phiên kết nối thành công).

SSH hỗ trợ nhiều thuật toán mã hoá đối với phiên dữ liệu, đó là những thuật toán mã hoá chuẩn như: AES, ARCFOUR, Blowfish, Twofish, IDEA, DES và triple-DES (3DES)

###1.2 Tính toàn vẹn (Integrity): bảo đảm dữ liệu được truyền từ một đầu này đến đầu kia của mạng không bị thay đổ
Giao thức SSH sử dụng phương pháp kiểm tra toàn vẹn mật mã, phương pháp này kiểm tra cả việc dữ liệu có bị biến đổi hay không và dữ liệu đến có đúng là do đầu kia gửi hay không.

Nó sử dụng thuật toán băm khoá là MD5 và SHA-1.

###1.3 Chứng minh xác thực (authentication): kiểm tra định danh của ai đó để xác định chính xác đúng là người đó hay không
Mỗi kết nối SSH bao gồm hai việc xác thực: client kiểm tra định danh của SSH server (server authentication) và server kiểm tra định danh của người sr dụng yêu cầu truy cập (user authentication).

Server authentication chắc chắn rằng SSH server là chính xác và không phải là kẻ lừa đảo để đề phòng kẻ tấn công lại gửi kết nối mạng đến một máy khác. Server authentication cũng bảo vệ việc bị kẻ xấu ngồi ở giữa hai bên, lừa gạt cả hai bên nghĩa là kẻ xấu sẽ nói với server nó là client và nói với client nó là server để đọc được dữ liệu trao đổi giữa hai bên.

User authentication theo truyền thống là làm việc với mật khẩu. Để xác thực định danh của bạn, bạn phải đưa ra mật khẩu, và dễ bị lấy cắp. Thêm nữa, để dễ nhớ một mật khẩu, người ta thường đặt nó ngắn và có ý nghĩa nào đó nên dễ bị kẻ xấu đoán ra. Đối với mật khẩu dài hơn thì người ta thường chọn những từ hoặc câu trong ngôn ngữ bẩm sinh nên cũng dễ bị bẻ khoá.

SSH hỗ trợ xác thực bằng mật khẩu, mã hoá mật khẩu khi nó truyền đi trên mạng. Đây là sự cải thiện rất lớn so với những giao thức truy cập từ xa thông thường khác (Telnet, FTP) mà chúng gửi mật khẩu qua mạng dưới dạng clear text.

Tuy nhiên, việc chứng thực như thế vẫn chỉ là chứng thực mật khẩu đơn giản vì thế SSH cung cấp cơ chế mạnh hơn và dễ sử dụng hơn: mỗi user có nhiều chữ kí khoá công cộng (per-user public-key signature) và một cải tiến rlogin-style xác thực với định danh host được kiểm tra bằng khoá công khai.

Hơn nữa, những bản bổ sung khác nhau của SSH hỗ trợ vài hệ thống khác bao gồm Kerberos, RSA, mật khẩu S/Key one-time và PAM. Một SSH client và SSH server đàm phán với nhau để xác định cơ chế xác thực sẽ sử dụng dựa trên cấu hình của chúng và một server thậm chí có thể yêu cầu nhiều kiểu xác thực.

###1.4 Việc cấp giấy phép
Việc cấp giấy phép có tác dụng quyết định ai đó có thể hoặc không thể làm gì đó. Nó diễn ra sau khi xác thực, bởi vì bạn không thể chấp nhận một ai đó có quyền gì khi chưa biết đó là ai. 

SSH server có nhiều cách khác nhau để giới hạn hành động của client.
	
	* Truy cập đến phiên đăng nhập tác động lẫn nhau như TCP port và X Window forwarding, key agent forwarding, … có thể tất cả đều được điều khiển mặc dù không phải tất các đặc điểm đều có sẵn trên tất cả các bản bổ sung SSH,và chúng không luôn luôn tống quát hoặc linh hoạt như bạn ý muốn.
	
	* Giấy phép có thể được điều khiển tại một mức server rộng (ví dụ: /etc/ssh/sshd_config file đối với OpenSH) hoặc theo tài khoản phụ thuộc vào phương thức xác thực sử dụng.

###1.5 Chuyển tiếp (forwarding) hoặc tạo đường hầm (tunneling)
SSH hỗ trợ 3 kiểu chuyển tiếp:
* TCP port forwarding:
SSH dùng TCP/IP làm cơ chế truyền, thường dùng port 22 trên máy server khi nó mã hoá và giải mã lưu lượng đi trên mạng. Ở đây chúng ta nói đến một đặc điểm mã hoá và giải mã lưu lựong TCP/IP thuộc về ứng dụng khác, trên cổng TCP khác dùng SSH. Tiến trình này gọi là port forwarding, nó có tính trong suốt cao va khá mạnh. Telnet, SMTP, NNTP, IMAP và những giao thức không an toàn khác chạy TCP có thể được bảo đảm bằng việc chuyển tiếp kết nối thông qua SSH. Port forwarding đôi khi được gọi là tunneling bởi vì kết nối SSH cung cấp một “đường hầm” xuyên qua để kết nối TCP khác có thể đi qua.

	Giả sử bạn có một máy H ở nhà đang chạy IMAP và bạn muốn kết nối đến một IMAP server trên máy S để đọc và gửi mail. Bình thường thì việc kết nối này không đảm bảo an toàn, tài khoản và mật khẩu mail của bạn được truyền đi dưới dạng clear text giữa chương trình mail của bạn và server. Đối với SSH port forwarding, bạn có thể định tuyến lại trong suốt kết nối IMAP ( tìm cổng TCP 143 trên server S) để truyền đi thông qua SSH, mã hoá bảo đảm dữ liệu truyền đi trên kết nối. Máy IMAP server phải chạy một SSH server cho port forwarding để cung cấp việc bảo đảm đó.

	Tuy nhiên, SSH port forwarding chỉ hoạt động trên giao thức TCP và không làm việc được trên các giao thức khác như UDP hay AppleTalk 

* X forwarding
X là một hệ thống window phổ biến đối với các trạm làm việc Unix, một trong những đặc điểm tốt nhất của nó là tính trong suốt. Sử dụng X bạn có thể chạy ứng dụng X từ xa để mở các cửa sổ của chúng trên màn hình hiển thị cục bộ của bạn

* Agent forwarding
SSH client có thể làm việc với một SSH agent trên cùng một máy. Sử dụng mọt đặc trưng gọi là agent forwarding, client cũng có thể liên lạc với các agent trên những máy từ xa. Điều thuận lợi là nó cho phép client trên nhiều máy làm việc với một agent và có thể tránh vấn đề liên quan đến tường lửa.

##2. Cài đặt và cấu hình SSH trên Ubuntu server
###2.1 Cài đặt
```sh
apt-get install ssh
```
###2.2 Cấu hình SSH
Các tập tin cấu hình của ssh đều nằm trong thư mục **/etc/ssh** .

Các file trong thư mục này là:

* **moduli:** Chứa một nhóm Diffie-Hellman được sử dụng cho việc trao đổi khóa Diffie-Hellman, nó thực sự quan trọng để xây dựng một lớp bảo mật ở tầng vận chuyển dữ liệu.Khi các khóa được trao đổi với nhau bắt đấu ở một phiên kết nối SSH, một share secret value được tạo ra và không thể xác định bởi một trong hai bên kết nối, giá trị này sau đó sẽ được dùng để cung cấp chứng thực cho host.

* **ssh_config:**  file cấu hình mặc định cho SSH client của hệ thống.

* **sshd_config:**  File cấu hình cho sshd deamon.

* **ssh_host_dsa_key:**  DSA private key được sử dụng với sshd deamon.

* **ssh_host_dsa_key.pub:**  DSA public key được sử dụng bởi sshd deamon.

* **ssh_host_key:**  RSA private key được sử dụng bởi sshd deamon cho phiên bản 1 của giao thức SSH.

* **ssh_host_key.pub:**  RSA public key được sử dụng bởi sshd deamon cho phiên bản 1 của giao thức SSH.

* **ssh_host_rsa_key:**  RSA private key được sử dụng bởi sshd deamon cho phiên bản 2 của giao thức SSH.

* **ssh_host_rsa_key.pub:**  RSA public key được sử dụng bởi sshd deamon cho phiên bản 2 của giao thức SSH.

* **ssh_host_ecdsa_key:** ECDSA private key.

* **ssh_host_ecdsa_key.pub:** ECDSA public key.


Cấu hình file **sshd_config**:
```sh
Port 22	//Đổi port ssh
ListenAddress 0.0.0.0	//Chỉ cho phép đăng nhập SSH từ một IP cố định
Protocol 2
# HostKeys for protocol version 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
#Privilege Separation is turned on for security
UsePrivilegeSeparation yes

# Lifetime and size of ephemeral version 1 server key
KeyRegenerationInterval 3600
ServerKeyBits 1024

# Logging
SyslogFacility AUTH
LogLevel INFO

# Authentication:
LoginGraceTime 120
PermitRootLogin without-password
StrictModes yes

RSAAuthentication yes	//xác thực bằng thuật toán rsa
PubkeyAuthentication yes	//xác thực khóa công khai
AuthorizedKeysFile	%h/.ssh/authorized_keys	//đường dẫn file authorized key (file chứa public-key)

# Don't read the user's ~/.rhosts and ~/.shosts files
IgnoreRhosts yes
# For this to work you will also need host keys in /etc/ssh_known_hosts
RhostsRSAAuthentication no
# similar for protocol version 2
HostbasedAuthentication no
# Uncomment if you don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication
#IgnoreUserKnownHosts yes

PermitEmptyPasswords no	/cho phép mật khẩu trống

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Change to no to disable tunnelled clear text passwords
PasswordAuthentication no	//cấu hình xác thực bằng mật khẩu hoặc key

UsePAM yes
AllowUsers user1 user2 user3 user4 user5	//các user truy cập ssh
```

###2.3 Cấu hình SSH chứng thực bằng khóa.
Khóa công khai (Public key) nằm ở server và Khóa bí mật (private key) nằm ở máy client.

####2.3.1 Tạo mã khóa công khai và bí mật trên server
* Cấu hình file **/etc/ssh/sshd_config** 
```sh
RSAAuthentication yes	//xác thực bằng thuật toán rsa
PubkeyAuthentication yes	//xác thực khóa công khai
AuthorizedKeysFile	%h/.ssh/authorized_keys	//đường dẫn file authorized key (file chứa public-key)
PasswordAuthentication no	//cấu hình xác thực bằng key
```
* Tạo khóa RSA bằng lệnh sau:
```sh
ssh-keygen -t rsa -b 1024
```
	Trong quá trình tạo khóa, bạn sẽ cấu hình đường dẫn chứa file key và mật khẩu bảo vệ cho file key.

	Thư mục mặc định chứa key là **~/.ssh**

	Khi tạo xong, ta có 2 file private key(id_rsa) và public key(id_rsa.pub) 

* Phân quyền cho thư mục .ssh và file  id_rsa.pub
```sh
chmod 700 /.ssh/
chmod 600 /id_rsa.pub
```
* Rename file id_rsa.pub thành file authorized_keys
	
	Hoặc sau khi tạo 2 mã bí mật và công khai **ở máy client**, bạn có thể đẩy khóa public-key sang server bằng cách:
	```sh
	ssh-copy-id -i <đường dẫn file public key> user@domain.com
	```

* Copy file **id_rsa** cho máy client 

####2.3.2 Tại máy client là linux
* Mở file **ssh_config** và thêm dòng này
```sh
IdentityFile ~/.ssh/id_rsa
```

* Vào thư mục ~/.ssh và paste file id_rsa ở trên, sau đó phân quyền cho nó.
```sh
chmod 600 id_rsa
```
* Tiến hành login
```sh
ssh user@domain.com
```

####2.3.3 Tại máy client là Window
* Sử dụng phần mềm putty_gen để tạo khóa private ppk từ file id_rsa ở trên.

	![](http://img.vinastar.net/up/images/7814.png)

	![](http://img.vinastar.net/up/images/9015.png)

* Sau khi có khóa, sử dụng phần mềm PuTTY để tiến hành đăng nhập

	![](http://img.vinastar.net/up/images/8916.jpg)
