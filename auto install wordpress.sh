#!/bin/sh
wget https://wordpress.org/latest.tar.gz	#Tải wordpress
tar -zxvf latest.tar.gz						#Giải nén
cd wordpress/								#Di chuyển vào thư mục wordpress sau khi giải nén
echo "MySQL HOST"						
read mysqlhost								#Nhập địa chỉ host của DB
echo "MySQL Database"
read mysqldb								#Nhập tên DB
echo "MySQL User"
read mysqluser								#Nhập user DB
echo "MySQL Password"
read mysqlpassword							#Nhập password DB
#cập nhật địa chỉ host, tên, user, password của DB vào file wp-config.php
sed -e "s/database_name_here/"$mysqldb"/" -e "s/username_here/"$mysqluser"/" -e "s/password_here/"$mysqlpassword"/" -e "s/localhost/"$mysqlhost"/" wp-config-sample.php > wp-config.php
#Tải Authentication Key và lưu và file keys
wget -O keys https://api.wordpress.org/secret-key/1.1/salt/
sed -i "/#@+/,/#@-/d" wp-config.php			#Xóa phần secret-key trống trong file wp-config.php (từ #@+ đến #@-)
sed -i "/define('DB_COLLATE', '');/r keys" wp-config.php	#Cập nhật file keys vào file wp-config.php (Sau phần define('DB_COLLATE', '');)
exit 0
