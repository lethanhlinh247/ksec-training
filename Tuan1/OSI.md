#Mô hình OSI
##1.1 Chức năng
Tạo ra sự đồng bộ để có thể kết nối, trao đổi thông tin giữa các hệ thống mạng máy tính khác nhau.
##1.2 Cấu tạo
Chia thành 7 tầng

![](http://2.bp.blogspot.com/_oI4G5UUCxnU/TRxegRxWZaI/AAAAAAAAAJ4/49EnNEMpPt8/s1600/osi.gif)


###1.2.1 Tầng Physical (Tầng vật lý)
Có nhiệm vụ đảm bảo việc kết nối vật lý giữa 2 hệ thống.

Điều phối các chức năng cần thiết để truyền luồng bit đi qua môi trường vật lý. 

*Lớp vật lý liên quan đặc tính sau:*

*	**Đặc tính vật lý của giao diện và môi trường:** lớp vật lý định nghĩa các đặc tính của giao diện giữa các thiết bị và môi trường truyền. Ngoài ra, lớp còn định nghĩa dạng của môi trường truyền.

*	**Biểu diễn các bit:** Dữ liệu lớp vật lý bao gồm dòng các bit (chuỗi các giá trị 0 và 1) mà không cần phải phiên dịch. Để truyền dẫn thì các bit này phải được mã hóa thành tín hiệu - điện hay quang. Lớp vật lý định nghĩa dạng mã hóa (phương thức các giá trị 0 và 1 được chuyển đổi thành tín hiệu).

*	**Tốc độ dữ liệu:** Số bit được truyền đi trong một giây. Nói cách khác, lớp vật lý định nghĩa độ rộng mỗi bit.

*	**Đồng bộ  bit:** Máy phát và máy thu cần được đồng bộ hóa theo cấp độ bit. Nói cách khác, đồng hồ của máy phát và máy thu phải được đồng bộ hóa.

*	**Cấu hình đường dây:** Lớp vật lý còn giải quyết phương thức thiết bị được nối với môi trường. Trong cấu hình điểm - điểm, hai thiết bị được nối với nhau qua kết nối được chỉ định. Trong cấu hình điểm nối nhiều điểm, một kết nối được chia sẻ cho nhiều thiết bị.

*	**Tôpô mạng:** định nghĩa phương thức kết nối thiết bị để tạo thành mạng. Thiết bị có thể được nối theo lưới, sao, cây, vòng hay bus.

*	**Chế độ truyền:** lớp vật lý định nghĩa chiều truyền dẫn giữa hai thiết bị: đơn công, bán song công hay song công. Trong chế độ đơn công (simplex) chỉ có thông tin một chiều, trong bán song công (half duplex) hai thiết bị có thể nhận và gởi nhưng không đồng thời. Trong chế độ song công (full duplex) hai thiết bị có thể gởi và nhận đồng thời.

###1.2.2 Tầng Data Link
Lớp kết nối dữ liệu truyền các dữ liệu thô từ lớp vật lý thành dữ liệu có độ tin cây cao hơn và có thể truyền khung (frame) từ nút đến nút. 

*Lớp kết nối dữ liệu có các đặc tính liên quan như sau:*
*	**Tạo khung (framing):** lớp điều khiển kết nối chia dòng bit nhận được thành các đơn vị dữ liệu quản lý được gọi là khung (frame). 

*	**Định (tạo) địa chỉ vật lý:** nếu frame được phân phối đến nhiều hệ thống trong mạng, thì lớp kết nối dữ liệu thêm vào frame một header để định nghĩa địa chỉ vật lý của nơi phát (địa chỉ nguồn) và/hay nơi nhận (địa chỉ đích). Nếu frame nhằm gởi đến hệ thống ngoài mạng của nguồn phát, thì địa chỉ nơi nhận là địa chỉ của thiết bị nối với mạng kế tiếp.

*	**Điều khiển lưu lượng:** nếu tốc độ nhận dữ liệu của máy thu bé hơn so với tốc độ của máy phát, thì lớp kết nối dữ liệu tạo cơ chế điều khiển lưu lượng tránh quá tải của máy thu

*	**Kiểm tra lỗi:** lớp kết nối dữ liệu thêm khả năng tin cậy cho lớp vật lý bằng cách thêm cơ chế phát hiện và gởi lại các frame bị hỏng hay thất lạc. Đồng thời, cũng tạo cơ chế tránh gởi trùng các frame. Kiểm tra lỗi thường được thực hiện nhờ trailer được thêm vào ở phần cuối của frame.

*	**Điều khiển truy cập:** khi hai hay nhiều thiết bị được kết nối trên cùng một đường truyền, cần có giao thức của lớp kết nối dữ liệu để xác định thiết bị nào nắm quyền trên kết nối tại một thời điểm.

###1.2.3 Tầng Network

Nhằm phân phối các gói (packet) từ nguồn đến đích có thể đi qua nhiều mạng, lớp mạng cho phép chuyển giao gói này đi được từ một điểm nguồn đến điểm đích cuối cùng (có thể khác mạng).

*Các đặc tính liên quan của lớp mạng là:*

*	**Định (tạo) địa chỉ logic:** địa chỉ vật lý do lớp kết nối dữ liệu chỉ giải quyết được vấn đề định địa chỉ cục bộ. Nếu gói dữ liệu đi qua vùng biên của mạng, thì nhất thiết phải có thêm một hệ thống định địa chỉ khác giúp phân biệt giữa hệ thống nguồn và hệ thống đích. Lớp mạng thêm header vào gói từ lớp trên xuống, trong đó chứa địa chỉ logic của nơi gởi và nơi nhận.

*	**Định tuyến (routing):** khi nhiều mạng  độc lập được nối với nhau để tạo ra liên mạng (mạng của mạng) hay một mạng lớn hơn, thì thiết bị kết nối là bộ định tuyến (router hay gateways) được dùng để chuyển đường đi được đến đích, lớp mạng được thiết lập cho mục tiêu này.

###1.2.4 Tầng Transport
Lớp vận chuyển nhằm chuyển toàn bản tin từ thiết bị đầu cuối phát  đến thiết bị đầu cuối thu (end to end). 

Bảo đảm toàn bản tin đều đến là nguyên vẹn và theo thứ tự, bỏ qua việc kiểm tra lỗi, và điều khiển lưu lượng tại cấp nguồn đến đích. 

Để tăng cường tính an ninh, lớp vận chuyển có thể tạo một kết nối giữa hai cổng cuối. Kết nối là một đường nối logic giữa nguồn và đích liên quan đến mọi gói trong bản tin. Việc tạo kết nối bao gồm ba bước: thiết lập kết nối, truyền dữ liệu, và nhả kết nối. 

Thông qua việc xác nhận việc truyền dẫn tất cả mọi gói trên một đường, lớp vận chuyển kiểm soát thêm được lên trình tự truyền, lưu lượng, phát hiện và sửa lỗi.

*Các nhiệm vụ của lớp vận chuyển bao gồm:*

*	**Định địa chỉ điểm dịch vụ (service-point addressing):** Một máy tính thường chạy nhiều chương trình trong cùng một lúc. Vì thế, chuyển giao nguồn – đích không có nghĩa là từ một máy tính đến máy khác mà còn từ những quá trình đặc thù (chạy chương trình) lên các chương trình khác. Như thế header của lớp vận chuyển phải bao gồm một dạng địa chỉ đặc biệt là gọi là địa chỉ điểm dịch vụ (service-point addressing) hay còn gọi là địa chỉ cổng. Lớp mạng lấy mỗi gói đến đúng từ máy tính, lớp vận chuyển lấy toàn bản tin đến đúng quá trình của máy tính đó.

*	**Phân đoạn và hợp đoạn:** Một bản tin được chia thành nhiều phân đoạn truyền đi được, mỗi phân đoạn mang số chuỗi. Các số này cho phép lớp vận chuyển tái hợp đúng bản tin khi đến đích để có thể nhận dạng và thay thế các gói bị thất lạc trong khi truyền dẫn. 

*	**Điều khiển kết nối:** Lớp vận chuyển có thể theo hướng kết nối hay không kết nối. Lớp vận chuyển theo hướng không kết nối xử lý mỗi phân đoạn như là gói độc lập và chuyển giao đến lớp vận chuyển của máy đích. Lớp vận chuyển theo hướng kết nối tạo kết nối với lớp vận chuyển của máy đích truớc khi chuyển giao gói. Sau khi chuyển xong dữ liệu, thì kết thúc kết nối. 

*	**Điều khiển lưu lượng:** Tương tự như trong lớp kết nối dữ liệu, lớp vận chuyển có nhiệm vụ điều khiển lưu lượng. Tuy nhiên, điều khiển lưu lượng trong lớp này được thực hiện bằng cách end to end thay vì kết nối đơn. 

*	**Kiểm tra lỗi:** Tương tự như lớp kết nối dữ liệu, lớp vận chuyển cũng có nhiệm vụ kiểm tra lỗi. Tuy nhiên, kiểm tra lỗi trong lớp này  được thực hiện bằng cách end to end thay vì kết nối đơn. Lớp vận chuyển của máy phát bảo đảm là toàn bản tin đến lớp vận chuyển thu không bị lỗi (hỏng hóc, thất lạc hay trùng lắp). Việc sửa lỗi thường được thực hiện trong qua trình truyền lại.

###1.2.5 Tầng Session

Thiết lập, duy trì, giải phóng, và đồng bộ hóa tương tác giữa các hệ thống thông tin.

*Các nhiệm vụ của lớp kiểm soát:*

*	**Điều khiển đối thoại:** Lớp kiểm soát cho phép hai hệ thống đi vào đối thoại. Lớp cho phép thông tin giữa hai quá trình bán song công hoặc song công. Thí dụ đối thoại giữa đầu cuối kết nối với máy chủ là bán song công.

*	**Đồng bộ hoá:** Lớp kiểm soát cho phép quá trình thêm các checkpoint (điểm đồng bộ) vào trong dòng dữ liệu.

###1.2.6 Tầng Presentations

Lớp trình bày liên quan đến vấn đề về cú pháp (syntax) và ngữ nghĩa (sematic) của tin tức trao đổi giữa hai hệ thống. 

Biên dịch, mã hóa, nén dữ liệu tùy thuộc yêu cầu.

*Các nhiệm vụ của lớp là:*

*	**Biên dịch (translation):** Các quá trình (chương trình đang chạy) của hai hệ thống thường trao đổi thông tin theo dạng chuỗi các ký tự, số, v.v...Thông tin này nhất thiết phải được chuyển sang dòng bit trước khi được gởi đi. Do các máy tính khác nhau thường dùng các phương pháp mã hóa khác nhau, nên lớp trình bày có nhiệm vụ vận hành chung trong hai hệ thống này. Lớp trình bày tại máy phát thay đổi dạng thông tin từ dạng của máy phát (sender-depending) sang dạng thông thường. Tại máy thu, thì lớp trình bày chuyển dạng thông thường thành dạng của máy thu (receiving depending).

*	**Mã khóa (encryption) và Giải mã khóa (decryption):** Để mang các thông tin nhạy cảm, hệ thống phải có khả năng bảo đảm tính riêng tư. Mã khóa là quá trình mà máy phát chuyển đổi thông tin gốc thành dạng khác và gởi đi bản tin đi qua mạng. Giải mã khóa (decryption) là quá trình ngược lại nhằm chuyển bản tin trở về dạng gốc. 

*	**Nén:** Nén dữ liệu nhằm giảm thiểu số lượng bit để truyền đi. Nén dữ liệu ngày càng trở nhên quan trọng trong khi truyền multimedia như văn bản, audio, và video.

###1.2.7 Application

Cho phép người dùng (user), là người hay phần mềm, truy cập vào mạng.

Lớp này cung cấp giao diện cho người dùng và hỗ trợ dịch vụ như thư điện tử, remote file access and transfer, shared database management, và các dạng dịch vụ phân phối dữ liệu khác.

*Các đặc tính của lớp này là:*

*	**Mạng đầu cuối ảo (network virtual terminal):** là một version của phần mềm của đầu cuối vật lý và cho phép user log on vào máy chủ (remote host). Để làm việc này, lớp ứng dụng tạo ra một phần mềm mô phỏng đầu cuối cho remote host. Máy tính của user đối thoại phần mềm đầu cuối này, tức là với host và ngược lại. Remote host tưởng là đang đối thoại với terminal của mình và cho phép bạn log on. 

*	**Quản lý, truy cập và truyền dữ liệu (FTAM:** file transfer, access, and management): Ứng dụng này cho phép user truy cập vào remote computer (để đọc hay thay đổi dữ liệu), để truy lục file từ remote computer và quản lý hay điều khiển file từ remote computer.
 
*	**Dịch vụ thư điện tử:**  Ứng dụng này cho cung cấp cơ sở cho việc gởi, trả lời và lưu trữ  thư điện tử.

*	**Dịch vụ thư mục (directory services):** Ứng dụng này cung cấp nguồn cơ sở dữ liệu (database) phân bố và truy cập nguồn thông tin toàn cầu về các dịch vụ và mục đích khác nhau.

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
