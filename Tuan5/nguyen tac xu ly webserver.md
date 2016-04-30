#Nguyên tắc xử lý của webserver
![](http://static.howstuffworks.com/gif/webserver-basic-sm.gif)

Theo mô hình trên, trình duyệt web thực hiện một kết nối tới máy chủ web, yêu cầu một trang web và nhận lại nó.

Ví dụ khi ta truy cập trang web: https://vozforums.com/index.php

* Trình duyệt web tách địa chỉ website làm 3 phần:
    * Phần giao thức: (“https”)
    * Máy chủ tên miền: (www.vozforums.com)
    * Tên tệp: (“index.php”)

* Trình duyệt liên hệ với máy chủ tên miền để chuyển đổi tên miền "www.vozforums.com" ra địa chỉ IP (Internet Protcol).
* Sau đó, trình duyệt sẽ gửi tiếp một kết nối tới máy chủ có địa chỉ IP tương ứng qua cổng 80. (Cổng 80 là cổng mặc định của webserver).
* Dựa trên giao thức HTTP, trình duyệt gửi yêu cầu GET đến máy chủ, yêu cầu tệp "https://vozforums.com/index.php". (Bạn chú ý, cookies cũng sẽ được gửi kèm theo từ trình duyệt web đến máy chủ)
* Tiếp đến, máy chủ sẽ gửi đoạn text dạng HTML đến trình duyệt web của bạn. (cookies cũng được gửi kèm theo từ máy chủ tới trình duyệt web, cookies được ghi trên đầu trang của mỗi trang web)
* Trình duyệt web đọc các thẻ HTML, định dạng trang web và kết xuất ra màn hình của bạn.

##1. Đổi tên miền ra địa chỉ IP
###1.1 Cache

* Đầu tiên, trình duyệt sẽ tìm trong cache của mình, có chứa địa chỉ ip của tên miền không. 
* Nếu có, thì nó sẽ lấy ngay địa chỉ ip đấy, mà không cần phải kiểm tra trong file host hoặc truy vấn đến DNS server.
* Nếu không, nó sẽ tìm trong file host, và cuối cùng là truy vấn DNS server.
* Vậy tại sao trong cache lại có thể chứa địa chỉ ip của domain? Bởi vì nếu trong quá khứ, mình đã truy cập đến
tên miền đó rồi, thì nó sẽ lưu lại địa chỉ ip của tên miền đó, để sau này truy cập nhanh chóng. (Tất nhiên là bạn
phải chưa xóa history và cache của trình duyệt :v).

###1.2 File host
* Nếu tìm trong cache không có, trình duyệt sẽ tìm trong file host.
* File host của hệ điều hành window nằm ở thư mục: C:\Windows\System32\drivers\etc. 
* File host của ubuntu nằm ở thư mục: /etc/hosts

###1.3 Truy vấn DNS server.
* Nếu cả trong cache và file host không có, thì trình duyệt sẽ tìm trong cache DNS trên máy tính của bạn có
địa chỉ ip của tên miền đó không. Bởi vì khi bạn truy vấn đến DNS server, nó sẽ lưu lại.
* Nếu không có, nó mới thực hiện truy vấn đến DNS server. 
* Cách hoạt động của DNS server
![](http://dotnet.edu.vn/Upload/Blog/2013/2013/Thang10_2013/How_DNS_Works.jpg)

	* Đầu tiên, máy tính sẽ gửi yêu cầu đến local name server để phân giải tên miền thành địa chỉ IP tương ứng của nó. Yêu cầu này được truy vấn DNS. Local name server sẽ nhận được truy vấn để tìm xem nó có chứa tên phù hợp và địa chỉ IP trong cơ sở dữ liệu.
	* Nếu tìm thấy địa chỉ IP tương ứng (response) được trả về.
	* Nếu không, các truy vấn được tự động chuyển đến máy chủ khác trong các cấp trên trực tiếp của hệ thống phân cấp DNS.
	* Tiến trình này tiếp tục cho đến khi truy vấn đến máy chủ có chứa tên và địa chỉ IP phù hợp. Địa chỉ IP (response) quay trở lại các chuỗi theo thứ tự ngược lại đến máy tính của bạn.
	* Trong trường hợp hiếm hoi mà không ai trong số các máy chủ DNS cấp thấp hơn tên miền nhất định, các truy vấn DNS đã đến được một trong những root name server để có được response.

* Các loại máy chủ DNS và vai trò của chúng:
Hệ thống tên miền (DNS) là cơ sở dữ liệu phân tán cư trú trên nhiều máy tính trên Internet một cách có thứ bậc. Chúng bao gồm các loại sau đây:
	
	* **Root Name Servers:** Các máy chủ gốc đại diện cấp cao nhất của hệ thống phân cấp DNS. Đây là các máy chủ DNS có chứa cơ sở dữ liệu đầy đủ của tên miền và địa chỉ IP tương ứng của chúng. Hiện nay, có 13 máy chủ gốc phân phối trên toàn cầu, được đặt tên với chữ cái A, B, C và lên đến M.
	* **Local Name Servers:** Các máy chủ địa phương đại diện cho các máy chủ DNS mức thấp nhất được sở hữu và duy trì bởi nhiều tổ chức kinh doanh và các nhà cung cấp dịch vụ Internet (ISP). Các máy chủ địa phương có thể phân giải tên miền thường được sử dụng vào các địa chỉ IP tương ứng bộ nhớ đệm thông tin gần đây. Bộ nhớ cache này được cập nhật và làm mới một cách thường xuyên.

##2. Giao thức HTTP - HyperText Transfer Protocol (Giao thức truyền siêu văn bản)
![](http://2.bp.blogspot.com/-3I7YA-5vrN0/UsLuvYJWclI/AAAAAAAABq4/L7IGV6gHH14/s320/http-header.jpg)

* Giao thức này nằm trong tầng Application Layer của mô hình TCP/IP, được sử dụng để truyền nội dung trang Web từ Web Server đến trình duyệt Web ở Client.
* Là giao thức Client/Server dùng cho Internet - World Wide Web, HTTP thuộc tầng ứng dụng của bộ giao thức TCP/IP (Các giao thức nền tảng cho Internet).
* Cơ chế hoạt động chính của HTTP là Request-Response: Web Client sẽ gửi Request đến Web Server, Web Server xử lý và trả về Response cho Web Client.
* Stateless Protocol - Phi trạng thái là một giao thức giao tiếp mà mỗi request được xem là một phiên giao dịch độc lập (nghĩa là nó không lưu giữ bất kỳ thông tin nào liên quan đến các request trước đó cũng như các phiên làm việc trước) 
* Đối với thông tin trong HTTP bao gồm:
	+ Request URL
	+ Header
	+ Body (phần này có thể rỗng)


* Các method trong HTTP:
	+ GET: phương thức hay dùng để lấy tài nguyên từ URL truy vấn. Khi truy vấn dùng phương thức này thì các tham số sẽ được nối thẳng vào URL. Phương thức GET không có phần thân hay phần thân rỗng.
	+ HEAD: lấy phần đầu của truy vấn, tức thông tin về tài nguyên.
	+ POST: gửi dữ liệu với độ dài không giới hạn tới web server. Khác với phương thức GET, phương thức POST dùng phần thân của câu truy vấn gửi dữ liệu lên web server.
	+ PUT: dùng để chỉ định thay thế hay upload một file…lên web server theo URL cung cấp.
	+ DELETE: xoá tài nguyên ở máy chủ được định vị bởi URL
	+ OPTIONS: trả về các phương thức mà server cung cấp cho một URL xác định
	+ TRACE: trả về thông tin truy vấn mà máy chủ nhận được. Phương thức này cho phép theo dõi một truy vấn để xem có những thay đổi hay thêm vào nào nếu có do nhưng máy chủ chung gian (intermidate server) thực hiện.


* Request Header có một số trường thông dụng sau:
    + Accept: loại nội dung có thể nhận được từ thông điệp response. Ví dụ: text/plain, text/html…
    + Accept-Encoding: các kiểu nén được chấp nhận. Ví dụ: gzip, deflate, xz, exi…
	+ Accept-Language: ngôn ngữ mặc định của browser.
    + Connection: tùy chọn điều khiển cho kết nối hiện thời. Ví dụ: keep-alive, Upgrade…
    + Cookie: thông tin HTTP Cookie từ server.
    + User-Agent: thông tin về user agent của người dùng.
	+ Host: xác định địa chỉ internet
	+ Referer: Nếu như bạn truy cập vào liên kết trên trang đó và click bất kì liên kết nào thì url sẽ trả lại địa chỉ gốc kèm theo phần mở rộng ở sau
	+ If-Modified-Since: nếu như nội dung trang web được trình duyệt lưu lại trong bộ nhớ cache. Và lần sau nếu truy cập nữa thì trình duyệt sẽ gửi. Nếu như không có bất kì thay đổi nào thì server sẽ gửi một status code 304. Sau đó trình duyệt sẽ load nội dung được lưu trong bộ nhớ cache đã lưu trước đó.


* Response Header:
	- Server: Cung cấp thông tin về server và hệ điều hành được sử dụng.
	- Cache-Control: nới chứa thông tin cho biết tài nguyên này:
		+ public: sẽ được lưu trữ công khai và dùng chung trong hệ thống 
		+ private: mỗi user trên hệ thống sẽ cache riêng biệt 
		+ no-cache: không cache trang này, thích hợp cho những trang có nội dung thay đổi liên tục, như search-engine.
		+ Tham số max-age chỉ ra thời hạn sử dụng và đơn vị nó tính bằng giây.
	- Content-Length: Web server thông báo cho phía client về dung lượng của gói tin gửi cho phía client. 
	– Connection: tùy chọn điều khiển cho kết nối hiện thời.
	– Content-type: header này cho biết thông tin về định dạng của văn bản. ví dụ ở trên đây là một ảnh động.
	- Content-Encoding: Header này trả về một định dạng mã hóa nội dung.
	- Etag: Header này dùng để lưu trữ bộ nhớ tỏng cache.
	– Date: thời gian response lại
	– Expires: thông báo cho trình duyệt biết các nội dung này có hiệu lực trong bao lâu tính từ khi server trả về tài nguyên
	– Last-Modified: lần cuối cùng đoạn văn bản được chỉnh sửa.
	- Localtion: Header này được sử dụng để chuyển hướng (redirect). Với status là 301 hoặc 302.
	- Pragma: Cho phép trình duyệt có được lưu vào bộ nhớ cache không.
	- Set-cookie: Webserver sẽ gửi cookie cho phía client và client sẽ gửi cookie này lại cho server trong các lần truy cập tiếp theo.


* Response Code
	- Response Code chỉ ra trạng thái của một Repsonse khi phản hồi một request từ Web Client - Thành công hay thất bại, có lỗi hay không? Lỗi của ai?
	- Một số mã thông dụng: 
		+ 1xx - Informational
		+ 2xx - Success (200 - OK, 202 - Accepted, 204 - No Content)
		+ 3xx - Redirection (301 Moved Permanently: tài nguyên đã được chuyển hoàn toàn tới địa chỉ Location trong HTTP response. 303 See other: tài nguyên đã được chuyển tạm thời tới địa chỉ Location trong HTTP response. 304 Not Modified: tài nguyên không thay đổi từ lần cuối client request, nên client có thể sử dụng đã lưu trong cache.)
		+ 4xx - Client Error (400 - Bad Request, 401 - Unauthorized, 403 - Forbidden, 404 - Not Found, 405 - Method Not Allowed, 408 - Request Timeout, 429 - Too many requests)
		+ 5xx - Server Error (500 - Internal Server Error, 503 - Service Unavailable, 504 - Gateway Timeout, 509 - Bandwidth Limit Exceed)
