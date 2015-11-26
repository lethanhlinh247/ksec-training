#Command Edit file and folder
##New file
```sh
touch newfile.txt
```
##Delete file and folder
```sh
rm file.txt
```
##Copy file and folder
```sh
cp /file.txt /home/adk/
```
##Move, rename file and folder
```sh
mv /file.txt /filenew.txt
```
##New folder
```sh
mkdir newfolder
```
##Tạo Links

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