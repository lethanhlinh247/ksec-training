#Cân bằng tải

Cân bằng tải là một phương pháp phân phối khối lượng tải trên nhiều máy tính hoặc một cụm máy tính
để có thể sử dụng tối ưu các nguồn lực, tối đa hóa thông lượng, giảm thời gian đáp ứng
và tránh tình trạng quá tải trên máy chủ.

##1. Các lợi ích khi sử dụng phương pháp cân bằng tải:

 * **Tăng khả năng đáp ứng, tránh tình trạng quá tải trên máy chủ,** đảm bảo tính linh hoạt và mở rộng cho hệ thống.

 * **Tăng độ tin cậy và khả năng dự phòng cho hệ thống:** Sử dụng cân bằng tải giúp tăng tính HA (High Availability) cho hệ thống, đồng thời đảm bảo cho người dùng không bị gián đoạn dịch vụ khi xảy ra lỗi sự cố lỗi tại một điểm cung cấp dịch vụ.

 * **Tăng tính bảo mật cho hệ thống:** Thông thường khi người dùng gửi yêu cầu dịch vụ đến hệ thống, yêu cầu đó sẽ được xử lý trên bộ cân bằng tải, sau đó thành phần cân bằng tải mới chuyển tiếp các yêu cầu cho các máy chủ bên trong. Quá trình trả lời cho khách hàngcũng thông qua thành phần cân bằng tải, vì vậy mà người dùng không thể biết được chính xác các máy chủ bên trong cũng như phương pháp phân tải được sử dụng. Bằng cách này có thể ngăn chặn người dùng giao tiếp trực tiếp với các máy chủ, ẩn các thông tin và cấu trúc mạng nội bộ, ngăn ngừa các cuộc tấn công trên mạng hoặc các dịch vụ không liên quan đang hoạt động trên các cổng khác.

##2. Chức năng của cân bằng tải

Cân bằng tải có một số chức năng cơ bản sau:
- Chặn lưu lượng mạng (chẳng hạn lưu lượng web) đến một trang web. Bản thân thiết bị cân bằng tải có thể là một Proxy hay một Firewall tầng ứng dụng (Application Layer), nó sẽ là đối tượng đầu tiên nhận các yêu cầu trước khi chia tải, do đó, chức năng này được coi như là thiết yếu của một cân bằng tải.
- Tách các lưu lượng thành các yêu cầu riêng biệt và quyết định máy chủ nào nhận các yêu cầu đó. Đây là chức năng chủ chốt của cân bằng tải. Tùy vào thuật toán áp dụng mà sẽ có từng cách thức khác nhau để phân chia cụ thể cho mỗi máy chủ.
- Duy trì một cơ chế ở những máy chủ đang sẵn sàng. Giữa  cân bằng tải và máy chủ luôn phải có liên lạc với nhau (Keep Alive) để biết được máy chủ đó còn “sống” hay không.
- Cung cấp khả năng dự phòng bằng cách sử dụng nhiều hơn một kịch bản fail- over.
- Cung cấp khả năng nhận thức nội dung phân tán bằng cách đọc URL, chặn cookie và biên dịch XML. Đây được coi là một trong những tiêu chí chia tải của hệ thống.

##3. Ưu điểm của cân bằng tải
Khả năng của cân bằng tải thể hiện ở các mặt sau:
- Tính linh hoạt (Flexibility): Hệ thống cho phép bổ sung và loại bỏ các máy chủ bất kỳ khi nào cần và hiệu quả ngay tức thì. Thực tế, việc này không làm gián đoạn tới hoạt động của cả hệ thống, mà chỉ tại một điểm (node) trong hệ thống đó. Điều này cho phép duy trì, sửa chữa bất kỳ máy chủ nào trong hệ thống (thậm chí trong giờ cao điểm) mà ít tác động hoặc không có tác động nào tới hệ thống. Một cân bằng tải (Load Balancer) cũng có thể trực tiếp điều khiển lưu lượng mạng bằng cách sử dụng tập tin cookie, phân tích cú pháp URL, các thuật toán tĩnh/động... để tìm ra cách phân tải tối ưu cho hệ thống.
- Tính sẵn sàng cao (High availability): Hệ thống sẽ liên tục kiểm tra trạng thái của các máy chủ trong hệ thống và tự động “loại” bất kỳ máy chủ nào không “trả lời” trong một chu kỳ, cũng như tự động bổ sung máy chủ đó ngay khi nó hoạt động trở lại. Quá trình này là hoàn toàn tự động, thông qua cơ chế giao tiếp của cân bằng tải và các máy chủ, không cần có sự tham gia điều khiển trực tiếp của người quản trị. Do dó, một hệ thống cân bằng tải hướng đến tính dự phòng cho thiết bị chính trong trường hợp có thiết bị nào đó bị “hỏng”.
- Khả năng mở rộng (Scalability): Cân bằng tải chịu trách nhiệm phân phối tải tới nhiều máy chủ trong một hệ thống (Server Farm theo mặt vật lý và được gọi là Server Cluser – các bó Server), với mục đích là nâng cao hiệu quả, tăng sức mạnh phục vụ với số lượng lớn các máy chủ. Điều này mang lại lợi ích lớn về kinh tế, vì chỉ phải chi phí cho nhiều máy chủ nhỏ, thay vì đầu tư cho một máy chủ lớn, thiết bị chuyên dụng. Ngoài ra, trong quá trình hoạt động, số các máy chủ có thể thay đổi, thêm/bớt, loại bỏ, thay thế một cách dễ dàng mà không ảnh hưởng đến hoạt động của hệ thống, giữ cho hệ thống luôn có tính sẵn sàng cao.

##4. Các thuật ngữ
Có nhiều thuật ngữ và khái niệm quan trọng khi nói về cân bằng tải và proxy. Trước khi tìm hiểu các thuật ngữ này, chúng ta hãy nói về ACLs, backends, và frontends.

* Access Control List (ACL):
Trong mối liên hệ với việc cân bằng tải, ACLs thường dùng để test một số điều kiện và thực hiện 1 hành động (như chọn 1 máy chủ hoặc khóa 1 request) dựa trên kết quả test.
Dùng ACLs cho phép chuyển hướng lưu lượng mạng một cách linh động dựa trên nhiều tác nhân giống pattern-matching và 1 số kết nối đến backend. Ví dụ: 
```sh
acl url_blog path_beg /blog
```
ACL này thỏa nếu đường dẫn trong request của người dùng bắt đầu với /blog.
Ví dụ http://yourdomain.com/blog/blog-entry-1.

* Backend
Backend là tập các máy chủ mà nhận các request được chuyển hướng. Backend được định nghĩa trong phần backend của cấu hình HAProxy. Cơ bản, 1 backend có thể được định nghĩa bởi:

	* thuật toán cân bằng tải nào được dùng
	* danh sách các máy chủ và cổng (port)

Một backend có thể chứa 1 hay nhiều máy chủ trong nó, thêm nhiều máy chủ vào backend sẽ gia tăng khả năng tải bằng cách phân phối lượng tải trên nhiều máy chủ. Gia tăng độ tin cậy cũng đạt được trong trường hợp này nếu một trong số các máy chủ của backend bị lỗi.

Ví dụ: 
```sh
backend web-backend:

    balance roundrobin

    server web1 web1.yourdomain.com:80 check

    server web2 web2.yourdomain.com:80 check
```
```sh
backend blog-backend:

    balance roundrobin	//thuật toán cân bằng tải

    mode http	//chỉ ra rằng layer 7 proxy sẽ được dùng

    server blog1 blog1.yourdomain.com:80 check	//Tùy chọn check ở cuối của mỗi chỉ thị server chỉ ra rằng việc kiểm tra sức khỏe (tình trạng của máy chủ) sẽ được thực hiện trên các máy chủ backend.

    server blog2 blog2.yourdomain.com:80 check
```
* Frontend

Một frontend định nghĩa cách thức các request sẽ được chuyển hướng đến backend. Frontend được định nghĩa trong phần frontend của cấu hình HAProxy. Định nghĩa gồm các thành phần sau:

	* Tập các địa chỉ IP và cổng (port) (vd: 10.1.1.7:80, *:443, …)
	* ACLs
	* Các quy tắc use_backend, mà định nghĩa backend nào sẽ được dùng phụ thuộc điều kiện ACL có khớp hay không, và/hoặc 1 quy tắt default_backend xử lý các trường hợp còn lại.

Một frontend có thể được cấu hình cho nhiều loại lưu lượng mạng.

##5. Các loại cân bằng tải. 

![](https://viblo.asia/uploads/images/16f4f44126b2b1b11f9f0e01621d6ab9425240e9/eac00ecc9e7c9a5add5a92ca2532060e565a56b5.png)

* Layer 4 load balancer xử lý dữ liệu tìm thấy trong các giao thức tầng mạng và giao vận (IP, TCP, FTP, UDP).

* Layer 7 load balancer phân phối yêu cầu dựa trên dữ liệu tìm thấy trong tầng ứng dụng, lớp giao thức như HTTP.

###5.1 Layer 4 load balancer

Layer 4 load balancing hoạt động ở tầng trung gian với tầng giao vận của tin nhắn và không liên quan đến nội dung của các tin nhắn.

Transmission Control Protocol (TCP) là các giao thức layer 4 cho giao thức truyền siêu văn bản (HTTP) lưu lượng truy cập trên Internet.

Layer 4 load balancer chỉ đơn giản là chuyển tiếp gói dữ liệu mạng đến và đi từ máy chủ upstream mà không kiểm tra nội dung của các gói dữ liệu.

Có thể đưa ra quyết định định tuyến giới hạn bằng kiểm tra vài gói đầu tiên trong dòng TCP. 

Nếu 1 request đến http://yourdomain.com/anything, lưu lượng sẽ được chuyển hướng đến backend mà xử lý tất cả các request cho yourdomain.com trên port 80)

Ví dụ: 

![](https://dinhnguyenngoc.files.wordpress.com/2014/08/clip_image0024_thumb.png?w=690&h=248)

Người dùng truy xuất load balancer, nó sẽ chuyển hướng request đến các máy chủ của web-backend.
Máy chủ backend được chọn sẽ hồi đáp trực tiếp request người dùng.
Thường, tất cả các máy chủ trong web-backend phải phục vụ nội dung giống hệt nhau – nếu không, người dùng có thể nhận nội dung không phù hợp.
Lưu ý rằng cả 2 máy chủ web kết nối đến cùng máy chủ database.


###5.2 Layer 7 load balancer

Layer 7 load balancing hoạt động ở các lớp ứng dụng cao cấp, xử lý trực tiếp với nội dung thực tế của mỗi thư.

HTTP là giao thức chủ yếu của layer 7 cho việc điều phôi lưu lượng truy cập trang web trên Internet.

Layer 7 load balancer điều phối lưu lượng theo một cách tinh vi hơn so với layer 4 load balancer, đặc biệt là áp dụng đối với TCP dựa trên lưu lượng truy cập chẳng hạn như HTTP.

Một Layer 7 load balancer chấm dứt mạng lưới giao vận và đọc message bên trong. Nó có thể quyết định cân bằng tải dựa trên nội dung của thư (URL hoặc cookie, ...). Sau đó tạo mới một kết nối TCP mới đến máy chủ upstream đã chọn (hoặc tái sử dụng nếu sẵn có bằng phương pháp HTTP keepalives) và tạo ra yêu cầu đến máy chủ.

Dùng layer 7 cho phép load balancer chuyển hướng request đến các máy chủ backend khác nhau dựa trên nội dung request. Chế độ cân bằng tải này cho phép bạn chạy nhiều máy chủ ứng dụng web dưới cùng domain và port. 

Ví dụ:

![](https://dinhnguyenngoc.files.wordpress.com/2014/08/clip_image0034_thumb.png?w=690&h=311)

Trong ví dụ này, nếu người dùng yêu cầu yourdomain.com/blog, họ sẽ được chuyển hướng đến blog-backend, là tập các máy chủ chạy ứng dụng blog.
Các request khác được chuyển hướng đến web-backend, mà có thể chạy các ứng dụng khác. Trong ví dụ này, cả 2 backend dùng cùng máy chủ database.

##6. Các thuật toán cân bằng tải

###6.1. Round Robin
Là thuật toán luân chuẩn vòng, các máy chủ sẽ được xem ngang hàng và sắp xếp theo một vòng quay. Các truy vấn dịch vụ sẽ lần lượt được gửi tới các máy chủ theo thứ tự sắp xếp

Ví dụ:
```sh
Cấu hình một cụm Cluster bao gồm 03 máy chủ: A, B, C.
Yêu cầu dịch vụ thứ nhất sẽ được gửi đến máy chủ A.
Yêu cầu dịch vụ thứ hai sẽ được gửi đến máy chủ B.
Yêu cầu dịch vụ thứ ba sẽ được gửi đến máy chủ C.
…
Yêu cầu dịch vụ thứ tư sẽ lại được gửi cho máy chủ A….
```

![](https://lh5.googleusercontent.com/h4SOh9JyAFuJY1oBD5meRIP57QdxtQFeCWfS7_xPaQBURdEnq6B9cI1xZn3mIOaw3APdz1_1IQ-Ll7G7i6xQRU0t-M8ajQPVDpq9-BBlCBqA7v4LBnPnvR6SzrzhHf44nSo7IAGLGvslKy_k)

Nhược điểm: khi có 2 yêu cầu liên tục từ phía người dùng sẽ có thể được gửi vào 2 server khác nhau.
Điều này làm tốn thời gian tạo thêm kết nối với server thứ 2 trong khi đó server thứ nhất cũng có thể trả lời được thông tin mà người dùng đang cần.
Để giải quyết điều này, round robin thường được cài đặt cùng với các phương pháp duy trì session như sử dụng cookie.
	
###6.2. Thuật toán Weighted Round Robin
Tương tự như kỹ thuật Round Robin nhưng WRR còn có khả năng xử lý theo cấu hình của từng server đích. Mỗi máy chủ được đánh giá bằng một số nguyên (giá trị trọng số Weight – mặc định giá trị là 1). Một server có khả năng xử lý gấp đôi server khác sẽ được đánh số lớn hơn và nhận được số request gấp đôi từ bộ cân bằng tải
Ví dụ:
```sh
Cấu hình một cụm Cluster bao gồm 03 máy chủ: A, B, C. với khả năng xử lý của máy A lơn hơn máy B và lớn hơn máy C.
Chúng ta thiết sẽ lập trọng số weight cho các server A, B, C lần lượt là 4,3,2.
Thứ tự điều phối luân phiên các request sẽ là AABABCABC
Yêu cầu dịch vụ thứ nhất sẽ được gửi đến máy chủ A.
Yêu cầu dịch vụ thứ hai sẽ được gửi đến máy chủ A.
Yêu cầu dịch vụ thứ ba sẽ được gửi đến máy chủ B.
Yêu cầu dịch vụ thứ tư sẽ lại được gửi cho máy chủ A….
```
![](https://lh6.googleusercontent.com/a-nulbkkPkfkG0J585BpIxXI53E6r1aWhOO6tFewE235JnQtsN2kYfqBGbk7CsplZMcGHZMEtqTFPQeoCcrVeGmrDPJUtn2PofpbLxvKGpsr-tcgZbG0mcgnbbwmXFinvxqiQkocfXe3YFqE)

Nhược điểm:
	* Sử dụng thuật toán này có thể dẫn đến việc mất cân bằng tải động nếu như tải của các request liên tục thay đổi trong một khoảng thời gian rộng
	* Ví dụ các yêu cầu xem video hoặc tải các file có dung lượng lớn xen kẽ với các yêu cầu đọc thông tin,…). Như vậy nó sẽ dồn request tới 1 server có trọng số Weight cao và làm mất khả năng load balancing.
	* Trong một khoảng thời gian ngắn, hoàn toàn có khả năng phần lớn các yêu cầu có tải cao sẽ được chuyển hướng đến một server.

###6.3. Thuật toán Dynamic Round Robin (DRR)
Thuật toán DRR hoạt động gần giống với thuật toán WRR, điểm khác biệt là trọng số ở đây dựa trên sự kiểm tra server một cách liên tục, do đó trọng số liên tục thay đổi.

Đây là thuật toán động (các thuật toán ở trên là thuật toán tĩnh), việc chọn server sẽ dựa trên rất nhiều khía cạnh trong việc phân tích hiệu năng của server trên thời gia thực (ví dụ: số kết nối hiện đang có trên các server hoặc server trả lời nhanh nhất, …).

Thuật toán này thường không được cài đặt trong các bộ cân bằng tài đơn giản, nó thường được sử dụng trong các sản phẩm cân bằng tải của F5 Network.

###6.4. Thuật toán Fastest (Thuật toán Least Response Time)
Đây là thuật toán dựa trên tính toán thời gian đáp ứng của mỗi server (response time), thuật toán này sẽ chọn server nào có thời gian đáp ứng nhanh nhất.

Thời gian đáp ứng được xác định bởi khoảng thời gian giữa thời điểm gửi một gói tin đến server và thời điểm nhận được gói tin trả lời.

Việc gửi và nhận này sẽ được bộ cân bằng tải đảm nhiệm, dựa trên thời gian đáp ứng, bộ cân bằng tải sẽ biết chuyển yêu cầu tiếp theo đến server nào.

![](https://lh4.googleusercontent.com/bxaHaxJBUBebi9i9kUilCpnN4peK3ELPv_OWy-6UNdRUoEgal-vn-9uKym1roAB1GRh0BIctWi6EItorrHi5ZSY9Qq3QfK-wZihwotQisk-taKMp01bBTokNVUJ5yH0FkB56e4-5HTc9JM8x)

Ví dụ:
```sh
Khi truy cập vào trang youtube.com, nếu IP của người dùng đến từ Việt Nam, yêu cầu sẽ được chuyển vào server Việt Nam xử lý. Điều này sẽ tiết kiệm khá lớn cho lượng băng thông quốc tế và cải thiện tốc độ đường truyền.
```
Thuật toán fastest thường được dùng khi các server ở các vị trí địa lý khác nhau. Như vậy người dùng ở gần server nào thì thời gian đáp ứng của server đó sẽ nhanh nhất, và server đó sẽ được chọn để phục vụ.

###6.5. Thuật toán Lest Connection (LC)
Các request sẽ được chuyển vào server có ít kết nối nhất trong hệ thống. Thuật toán này được coi như thuật toán động, vì nó phải đếm số kết nối đang hoạt động của server.

Với một hệ thống có các server gần giống nhau về cấu hình, LC có khả năng hoạt động tốt ngay cả khi tải của các kết nối biến thiên trong một khoảng lớn. Do đó nếu sử dụng RC sẽ khắc phục được nhược điểm của RR.

![](https://lh3.googleusercontent.com/2NKoJM4jyEhxN_wS6HdndhtuH6Zai0QH5Gp8nU6G-hy5VULhJ5JlBLl2YGydEaLVZXdcc-pwlEPOWQ38OogTOmJicMeWVxWxJTrmmjgp_WbjLLXZtnZifgql-NSJTgaJao1OrAX5HNiMCRqj)

Nhìn bên ngoài có vẻ như LC hoạt động tốt khi các server có cấu hình biến thiên khác nhau, tuy nhiên trên thực tế đều đó là không đúng.

Nhược điểm:
	* Trạng thái TIMVE_WAIT của TCP thường được đặt là 2 phút, trong 2 phút đó có một server bận rộn có thể nhận hàng chục ngàn kết nối liên tục.
	* Giả sử server A có khả năng xử lý gấp đôi server B, server A đang xử lý hàng ngàn những yêu cầu và giữ những yêu cầu này trong trạng thái TIME_WAIT của TCP. Trong khi đó server B cũng phải xử lý như server A nhưng vì cấu hình server B thấp hơn nên sẽ chậm hơn rất nhiều. Như vậy thuật toán LC hoạt động không tốt khi các server có cấu hình khác nhau.

###6.6. Thuật toán Weights Least Connection:

Bản chất giống thuật toán Least Connection, nhưng chúng ta có thể cấu hình ưu tiên cho một máy chủ trong cụm máy chủ hoạt động.

###6.7. Source

Chọn máy chủ dựa trên 1 hash của source IP, ví dụ IP address của người dùng của bạn. Đây là 1 phương pháp nhằm đảm bảo rằng 1 người dùng sẽ kết nối đến cùng 1 máy chủ.


##7. Các phần mềm triển khai

###7.1 HAproxy (Layer 4)
HAproxy là một load balancer HTTP và TCP mạnh mẽ, nó cho phép duy trì trạng thái dựa vào cookies, thay đổi theo nội dung, automatic failover, Web-based reporting, advanced logging và nhiều đặc điểm khác.

Hệ thống điều khiển trạng thái có thể xử lý 20,000 truy cập/giây thậm chí hàng chục nghìn kết nối cùng lúc!

Homepage:http://haproxy.1wt.eu/

###7.2 Linux Virtual Server (Layer 4)
Đây là một dự án nhằm mục đích nhóm cùng nhau nhiều server thực vào một khối duy nhất gọi là một  virtual server với tính sẵn sàng cao.

LVS load balancer xử lý các kết nối từ client và pass chúng vào các server thực (thường gọi là Layer 4 switching) và có thể xử lý hầu hết các dịch vụ TCP/UDP thông dụng như HTTP, HTTPS, NNTP, FTP, DNS, ssh, POP3, IMAP4, SMTP, etc.

Nó hoàn toàn trong suốt với người dùng hay nói cách khác người dùng không hề biết về sự có mặt của virtual server này.

Homepage: http://www.LinuxVirtualServer.org/

###7.3 Nginx
Nginx - Máy chủ web nhanh và đáng tin cậy được dùng cho proxy và cân bằng tải.

Nginx thường dùng kết hợp với HAProxy cho việc lưu đệm (caching) và nén dữ liệu (compression) của mình.

###7.4 BalanceNG
BalanceNG là giải pháp load balancing based-IP mới, nhỏ gọn, mạnh mẽ và dễ dàng setup.

BalanceNG cho phép duy trì các session (session persistence), các phương pháp distribute khác nhau như : Round Robin, Random, Weighted Random, Least Session, Least Bandwidth, Hash, Agent, and Randomized Agent và một bộ kiểm tra trạng thái.

BalanceNG cũng  hỗ trợ VRRP để setup HA trên nhiều nodes.

Vì cho phép database thực thi ngay trên bộ nhớ nên BalanceNG sử dụng các IP-to-location (location-based) server cho tốc độ xử lý vô cùng mạnh mẽ.

Homepage:http://www.inlab.de/balanceng/

###7.5 Pound


### MultiLoad
MultiLoad là một load balancer cho phép redirects các HTTP requests đến các server có sẵn.

Đó là giải pháp để cân bằng lượng tải và giấu đi vị trí thật của server.

Các servers có mức độ ưu tiên khác nhau với traffic đang hoạt động.

