##1. Phân quyền trong Linux

Trong Linux, khi nói đến phân quyền là chúng ta sẽ nghĩ ngay đến 3 quyền hạn cơ bản của một user/group nào đó trên một file/folder nào đó bao gồm:

* r (read)(4) – quyền đọc file/folder.
* w (write)(2) – quyền ghi/sửa nội dung file/folder
* x (execute)(1) – quyền thực thi (truy cập) thư mục. Đối với thư mục thì bạn cần phải có quyền execute thì mới dùng lệnh cd để truy cập vào được
	
```sh
total 5068
-rw-r--r--  1 root root      811 Nov 25 20:14 group.txt
drwxr-xr-x 11  501 staff    4096 Nov 22 23:34 httpd-2.4.17
-rw-r--r--  1 root root  5157721 Oct 12 10:42 httpd-2.4.17.tar.bz2
-rw-r--r--  1 root root     1213 Nov 25 19:38 ifconfig.txt
-rw-r--r--  1 root root       25 Nov 23 06:29 linh.txt
-rw-rw-r--  1 adk  adk        11 Nov 25 05:39 test
```
```sh
-rw-r--r--
```
**-**: thư mục hay là tệp tin, nếu bắt đầu là **d**: thư mục; **-**: tệp tin.

**rw-**: quyền dành cho user sở hữu nó.

**r--**: quyền dành cho CÁC user thuộc group đang sở hữu nó.

**r--**: quyền dành cho MỌI user khác.

Nếu một đối tượng mà có đủ 3 quyền, thì bạn cứ lấy cả 3 cộng lại là  4 + 2 + 1 = 7, vậy quyền số 7 nghĩa là nó được phép đọc, sửa và thực thi file.

##2. Quyền mặc định (Default Permissions)
* Khi một file hay một thư mục được tạo ra thì các quyền hạn truy cập đối với chúng là (read, write, execute) cho các chủ thể (owner, group, other) sẽ được xác định dựa trên hai giá trị là quyền truy nhập cơ sở (base permission) và mặt nạ (mask).

* Base Permission là giá trị được thiết lập sẵn từ trước, và ta không thể thay đổi được
	* đối với file thông thường giá trị base perm là 666 (rw-rw-rw-)
	* đối với thư mục (file đặc biệt) giá trị base perm là 777 (rwxrwxrwx)

* Mask là giá trị đựợc thiết lập bởi người dùng bằng lệnh umask	
	Giá trị Mask sẽ “che đi” một số bit trong Base Permission để tạo ra quyền truy cập chính thức cho file.

* Quyền truy cập chính thức được tính bằng cách lấy: “giá trị nhị phân của Base permission ”AND“ dạng biểu diễn bù 1 của mask”. Dạng bù của 1 tức là chuyển 1->0, 0->1. Ở đây ta chuyển mask sang dạng bù của 1, rồi thực hiện phép toán AND với Base permission.

* Ví dụ:

	Vì Base Permission của file bất kỳ luôn là 666 (110110110), nên nếu giá trị mask là 022 (000010010 => dạng bù 1 là: 111101101) thì quyền truy nhập chính thức của file sẽ là:

    110 110 110 AND 111 101 101 = 110 100 100 = 644 (rw-r–r–)
	
* Giá trị mask mặc định của user thường là 002 =>quyền hạn truy cập mặc định cho thư mục là **775** và file là **664**
* Giá trị mask mặc định của root thường là 022 =>quyền hạn truy cập mặc định cho thư mục là **755** và file là **644**
* Thay đổi mask
	* Để xem giá trị mặc định của mask, ta sử dụng lệnh umask
	* Để thay đổi giá trị mặc định của mask, ta sử dụng lệnh umask giá trị.
	ví dụ: 
	```sh
	umask 022
	```
	* Ngoài ra, ta có thể thiết lập giá trị umask cho tất cả người dùng ở  **/etc/bashrc** hoặc **/etc/profile** tùy từng hệ thống. Trong ubuntu, đó là file **/etc/login.defs**
	
##3. Thay đổi phân quyền
Để phân lại quyền cho cả file/folder trên Linux thì bạn sẽ sử dụng lệnh tên là chmod. Cấu trúc sử dụng lệnh này là:
```sh
chmod [tùy chọn] [biểu diễn phân quyền] [tên file hoặc thư mục]
```
Mục [tùy chọn] là không bắt buộc, bao gồm các tùy chọn sau:

    v: hiển thị báo cáo sau khi chạy lệnh. Nếu bạn chmod nhiều file/folder cùng lúc thì cứ mỗi lần nó đổi quyền của 1 file/folder xong là sẽ hiện báo cáo.
    
	c: giống như trên, nhưng chỉ hiện khi nó đã làm xong tất cả.
    
	f: Hiểu ngắn gọn là kiểu “kệ mẹ nó”, nếu có lỗi xảy ra nó cũng không thông báo.
    
	R: nếu bạn CHMOD một folder thì kèm theo -R nghĩa là áp dụng luôn vào các file/folder nằm bên trong nó.
    
	--help: hiển thị thông báo trợ giúp.
	
Ở phần [biểu diễn phân quyền], ban có thể biểu diễn bằng 3 kiểu:

    kiểu ký tự: giống như ở trên (rw-rw-x–).
    kiểu ugo: kiểu này sẽ phân quyền cho từng đối tượng phân quyền.
    kiểu số: cũng giống như ở trên (644).
Ví dụ:
```sh
	chmod 775 testfile
	chmod 400 testfolder
	chmod u+w testfolder 
```
Một vài ví dụ thêm về kiểu ugo:
```sh
	u+w: cho phép user sở hữu có quyền đọc
    g+rw: cho phép group sở hữu có quyền đọc và ghi
    o+rwx: cho phép các user khác có full quyền
    a+rwx: cho phép toàn bộ user có full quyền (777)
```
##4. Thay chủ sở hữu file/folder
Mặc định các file và folder sẽ được sở hữu bởi user/group tạo ra nó.

Để đổi chủ sở hữu một thư mục cho user/group nào đó thì bạn sẽ sử dụng lệnh chown như sau:
```sh
chown -R [tên user]:[tên group] [file/folder]
```
Ví dụ:
```sh
chown -R thach2:thach2 /home/thach1
```
##5. Sticky bit 
* **Đối với file/tập tin:** sticky bit thường chỉ được dùng với các thực thi và thường thì chỉ có root hoặc các user có quyền hạn cao mới được bật hay tắt sticky bit cho file.
 Khi một file thực thi có sticky bit được bật, file này sẽ được nạp vào swap-space (không gian swap) của Unix để có thể chạy nhanh. 
 Các chương trình như vi, vim, pico, pine thường được bật sticky bit vì người dùng thường sử dụng các chương trình này thường xuyên!

* ** Đối với thư mục/đường dẫn:** khi một thư mục được bật sticky bit thì các user có thể đọc hoặc viết vào các file trong thư mục đó.
 Tuy nhiên, user không thể đổi tên hoặc xóa các file/thư mục con trong đó mà không thuộc quyền sở hữu của user đó. Họ chỉ có thể xóa hoặc đổi tên các file do họ tạo ra mà thôi. 
 Chỉ có chủ sở hữu thư mục cha, chủ sở hữu file/thư mục con, hay root là có quyền xoá/đổi tên chúng. 

* Mặc định Sticky bit được bật sẵn trên thư mục tmp, được biểu diễn bằng chữ t trong phần permission. "drwxrwxrw**t**"
```sh
drwxrwxrwt 10 root root 4096 Dec  4 21:51 /tmp
```

* Thêm quyền sticky bit cho thư mục, tệp tin:
```sh
chmod o+t /tenthumuc
hoặc 
chmod 1750 /tenthumuc 
```
* Xóa quyền sticky bit cho thư mục, tệp tin:
```sh
chmod o-t /tenthumuc
```

##6.  SUID (Set owner User ID up on execution): 

* Chúng ta thường kích hoạt SUID bit trên các executable scripts.
* Khi SUID bit được kích hoạt trên file, bất cứ user nào có quyền thực thi file này đều có khả năng chạy file ấy với tư cách của owner file đó.
* Đây chính là lý giải cho việc tại sao 1 user bình thường có khả năng thay đổi password cho chính mình.
* Được ký hiệu bằng chừ s trong phần permission
```sh
-rwsrwsrwx  1 adk  adk         5 Dec  4 23:52 kaka.txt
```
* Thêm quyền SUID cho file
```sh
chmod u+s file
hoặc
chmod 4750 file
```
* Xóa SUID cho file
```sh
chmod u-s file
```
##7. SGID (Set Group ID up on execution):
* SGID hoạt động giống như SUID, chỉ khác là, SGID thực thi trên 1 nhóm các user cùng group.
* Thêm quyền SGID
```sh
chmod g+s file
hoặc
chmod 2750 file
```
* Xóa quyền SGID
```sh
chmod g-s file
```