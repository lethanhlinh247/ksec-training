#IP DATAGRAM
Giao thức liên mạng IP là cung cấp khả năng kết nối các mạng con thành liên mạng để truyền dữ liệu.
IP là giao thức cung cấp dịch vụ phân phát datagram theo kiểu không liên kết và không tin cậy
nghĩa là không cần có giai đoạn thiết lập liên kết trước khi truyền dữ liệu, 
không đảm bảo rằng IP datagram sẽ tới đích 
và không duy trì bất kỳ thông tin nào về những datagram đã gửi đi. 

![hình ảnh các thành phần](https://4yatfw.bn1.livefilestore.com/y2pj3_VXtcreN016i6uoHEFSeMQAc6rANxHt3Dkw0cThQkIz15HRRIa3-oyTVkYxkjWWps7EHp3mR-xBoggGUd6XSnt2u-wFruAeBu8_LA0skM/01-%20IP%20header.png)

##Ý nghĩa các tham số trong IP header:
− Version (4 bit): chỉ phiên bản (version) hiện hành của IP được cài đặt.

− IHL: Internet header length (4 bit): chỉ độ dài phần header tính theo đơn vị từ (word - 32 bit)

− Type of Service (8 bit): đặc tả tham số về yêu cầu dịch vụ: Thông tin về loại dịch vụ và mức ưu tiên của gói IP.
	
	Precedence (3 bits): chỉ thị về quyền ưu tiên gửi datagram, cụ thể là:
	
	111 Network control (cao nhất)
	
	110 Internetwork Control
	
	101 CRITIC/ECP
	
	100 Flas Override
	
	011 flash
	
	010 Immediate
	
	001 Priority
	
	000 Routine (thấp nhất)
	
− Total length (16 bit): chỉ độ dài toàn bộ IP datagram tính theo byte. Dựa vào trường này và trường header length ta tính được vị trí bắt đầu của dữ liệu trong IP datagram.

− Indentification (16 bit): là trường định danh, cùng các tham số khác như địa chỉ nguồn (Source address) và địa chỉ đích (Destination address) để định danh duy nhất cho mỗi datagram được gửi đi bởi 1 trạm. Thông thường phần định danh (Indentification) được tăng thêm 1 khi 1 datagram được gửi đi.
− Flags (3 bit): các cờ, sử dụng trong khi phân đoạn các datagram. 

![](https://4yatfw.bn1.livefilestore.com/y2phlastvdF-KwMXVyPrpwowT-ZnQ8XKpoEBONbun1VqRZxk89sye8YrlKDEUYGbp26_XRwDlHFJdVPTD79zHYHdO6sOBawzjAEvIlelqtpnts/02-%20flag.png)


− Fragment Offset (13 bit): chỉ vị trí của đoạn phân mảnh (Fragment) trong datagram tính theo đơn vị 64 bit.

− TTL -Time to live  (8 bit): thiết lập thời gian tồn tại của datagram để tránh tình trạng datagram bị quẩn trên mạng. TTL thường có giá trị 32 hoặc 64 được giảm đi 1 khi dữ liệu đi qua mỗi router. Khi trường này bằng 0 datagram sẽ bị hủy bỏ và sẽ không báo lại cho trạm gửi.

− Protocol (8 bit): chỉ giao thức tầng trên kế tiếp

− Header checksum (16 bit): để kiểm soát lỗi cho vùng IP header.

− Source address (32 bit): địa chỉ IP trạm nguồn

− Destination address (32 bit): địa chỉ IP trạm đích

− Option (độ dài thay đổi): khai báo các tùy chọn do người gửi yêu cầu, thường là:

    Độ an toàn và bảo mật
	
    Bảng ghi tuyến mà datagram đã đi qua được ghi trên đường truyền 
	
    Time stamp
	
    Xác định danh sách địa chỉ IP mà datagram phải qua nhưng datagram không bắt buộc phải truyền qua router định trước
    
	Xác định tuyến trong đó các router mà IP datagram phải được đi qua




