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
-c “Thông tin người dùng”
-d <Thư mục cá nhân>
-m : Tạo thư mục cá nhân nếu chưa tồn tại
-g <nhóm của người dùng>
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
* Khóa/Mở khóa người dùng
```sh
passwd –l <username>  /  passwd –u <username>
usermod –L <username> /  usermod –U <username>
```
Trong /etc/shadow có thể khóa tài khoản bằng cách thay từ khóa x bằng từ khóa *.

* Tạo nhóm:
```sh
#groupadd <groupname>
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
##4.Những file liên quan đến User và Group
* Thông tin về user
```sh
#/etc/passwd
```
Mỗi dòng trong tập tin gồm có 7 trường, được phân cách bởi dấu hai chấm.
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