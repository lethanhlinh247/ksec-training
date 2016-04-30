#DNS - Domain Name System
DNS được sử dụng để ánh xạ tên miền thành địa chỉ ip và ngược lại.

##1. Cấu trúc của hệ thống tên miền (DNS)
###1.1 Cấu trúc cơ sở dữ liệu.
* Cơ sở dữ liệu của hệ thống DNS là hệ thống cơ sở dữ liệu phân tán và phân cấp hình cây. Với .Root server là đỉnh của cây và sau đó các miền (domain) được phân nhánh dần xuống dưới và phân quyền quản lý.
	
	Khi một máy khách (client) truy vấn một tên miền nó sẽ đi lần lượt từ root phân cấp xuống dưới để đến DNS quản lý domain cần truy vấn.
	
	Tổ chức quản lý hệ thống tên miền trên thế giới là The Internet Coroperation for Assigned Names and Numbers (ICANN) .Tổ chức này quản lý mức cao nhất của hệ thống tên miền (mức root) do đó nó có quyền cấp phát các tên miền ở mức cao nhất gọi là Top-Level-Domain.

	Cấu trúc của dữ liệu được phân cấp hình cây root quản lý toàn bộ sơ đồ và phân quyền quản lý xuống dưới và tiếp đó các tên miền lại được chuyển xuống cấp thấp hơn (delegale) xuống dưới.
* **Zone**
	* Hệ thống tên miền(DNS) cho phép phân chia tên miền để quản lý và nó chia hệ thống tên miền thành zone và trong zone quản lý tên miền được phân chia đó.
	
	* Các Zone chứa thông tin vê miền cấp thấp hơn, có khả năng chia thành các zone cấp thấp hơn và phân quyền cho các DNS server khác quản lý.

	* Ví dụ : Zone “.vn” thì do DNS server quản lý zone “.vn” chứa thông tin về các bản ghi có đuôi là “.vn” và có khả năng chuyển quyền quản lý (delegate) các zone cấp thấp hơn cho các DNS khác quản lý như “.fpt.vn” là vùng (zone) do fpt quản lý.

* Hệ thống cơ sở dữ liệu của DNS là hệ thống dữ liệu phân tán hình cây như cấu trúc đó là cấu trúc logic trên mạng Internet

###1.2 Máy chủ quản lý tên miền (Domain name server-dns)
* Máy chủ quản lý tên miền (dns) theo từng khu vực, theo từng cấp như : một tổ chức, một công ty hay một vùng lãnh thổ.
	
	Máy chủ đó chứa thông tin dữ liệu về địa chỉ và tên miền trong khu vực , trong cấp mà nó quản lý dùng để chuyển giữa tên miền và địa chỉ IP đồng thời nó cũng có khả năng hỏi các máy chủ quản lý tên miền khác hoặc cấp cao hơn nó để có thể trả lời được các truy vấn về những tên miền không thuộc quyền quản lý của nó và cũng luôn sẵn sàng trả lời các máy chủ khác về các tên miền mà nó quản lý.

* Máy chủ cấp cao nhất là Root Server do tổ chức ICANN quản lý:
	* Là server quản lý toàn bộ cấu trúc của hệ thống tên miền
	* Root Server không chứa dữ liệu thông tin về cấu trúc hệ thống DNS mà nó chỉ chuyển quyền (delegate) quản lý xuống cho các server cấp thấp hơn và do đó root server có khả năng định đường đến của một domain tại bất kì đâu trên mạng
	* Hiện nay trên thế giới có khoảng 13 root server quản lý toàn bộ hệ thống Internet.
	
* Một DNS server có thể nằm bất cứ vị trí nào trên mạng Internet nhưng được cấu hình logic để phân cấp chuyển tên miền cấp thấp hơn xuống cho các DNS server khác nằm bất cứ vị trí nào trên mạng Internet. Nhưng tốt nhất là đặt DNS tại vị trí nào gần với các client để dễ dàng truy vấn đến đồng thời cũng gần với vị trí của DNS server cấp cao hơn trực tiếp quản lý nó.
* Các loại DNS server

####1.2.1 Primary Name Server
* Mỗi Domain phải có 1 Primary Name Server. Server này được register trên Internet để quản lý Domain. Mọi người trên Internet đều biết tên máy tính và IP của Server này.
	
	Người quản trị DNS sẽ tổ chức các cơ sở dữ liệu DNS trên Primary Name Server. Server này đảm nhận vai trò chính trong việc phân giải tất cả các máy tính trong Domain hay Zone

####1.2.2 Secondary Name Server
* Mỗi Domain có 1 Primary Name Server để quản lý cơ sở dữ liệu DNS. Nếu như Server này tạm ngưng hoạt động vì 1 lý do nào đó thì việc phân giải DNS bị gián đoạn. Để tránh trường hợp này ngườ ta đã thiết kế ra 1 máy chủ dự phòng gọi là Secondary Name Server (hay còn gọi là Slave).
	
	Khi Secondary Name Server được khởi động nó sẽ tìm Primary Name Server nào mà nó được phép lấy dữ liệu về máy. Nó sẽ copy lại toàn bộ CSDL DNS của Primary Name Server mà nó được phép transfer (quá trình này gọi là quá trình Zone Transfer). Theo 1 chu kỳ nào đó do người quản trị quy định thì Secondary Name Server sẽ sao chép và cập nhật CSDL từ Primary Name Server.

####1.2.3 Caching Name Server
* Caching Name Server không có bất kỳ tập tin CSDL nào. Nó có chức năng phân giải tên máy trên những mạng ở xa thông qua những Name Server khác. Nó sẽ lưu lại những thông tin đã được phân giải trước đó và được sử dụng lại những thông tin này nhằm mục đích :

	* Làm tăng tốc độ phân giải bằng cách sử dụng cache.
	* Giảm bớt gánh nặng phân giải tên máy cho các Name Server.
	* Giảm việc lưu thông trên những mạng lớn.
	
###1.3 Các bản ghi thường có trong cơ sở dữ liệu của DNS serrver
####1.3.1 Bản ghi SOA (Start of Authority )

* Bản ghi này xác định máy chủ DNS có thẩm quyền cung cấp thông tin về tên miền xác định trên DNS.
* Trong mỗi tập tin CSDL phải có 1 và chỉ 1 record SOA. Bảng ghi SOA này chỉ ra rằng Primary Name Server là nơi cung cấp thông tin tin cậy từ dữ liệu có trong zone.
* Cú pháp:
```sh

[tên-miền] IN SOA [tên-DNS-Server] [địa-chỉ-email] (

Serial number;

Refresh number;

Retry number;

Experi number;

Time-to-line number)

```
* Ví dụ:
```sh
Ví dụ :

ksec.com. IN SOA ns.ksec.com. root.ksec.com. (

1 ; serial

10800 ; refresh after 3 hours

3600 ; retry after 1 hours

604800 ; expire after 1 week

86400 ) ; minimum TTL of 1 day
```
Giải thích ý nghĩa ví dụ trên :

- Tên Domain : ksec.com. phải ở vị trí cột đầu tiên và kết thúc bằng dấu chấm (.).

- IN là Internet

- ns.ksec.com. là tên FQDN của Primary Name Server của dữ liệu này.

- root.ksec.com. là địa chỉ email của người phụ trách dữ liệu này. Lưu ý là địa chỉ email thay thế dấu @ bằng dấu chấm sau root.

- Dấu ( ) cho phép ta mở rộng ra viết thành nhiều dòng, tất cả các tham số trong dấu ( ) được dùng cho các Secondary Name Server.

Các thành phần bên trong cú pháp của record SOA :

+ Serial : áp dụng cho mọi dữ liệu trong zone và là 1 số nguyên. Trong ví dụ, giá trị này là 1 nhưng thông thường người ta sẽ sử dụng theo định dạng thời gian như 2007092001. Định dạng này theo kiểu yyyymmddnn, trong đó nn là số lần sửa đổi dữ liệu zone trong ngày. Bất kể theo định dạng nào thì luôn luôn phải tăng số này lên mỗi lần sửa đổi dữ liệu zone. Khi Secondary Name Server liên lạc với Primary Name Server thì trước tiên nó sẽ hỏi số serial này. Nếu số serial của máy Secondary nhỏ hơn số serial của máy Primary tức là dữ liệu trên Secondary đã cũ và sau đó máy Secondary sẽ sao chép dữ liệu mới từ máy Primary thay cho dữ liệu đang có.

+ Refresh : chỉ ra khoản thời gian máy Secondary kiểm tra dữ liệu zone trên máy Primary để cập nhật nếu cần. Trong ví dụ trên thì cứ mổi 3 giờ máy chủ Secondary sẽ liên lạc với máy chủ Primary để cập nhật nếu có. Giá trị này thay đổi theo tần suất thay đổi dữ liệu trong zone.

+ Retry : nếu máy Secondary không kết nối được với máy Primary theo thời hạn mô tả trong refresh (ví dụ trường hợp máy Primary shutdown máy vào lúc đó) thì máy Secondary sẽ tìm cách kết nối lại với máy Primary theo chu kỳ thời gian được xác định trong retry. Thông thường giá trị này nhỏ hơn giá trị refresh

+ Expire : nếu sau khoản thời gian này mà máy Secondary không cập nhật được thông tin mới trên máy Primay thì giá trị của zone này trên máy Secondary sẽ bị hết hạn. Nếu bị expire thì Secondary sẽ không trả lời bất cứ 1 truy vấn nào về zone này. Giá trị expire này phải lớn hơn giá trị refresh và giá trị retry.

+ TTL : giá trị này áp dụng cho mọi record trong zone và được đính kèm trong thông tin trả lời 1 truy vấn. Mục đích của nó là chỉ ra thời gian mà các máy DNS Server khác cache lại thông tin trả lời. Giúp giảm lưu lượng truy vấn DNS trên mạng.

####1.3.2 Bản ghi NS
* Bản ghi NS dùng để khai báo máy chủ tên miền cho một tên miền. Nó cho biết các thông tin về tên miền quản lý, do đó yêu cầu có tối thiểu hai bản ghi NS cho mỗi tên miền.
* Cú pháp của bản ghi NS
```sh
<tên miền> IN NS <tên của máy chủ tên miền>
```
Ví dụ:
```sh
ksec.com IN NS dns1.ksec.com
ksec.com IN NS dns2.ksec.com
```
Với khai báo trên, tên miền ksec.com sẽ do máy chủ tên miền có tên dns.ksec.com quản lý. Điều này có nghĩa, các bản ghi như A, CNAME, MX … của tên miền cấp dưới của nó sẽ được khai báo trên máy chủ dns1.ksec.com. và dns2.ksec.com.

####1.3.3 Bản ghi kiểu A
* Bản ghi kiểu A được dùng để khai báo ánh xạ giữa tên của một máy tính trên mạng và địa chỉ IP của một máy tính trên mạng.
* Bản ghi kiểu A có cú pháp như sau:
```sh
Domain IN A <địa chỉ IP của máy>
```
* Ví dụ :
```sh
ksec.com IN A 10.10.10.4
```
=> Theo ví dụ trên, tên miền ksec.com được khai với bản ghi kiểu A trỏ đến địa chỉ 10.10.10.4 sẽ là tên của máy tính này.

* Một tên miền có thể được khai nhiều bản ghi kiểu A khác nhau để trỏ đến các địa chỉ IP khác nhau. Như vậy có thể có nhiều máy tính có cùng tên trên mạng. Ngược lại một máy tính có một địa chỉ IP có thể có nhiều tên miền trỏ đến, tuy nhiên chỉ có duy nhất một tên miền được xác định là tên của máy, đó chính là tên miền được khai với bản ghi kiểu A trỏ đến địa chỉ của máy.

####1.3.4 Bản ghi kiểu AAAA
* Ánh xạ tên máy (hostname) vào địa chỉ IP version 6
* Cú pháp : 
```sh
[tên-máy-tính] IN AAAA [địa-chỉ-IPv6]
```
* Ví dụ : 
```sh
Server IN AAAA 1243:123:456:7892:3:456ab
```

####1.3.5 Bản ghi CNAME

* Bản ghi CNAME cho phép một máy tính có thể có nhiều tên. Nói cách khác bản ghi CNAME cho phép nhiều tên miền cùng trỏ đến một địa chỉ IP cho trước.
	
	Để có thể khai báo bản ghi CNAME , bắt buộc phải có bản ghi kiểu A để khai báo tên của máy. Tên miền được khai báo trong bản ghi kiểu A trỏ đến địa chỉ IP của máy được gọi là tên miền chính (canonical domain ). Các tên miền khác muốn trỏ đến máy tính này phải được khai báo là bí danh của tên máy (alias domain).

* Bản ghi CNAME có cú pháp như sau :
```sh
alias-domain IN CNAME canonical domain
```
* Ví dụ :
```sh
www.ksec.com IN CNAME ksec.com
```
Tên miền www.ksec.com sẽ là tên bí danh của tên miền ksec.com, hai tên miền www.ksec.com sẽ cùng trỏ đến địa chỉ IP 10.10.10.4

####1.3.6 Bản ghi MX
* Bản ghi MX dùng để khai báo trạm chuyển tiếp thư điện tử của một tên miền.
* Ví dụ : Để các thư điện tử có cấu trúc user@ksec.com được gửi đến trạm chuyển tiếp thư điện tử có tên mail.ksec.com, trên cơ sở dữ liệu cần khai báo bản ghi MX như sau:
```sh
ksec.com IN MX 10 mail.ksec.com
```
* Các thông số được khai báo trong bản ghi MX nêu trên gồm có:
	* ksec.com : là tên miền được khai báo để sử dụng như địa chỉ thư điện tử.
	* mail.ksec.com: là tên của trạm chuyển tiếp thư điện tử, nó thực tế là tên của máy tính dùng làm máy trạm chuyển tiếp thư điện tử.
	* 10: Là giá tri ưu tiên, giá trị ưu tiên có thể là một số nguyên bất kì từ 1 đến 225, nếu giá trị ưu tiên này càng nhỏ thì trạm chuyển tiếp thư điện tử được khai báo sau đó sẽ là trạm chuyển tiếp thư điện tử được chuyển đến đầu tiên.

* Ví dụ nếu khai báo:
```sh
ksec.com IN MX 10 mail.ksec.com
ksec.com IN MX 20 backupmail.ksec.com
```
Thì tất cả các thư điện tử có cấu trúc địa chỉ user@ksec.com trước hết sẽ được gửi đến trạm chuyển tiếp thư điện tử mail.ksec.com. Chỉ trong trường hợp may chủ mail.ksec.com không thể nhận thư thì các thư này mới chuyển đến trạm chuyển tiếp thư điện tử backupmail.ksec.com


####1.3.7 Bản ghi PTR
* Hệ thống DNS không những thực hiện việc chuyển đổi từ tên miền sang địa chỉ IP mà còn thực hiện chuyển đổi địa chỉi IP mà còn thực hiện chuyển đổi địa chỉ IP sang tên miền.
	
	Bản ghi PTR cho phép thực hiện chuyển đổi địa chỉ IP sang tên miền. Cú pháp của bản ghi PTR:
```sh
4.10.10.10.in-addr.arpa IN PTR www.ksec.com
```
Bản ghi PTR trên cho phép tìm tên miền www.ksec.com khi biết địa chỉ IP (10.10.10.4) mà tên miền trỏ tới.

##2. Nguyên tắc làm việc của DNS

* Mỗi nhà cung cấp dịch vụ vận hành và duy trì DNS server riêng của mình, gồm các máy bên trong phần riêng của mỗi nhà cung cấp dịch vụ đó trong Internet. 

	Tức là, nếu một trình duyệt tìm kiếm địa chỉ của một website thì DNS server phân giải tên website này phải là DNS server của chính tổ chức quản lý website đó chứ không phải là của một tổ chức ( nhà cung cấp dịch vụ ) nào khác.

* INTERNIC ( Internet Network Information Center ) chịu trách nhiệm theo dõi các tên miền và các DNS server tương ứng.

	INTERNIC là một tổ chức được thành lập bởi NFS ( National Science Foundation ), AT&T và Network Solution, chịu trách nhiệm đăng ký các tên miền của Internet.

	INTERNIC chỉ có nhiệm vụ quản lý tất cả các DNS server trên Internet chứ không có nhiệm vụ phân giải tên cho từng địa chỉ.

* DNS có khả năng tra vấn các DNS server khác để có được một cái tên đã được phân giải. DNS server của mỗi tên miền thường có hai việc khác biệt.

	* Thứ nhất, chịu trách nhiệm phân giải tên từ các máy bên trong miền về các địa chỉ Internet, cả bên trong lẫn bên ngoài miền nó quản lý.

	* Thứ hai, chúng trả lời các DNS server bên ngoài đang cố gắng phân giải những cái tên bên trong miền nó quản lý.

* DNS server có khả năng ghi nhớ lại những tên vừa phân giải. Để dùng cho những yêu cầu phân giải lần sau. Số lượng những tên phân giải được lưu lại tùy thuộc vào quy mô của từng DNS.


