#User - Group
##1.User

User là người có thể truy cập đến hệ thống.

User có username và password.

Có hai loại user: super user và regular user.

Mỗi user còn có một định danh riêng gọi là UID.

Định danh của người dùng bình thường sử dụng giá trị bắt đầu từ 500.

##2.Group

Group là tập hợp nhiều user lại.

Mỗi user luôn là thành viên của một group.

Khi tạo một user thì mặc định một group được tạo ra.

Mỗi group còn có một định danh riêng gọi là GID.

Định danh của group thường sử dụng giá trị bắt đầu từ 500.

##3.Tập lệnh quản lý User và Group
* Tạo user
```sh
#useradd [option] <username>
```
Các option:
```sh
-c: comment: Soạn thảo thông tin người dùng.
-d: home_dir: Tạo thư mục cá nhân của người dùng.
-D: Lệnh useradd sẽ bỏ qua các giá trị mặc định và cập nhật các giá trị mới. Nếu không có tuỳ chọn –D, lệnh useradd sẽ tạo
một tài khoản người dùng mới sử dụng các giá trị được chỉ ra trên dòng lệnh và các giá trị mặc định của hệ thống. Tài khoản người dùng mới sẽ được nhập vào trong các file hệ thống, thư mục cá nhân sẽ được tạo, hay các file khởi tạo được sao chép,
điều này còn tùy thuộc vào tùy chọn đưa ra.
-m: Tạo thư mục cá nhân nếu chưa tồn tại.
-M: Không tạo thư mục người dùng.
-g: initial_group: Xác định tên, hoặc số của nhóm người người dùng. Tên nhóm và số phải tham chiếu đến nhóm tồn tại.
-G: group: Danh sách các nhóm phụ, mà người dùng cũng là thành viên của nhóm đó. Các nhóm được ngăn cách bằng dấu ","
-e: expire_day (YYYY-MM-DD): Thiết đặt thời gian tài khoản người dùng sẽ bị hủy bỏ.
-f: inactive days: thời điểm hết hiệu lực của mật khẩu đăng nhập khi tài khoản người dùng bị xóa bỏ. Nếu = 0, hủy bỏ tài
 khoản ngay sau khi mật khẩu hết hiệu lực. Nếu = -1 thì ngược lại. Mặc định = -1.
-n: Mặc định khi thêm người dùng, một nhóm cùng tên với người dùng được tạo ra. Tùy chọn này sẽ hủy bỏ điều đó.
-p: Password: Tạo mật khẩu cho người dùng.
-s: shell: Thiết lập thư mục shell cho người dùng.
-u: uid: Thiết đặt chỉ số người dùng, giá trị này là duy nhất.
```
Ví dụ:
```sh
#useradd –c “Nguyen Van A – Server Admin” –g serveradmin vana
```
* Thay đổi thông tin cá nhân:
```sh
#usermod [option] <username>
```
Option tương tự lệnh useradd.

	Ví dụ: Chuyển vana từ nhóm cũ sang nhóm kinh doanh.
```sh
#usermod –g kinhdoanh vana  
```
* Xóa người dùng
```sh
userdel [option] <username>
```
Tùy chọn:

	* -r: các file tồn tại trong thư mục riêng của người dùng, cũng như các file nằm trong các thư mục khác có liên quan đến người dùng sẽ bị xóa bỏ cùng lúc với thư mục của người dùng.

* Khóa/Mở khóa người dùng
```sh
passwd –l <username>  /  passwd –u <username>
usermod –L <username> /  usermod –U <username>
```
Trong /etc/shadow có thể khóa tài khoản bằng cách thay từ khóa x bằng từ khóa *.

* Tạo nhóm:
```sh
#groupadd [option] <groupname>
```
Tùy chọn: 
	* -g: gid: chỉ số nhóm người dùng, chỉ số này là duy nhất.
	* -r: Tùy chọn này được dùng khi thêm tài khoản hệ thống.
	* -f: Tùy chọn này bỏ qua việc nhắc nhở, nếu nhóm người dùng đã tồn tại, sẽ thực hiện ghi đè.
* Sửa đổi thuộc tính nhóm
```sh
#groupmod [option] <tên-nhóm>
```
	* -g: gid: Thay đổi giá trị chỉ số nhóm người dùng.
	* -n: name: Thay đổi tên nhóm người dùng.
* Đặt mật khẩu nhóm
```sh
gpasswd [<ten>]
```
* Xóa nhóm
```sh
groupdel <groupname>
```
* Xem thông tin về User và Group
```sh
#id <option> <username>
#groups <username>
```
* Khi sử dụng lệnh useradd hoặc groupadd để thêm mối một user hay một group, nếu chúng chúng ta không liệt kê đầy đủ các thông số tức các tùy chọn kèm theo cần thiết thì hệ thống sẽ lấy theo giá tri mặc định đã được định nghĩa.

* Chúng ta có thể thay đổi định nghĩa những giá trị này trong file sau:

	* /etc/login.defs : file chứa thông số mặc định khi tạo user hoặc tạo group.
	* /etc/skel/ : Tất cả những file và thư mục thuộc thư mục này sẽ được copy sang HOME của user ngay khi mới vừa được tạo mặc định là rỗng.

##4.Những file liên quan đến User và Group
* Thông tin về user
```sh
#/etc/passwd
```
Mỗi một dòng trong tập tin là thông tin tương ứng cho một user trong hệ thống.
Một trường có tất cả 7 phần thông tin mỗi phần ngăn cách nhau bởi dấu **“:”**.
```sh
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-timesync:x:100:103:systemd Time Synchronization,,,:/run/systemd:/bin/false
systemd-network:x:101:104:systemd Network Management,,,:/run/systemd/netif:/bin/false
systemd-resolve:x:102:105:systemd Resolver,,,:/run/systemd/resolve:/bin/false
systemd-bus-proxy:x:103:106:systemd Bus Proxy,,,:/run/systemd:/bin/false
syslog:x:104:109::/home/syslog:/bin/false
messagebus:x:105:110::/var/run/dbus:/bin/false
uuidd:x:106:111::/run/uuidd:/bin/false
adk:x:1000:1000:cosy,,,:/home/adk:/bin/bash
sshd:x:107:65534::/var/run/sshd:/usr/sbin/nologin
mysql:x:108:117:MySQL Server,,,:/nonexistent:/bin/false
linh:x:1001:1001:no_hat,1,0123456789,01234567891,no:/home/linh:/bin/bash
```
* Ý nghĩa của 7 phần: 
![](http://i.imgur.com/4J99Hjg.png)
	* 1: Username: Tên người dùng, được sử dụng khi user đăng nhập.
	* 2: Password: ký tự đại diện ở đây là x, bởi vì mật khẩu đã được mã hóa.
	* 3: User ID (UID): Đây là 1 chuỗi số duy nhất được gán cho user, hệ thống sử dụng UID hơn là username để nhận dạng user.
	* 4: Group ID (GID): Là 1 chuỗi số duy nhất được gán cho Group đầu tiên mà user này tham gia (thông tin các Group có trong file /etc/group)
	* 5: User ID Info (còn gọi là GECOS): Trường này khai báo các thông tin cá nhân về user như: tên đầy đủ, số điện thoại… Lệnh finger sẽ cung cấp thêm những thông tin phụ này.
	* 6: Home directory: Là đường dẫn đầy đủ tới thư mục sẽ làm thư mục chủ cho user, mặc định đây sẽ là thư mục hiện hành (working direcroty) khi user đăng nhập. Nếu bạn chỉ đến 1 thư mục không tồn tại thì hệ thống sẽ tự gán là thư mục gốc (/) làm thư mục chủ.
	* 7: Shell: Đường dẫn đầy đủ tới login shell. Nếu để trống trường này thì login shell mặc định là file /bin/sh, nếu chỉ tới 1 file không tồn tại thì user không thể đăng nhập vào hệ thống từ giao diện console hoặc qua SSH bằng lệnh login. Nhưng user vẫn có thể đăng nhập thông qua giao diện đồ họa bằng cách sử dụng non-login shell.

* Thông tin về group
```sh
#/etc/group
```
Mỗi dòng trong tập tin gồm có 4 trường, được phân cách bởi dấu hai chấm.
```sh
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,adk
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:
fax:x:21:
voice:x:22:
cdrom:x:24:adk
floppy:x:25:
tape:x:26:
sudo:x:27:adk
audio:x:29:
dip:x:30:adk
www-data:x:33:
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
gnats:x:41:
shadow:x:42:
utmp:x:43:
video:x:44:
sasl:x:45:
plugdev:x:46:adk
staff:x:50:
games:x:60:
users:x:100:
nogroup:x:65534:
input:x:101:
systemd-journal:x:102:
systemd-timesync:x:103:
systemd-network:x:104:
systemd-resolve:x:105:
systemd-bus-proxy:x:106:
netdev:x:107:
crontab:x:108:
syslog:x:109:
messagebus:x:110:
uuidd:x:111:
mlocate:x:112:
ssh:x:113:
adk:x:1000:
lpadmin:x:114:adk
sambashare:x:115:adk
ssl-cert:x:116:
mysql:x:117:
linh:x:1001:
group1:x:1002:linh
```
* Ý nghĩa của 4 trường
![](http://i.imgur.com/uGSKQju.png)
	* 1: Group name: Tên nhóm người dùng
	* 2: Password : Mật khẩu nhóm người dùng (password – được mã hóa). Trong trường hợp dùng file /etc/gshadow thì ký hiệu là x. Thông thường nhóm khi tạp ra không có password
	* 3: Group ID: Chỉ số định danh cho nhóm
	* 4: User list: Danh sách các người dùng thuộc nhóm đó
	
* Thông tin về mật khẩu
```sh
#/etc/shadow
```
Lưu mật khẩu đã được mã hóa và chỉ có user root mới được quyền đọc.
```sh
root:!:16762:0:99999:7:::
daemon:*:16729:0:99999:7:::
bin:*:16729:0:99999:7:::
sys:*:16729:0:99999:7:::
sync:*:16729:0:99999:7:::
games:*:16729:0:99999:7:::
man:*:16729:0:99999:7:::
lp:*:16729:0:99999:7:::
mail:*:16729:0:99999:7:::
news:*:16729:0:99999:7:::
uucp:*:16729:0:99999:7:::
proxy:*:16729:0:99999:7:::
www-data:*:16729:0:99999:7:::
backup:*:16729:0:99999:7:::
list:*:16729:0:99999:7:::
irc:*:16729:0:99999:7:::
gnats:*:16729:0:99999:7:::
nobody:*:16729:0:99999:7:::
systemd-timesync:*:16729:0:99999:7:::
systemd-network:*:16729:0:99999:7:::
systemd-resolve:*:16729:0:99999:7:::
systemd-bus-proxy:*:16729:0:99999:7:::
syslog:*:16729:0:99999:7:::
messagebus:*:16762:0:99999:7:::
uuidd:*:16762:0:99999:7:::
adk:$1$JTKxG98j$wy37x9oLFdhpQcbHCFhfP/:16762:0:99999:7:::
sshd:*:16762:0:99999:7:::
mysql:!:16762:0:99999:7:::
linh:!$6$NLtZWYHr$6o1M1UkkyuTS0yO1m4hXBL1xQkobM6Rj9ed0walzrcqLxnVIhLQ4xHTGenMvY97fUzGA/a2mYWiTVoFKnprim.:16764:0:99999:7:::
```
* Ý nghĩa của 9 trường
![](http://i.imgur.com/EAoAJoo.png)
    * 1: User name: tên đăng nhập của người dùng
    * 2: Password: mật khẩu người dùng đã được mã hóa một chiều
    * 3: Last password change: thời gian lần cuối thay đổi mật khẩu. Được biểu diễn dưới dạng số. Giá trị của nó là số ngày, được tính từ ngày 01/01/1970, đến ngày thay đổi mật khẩu.
		Ví dụ hôm nay, ngày 05/12/2015, số ngày là: 16775.
		Ta thấy 16775 - 16764 = 11. => Ngày lần cuối ta thay đổi password là 24/11/2015.
    * 4: Minimum: số ngày tổi thiểu yêu cầu giữa các lần thay đổi mật khẩu
    * 5: Maximum: số ngày tối đa xác định tính hợp lệ của mật khẩu sau khi thay đổi mật khẩu
    * 6: Warn: quy định số ngày trước khi mật khẩu hết hạn sẽ cảnh báo người dùng
    * 7: Inactive: số ngày đã bị khóa tài khoản
    * 8: Expire: quy định ngày cụ thể hết hạn
    * 9: Flag: Failed login count in low order four bits; remainder reserved for future use, set to zero. (Dành 4 bit để đếm số lần đăng nhập thất bại, còn lại dùng để cho tương lai, đặt = 0).

##4. Mật khẩu trong linux
* Trong Linux, file /etc/passwd là file lưu thông tin user của hệ thống, khi tạo một user mới thì linux sẽ add thêm 1 bản ghi mới vào file này.
File này có 1 đặc điểm là tất cả người dùng trong hệ thống đều có thể đọc được (‘r’). Thuộc tính ‘r’ là cần thiết vì một số ứng dụng và tool hệ thống cần đọc file này thì mới chạy chính xác.

* Nếu để password lưu trữ trong /etc/passwd thì cũng rất nguy hiểm, vì tất cả user trong hệ thống đều đọc được.
Vì vậy, cần lưu trữ password người dùng trong 1 file mà chỉ ‘root’ mới đọc được. Giải pháp mà Linux đưa ra là bổ sung 1 file tên là /etc/shadow để lưu trữ mật khẩu người dùng.
File /etc/shadow này chỉ truy cập được bởi ‘root’.
```sh
linh:!$6$NLtZWYHr$6o1M1UkkyuTS0yO1m4hXBL1xQkobM6Rj9ed0walzrcqLxnVIhLQ4xHTGenMvY97fUzGA/a2mYWiTVoFKnprim.:16764:0:99999:7:::
```
Ở ví dụ trên,trong file /etc/shadow mật khẩu của user linh đã được mã hóa.
![](http://i.imgur.com/ORDnicE.png)
	* 1: Cho biết thuật toán mã hóa. Ở đây sử dụng SHA-512.
```sh
 $1 = MD5 hashing algorithm.
 $2 = Blowfish Algorithm is in use.
 $2a = eksblowfish Algorithm
 $5 = SHA-256 Algorithm
 $6 = SHA-512 Algorithm
```
	* 2: là một chuỗi dữ liệu ngẫu nhiên(salt) được sinh ra để kết hợp với mật khẩu người dùng(password), để tăng sức mạnh mã hóa.
	* 3: là giá trị băm của salt + password.

* Khi login vào hệ thống, bạn nhập user/password. Hệ thống sẽ sử dụng giá trị salt của user + password mà bạn nhập vào để tạo ra 1 chuỗi mã hóa. Nếu chuỗi mã hóa này trùng với chuỗi mã hóa trong file /etc/shadow thì user login thành công.
* Tại sao mật khẩu được kết hợp với salt, sau đó sử dùng thuật toán mã hóa 1 chiều vẫn có thể bị hack bằng phương pháp brute force?

	Bởi vì:
	* Brute Force: Là phương pháp thử lần lượt các mật khẩu, có thể thêm tên đăng nhập, để có thể đăng nhập thành công vào hệ thống.
	* Mật khẩu dù có mã hóa như thế nào, nhưng nếu đặt mật khẩu đơn giản, dễ đoán thì có thể brute force dễ dàng.
  
