#PHP
PHP (viết tắt hồi quy "PHP: Hypertext Preprocessor") là một ngôn ngữ lập trình kịch bản hay một loại mã lệnh chủ yếu được dùng để phát triển các ứng dụng viết cho máy chủ, mã nguồn mở, dùng cho mục đích tổng quát.

Nó rất thích hợp với web và có thể dễ dàng nhúng vào trang HTML.

Do được tối ưu hóa cho các ứng dụng web, tốc độ nhanh, nhỏ gọn, cú pháp giống C và Java, dễ học và thời gian xây dựng sản phẩm tương đối ngắn hơn so với các ngôn ngữ khác nên PHP đã nhanh chóng trở thành một ngôn ngữ lập trình web phổ biến nhất thế giới.


##1. Cài đặt
```sh
apt-get install php5
```
Cấu hình php ở tệp php.ini nằm trong thư mục **/etc/php5/cli**
##2. Cấu hình
Một số cấu hình thông dụng:

* **short_open_tag = Of:** Tùy chọn này phải được thiết lập là Off nếu bạn muốn sử dụng các hàm XML.

* **disable_functions = [function1, function2...] ** vô hiệu hóa các hàm đã chọn vì các lý do an toàn. 

* **expose_php:** Tuỳ chọn này sẽ giúp bạn ẩn thông tin về PHP trên HTTP Header của website nếu bạn không muốn cho ai đó biết rằng bạn đang sử dụng PHP. Nếu muốn ẩn đi, chỉ cần sửa giá trị thành Off.

* **max_execution_time:** Đây là tuỳ chọn rất phổ biến, nó sẽ giúp bạn gia hạn thời gian thực thi một kịch bản PHP nào đó nếu nó cần nhiều thời gian hơn 30 giây. Nếu thời gian thực hiện script quá giá trị trong này nó sẽ báo lỗi “Fatal error: Maximum execution time of {giây} seconds”. Hiện tại bạn có thể nâng lên thành 600, tức 600 giây.

* **memory_limit:** Mặc định PHP sẽ được chỉ định sử dụng 128MB bộ nhớ của hệ thống cho việc xử lý kịch bản trong PHP. Tuy nhiên với các mã nguồn lớn, có thể nó sẽ cần thêm bộ nhớ nên bạn sẽ chỉnh ở đây.

* **error_reporting:** Mặc định PHP sẽ hiển thị tất cả các lỗi bao gồm lỗi nghiêm trọng (Fatal Error), cảnh báo (Warning), ghi chú (Notice),…nhưng nếu bạn muốn tuỳ chọn hiển thị các lỗi nhất định thì sẽ điều chỉnh giá trị ở đây.

* **display_errors:** Tuỳ chọn hiển thị lỗi ra ngoài website. Khi học lập trình hoặc khi đang viết code cho dự án, bạn nên bật bằng cách sửa giá trị thành On để thấy ngay lỗi thay vì trang trắng.

* **log_errors:** Tuỳ chọn này sẽ lưu lỗi vào các tập tin log, hay còn gọi là error_log đó.

* **file_uploads:** Tuỳ chỉnh cho phép upload tập tin thông qua PHP.

* **upload_max_filesize:** Dung lượng tối đa mỗi tập tin khi upload. Ngoài ra, bạn cũng phải nâng dung lượng của tuỳ chọnpost_max_size lên nhé.

* **mysql.default_host = hostname:** Server Host mặc định để sử dụng khi kết nối tới Database Server nếu không có host nào khác được xác định.

* **mysql.default_user = username:** Username mặc định để sử dụng khi kết nối tới Database Server nếu không có name nào khác được xác định.

* **mysql.default_password = password:** Password mặc định để sử dụng khi kết nối tới Database Server nếu không có password nào khác được xác định.