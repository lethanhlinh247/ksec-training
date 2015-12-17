#Cài đặt phần mềm trên Linux
##1. Phần mềm trên Linux được phân phối theo các nguồn sau:
* Trong bộ đĩa cài đặt.
* Trên trang web của nhà sản xuất.
* Trên các Repository, là nơi chứa phần mềm tập trung trên mạng, dành riêng cho từng hệ thống.
* Các gói cài đặt phần mềm phân phối dưới dạng mã nguồn, người dùng phải tự biên dịch rồi cài đặt;
hoặc các định dạng phân phối riêng như là .RPM và .DEB
	* RPM (Redhat Package Manager) và DEB(Debian Software Package) là hai định dạng phần mềm trên Redhat(Fedora,openSuse,centOS...) và Debian (Ubuntu,Debian,...).
	* RPM và DEB thực chất là các file nén chứa tất cả những file chạy, cấu hình, thông tin của phần mềm.
	* Hệ điều hành sẽ có phần mềm chuyên dụng để cài đặt các gói phần mềm này.

##2. Cài đặt phần mềm
* Sử dụng apt/yum để cài đặt phần mềm từ các kho trên mạng.
* Cài đặt trực tiếp từ gói phần mềm dưới định dạng RPM và DEB.
* biên dịch từ mã nguồn.

##3. Cài đặt phần mềm trên Debian
###3.1 Sử dụng APT
APT - Advanced Packaging Tool: Là một công cụ quản lý các gói phần mềm trong Ubuntu.
* Tìm kiếm gói phần mềm
```sh
apt-cache search tenphanmem
```
* Thêm các kho phần mềm. PPA là phương pháp chia sẻ phần mềm do một user nào đó đóng gói thành file deb và chia sẻ trên trang launchpad.com. Sau khi add PPA này vào, người dùng có thể cài đặt phần mềm mà PPA ấy cung cấp qua APT.
```sh
sudo add-apt-repository [repository name here] 
```
* Xóa các kho phần mềm
```sh
sudo add-apt-repository –remove ppa:someppa/ppa
```
* Cài đặt các gói phần mềm
```sh
apt-get install phanmem1 phanmem2
```
* Gỡ bỏ gói phần mềm, sẽ giữ lại những tập tin cấu hình, những thư mục liên quan đến phần mềm.
```sh
apt-get remove phanmem1 phanmem2
```
* Gỡ bỏ sạch sẽ phần mềm
```sh
sudo apt-get remove –purge [package name 1] [package name 2] … [package name n]
```
* Nâng cấp gói phần mềm
```sh
sudo apt-get upgrade
```

###3.2 Cài đặt trực tiếp từ gói phần mềm với định dạng .DEB

* **dpkg -i {.deb package}**: Cài đặt gói hoặc nâng cấp nếu đã cài rồi. Ví dụ: dpkg -i zip_2.31-3_i386.deb
* **dpkg -R {Directory-name}**: Cài đặt toàn bộ các gói trong thư mục. Ví dụ dpkg -R /tmp/downloads
* **dpkg -r {package}**: Gỡ bỏ gói trừ các file cấu hình. Ví dụ: dpkg -r zip
* **dpkg -P {package}**: Gỡ bỏ gói kể các các file cấu hình. Ví dụ: dpkg -P apache-perl
* **dpkg -l**: Liệt kê các gói đã cài đặt, phiên bản và mô tả ngắn. Ví dụ: dpkg -l, dpkg -l | less
* **dpkg -l {package}**: Liệt kê các gói riêng đã cài đặt, phiên bản và mô tả ngắn 	dpkg -l apache-perl
* **dpkg -L {package}**: Liệt kê các file đã cài đặt. Ví dụ: dpkg -L apache-perl
* **dpkg -c {.Deb package}**: Liệt kê những file bên trong gói .deb. Ví dụ: dpkg -c dc_1.06-19_i386.deb
* **dpkg -S {/path/to/file}**: Tìm gói mà file phụ thuộc. Ví dụ: dpkg -S /bin/netstat
* **dpkg -p {package}**: Mô tả chi tiết gói: nhóm, phiên bản, bảo trì, cấu trúc, các gói phụ thuộc, mô tả,…Ví dụ: dpkg -p lsof
* **dpkg -s {package} | grep Status**: Tìm xem gói đã được cài hay chưa. Ví dụ: dpkg -s lsof | grep Status



##4. Cài đặt phần mềm Redhat
###4.1 Sử dụng YUM
* Một tiện ích khác được cộng đồng Redhat phát triển riêng, nó cũng tương tự như tiện ích RPM mục đích và ưu điểm giúp người dùng cài đặt phần mềm dễ dàng hơn.
* Tuy nhiên ở yum có sự khác biệt đó là nó tự động xác định được các gói phụ thuộc và tự động cài đặt các gói phụ thuộc đó trước khi cài đặt gói chính.
* Yêu cầu của phương pháp này là bạn phải có internet.
* Câu lệnh
```sh
yum option tenphanmem
```
option:
	* install: Cài đặt phần mềm.
	* remove: Gỡ bỏ gói phần mềm.
	* search: Tìm một phần mềm.
	* info: Hiển thị thông tin phần mềm.

```sh
yum list installed
```
Liệt kê tất cả các phần mềm đã cài đặt.
```sh
yum update
```
update các gói phần mềm.
```sh
yum list update
yum check-update
```
Hiển thị danh sách các gói phần mềm có bản update.
```sh
yum extras
```
Hiển thị các gói phần mềm ko thể cài đặt

###4.2 Cài đặt trực tiếp từ gói phần mềm với định dạng .RPM
RedHat Package Manager (RPM): cung cấp cho người dùng cài đặt, xóa hoặc nâng cấp các package trực tiếp bằng lệnh
RPM có một cơ sở dữ liệu chứa các thông tin của các package đã cài đặt và các tập tin của chúng, nhờ vậy RPM cho phép bạn truy vấn các thông tin, cùng như xác thực các package trong hệ thống. Nếu bạn sử dụng XWindow, có thể dùng chương trình KDE-PRM hoặc Gnome-RPM thay cho việc sử dụng lệnh. Nhược điểm của RPM là không tự động xác định các gói phụ thuộc.

Cấu trúc của một RPM Package như sau:
![](http://tuhocmang.com/wp-content/uploads/2014/08/rpm_0.png)
* Câu lệnh
```sh
rpm [option] package.rpm
```
Các tùy chọn
	* –i:  (install) cài đặt một package
	* –v: (verbose) hiện thị tóm tắt kết quả sau khi cài đặt package
	* –h: (hash) hiện thị dấu “#” thông báo quá trình cài đặt đang tiếp diễn
	* —nodeps: lệnh rpm sẽ bỏ qua các gói phụ thuộc
	* —force: lệnh rpm sẽ bỏ qua lỗi xung đột
	* –q: (packagefile) hiện thị package
	* –a: (all) truy vấn tất cả các package đã được cài đặt
	* –d: (documentation) liệt kê các files tài liệu liên quan đến package
	* –i:  (information) liệt kệ các thông tin như package name, description, release number, và các thông tin khác
	* –c: (configuration) liệt kê các tập tin cấu hình của package
	* -e: gỡ bỏ package.

##5. Biên dịch phần mềm
* Phương pháp này không phụ thuộc bạn dùng distro nào miễn là dùng Linux là điều có thể dùng phương pháp này.
* Bước đầu tiên khi muốn thực hiện phương pháp cài đặt này là bạn phải có file source của nó(có định dạng thường là file nén tag.gz. tar.bz2,..).
* Sau khi down file source về bạn tiến hành giải nén nó ra, sau đó bay vào trong thư mục giải nén thực hiện quá trình đầu tiên là check thư viện và các config file. Lỗi 98% thường xuất hiện tại bước này, vì cũng giống như RPM biên dịch phần mềm cũng cần phải đầy đủ thư viện thì mới có thể biên dịch được. Và bước này cũng chiếm nhiều thời gian nhất trong 3 bước cài đặt, qua được bước này 2 bước kia coi như là hoàn tất.
* Một đặc điểm chung nữa là cả Yum và RPM điều cài đặt những gói nhị phân. Nói một cách dễ hiểu, cài đặt gói nhị phân như RPM hay Yum thì nhượt điểm đó là bạn không thể tự mình điều khiển được những gì muốn cài vào hệ thống mà gần như mặc định là cài tất cả. Nhưng 1 trong 3 nguyên tắc trong bảo mật hệ thống “những gì không dùng nên xóa hoặc tắt bỏ”, mục đích của nguyên tắc này là giảm thiểu rủi ro một cách tối ưu nhất có thể cho hệ thống phát sinh từ những thành phần hay module trong phần mềm. Với yêu cầu này thì phương pháp biên dịch phần mềm có thể giúp bạn giải quyết được, bạn có thể tùy chỉnh cài đặt những thành phần nào vào hệ thống ở bước đầu tiên.
* Bên cạnh đó, việc sử dụng phương pháp biên dịch bạn có thể tối ưu hóa tài nguyên hệ thống, Mặt khác, đối với kiến thức trong tương lai, biên dịch có thể cho bạn những kiến thức cơ bản đầu tiên về biên dịch kernel trên Linux và đích cuối cùng chính là tự mình biên dịch một distro linux cho riêng mình.
* Mỗi một phần mềm thường có hướng dẫn biên dịch. Thường nằm ở file readme.

##6. update - upgrade - dist-upgrade
* **update:** Cập nhật danh sách các gói, phiên bản sẵn có của phần mềm. Và nó không cài đặt hay nâng cấp gói phần mềm nào cả.
* **upgrade:** Được sử dụng để cập nhật các phiên bản mới hớn của các gói phần mềm đã được cài đặt trên hệ thống.
Phải sử dụng lệnh update để kiểm tra trước khi tiến hành nâng cấp.
* **dist-upgrade:** Nó bổ sung cho cậu lệnh upgrade. Nó thông minh hơn trong việc xử lý các gói phụ thuộc với phiên bản mới.
Nó sẽ cố gắng nâng cấp các gói quan trọng nhất. Và nó có thể xóa bỏ một vài gói.
