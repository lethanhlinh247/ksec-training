# Mô hình TCP/IP
Là tập hợp các giao thức hỗ trợ việc lưu truyền trên mạng
##1 Cấu tạo:
Gồm có 4 tầng. Mỗi tầng có 1 nhiệm vụ khác nhau

![Mô hình TCP/IP](http://www.tuvantinhoc1088.com/my_documents/my_pictures/Giainghia2/TCP%20IP/hinh1.gif)

##2 Chức năng của mỗi tầng.
###2.1 Tầng Network Interface
Định ra các thủ tục để giao tiếp với phần cứng mạng và truy nhập môi trường truyền

Các giao thức ở lớp này phải biết các chi tiết ở các phần cấu trúc vật lý mạng ở dưới nó để định dạng được chính xác các gói dữ liệu sẽ được truyền trong từng loại mạng cụ thể

Có nhiều giao thức hoạt động tại lớp này như: Ethernet, FDDI,ATM….

Datagram được tạo từ lớp Internet sẽ được gửi xuống tới lớp Network Interface , nếu chúng ta đang truyền dữ liệu , hoặc lớp Network Interface sẽ lấy dữ liệu từ mạng và gửi nó tới lớp Internet , nếu chúng ta đang nhận dữ liệu .

Lớp này vạch rõ mạng vật lí kiểu nào mà máy tính của bạn kết nối tới . Hiện nay hầu hết máy tính của chúng ta dùng kết nối mạng Ethernet.

###2.2 Tầng Internet
Chọn đường đi tốt nhất xuyên qua mạng cho các gói dữ liệu di chuyển tới đích

Giao thức chính của lớp này là Internet Protocol (IP) có các chức năng

*	Định nghĩa cấu trúc các gói dữ liệu là đơn vị cơ sở cho việc truyền dữ liệu trên internet

*	Định nghĩa phương thức đánh địa chỉ IP

*	Truyền dữ liệu giữa tầng vận chuyển và tầng mạng

*	Định tuyến để truyền các gói dữ liệu trong mạng

*	Thực hiện việc phân mảnh và hợp nhất các gói dữ liệu và nhúng/tách chúng trong các gói dữ liệu ở tầng liên kết.

###2.3 Tầng Transport
Cung ứng dịch vụ vận chuyển từ host nguồn đến host đích

Thiết lập một cầu nối luận lý giữa các đầu cuối của mạng, giữa host truyền và host nhận.

Có 2 giao thức chính: 
* TCP: Vận chuyển tin cậy, sử dụng cơ chế bắt tay 3 bước.

* UDP: vận chuyển không tin cậy.

![](https://mobilesprogramming.files.wordpress.com/2010/08/udp3.png)

####2.3.1 UDP:
Là giao thức cho phép các ứng dụng truy nhập vào lớp mạng mà không cần thông tin về cơ chế quản lí độ tin cậy. UDP không có cơ chế kiểm tra số tuần tự phát, số tuần tự thu, kiểm tra lỗi và cơ chế phục hồi lại dữ liệu. Mặc dù không tin cậy nhưng theo thống kê vận hành khai thác mạng, 99% các gói dữ liệu UDP vẫn được chuyển phát đúng.

UDP cũng cung cấp dịch vụ chuyển phát datagram không định hướng, không có độ tin cậy, sử dụng IP để chuyển thông điệp giữa các máy. Nó sử dụng IP để chuyển tải thông điệp, nhưng thêm vào khả năng phân biệt nhiều đích đến bên trong một máy

Ưu điểm của UDP là thực hiện đơn giản

####2.3.2 TCP
TCP là một giao thức thông tin liên lạc chứ không phải là thành phần của phần mềm.

Giao thức này đặc tả các định dạng của dữ liệu và đáp lời mà hai máy tính trao đổi để đạt được việc truyền đáng tin cậy, cũng như là những thủ tục mà các máy tính sử dụng để đảm bảo rằng dữ liệu truyền đến một cách chính xác. Nó đặc tả cách mà phần mềm TCP phân biệt trong số các đích trên một máy cụ thể, và cách này mà các máy thông tin liên lạc với nhau để phục hồi các lỗi như mất gói dữ liệu hay dữ liệu bị trùng lặp. Giao thức này  cũng xác định phương thức hai máy tính khởi động qua trình stream TCP và cách mà chúng thống nhất với nhau khi hoàn tất việc truyền.

TCP cho phép nhiều chương trình ứng dụng trên một máy được phép thông tin liên lạc đồng thời và demultiplex những dữ liệu TCP gửi đến trong số các chương trình ứng dụng.

TCP sử dụng tiến trình bắt tay 3 bước.


###2.4 Tầng Application
Kiểm soát các giao thức lớp cao, các chủ đề về trình bày, biểu diễn thông tin, mã hóa và điều khiển hội thoại.

Trong lớp Application bạn sẽ tìm thấy những giao thức Application như : SMTP ( cho Email ) , FTP ( để truyền file ) và HTTP ( cho duyệt Web ) 

##3 Một số giao thức trong tầng ứng dụng:

SMTP - Email (Port 25)

* FTP (File Transfer Protocol) - Truyền file (Port 20/21): là dịch vụ có tạo cầu nối, sử dụng TCP để truyền các tập tin giữa các hệ thống.

HTTP - Duyệt web (Port 80/443)
