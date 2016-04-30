#MySQL Replication Master-Slave

    MySQL master : 10.10.10.8
    MySQL slave	 : 10.10.10.18
	
	
##Cần phải đảm bảo database ở master và slave là giống nhau hoàn toàn. 
Nếu database ở master đã có dữ liệu, hay backup và thực hiện restore trên slave.

* Backup 1 database
```sh
mysqldump -u username -p mydb > mydb.sql
```
* Backup nhiều database
```sh
mysqldump -u username -p --databases dbname1 dbname2 dbname3 > backup.sql
```
* Backup toàn bộ database
```sh
mysqldump -u username -p -–all-databases > alldb.sql
```
* restore database
```sh
mysql -u username -p < backup.sql 
```

##1, Cấu hình ở Master
###1, Thay đổi file cấu hình `/etc/mysql/mysql.conf.d/mysqld.cnf`

* thêm dấu # để vô hiệu
```sh
#skip-networking
#bind-address = 127.0.0.1
```

![](http://i.imgur.com/oGgyIUW.png)

* bỏ dấu # để kích hoạt và cấu hình
```sh
log-bin
server-id=1
binlog-do-db=ksecsystem	//Tên database replicated, ở đây là ksecsystem
```
![](http://i.imgur.com/ad1Aa9T.png)

###2, Tạo một user để Slave đăng nhập và có thể Replicate
```sh
mysql1> grant replication slave on *.* to 'slave'@10.10.10.18' identified by '123456';
```

![](http://i.imgur.com/r42rcsP.png)

* Khởi động lại mysql
```sh
service mysql restart
```

###3, Ngưng các tác động làm thay đổi cơ sở dữ liệu.
```sh
FLUSH TABLES WITH READ LOCK;
```

![](http://i.imgur.com/r42rcsP.png)


###4, Xem file log của cơ sỡ dữ liệu "ksecsystem" hiện tại để slave biết bắt đầu replicate tại thời điểm nào.
```sh
SHOW MASTER STATUS;
```

![](http://i.imgur.com/JzL6Eca.png)

Chúng ta cần lưu lại 2 tham số của cột `File` và `Position` để cấu hình cho SLAVE.


##2, Cấu hình ở Slave
###1, Thay đổi file cấu hình `/etc/mysql/mysql.conf.d/mysqld.cnf`

* thêm dấu # để vô hiệu
```sh
#skip-networking
#bind-address = 127.0.0.1
```


bỏ dấu # để kích hoạt và cấu hình
```sh
server-id=2
```

![](http://i.imgur.com/pFW4STb.png)

###2, Cấu hình những thông tin cần thiết, để slave giao tiếp được với master:
```sh
mysql> CHANGE MASTER TO
-> MASTER_HOST='master.mydomain.com',
-> MASTER_USER='repl',
-> MASTER_PASSWORD='slavepass',
-> MASTER_LOG_FILE='recorded_log_file_name',
-> MASTER_LOG_POS=recorded_log_position;
```

* Ghi chú: giá trị `MASTER_LOG_FILE` ở đây là `[file name]` và `MASTER_LOG_POS` là giá trị `[Position]` của câu lệnh `SHOW MASTER STATUS;`

* Nếu trước khi thực hiện replication, master không ghi thành log file, thì giá trị tương ứng ở đây là: chuỗi rỗng (“”) và 4.

![](http://i.imgur.com/fALloDV.png)



* restart mysql

##3, sau khi thực hiện xong, mở khóa các table trên master
```sh
mysql> UNLOCK TABLES;
```

##4, chạy kiểm tra trên slave
```sh
mysql> start slave;
mysql> show slave status\G;
```
* Chú ý 2 kiểm tra thông số `Slave_IO_Running` và `Slave_SQL_Running`

Nếu YES =>Hoạt động tốt
Nếu No  =>Kiểm tra lại cấu hình.

* Nếu gặp lỗi Errno: 1593
```sh
Fatal error: The slave I/O thread stops because master and slave
have equal MySQL server UUIDs; these UUIDs must be different for
replication to work.
```

Hãy làm the các bước sau:
```sh
    Stop your MySQL,
    Remove the auto.cnf file 
    Restart MySQL.
```

file `auto.cnf` ở trong thư mục `/var/lib/mysql` trên máy slave.

![](http://i.imgur.com/BXGVbHz.png)

##5: Xong.

#MySQL Replication Master1-Master2
Master1: 10.10.10.8
Master2: 10.10.10.18
##1 
Sau khi cấu hình như bài ở trên, thì mọi thay đổi dữ liệu ở master1 đã được cập nhật ở slave(master2)
Giờ ta cấu hình như ở trên, nhưng thay đổi vai trò của Master-SLAVE(Master2) để mọi thay đổi ở
Slave(Master2) được cập nhật ở master1.

##2 Cấu hình như bài ở trên.

##3 Sau khi cấu hình như bài trên, ta thực hiện tiếp

## Ở MASTER2(Slave)

###3.1 Thay đổi file cấu hình `/etc/mysql/mysql.conf.d/mysqld.cnf`
* bỏ dấu # để kích hoạt
```sh
log-bin
binlog-do-db=ksecsystem	//Tên database replicated, ở đây là ksecsystem
```
![](http://i.imgur.com/SsuYcbI.png)

###3.2 Tạo một user để Master 1 đăng nhập và có thể Replicate
```sh
mysql> grant replication slave on *.* to 'slave2'@10.10.10.8' identified by '123456';
```

![](http://i.imgur.com/WBXKe1R.png)

* Khởi động lại mysql
```sh
service mysql restart
```

###3.3 Ngưng các tác động làm thay đổi cơ sở dữ liệu.
```sh
FLUSH TABLES WITH READ LOCK;
```

###3.4 Xem file log của cơ sỡ dữ liệu "ksecsystem" hiện tại để master1 biết bắt đầu replicate tại thời điểm nào.
```sh
SHOW MASTER STATUS;
```

![](http://i.imgur.com/pt2yEGL.png)

Chúng ta cần lưu lại 2 tham số của cột `File` và `Position` để cấu hình cho master1.

##4. Ở MASTER1
Cấu hình những thông tin cần thiết, để master2 giao tiếp được với master1
```sh
mysql> CHANGE MASTER TO
-> MASTER_HOST='master.mydomain.com',
-> MASTER_USER='repl',
-> MASTER_PASSWORD='slavepass',
-> MASTER_LOG_FILE='recorded_log_file_name',
-> MASTER_LOG_POS=recorded_log_position;
```

* Ghi chú: giá trị `MASTER_LOG_FILE` ở đây là [file name] và `MASTER_LOG_POS` là giá trị [Position] của câu lệnh `SHOW MASTER STATUS;`

* Nếu trước khi thực hiện replication, master không ghi thành log file, thì giá trị tương ứng ở đây là: chuỗi rỗng (“”) và 4.

![](http://i.imgur.com/VHx3pVw.png)



* Khởi động lại mysql
```sh
service mysql restart
```

##3, sau khi thực hiện xong, mở khóa các table trên master2
```sh
mysql> UNLOCK TABLES;
```

##4, chạy kiểm tra trên master1
```sh
mysql> start slave;
mysql> show slave status\G;
```
* Chú ý 2 kiểm tra thông số `Slave_IO_Running` và `Slave_SQL_Running`

Nếu YES =>Hoạt động tốt
Nếu No  =>Kiểm tra lại cấu hình.


![](http://i.imgur.com/6rSrekx.png)


##5: OK


