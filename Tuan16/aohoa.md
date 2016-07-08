#1. Khái niệm Ảo hóa
Ảo hóa máy chủ là một công nghệ được ra đời nhằm khai thác triệt để khả năng làm việc của các phần cứng trong một hệ thống máy chủ.Nó hoạt động như một tầng trung gian giữa hệ thống phần cứng máy tính và phần mềm chạy trên nó.Ý tưởng của công nghệ ảo hóa máy chủ là từ một máy vật lý đơn lẻ có thể tạo thành nhiều máy ảo độc lập.

* Ảo hóa cho phép tạo nhiều máy ảo trên một máy chủ vật lý, mỗi một máy ảo cũng được cấp phát tài nguyên phần cứng như máy thật gồm có Ram, CPU, Card mạng, ổ cứng, các tài nguyên khác và hệ điều hành riêng. Khi chạy ứng dụng, người sử dụng không nhận biết được ứng dụng đó chạy trên lớp phần cứng ảo.

* Các bộ xử lý có ứng dụng ảo hóa thường là Intel VT(Virtual Technology) hoặc AMD Pacifica.

* **Ảo hóa cứng** còn được gọi là phân thân máy chủ. Dạng ảo hóa này cho phép tạo nhiều máy ảo trên môt máy chủ vật lý. Mỗi máy ảo chạy hệ điều hành riêng và được cấp phát các tài nguyên phần cứng như số xung nhịp CPU, ổ cứng và bộ nhớ... Các tài nguyên của máy chủ có thể được cấp phát động một cách linh động tùy theo nhu cầu của từng máy ảo. Giải pháp này cho phép hợp nhất các hệ thống máy chủ cồng kềnh thành một máy chủ duy nhất và các máy chủ trước đây bây giờ đóng vai trò là máy ảo ứng dụng chạy trên nó.

* **Ảo hóa mềm** còn gọi là phân thân hệ điều hành. Nó thực ra chỉ là sao chép bản sao của một hệ điều hành chính làm nhiều hệ điều hành con và cho phép các máy ảo ứng dụng có thể chạy trên nó. Như vậy, nếu hệ điều hành chủ là Linux thì cách ảo hoá này sẽ cho phép tạo thêm nhiều bản Linux làm việc trên cùng máy. Cách này có ưu điểm là chỉ cần một bản quyền cho một hệ điều hành và có thể sử dụng cho các máy ảo còn lại. Nhược điểm của nó là không thể sử dụng nhiều hệ điều hành khác nhau trên cùng một máy chủ.

##2. Các thành phần của một hệ thống ảo hóa.

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%203.png)

* Tài nguyên vật lý (host machine, host hardware).
* Các phần mềm ảo hóa (virtual software) cung cấp và quản lý môi trường làm việc của các máy ảo.
* Máy ảo (virtual machine): Các máy được cài trên phần mềm ảo hóa.
* Hệ điều hành: Là hệ điều hành được cài trên máy ảo.

###2.1. Tài nguyên vật lý (host machine / host hadware).
Các tài nguyên vật lý trong môi trường ảo hóa cung cấp tài nguyên mà các máy ảo sẽ sử dụng tới. Một môi trường tài nguyên lớn có thể cung cấp được cho nhiều máy ảo chạy trên nó và nâng cao hiệu quả làm việc của các máy ảo .Các tài nguyên vật lý có thể kể đến là là ổ đĩa cứng, ram, card mạng….

###2.2. Các phần mềm ảo hóa (virtual software).
Lớp phần mềm ảo hóa này cung cấp sự truy cập cho mỗi máy ảo đến tài nguyên hệ thống. Nó cũng chịu trách nhiệm lập kế hoạch và phân chia tài nguyên vật lý cho các máy ảo. Phần mềm ảo hóa là nền tảng của một môi trường ảo hóa. Nó cho phép tạo ra các máy ảo cho người sử dụng, quản lý các tài nguyên và cung cấp các tài nguyên này đến các máy ảo.. Ngoài ra phần mềm ảo hóa còn cung cấp giao diện quản lý và cấu hình cho các máy ảo.

###2.3. Máy ảo (virtual machine).
Thuật ngữ máy ảo được dùng chung khi miêu tả cả máy ảo (lớp 3) và hệ điều hành ảo (lớp 4). Máy ảo thực chất là một phần cứng ảo, một môi trường hay một phân vùng trên ổ đĩa. Trong môi trường này có đầy đủ thiết bị phần cứng như một máy thật . Đây là một kiểu phần mềm ảo hóa dựa trên phần cứng vật lý. Các hệ điều hành khách mà chúng ta cài trên các máy ảo này không biết phần cứng mà nó nhìn thấy là phần cứng ảo.

###2.4. Hệ điều hành khách(guest operating system).
Hệ điều hành khách được xem như một phần mềm (lớp 4) được cài đặt trên một máy ảo (lớp 3) giúp ta có thể sử dụng dễ dàng và xử lý các sự cố trong môi trường ảo hóa. Nó giúp người dùng có những thao tác giống như đang thao tác trên một lớp phần cứng vật lý thực sự.

Khi có đủ các thành phần trên, người dùng có thể xây dựng cho mình một hệ thống ứng dụng ảo hóa. Ngoài việc lựa chọn phần cứng cho thích hợp, người dùng còn cần cân nhắc xem phải sử dụng phần mềm ảo hóa gì hoặc loại ảo hóa nào. Điều này rất quan trọng trong việc tối ưu hóa hiệu suất làm việc cho hệ thống.

##3. Các kiến trúc ảo hóa.
###3.1. Kiến trúc ảo hóa Hosted-based.
Còn gọi là kiến trúc hosted hypervisor, kiến trúc này sử dụng một lớp hypervisor chạy trên nền tảng hệ điều hành, sử dụng các dịch vụ được hệ điều hành cung cấp để phân chia tài nguyên tới các máy ảo. Nếu ta xem hypervisor này là một lớp phần mềm riêng biệt, thì các hệ điều hành khách của máy ảo sẽ nằm trên lớp thứ 3 so với phần cứng máy chủ.
![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%201.png)

Ta có thể thấy, một hệ thống ảo hóa sử dụng Mô hình Hosted-based được chia làm 4 lớp hoạt động như sau:

 * Nền tảng phần cứng: Bao gồm các thiết bị nhập xuất, thiết bị lưu trữ (Hdd, Ram), bộ vi xử lý CPU, và các thiết bị khác (các thiết bị mạng, vi xử lý đồ họa, âm thanh…)
 * Hệ điều hành Host: Hệ điều hành này thực hiện việc liên lạc trực tiếp với phần cứng, qua đó cung cấp các dịch vụ và chức năng thông qua hệ điều hành này.
 * Hệ thống virtual machine monitor (hypervisor) : Chạy trên nền tảng hệ điều hành Host, các hệ thống này lấy tài nguyên và dịch vụ do hệ điều hành host cung cấp, thực hiện việc quản lý, phân chia trên các tài nguyên này.
 * Các ứng dụng máy ảo: Sử dụng tài nguyên do hypervisor quản lý.

Mối liên lạc giữa phần cứng và trình điều khiển thiết bị trên hệ điều hành trong kiểu ảo hóa VMM được mô tả như sau :

 * Bước đầu tiên mô phỏng phần cứng: Lớp ảo hóa hypervisor sẽ tạo ra một phân vùng trên ổ đĩa cho các máy ảo. Phân vùng này bao gồm các phần cứng ảo như ổ đĩa, bộ nhớ….
 * Hypervisor xây dựng mối liên lạc giữa lớp ảo hóa với hệ điều hành: Khi một máy ảo truy xuất tài nguyên thì lớp hypervisor sẽ thay thế máy ảo đó gởi các yêu cầu tới hệ điều hành máy chủ để yêu cầu thực hiện,
 * Khi hệ điều hành nhận được các yêu cầu này. Nó liên lạc với trình điều khiển thiết bị phần cứng.
 * Các trình điều khiển thiết bị phần cứng liên lạc đến các phần cứng trên máy thực.
 * Quá trình này sẽ xảy ra ngược lại khi có các trả lời từ các phần cứng đến hệ điều hành chủ.

Một số hệ thống hypervisor dạng Hosted-base có thể kể đến như Vmware Server,Microsoft Virtual PC, máy ảo Java ..

###3.2. Kiến trúc ảo hóa Hypervisor-based.

Còn gọi là kiến trúc bare-metal hypervisor. Trong mô hình này, lớp phần mềm hypervisor chạy trực tiếp trên nền tảng phần cứng của máy chủ, không thông qua bất kì một hệ điều hành hay một nền tảng nào khác. Qua đó, các hypervisor này có khả năng điều khiển, kiểm soát phần cứng của máy chủ. Đồng thời, nó cũng có khả năng quản lý các hệ điều hành chạy trên nó. Nói cách khác, các hệ điều hành sẽ chạy trên một lớp nằm phía trên các hypervisor dạng bare-metal. Hình vẽ sau sẽ minh họa cụ thể hơn cho vấn đề này:
![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%205.png)

Ta có thể thấy, một hệ thống ảo hóa máy chủ sử dụng nền tảng Bare-metal hypervisor bao gồm 3 lớp chính:

 * Nền tảng phần cứng: Bao gồm các thiết bị nhập xuất, thiết bị lưu trữ (Hdd, Ram), bộ vi xử lý CPU, và các thiết bị khác (các thiết bị mạng, vi xử lý đồ họa, âm thanh…)
 * Lớp nền tảng ảo hóa Virtual Machine Monitor (còn gọi là hypervisor), thực hiện việc liên lạc trực tiếp với nền tảng phần cứng phía dưới, quản lý và phân phối tài nguyên cho các hệ điều hành khác nằm trên nó.
 * Các ứng dụng máy ảo: Các máy ảo này sẽ lấy tài nguyên từ phần cứng, thông qua sự cấp phát và quản lý của hypervisor.

Khi một hệ điều hành thực hiện truy xuất hoặc tương tác tài nguyên phần cứng trên hệ điều hành chủ thì công việc của một Hypervisor sẽ là:

 * Hypervisor mô phỏng phần cứng. nó làm cho các hệ điều hành tưởng rằng mình đang sử dụng tài nguyên vật lý của hệ thống thật.
 * Hypervisor liên lạc với các trình điều khiển thiết bị
 * Các trình điều khiển thiết bị phần cứng liên lạc trực tiếp đến phần cứng vật lý.

Một số ví dụ về các hệ thống Bare-metal hypervisor như là: Oracle VM, Vmware ESX Server, IBM's POWER Hypervisor (PowerVM), Microsoft's Hyper-V (xuất xưởng tháng 6 năm 2008), Citrix XenServer…

* Mô hình Hypervisor - Base có 2 dạng là Monothic Hypervisor và Microkernel Hypervisor.

####3.2.1 Monolithic Hypervisor.

Monolithic Hypervisor là một hệ điều hành máy chủ. Nó chứa những trình điều khiển (Driver) hoạt động phần cứng trong lớp Hypervisor để truy cập tài nguyên phần cứng bên dưới. Khi các hệ điều hành chạy trên các máy ảo truy cập phần cứng thì sẽ thông qua lớp trình điều khiển thiết bị của lớp hypervisor.

* Mô hình này mang lại hiệu quả cao, nhưng cũng giống như bất kì các giải pháp khác, bên cạnh mặt ưu điểm thì nó cũng còn có những nhược điểm.
	* Vì trong quá trình hoạt động, nếu lớp trình điều khiển thiết bị phần cứng của nó bị hư hỏng hay xuất hiện lỗi thì các máy ảo cài trên nó đều bị ảnh hưởng và nguy hại.
	* Thêm vào đó là thị trường phần cứng ngày nay rất đa dạng, nhiều chủng loại và do nhiều nhà cung cấp khác nhau, nên trình điều khiển của Hypervisor trong loại ảo hóa này có thể sẽ không thể hỗ trợ điều khiển hoạt động của phần cứng này một cách đúng đắn và hiệu suất chắc chắn cũng sẽ không được như mong đợi.
	* Một trình điều khiển không thể nào điều khiển tốt hoạt động của tất cả các thiết bị nên nó cũng có những thiết bị phần cứng không hỗ trợ.

	**= >** Những điều này cho thấy rằng việc phụ thuộc quá nhiều vào các loại thiết bị dẫn tới sự hạn chế việc phát triển công nghệ này.

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%206.png)

####3.2.2 Microkernelized Hypervisor.

Microkernelized Hypervisor là một kiểu ảo hóa giống như Monolithic Hypervisor. Điểm khác biệt giữa hai loại này là trong Microkernelized trình điều khiển thiết bị phần cứng bên dưới được cài trên một máy ảo và được gọi là trình điều khiển chính, trình điều khiển chính này tạo và quản lý các trình điều khiển con cho các máy ảo.

Khi máy ảo có nhu cầu liên lạc với phần cứng thì trình điều khiển con sẽ liên lạc với trình điều khiển chính và trình điều khiển chính này sẽ chuyển yêu cầu xuống lớp Hypervisor để liên lạc với phần cứng.

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%207.png)

###3.3 Kiến trúc ảo hóa Hybrid.

Hybrid là một kiểu ảo hóa mới hơn và có nhiều ưu điểm. Trong đó lớp ảo hóa hypervisor chạy song song với hệ điều hành máy chủ. Tuy nhiên trong cấu trúc ảo hóa này, các máy chủ ảo vẫn phải đi qua hệ điều hành máy chủ để truy cập phần cứng nhưng khác biệt ở chỗ cả hệ điều hành máy chủ và các máy chủ ảo đều chạy trong chế độ hạt nhân. Khi một trong hệ điều hành máy chủ hoặc một máy chủ ảo cần xử lý tác vụ thì CPU sẽ phục vụ nhu cầu cho hệ điều hành máy chủ hoặc máy chủ ảo tương ứng. Lý do khiến Hyrbird nhanh hơn là lớp ảo hóa chạy trong chế độ hạt nhân (chạy song song với hệ điều hành), trái với Virtual Machine Monitor lớp ảo hóa chạy trong trong chế độ người dùng (chạy như một ứng dụng cài trên hệ điều hành).

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%208.png)

##4. Các mức độ ảo hóa.

###4.1. Ảo hóa toàn phần - Full Virtualization.

Đây là loại ảo hóa mà ta không cần chỉnh sửa hệ điều hành khách (guest OS) cũng như các phần mềm đã được cài đặt trên nó để chạy trong môi trường hệ điều hành chủ (host OS).

* Khi một phần mềm chạy trên guest OS, các đoạn code của nó không bị biến đổi mà chạy trực tiếp trên host OS và phần mềm đó như đang được chạy trên một hệ thống thực sự.

* Bên cạnh đó, ảo hóa toàn phần có thể gặp một số vấn đề về hiệu năng và hiệu quả trong sử dụng tài nguyên hệ thống.

* Trình điều khiển máy ảo phải cung cấp cho máy ảo một “ảnh” của toàn bộ hệ thống, bao gồm BIOS ảo, không gian bộ nhớ ảo, và các thiết bị ảo. Trình điều khiển máy ảo cũng phải tạo và duy trì cấu trúc dữ liệu cho các thành phần ảo(đặc biệt là bộ nhớ), và cấu trúc này phải luôn được cập nhật cho mỗi một truy cập tương ứng được thực hiện bởi máy ảo.

###4.2. Paravirtualization - Ảo hóa song song
Là một phương pháp ảo hóa máy chủ mà trong đó, thay vì mô phỏng một môi trường phần cứng hoàn chỉnh, phần mềm ảo hóa này là một lớp mỏng dồn các truy cập các hệ điều hành máy chủ vào tài nguyên máy vật lý cơ sở, sử dụng môt kernel đơn để quản lý các Server ảo và cho phép chúng chạy cùng một lúc (có thể ngầm hiểu, một Server chính là giao diện người dùng được sử dụng để tương tác với hệ điều hành).

Ảo hóa song song đem lại tốc độ cao hơn so với ảo hóa toàn phần và hiệu quả sử dụng các nguồn tài nguyên cũng cao hơn. Nhưng nó yêu cầu các hệ điều hành khách chạy trên máy áo phải được chỉnh sửa. Điều này có nghĩa là không phải bất cứ hệ điều hành nào cũng có thể chạy ảo hóa song song được (trái với Ảo hóa toàn phần). XP Mode của Windows 7 là một ví dụ điển hình về ảo hóa song song.

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/paravirtualization.png)

* Phương pháp ảo hóa này có hai ưu điểm.
	* Thứ nhất, giảm chi phí hoạt động do số lượng mã rất ít. Lớp phần mềm của ảo hóa song song hoạt động giống một cảnh sát giao thông , nó cho phép một hệ điều hành chủ truy cập các tài nguyên vật lý của phần cứng, đồng thời ngăn không cho các hệ điều hành chủ khác truy cập các nguồn tài nguyên đó.
	* Ưu điểm thứ hai của ảo hóa song song song là nó không giới hạn các trình điều khiển thiết bị trong phần mềm ảo hóa; thực tế là ảo hóa song song không hề có các trình điều khiển thiết bị. Thay vào đó, nó sử dụng các trình điều khiển thiết bị có trong một hệ điều hành chủ, gọi là máy chủ đặc quyền. Nó cho phép các công ty tận dụng hiệu suất phần cứng các máy chủ, chứ không bị giới hạn phần cứng mà các trình điều khiển phải sẵn có trong phần mềm ảo hóa này như trong ảo hóa mô phỏng phần cứng.

* Tuy nhiên, phương pháp ảo hóa này cũng có một nhược điểm lớn:
	* Do ít quan trọng và dồn truy cập vào một phần cứng cơ sở, ảo hóa song song yêu cầu các hệ điều hành chủ phải được thay đổi để tương tác với giao diện của nó. Công việc này chỉ có thể được thực hiện khi truy cập mã nguồn của hệ điều hành

**=>** Do đó, nhược điểm này sẽ được giảm thiểu khi sử dụng các máy chủ có các con chip mới trong cơ sở hạ tầng sản xuất. Một ví dụ của ảo hóa song song là một sản phẩm nguồn mở mới có tên gọi Xen, được công ty thương mại XenSource bảo trợ. Xen cũng xuất hiện trong các nguồn phân phối Linux gần đây từ Red Hat và Novell, và có trong nhiều nguồn phân phối cộng đồng Linux như Debian và Ubuntu. XenSource cũng tự bán các sản phẩm dựa trên Xen. Một phần mềm tiềm năng khác là Virtual Iron, một giải pháp dựa trên Xen

###4.3.Ảo hóa hệ điều hành.

Một hệ điều hành được vận hành ngay trên một hệ điều hành chủ đã tồn tại và có khả năng cung cấp một tập hợp các thư viện tương tác với các ứng dụng, khiến cho mỗi ứng dụng truy xuất tài nguyên phần cứng cảm thấy như truy xuất trực tiếp máy chủ vật lý. Từ phối cảnh của ứng dụng, nó được nhận thấy và tương tác với các ứng dụng chạy trên hệ điều hành ảo, và tương tác với hệ điều hành ảo mặc dù nó kiểm soát tài nguyên hệ điều hành ảo. Nói chung, không thể thấy các ứng dụng này hoặc các tài nguyên hệ điều hành đặt trong hệ điều hành ảo khác.

Phương pháp ảo hóa này đặc biệt hữu dụng nếu nhà cung cấp muốn mang lại cho cộng đồng người sử dụng khác nhau các chức năng khác nhau của hệ thống trên một một máy chủ duy nhất. Đây là một phương pháp lý tưởng cho các công ty máy chủ Web: Họ sử dụng ảo hóa container (OS ảo) để khiến cho một trang Web chủ “tin rằng” trang web này kiểm soát toàn bộ máy chủ Tuy nhiên, trên thực tế mỗi trang Web chủ chia sẻ cùng một máy với các trang Web khác, mỗi trang Web này lại có một container riêng.

Ảo hóa hệ điều hành yêu cầu rất ít tài nguyên hệ thống, do đó bảo đảm hầu hết tài nguyên máy sẵn có cho các ứng dụng chạy trên container. Tuy nhiên, ảo hóa hệ điều hành vẫn có một số nhược điểm. Nhược điểm đầu tiên và lớn nhất là phương pháp này thường giới hạn sự lựa chọn hệ điều hành. Sự container hóa nghĩa là các container cung cấp một hệ điều hành tương tự như hệ điều hành chủ và thậm chí thống nhất về phiên bản và các bản vá lỗi.

Như chúng ta có thể tưởng tượng, có thể xảy ra vấn đề nếu nhà cung cấp muốn chạy các ứng dụng khác nhau trên các container, do các ứng dụng thường được chứng thực cho một phiên bản hệ điều hành và các bản vá lỗi. Do đó, ảo hóa hệ điều hành thích hợp nhất với cấu hình thuần nhất, trong các tình huống này ảo hóa hệ điều hành là sự lựa chọn hoàn hảo.

###4.4 Ảo hóa ứng dụng.

Thông thường, khi muốn sử dụng một phần mềm nào đó như office, design, người dùng hay có suy nghĩ rằng cần phải tốn thời gian cài đặt phần mềm đó lên trên máy tính, cụ thể hơn là lên hệ điều hành đang sử dụng. Điều này tốn khá nhiều thời gian, nhất là nếu áp dụng trên những doanh nghiệp lớn, có cả ngàn máy tính, và đồng thời vấn đề quản lý các phần mềm này như ai truy xuất, thời gian truy xuất cho phép ra sao trở thành một thách thức thật sự.

Do đó, khái niệm ảo hóa ứng dụng ra đời. Một ứng dụng được ảo hóa sẽ không được cài đặt lên máy tính một cách thông thường, mặc dù ở góc độ người sử dụng, ứng dụng vẫn hoạt động một cách bình thường. Ảo hóa ứng dụng sẽ giúp tách rời sự phụ thuộc giữa nền tảng phần cứng, hệ điều hành và ứng dụng với nhau.

**Mô hình hoạt động**

Có khá nhiều tổ chức đã tham gia vào quá trình ảo hóa ứng dụng với các mô hình khác nhau. Có thể kể đến như Citrix với mô hình Application Streaming, Microsoft với mô hình Microsoft Application Virtualization. Ở đây chúng ta sẽ tìm hiểu về mô hình Application Streaming của Citrix.

![](http://voer.edu.vn/media/transforms/20140306-214626-tong-quan-ve-ao-hoa-may-chu/Picture%201.png)

Kỹ thuật streaming cho phép người quản lý có thể “đẩy” và quản lý các ứng dụng trên nền tảng hệ điều hành Windows đến bất cứ người dùng nào theo yêu cầu. Cụ thể hơn: thông qua các đường truyền dữ liệu được dành riêng, các ứng dụng được tải về thiết bị của người dùng, sau đó chạy trên một môi trường giả lập. Các thành phần của hệ thống application streaming này bao gồm:

 * Application Profiler: Tại đây các application được đóng gói, kèm với nó là các thông tin như tài nguyên cần thiết để chạy ứng dụng, các quy tắc khi triển khai trên thiết bị người dùng, các thành phần của ứng dụng…
 * Application Hub: Sau khi đã được đóng gói kèm theo các thông tin cần thiết, các ứng dụng/phần mềm được lưu trữ tại đây.
 * Một đặc điểm với kỹ thuật này là: Các ứng dụng được lưu trữ tại bộ nhớ cục bộ tại các máy tính cuối của người dùng, và được sử dụng như các phần mềm được cài đặt theo cách truyền thống. Nhưng thật sự nó không được cài đặt, mà là chạy trên lớp đệm là môi trường ảo hóa nằm ngay trên hệ điều hành.

##5. Ưu điểm, nhược điểm của ảo hoá máy chủ.
###5.1. Ưu điểm.

* Giúp tận dụng tối đa tài nguyên phần cứng của máy chủ vật lí, tiết kiệm chi phí đầu tư hệ thống.
* Ảo hóa là một khái niệm quan trọng trong xây dựng nền tảng bảo mật máy tính.
* Máy ảo có thể được sử dụng để tạo ra hệ điều hành, hay môi trường thực thi với tài nguyên giới hạn, mang lại một lịch trình đúng, bảo đảm tài nguyên.
* Máy ảo có thể cung cấp ảnh ảo của phần cứng, hay cấu hình phần cứng mà bạn không có (chẳng hạn như thiết bị SCSI, đa xử lý,...). Ảo hóa cũng có thể được sử dụng để mô phỏng mạng hay các máy tính độc lập.
* Máy ảo có thể được sử dụng để chạy nhiều hệ điều hành cùng một lúc: các phiên bản khác nhau hay thậm chí các hệ điều hành khác nhau.
* Máy ảo cho phép cơ chế sửa lỗi mạnh mẽ và giám sát hiệu năng. Bạn có thể đặt vào một số công cụ ví dụ như là virtual machine monitor (VMM). Hệ điều hành có thể sửa lỗi mà không làm mất mát hiệu suất, hay thiết lập những kịch bản sửa lỗi phức tạp hơn.
* Máy ảo có thể cách ly với những gì nó chạy, vì thế nó có thể ngăn chặn thiếu sót và lỗi. Bạn có thể chủ động đặt lỗi vào phần mềm để nghiên cứu cách xử lý tuần tự của nó.
* Máy ảo làm cho phần mềm di chuyển dễ dàng hơn, vì thế những ứng dụng trợ giúp và hệ thống có tính di động.
* Máy ảo là công cụ tuyệt vời để thử nghiệm lý thuyết. Từ khi chúng cung cấp sự cách ly, chúng có thể làm việc an toàn hơn. Chúng đóng gói toàn bộ trạng thái của hệ thống đang chạy: Người sử dụng có thể lưu trạng thái, khảo sát nó, sửa đổi nó, nạp lại nó và v.v...
* Ảo hóa có thể khởi tạo hệ điều hành có sẵn để chạy trên những bộ nhớ đa xử lý được chia sẻ.
* Máy ảo có thể được sử dụng để tạo ra các kịch bản test tùy ý, và có thể dẫn đến vài ý tưởng rất sáng tạo, chất lượng, hiệu quả.
* Ảo hóa có thể tạo ra các tác vụ như là di chuyển hệ thống, sao lưu, phục hồi & quản lí dễ dàng, thuận tiện hơn.

###5.2. Nhược điểm:

* Giải pháp ảo hóa có điểm nút sự cố (single point of failure): Hạn chế lớn nhất của ảo hóa là nó có một điểm nút sự cố. Khi một máy, mà trên đó, mọi giải pháp ảo hóa đang chạy, gặp sự cố hay khi chính giải pháp ảo hóa gặp sự cố, sẽ làm crash mọi thứ. Điều này nghe thật đáng sợ nhưng thực tế rủi ro này tương đối dễ phòng. Tăng sức chứa và thường xuyên sao lưu hệ điều hành ảo (cùng với ứng dụng ảo) là một cách thức giúp giảm thiểu nguy cơ mất dữ liệu và thời gian chết do single point of failure.
* Ảo hóa yêu cầu những cỗ máy mạnh mẽ: Ảo hóa có thể tiết kiệm được tiền bạc bởi vì nó đòi hỏi ít phần cứng hơn và điều này cho phép hạn chế số lượng máy vật lý trong một doanh nghiệp nhưng nó không có nghĩa là có khả năng sử dụng các máy tính cổ lỗ sĩ để chạy các giải pháp ảo hỏa mới. Các giải pháp ảo hóa đòi hỏi một cỗ máy thật sự mạnh mẽ. Nếu cỗ máy được sử dụng không đủ mạnh, vẫn có thể triển khai các giải pháp ảo hóa nhưng khi mà không có đủ sức mạnh CPU và RAM cho chúng, nó sẽ thực sự làm gián đoạn công việc.
* Ảo hóa có thể dẫn đến hiệu năng thấp: Thậm chí nếu cỗ máy mà trên đó các hệ điều hành và ứng dụng ảo đang chạy đủ mạnh, vấn đề hiệu năng vẫn có khả năng xảy ra. Một trong những thực tế gặp phải đó là một ứng dụng khi chạy trên môi trường không ảo hóa thì hoạt động tốt nhưng lại gặp vấn đề khi chạy trên hệ thống ảo hóa. Ví dụ: Hiệu suất của stress test trong môi trường ảo hóa có kết quả rất khác (và sai lệch) khi so sánh với stress test trên một máy dành riêng. Điều tốt nhất cần làm khi triển khai trên một nền tảng ảo hóa là luôn kiểm tra và theo dõi sát sao các vấn đề tiềm ẩn.
* Ứng dụng ảo hóa không phải luôn luôn khả dụng: Trong khi trong hầu hết các trường hợp không thể dự đoán chính xác được một ứng dụng cụ thể có thể hoạt động tốt khi được ảo hóa hay không thì cũng có một số ứng dụng khác qua thực tiễn cho thấy bị suy giảm hiệu năng khi được ảo hóa.
* Rủi ro lỗi vật lý cao: Rất tuyệt vời để lưu trữ/chạy 5 Server (ảo)rất quan trọng của bạn trong chỉ một Server vật lý. Nhưng bạn có bao giờ tưởng tượng được xung đột của 5 Server này chỉ bởi lỗi của 1 phần cứng trong Server vật lý? Nó sẽ đặt cả 5 Server quan trọng của bạn trong tình trạng offline. Đó rõ ràng là một nhược điểm và hạn chế lớn của ảo hóa cần phải cân nhắc khi có kế hoạch thiết lập một môi trường ảo hóa máy chủ.


##6. KVM & QEMU
- 1. Nếu host computer chỉ được cài duy nhất QEMU và không có/không kích hoạt KVM thì có thể tạo ra guest VM chạy trên computer đó được không?

–> Được. Bản thân QEMU đã là một type-2 hypervisor với đầy đủ khả năng tạo ra guest VM có các hardware được giả lập rồi.

- 2. Nếu host computer chỉ có cài KVM và không có chạy QEMU hay bất cứ một hypervisor nào khác thì có thể tạo được guest VM trên computer đó hay không?

–> Không. Bản thân KVM không thực sự là một hypervisor có chức năng giả lập hardware để có thể chạy guest VM. Chính xác nó chỉ là một Linux kernel module hỗ trợ cơ chế mapping các instruction giữa virtual CPU (của guest VM) và physical CPU (của host computer) với yêu cầu là physical CPU đó cần có virtualization extension, ví dụ như Intel VT-x hay AMD-V.

Có thể hình dung KVM giống như driver cho hypervisor để sử dụng được virtualization extension của physical CPU nhằm boost performance cho guest VM. KVM như định nghĩa trên official website thì là core virtualization infrastructure mà thôi, nó được các hypervisor khác lợi dụng làm back-end để tiếp cận được các công nghệ hardware acceleration.

- 3. Thường thấy người ta chạy chung QEMU/KVM, điều này có tác dụng gì?

–> Nhằm nâng cao hiệu suất của VM. Cụ thể, lúc tạo VM bằng QEMU có VirtType là KVM thì khi đó các instruction có nghĩa đối với virtual CPU sẽ được QEMU sử dụng KVM để mapping thành các instruction có nghĩa đối với physical CPU. Làm như vậy sẽ nhanh hơn là chỉ chạy độc lập QEMU, vì nếu không có KVM thì QEMU sẽ phải quay về (fall-back) sử dụng translator của riêng nó là TCG để chuyển dịch các instruction của virtual CPU rồi đem thực thi trên physical CPU.

Khi QEMU/KVM kết hợp nhau thì tạo thành type-1 hypervisor.

- 4. Tóm lại là gì?

QEMU cần KVM để boost performance và ngược lại KVM cần QEMU (modified version) để cung cấp giải pháp full virtualization hoàn chỉnh.
