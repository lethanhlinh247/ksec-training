# MYSQL
##1. Cài đặt
```sh
apt-get install mysql-server
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