# Mô hình TCP/IP
Là tập hợp các giao thức hỗ trợ việc lưu truyền trên mạng
##1 Cấu tạo:
Gồm có 4 tầng. Mỗi tầng có 1 nhiệm vụ khác nhau

![Mô hình TCP/IP](http://www.tuvantinhoc1088.com/my_documents/my_pictures/Giainghia2/TCP%20IP/hinh1.gif)

##2 Chức năng của mỗi tầng.
###2.1 Tầng Network Interface
Định ra các thủ tục để giao tiếp với phần cứng mạng và truy nhập môi trường truyền

###2.2 Tầng Internet
chọn đường đi tốt nhất xuyên qua mạng cho các gói dữ liệu di chuyển tới đích

###2.3 Tầng Transport
Vận chuyển từ host nguồn đến host đích, thông qua 2 giao thức là TCP và UDP.

TCP: Vận chuyển tin cậy, sử dụng cơ chế bắt tay 3 bước.
UDP: vận chuyển không tin cậy.

###2.4 Tầng Application
Kiểm soát các giao thức lớp cao, các chủ đề về trình bày, biểu diễn thông tin, mã hóa và điều khiển hội thoại.

##3 Một số giao thức trong tầng ứng dụng:
SMTP - Email (Port 25)

FTP - Truyền file (Port 21)

HTTP - Duyệt web (Port 80/443)
