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

##2. Thay đổi phân quyền
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
	chmod u+s testfolder 
```
Một vài ví dụ thêm về kiểu ugo:
```sh
    o+rws: cho phép user sở hữu có full quyền
    g+rw: cho phép group sở hữu có quyền đọc và ghi
    u+w: cho phép các user còn lại có quyền đọc
    a+rws: cho phép toàn bộ user có full quyền (777)
```
##3. Thay chủ sở hữu file/folder
Mặc định các file và folder sẽ được sở hữu bởi user/group tạo ra nó.

Để đổi chủ sở hữu một thư mục cho user/group nào đó thì bạn sẽ sử dụng lệnh chown như sau:
```sh
chown -R [tên user]:[tên group] [file/folder]
```
Ví dụ:
```sh
chown -R thach2:thach2 /home/thach1
```
