# MYSQL
MySQL là hệ quản trị cơ sở dữ liệu tự do nguồn mở phổ biến nhất thế giới và được các nhà phát triển rất ưa chuộng trong quá trình phát triển ứng dụng.

Vì MySQL là cơ sở dữ liệu tốc độ cao, ổn định và dễ sử dụng, có tính khả chuyển, hoạt động trên nhiều hệ điều hành cung cấp một hệ thống lớn các hàm tiện ích rất mạnh.

Với tốc độ và tính bảo mật cao, MySQL rất thích hợp cho các ứng dụng có truy cập CSDL trên internet.

MySQL miễn phí hoàn toàn 

MySQL là một trong những ví dụ rất cơ bản về Hệ Quản trị Cơ sở dữ liệu quan hệ sử dụng Ngôn ngữ truy vấn có cấu trúc (SQL).

MySQL được sử dụng cho việc bổ trợ PHP, Perl, và nhiều ngôn ngữ khác, nó làm nơi lưu trữ những thông tin trên các trang web viết bằng PHP hay Perl,...

##1. Cài đặt và cấu hình
```sh
apt-get install mysql-server
```
* Thư mục cấu hình của mysql:  **/etc/mysql**
* file mysqldump.cnf nằm trong thư mục conf.d có 1 tùy chọn là
	```sh
	max_allowed_packet      = 16M
	```
	Giá trị này dùng để xác định giá trị tối đa của packet.
* Cấu hình file mysqld.cnf trong thư mục mysql.conf.d

```sh
[mysqld_safe]
socket          = /var/run/mysqld/mysqld.sock	//Xác định đường dẫn file socket của mysql. mysql.sock là một UNIX domain socket.
nice            = 0
[mysqld]

user            = mysql	//user
pid-file        = /var/run/mysqld/mysqld.pid	//file có nội dung chứa process id của mysql
socket          = /var/run/mysqld/mysqld.sock	//Xác định đường dẫn file socket của mysql
port            = 3306							//port mysql.
basedir         = /usr							//thư mục...
datadir         = /var/lib/mysql				//thư mục chứa đường dẫn file database.
tmpdir          = /tmp							//thư mục tạm
lc-messages-dir = /usr/share/mysql				//thư mục...
skip-external-locking

bind-address            = 0.0.0.0	//nếu muốn truy cập mysql-server từ ngoài, bạn phải chuyển địa chỉ này thành 0.0.0.0
key_buffer_size         = 16M	//
max_allowed_packet      = 16M	//giá trị tối đa của packet
thread_stack            = 192K	//
thread_cache_size       = 8		//

myisam-recover         = BACKUP
max_connections        = 100	//số connect tối đa

query_cache_limit       = 1M	//kích thước tối đa 1 query :v
query_cache_size        = 16M	//kích thước bộ nhớ cache của query

log_error = /var/log/mysql/error.log	//đường dẫn file log

expire_logs_days        = 10	//thời gian hết hạn file log.
max_binlog_size   = 100M		//kích thước file binlog tối đa.

```
##2. MySQL Data Types
###2.1 Kiểu dữ liệu số (Numeric Data Types)
* **TINYINT:** Kích thước rất nhỏ
* **SMALLINT:** Kích thước nhỏ
* **MEDIUMINT:** Kích thước vừa
* **INT:** Kích thước chuẩn
* **BIGINT:** Kích thước lớn
* **DECIMAL:** Số cố định
* **FLOAT:** Số có dấu chấm động
* **DOUBLE:** Số có dấu chấm động lớn hơn
* **BIT:** Kiểu BIT
###2.2 Kiểu chuỗi (String)
* **CHAR:** Có chiều dài cố định và không ở dạng nhị phân
* **VARCHAR:** Có chiều dài và ta phải xác định chiều dài cho nó, không ở dạng nhị phần
* **BINARY:** Chuỗi nhị phân có độ dài cố định
* **VARBINARY:** Chuỗi nhị phân có độ dài thay đổi
* **TINYBLOB:** BLOB rất nhỏ
* **BLOB:** BLOB nhỏ
* **MEDIUMBLOB:** BLOB vừa
* **LONGBLOB:** BLOB lớn
* **TINYTEXT:** Chuỗi không nhị phân rất nhỏ
* **TEXT:** Chuỗi không nhị phân nhỏ
* **MEDIUMTEXT:** Chuỗi không nhị phân trung bình
* **LONGTEXT:** Chuỗi không nhị phân lớn
* **ENUM:** enumeration
* **SET:** Bộ

###2.3 Kiểu ngày tháng (Date and Date time)
* **DATE:** Kiểu ngày tháng, định dạng YYYY-MM-DD
* **TIME:** Kiểu thời gian, định dạng HH:MM:SS
* **DATETIME:** Kiểu ngày tháng có thời gian, định dạng YYYY-MM-DD HH:MM:SS
* **TIMESTAMP:** Kiểu ngày tháng có thời gian, định dạng YYYY-MM-DD HH:MM:SS
* **YEAR:** Kiểu năm, định dạng YYYY

##3. Create Database trong MySQL
###3.1 Lệnh tạo Database - Create Database
```sh
CREATE DATABASE [IF NOT EXISTS] database_name;
```
Trong đó:
    * CREATE DATABASE: là từ khóa tạo database
    * [IF NOT EXISTS]: Nếu có dòng này thì khi chạy nếu bảng đã tồn tại thì nó không báo lỗi (bỏ cặp dấu ngoặc)

###3.2 Thiết lập Charset và Collate cho database
```sh
CREATE DATABASE IF NOT EXISTS database_name CHARACTER SET 'charset_name' COLLATE 'collateName';
```
* Thông thường chúng ta sử dụng charset là UTF-8 và Collate là utf8_unicode_ci để khi nhập tiếng Việt không bị lỗi font.

###3.3 Lệnh sử dụng database (use database)
```sh
USE database_name;
```

###3.4 Xóa database (Drop Database)
```sh
DROP DATABASE SINHVIEN;
```
##4. Lệnh tạo bảng (Create Table) trong MySQL
###4.1 Lệnh tạo bảng (Create Table) trong MySQL
```sh
CREATE TABLE [IF NOT EXISTS] table_name(
        /*column_list*/
) ENGINE=table_type
```
Trong đó:

    * CREATE TABLE: là từ khóa tạo bảng
    * [IF NOT EXISTS]: dòng này có thể có hoặc không, ý nghĩa của nó là nếu table này chưa tồn tại thì thực hiện tạo, còn nếu tồn tại rồi thì không tạo mới.
    * column_list: là danh sách các fields, ví dụ như TenSV, MaSV, ... Mỗi field gồm hai thông số là tên field và kiểu dữ liệu cho nó, nếu có nhiều field thì sẽ dùng dấu phảy (,) để ngăn cách.
		
		Ví dụ: TenSV varchar(255)
    * ENGINE=table_type: Là kiểu engine của bảng này.

Ví dụ: Cho bảng SINHVIEN gồm có các thông tin sau:

    * TenSV: Tên sinh viên, kiểu varchar và chiều dài tối đa 255 ký tự
    * MaSV: Mã sinh viên, kiểu INT và chiều dai là tối đa 11 số
    * NamSinh: Năm sinh, kiểu INT và chiều dài tối đa là 4 số

Lệnh tạo bảng như sau:
```sh
USE QLSV; 
 
CREATE TABLE SINHVIEN(
    TenSV VARCHAR(255),
    MaSV INT(11),
    NamSinh INT(4)
) ENGINE = InnoDB;
```

###4.2 Gán giá trị mặc định cho table
* Giá trị mặc định tức là khi bạn tạo một record mới mà bạn không nhập dữ liệu vào thì mặc nhiên nó sẽ lấy giá trị mặc định đó làm giá trị. Để gán giá trị mặc định thì ta sẽ dùng từ khóa DEFAULT đằng sau mỗi fields.

* Ví dụ:

```sh
USE QLSV; 
 
CREATE TABLE SINHVIEN(
    TenSV VARCHAR(255) DEFAULT 'noname',
    MaSV INT(11),
    NamSinh INT(4)
) ENGINE = InnoDB;
``` 
###4.3 Thiết lập Null và Not Null cho Column
Nếu bạn muốn một column nào đó mỗi khi nhập dữ liệu thì bắt buộc phải nhập cho nó thì bạn sẽ sử dụng từ khóa NOT NULL. Ngược lại thì bạn sẽ dùng từ khóa NULL (mặc định là NULL nếu ban không truyền)

```sh
USE QLSV; 
 
CREATE TABLE SINHVIEN(
    TenSV VARCHAR(255) DEFAULT 'noname',
    MaSV INT(11) NOT NULL,
    NamSinh INT(4)
) ENGINE = InnoDB;
```
###4.4 Xóa bảng (DROP TABLE)
```sh
DROP TABLE table_name;
```
###4.5 Tạo khóa chính
####4.5.1 Tạo trong lệnh tạo bảng Create Table
* Để chọn field cho khóa chính ta sẽ đặt từ khóa primary key đằng sau column đó, ví dụ:
```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY,
  email VARCHAR(70) NOT NULL
) ENGINE = INNODB;
```
* Hoặc ta sẽ dùng lệnh PRIMARY KEY(field)  đặt ở cuối các fields trong lệnh tạo bảng, ví dụ:
```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL,
  email VARCHAR(70) NOT NULL,
  PRIMARY KEY(id)
) ENGINE = INNODB;
```
* Chọn nhiều fields làm khóa chính
Để chọn nhiều fields làm khóa chính thì ta sử dụng lệnh PRIMARY KEY(field1, field2, ..) và đặt nó ở cuối danh sách các field trong lệnh tạo bảng, ví dụ:
```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL,
  email VARCHAR(70) NOT NULL,
  PRIMARY KEY(id, email)
) ENGINE = INNODB;
```

####4.5.2  Sử dụng lệnh Alter để tạo khóa chính
* Thông thường cách này sử dụng trong trường hợp ta tạo bảng trước rồi sau đó tạo khóa chính sau. Ta sẽ sử dụng cú pháp sau để tạo:
```sh
ALTER TABLE table_name ADD PRIMARY KEY(primary_key_column);
```

* Ví dụ:

```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL,
  email VARCHAR(70) NOT NULL
) ENGINE = INNODB;
 
ALTER TABLE users ADD PRIMARY KEY(id);
```
####4.5.3 Sử dụng CONSTRAINT đặt tên cho khóa chính
* Sử dụng lệnh CONSTRAINT chúng ta có thể tạo tên cho khóa chính, nhờ đó sau này ta sẽ dễ quản lý hơn. Ví dụ:

```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL,
  email VARCHAR(70) NOT NULL,
  CONSTRAINT pk_user PRIMARY KEY(id)
) ENGINE = INNODB;
```
hoặc

```sh
CREATE TABLE users (
  id INT(10) UNSIGNED NOT NULL,
  email VARCHAR(70) NOT NULL
) ENGINE = INNODB;
 
ALTER TABLE users ADD CONSTRAINT pk_user PRIMARY KEY (id);
```
####4.5.4 Xóa khóa chính (Drop Primary Key)
Để xóa khóa chính thì chúng ta sử dụng lệnh ALTER TABLE kết hợp với DROP, ví dụ:
```sh
ALTER TABLE users DROP PRIMARY KEY;
```
##5. INSERT trong MySQL
###5.1 Cú pháp 1: Khai báo rõ tên column:
```sh
INSERT INTO
table_name(field1, field2, field2, ..., fieldn)
VALUES('field1', 'field2', 'field3', ...,'fieldn');
```
Khi sử dụng cú pháp này thì các field ở vị trí nào sẽ tương ứng với vị trí của nó ở VALUES, và ở phần khai báo có bao nhiêu column thì ở phần value sẽ có bấy nhiêu value tương ứng.

Ví dụ:
```sh
INSERT INTO sinhvien(tensv, sv_description)
VALUES ('Nguyen van cuong', 'Sinh vien dai hoc');
```
###5.2 Cú pháp 2: Không khai báo rõ tên column
```sh
INSERT INTO table_name
VALUES ('field_1', 'field_2', ..., 'field_n');
```
Trong trường hợp này thì bạn bắt buộc phải truyền cho tất cả các column, ví dụ bạn có 10 column thì bạn phải truyền cho cả 20, nếu không sẽ báo lỗi ngay.

Ví dụ:
```sh
INSERT INTO sinhvien
VALUES ('2', 'Nguyen van Kinh', 'Hoc sinh trung hoc');
```
Các bạn thấy tuy là khóa chính và tăng tự động nhưng vẫn phải truyền value cho nó, điều này khác hoàn toàn với cách trên.
##6 Lệnh SELECT lấy dữ liệu trong MySQL
```sh
SELECT field1, field2, field3, ...
FROM table_name
WHERE <dieu_kien_loc>
ORDER BY field_name ASC|DESC
LIMIT start, limit
;
```

* SELECT field1, field2, field3, ... là danh sách các fields cần lấy. Nếu lấy tất cả field, gõ ký tự đại diện là *
* FROM table_name tên table cần lấy
* WHERE <dieu_kien_loc> là các điều kiện để lấy các dòng dữ liệu
* ORDER BY field_name, ASC|DESC: là cách sắp xếp cho field_name theo kiểu ASC (tăng dần) hoặc DESC (giảm dần)
* LIMIT start, limit là lấy limit records kể từ record thứ start trong kết quả.
###6.1 WHERE IN trong MySQL
WHERE IN có nghĩa là sẽ kiểm tra giá trị của field đó có nằm trong một tập hợp nào đó hay không.

Ví dụ
```sh
SELECT *
FROM SINHVIEN
WHERE tensv IN ('Linh');
```
=> Những record nào có tên là Linh ở field tensv sẽ được hiển thị.

###6.2 WHERE LIKE trong MYSQL
Nó sẽ so khớp với cấu trúc của chuỗi LIKE truyền vào.

####6.2.1 LIKE với ký hiệu %
Ký hiệu % đại diện cho 0 hoặc nhiều ký tự.
```sh
SELECT *
FROM SINHVIEN
WHERE tensv LIKE '%Linh%'
```
chuỗi %Linh% có nghĩa là các trường hợp sau là đúng:

    * Chuỗi 'some thing Linh some thing' đúng
    * Chuỗi 'some thing Cuong' đúng
    * Chuỗi 'Linh some thing' đúng
####6.2.2 Like với kí hiệu _
Ký hiệu _ đại diện cho một ký tự bất kì, nghĩa là khi bạn sử dụng ký hiệu này thì nó sẽ là một ký tự.
```sh
SELECT *
FROM SINHVIEN
WHERE tensv LIKE 'L_'
;
```
###6.2 ORDER BY 
* Sắp xếp theo 1 column
```sh
SELECT field1, field2, ...
FROM table_name
WHERE ...
ORDER BY column_name sort_type
```
Trong đó:
    * column_name là tên column cần sắp xếp
    * sort_type là loại sắp xếp và có giá trị là:
		* ASC nếu tăng dần
        * DESC nếu giảm dần

Ví dụ: Lấy danh sách sinh viên trong bảng SINHVIEN và kết quả trả về sắp xếp theo ID sinh viên và tăng dần
```sh
SELECT MaSV, TenSV, NamSinh
FROM SINHVIEN
ORDER BY MaSV ASC
```

* Sắp xếp theo nhiều column
```sh
SELECT field1, field2, ...
FROM table_name
WHERE ...
ORDER BY column_name1 sort_type1, column2 sort_type2, ...
```
Ví dụ: Lấy danh sách sinh viên trong bảng SINHVIEN và sắp xếp theo ID sinh viên là tăng dần và năm sinh giảm dần
```sh
SELECT MaSV, TenSV, NamSinh
FROM SINHVIEN
ORDER BY MaSV ASC, NamSinh DESC
```

##7. Quản lý user.
###7.1 Tạo user mới
Chúng ta tạo user mới trong tình huống cần hạn chế một vài quyền, có nhiều cách để tạo ra user với các quyền là tùy chỉnh.

* Lệnh sau tạo ra user mới có tên là newuser, passowrd là newuser trên localhost:
```sh
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'newuser';
```
* Tuy nhiên, tại thời điểm này, newuser không có quyền để làm bất cứ điều gì với cơ sở dữ liệu. Thực tế thì, thậm chí nếu newuser cố gắng thử đăng nhập (với mật khẩu là password), họ cũng không thể vào được shell điều khiển của MySQL.

Vì vậy, điều đầu tiên cần làm là cung cấp cho người dùng truy cập vào các thông tin mà họ cần:
```sh
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
```
Các dấu sao (*) trong lệnh này liên quan đến cơ sở dữ liệu và bảng (tương ứng) mà họ có thể truy cập – cụ thể lệnh này cho phép người dùng đọc, chỉnh sửa, ,thực thi tất cả các task trên tất cả cơ sở dữ liệu và bảng.

* Một khi hoàn tất các quyền gán cho user, và bạn muốn thiết lập quyền mới cho tài khoản mới khác, hãy thực hiện lệnh sau để đảm bảo các quyền được thiết lập lại từ đầu cho user mới.
```sh	
FLUSH PRIVILEGES;
```
Các thay đổi của bạn bây giờ sẽ có hiệu lực !

###7.2  Gán quyền cho User
* Dưới đây là danh sách các lệnh thường dùng để gán quyền cho user mới.

* **ALL PRIVILEGES:** như ở trên ta thấy, lệnh này cho phép MySQL user thực hiện toàn quyền trên databases (hoặc 1 vài db được thiết lập)
* **CREATE:** Cho phép user tạo mới tables hoặc databases
* **DROP:** Cho phép xóa tables hoặc databases
* **DELETE:** Cho phép xóa bản ghi dữ liệu trong bảng tables
* **INSERT:** Cho phép thêm bản ghi mới vào bảng csdl
* **SELECT:** Cho phép sử dụng lệnh Select để tìm kiếm dữ liệu
* **UPDATE:** Cho phép cập nhật csdl
* **GRANT OPTION:** Cho phép gán hoặc xóa quyền của người dùng khác.

* Để thiết lập quyền người dùng với môt vài quyền cụ thể, hãy dùng mẫu lệnh sau:
```sh
GRANT [type of permission] ON [database name].[table name] TO '[username]'@'localhost';
```
Nếu bạn muốn cho phép user truy cập tất cả databases hoặc tất cả bảng, hãy dùng dấu sao (*) thay cho tên database hoặc table.

* Mỗi lần bạn cập nhật hay thay đổi quyền hãy dùng lệnh Flush Privileges đảm bảo các thay đổi có hiệu lực.
```sh
FLUSH PRIVILEGES;
```

* Nếu cần thu hồi lại quyền của user, hãy dùng lệnh REVOKE với biểu mẫu lệnh sau đây:
```sh
REVOKE [type of permission] ON [database name].[table name] FROM '[username]'@'localhost';
```
Hoặc bạn cũng có thể dùng lệnh drop để xóa hẳn user đó đi.
```sh	
DROP USER 'demo'@'localhost';
```

##8. Enable Remote Access To MySQL Database Server
* Bước 1: Chỉnh sửa file my.cnf.

If you are using Debian Linux file is located at /etc/mysql/my.cnf location.

If you are using Red Hat Linux/Fedora/Centos Linux file is located at /etc/my.cnf location.

If you are using FreeBSD you need to create a file /var/db/mysql/my.cnf location
	
Trong file my.cnf, tìm phần 
```sh
bind-address=YOUR-SERVER-IP
```
và sửa thành địa chỉ ip của MySQL SERVER hoặc 0.0.0.0

Sau đó lưu lại và khởi động lại dịch vụ mysql server
```sh
service mysql restart
```
* Bước 2: Mở port 3306.
Nếu tường lửa đang chặn port 3306 thì các bạn phải mở port mới có thể truy nhập database từ xa.

Với tường lửa iptables, có thể dùng lệnh dưới đây
```sh
iptables -A INPUT -i eth0 -p tcp --destination-port 3306 -j ACCEPT
```

* Bước 3:  Phân quyền remote database
* Phân quyền remote database cho database mới
```sh
CREATE DATABASE ksec;	//tạo database ksec
GRANT ALL ON ksec.* TO ksec@'10.10.10.4' IDENTIFIED BY 'PASSWORD_ksec'	//để phân quyền cho user test có host là 10.10.10.4 được toàn quyền thao tác trên database ksec.  ( Host chính là ip của client remote vào database, có thể để host = % để cho tất cả ip từ client có thể remote vào database)

* Phân quyền remote database cho database đã có.
```sh
update db set Host='10.10.10.4' where Db='ksec';	//để cập nhật lại ip cho phần host là 10.10.10.4 cho database ksec.
update user set Host='10.10.10.4' where user='ksec';  để cập nhật lại phần host là 10.10.104 cho user ksec.
```

* Bước 4: Remote vào database.
Tại server điều khiển:
```sh
mysql -u user -h ip_server_database -p
```
Các thông số:
    * u user là username của mysql
    * h ip_server là địa chỉ ip của server bị remote.
    * p là chỉ định mật khẩu của user sẽ nhập sau khi chạy lệnh trên.

	Ví dụ:
```sh
mysql -h ksec -h 10.10.10.6 -p
```