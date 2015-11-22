#Mô hình OSI
##1.1 Chức năng
Tạo ra sự đồng bộ để có thể kết nối, trao đổi thông tin giữa các hệ thống mạng máy tính khác nhau.
##1.2 Cấu tạo
Chia thành 7 tầng

7: Application

6: Presentations

5: Session

4: Transport

3: Network

2: Data Link

1: Physical

###1.2.1 Tầng Physical (Tầng vật lý)
Có nhiệm vụ đảm bảo việc kết nối vật lý giữa 2 hệ thống.
###1.2.2 Tầng Data Link
Truyền dữ liệu dưới dạng frame từ nút đến nút.
###1.2.3 Tầng Network
Có nhiệm vụ định tuyến, tìm đường đi tối ưu để đến được đích.
###1.2.4 Tầng Transport
Có nhiệm vụ vận chuyển dữ liệu, kiểm tra gói tin nào lỗi để có thể gửi lại. (Đảm bảo tính
nguyên vẹn và theo thứ tự của các gói tin).
###1.2.5 Tầng Session
Có nhiệm vụ thiết lập phiên kết nối giữa 2 hệ thống.
###1.2.6 Tầng Presentations
Biên dịch, mã hóa, nén dữ liệu tùy thuộc yêu cầu.
###1.2.7 Application
Có nhiệm vụ giao tiếp với người dùng, nhận lệnh từ người dùng.

##1.3 Ví dụ về mô hình OSI
Ví dụ về gửi mail từ máy tính A sang máy tính B, trong cùng 1 hệ thống mạng LAN.
Ở máy tính A:

Tầng application cung cấp port 25, giao thức SMTP để người dùng có thể gửi mail.

Nội dung mail sau đó được đẩy xuống tầng Presentations. Ở đây, nội dung sẽ được nén và mã hóa
để bảo mật nội dung.

Sau đó, được đẩy xuống tầng tiếp theo, tầng session. Tầng này sẽ cho phép ta thiết lập và duy trì
kết nối giữa 2 máy tính.

Tiếp tục đẩy xuống tầng Transport.Tầng Transport có nhiệm vụ cắt các gói tin thành các
gói tin nhỏ, chuyển các gói tin để máy B.

và kiểm tra gói tin, nếu lỗi, gói tin sẽ được gửi lại. Sau đó nối gói tin lại theo thứ tự.
Network: Tìm ra địa chỉ logic, đường đi tối ưu.

DAta link: tìm ra địa chỉ vật lý (MAC), đi giữa các nút mạng.

Physical: đường đi vật lý để gói tin có thể đến được máy nhận.

Khi máy B nhận được tin, thì làm các bước ngược lại ở trên.
