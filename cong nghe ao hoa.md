#Công nghệ ảo hóa
##1. OpenVZ
![](http://cuocsongmoi.vn/wp-content/uploads/2014/09/OpenVZ-300x76.png)
OpenVZ (Open Virtuozzo) là một hệ thống cấp công nghệ ảo hóa hoạt động dựa trên nhân Linux. OpenVZ cho phép một máy chủ vật lý để chạy nhiều trường hợp hệ điều hành riêng biệt, được gọi là container, máy chủ riêng ảo (VPSS), hoặc môi trường ảo (VES).

OpenVZ không thực sự ảo hóa, nó sử dụng chung 1 nhân Linux đã được sửa đổi và do đó chỉ có thể chạy duy nhất hệ điều hành Linux, như vậy tất cả các máy chủ ảo VPS cũng chỉ có thể chạy được Linux với chung 1 công nghệ và phiên bản Kenel. Tuy nhiên, do không có nhân riêng nên nó rất nhanh và hiệu quả, nhưng đó cũng chính là nhược điểm của nó khi tất cả các máy chủ phải sử dụng chung 1 nhân duy nhất.

Nhược điểm nữa của OpenVZ là việc cấp phát bộ nhớ không được tách biệt, nghĩa là bộ nhớ được cấp phát cho 1 máy chủ VPS này lại có thể bị sử dụng bởi VPS khác trong trường hợp VPS kia yêu cầu. Nó cũng sử dụng hệ thống file dùng chung, vì thế mối VPS thực chất chỉ là 1 Thư mục được change root. Phiên bản mới của OpenVZ cho phép mỗi VPS có thể có hệ thống file system riêng của chính nó. Với việc “ảo hóa” thư mục thành VPS như vậy, có thể copy 1 VPS bằng cách copy thư mục, rồi thay đổi cấu hình phù hợp và start nó lên như 1 VPS mới.
##2. XEN VPS

![](http://cuocsongmoi.vn/wp-content/uploads/2014/09/vps-xen.png)

XEN là công nghệ ảo hóa thực sự cho phép chạy cùng lúc nhiều máy chủ ảo VPS trên 1 máy chủ vật lý.

Công nghệ ảo hóa XEN cho phép mỗi máy chủ ảo chạy nhân riêng của nó, do đó VPS có thể cài được cả Linux hay Windows Operating system, mỗi VPS có hệ thống File System riêng và hoạt động như 1 máy chủ vật lý độc lập.

Tài nguyên cung cấp cho máy chủ VPS XEN cũng độc lập, nghĩa là mỗi máy chủ XEN được cấp 1 lượng RAM, CPU và Disk riêng, nó đảm bảo rằng máy chủ VPS của bạn sẽ được cung cấp đủ tài nguyên như lúc đăng ký với nhà cung cấp dịch vụ.

Do công nghệ XEN yêu cầu tài nguyên vật lý đầy đủ cho mỗi VPS, do đó nhà cung cấp dịch vụ cũng phải tăng cường tài nguyên vật lý trên máy chủ thật, dẫn đến máy chủ VPS sử dụng công nghệ XEN thường có giá đắt hơn công nghệ OpenVZ.

##3. VMWare
![](http://cuocsongmoi.vn/wp-content/uploads/2014/09/vps-vmware.jpg)

Công nghệ ảo hóa VMWare do công ty VMWare phát triển, nó hỗ trợ ảo hóa từ mức phần cứng. Công nghệ này thường áp dụng cho các công ty lớn như ngân hàng, và ít được sử dụng cho các VPS thương mại bán trên thị trường.
##4.  KVM (Kernel-based Virtual Machine)

KVM là công nghệ ảo hóa mới cho phép ảo hóa thực sự trên nền tảng phần cứng. Do đó máy chủ KVM giống như XEN được cung cấp riêng tài nguyên để sử dụng, tránh việc tranh chấp tài nguyên với máy chủ khác trên cùng node. Máy chủ gốc được cài đặt Linux, nhưng KVM hỗ trợ tạo máy chủ ảo có thể chạy cả Linux, Windows. Nó cũng hỗ trợ cả x86 và x86-64 system.

Chưa có thống kê chính thức về ưu điểm của KVM so với XEN, tuy nhiên XEN được phát triển trước KVM khoảng 10 năm nên có thể được hoàn thiện hơn, trong khi KVM được phát triển mới nên được tiếp thu các công nghệ mới hơn và tránh những sai lầm không đáng có. Do đó, việc lựa chọn VPS chạy XEN hoặc KVM là tùy thuộc vào sở thích của bạn cũng như uy tín của nhà cung cấp hosting.


