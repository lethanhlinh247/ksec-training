#Command Edit file and folder
## Liệt kê tệp và thư mục
```sh
ls [options] <Path>
```
Options
* -a: liệt kê các file ẩn.
* -i: liệt kê inode
* -h: in ra kích thước dễ đọc
* -l: liệt kê mỗi mục trên một dòng
* -n: liệt kê cả UID và GID
* -p: hiển thị cả các ký hiệu mô tả (/, =, @) 
* -R: recursive để liệt kê cả những thư mục con
* -S: sắp xếp kết quả theo kích thước
* -t (-c): sắp xếp kết quả theo thời gian cập nhật
* -u: hiển thị thời gian của lần truy cập sau cùng

##Tạo và thay đổi tệp
```sh
touch [options] newfile.txt
```
Options
* -a: thay đổi thời gian truy cập file
* -m: thay đổi thời gian cập nhật file
* -r: lấy thuộc tính thời gian từ file khác

##Xóa tệp và thư mục
```sh
rm [options] file.txt
```
Options:
* -f: xóa không cần hỏi, ví dụ: rm -f data/toto
* -r, hoặc -R: xóa đệ quy (dùng để xóa thư mục)

##Sao chép tệp và thư mục
```sh
cp [OPTIONS] <nguồn1> <nguồn 2> ... <đích>
```
Options:
* -r, hoặc -R: đệ quy (dùng để copy cả thư mục)
* -d: bỏ qua các liên kết khi sử dụng –R
* -f: ép buộc phải làm (force)
* -I: hiện dấu nhắc khi ghi đè
* -p: duy trì thuộc tính file

##Di chuyển, đổi tên tệp và thư mục
```sh
mv [options] <OldName> <NewName>
mv [options] <Source> <Dest>
mv [options] <Source> <DestDir>
```
Options
* -f: ép buộc phải làm (force)
* -I: hiện dấu nhắc khi ghi đè

##Tạo thư mục mới
```sh
mkdir newfolder
```
##Tạo liên kết

Mục đích của links trên Linux là tạo ra nhiều tên hoặc alias cho file và thư mục.

Có 2 loại links: hard link và soft link (symbolic link)


* Hard link
	Nhằm tạo ra nhiều file hoặc thư mục có cùng sử dụng chung 1 inode.

	Do đó các files hoặc thư mục này phải cùng nằm chung trên 1 partition (chung bảng inode).

	Tuy nhiên, chúng ta không thể dùng lệnh để tạo thêm hard link cho thư mục!
```sh
$ ln oravn.txt hrdoravn.txt
```
* Soft link
	Nhằm tạo alias tới tên file hiện có, gần giống như shortcut trên MS Windows. Do đó bạn có thể link tới bất kỳ file nào trên cây thư mục.

	Điểm khác nhau cơ bản giữa softlink và shortcut chính là trong softlink tới thư mục bạn có thể “nhảy” vào đó đứng được, hay nói cách khác là có thể cd vào “thư mục” link được.

	Lưu ý khi tạo softlink, bạn nên ghi đường dẫn tuyệt đối cho tên source-file. Điều này sẽ giúp bạn khi bị lổi khi di chuyển file hoặc link đi nới khác.
```sh
ln [-s] filename linkname
```

##Nhóm lệnh tìm kiếm
```sh
 find <Thư mục> <Criteria> [-exec <CMD> {} \;]
```
Ví dụ: 
```sh
find /usr -name pgsql
```
Tìm file “pgsql” bắt đầu từ thư mục /usr

Ví dụ: 
```sh
find /home -user 501
```
Tìm tất cả các file của chủ sở hữu là người dùng có số hiệu UID là 501 bắt đầu từ thư mục /home

Ví dụ:
```sh
find /home/user1 –name log.txt –exec rm {} \;
```
Tìm tất cả các file tên log.txt bắt đầu từ thư mục /home/user1 và xóa các file này

