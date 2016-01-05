Mod_Rewrite là một module của Apache Web Server, cho phép viết lại địa chỉ của website. Thông thường, Mod_Rewrite chuyển đổi từ một địa chỉ website động sang địa chỉ tĩnh. Quy luật chuyển đổi phân tích địa chỉ website được client gởi đến và dịch sang một địa chỉ mới trước khi thể hiện trên trình duyệt.

Ví dụ:
Mod_Rewrite chuyển đổi một địa chỉ động:
từ yourdomain.com/article.php?day=20&month=aug&year=2007
sang yourdomain.com/article-20-aug-2007.htm





##3. Enabling module userdir.
* Module này có tác dụng là tạo mỗi thư mục web cho mỗi người sử dụng. 
* Bật module
```sh
a2enmod userdir 
```
* Sửa dòng lệnh php_admin_flag thành comment trong file /etc/apache2/mods-enabled/php5.conf 
```sh
#php_admin_flag engine Off 
```
* Khởi động lại dịch vụ apache2.
* Tạo thư mục public_html ở trong một user bất kỳ.
* Truy cập với địa chỉ ip/~user
