#Card Mạng trong VMware

##1: Switch ảo (Virtual Switch):
* Cũng giống như switch vật lý, một Virtual Switch kết nối các thành phần mạng ảo lại với nhau.

* Những  switch ảo hay còn gọi là mạng ảo, chúng có tên là VMnet0, VMnet1, VMnet2… một số switch ảo được gắn vào mạng một cách mặc định.

* Mặc định khi ta cài Wmware thì có sẵn 3 Switch ảo như sau: VMnet0 chế độ Bridged (cầu nối), VMnet8 chế độ NAT và VMnet1 chế độ Host-only.

* Ta có thể thêm, bớt, chỉnh các option của VMnet bằng cách vào menu Edit -> Virtual Network Editor.

##2: DHCP server ảo (Dynamic Host Configuration):
* Là  server ảo cung cấp địa chỉ IP cho các máy ảo trong việc kết nối máy ảo vào các Switch ảo không có tính năng Bridged (VMnet0).

* Ví dụ như DHCP ảo cấp đến các máy ảo có kết nối đến Host-only và NAT.

* **LAN Segment:** Các card mạng của máy ảo có thể gắn kết với nhau thành từng LAN Segment. Không giống như VMnet, LAN Segment chỉ kết nối các card ảo lại với nhau mà không có những tính năng như DHCP hoặc kết nối chung với một card mạng ảo được tạo bên ngoài (các VMware Network Adapter VMnet được tạo bên ngoài máy thật).

##3: Các chế độ của card mạng trên máy ảo:

* **Chế độ Bridge**: ở chế độ này thì card mạng trên máy ảo sẽ được gắn vào VMnet0 và VMnet0 này liên kết trực tiếp với card mạng vật lý. Ở chế độ này máy ảo sẽ kết nối internet thông qua lớp card mạng vật lý và có chung lớp mạng với card mạng vật lý.

* **Chế độ NAT**: ở chế độ này thì card mạng của máy ảo kết nối với VMnet8, VNnet8 cho phép máy ảo đi internet thông qua cơ chế NAT (NAT device).

	Lúc này lớp mạng bên trong máy ảo khác hoàn toàn với lớp mạng của card vật lý bên ngoài. IP của card mạng sẽ được cấp bởi DHCP VMnet8 cấp, trong trường hợp bạn muốn thiết lập IP tĩnh cho card mạng máy ảo bạn phải đảm bảo chung lớp mạng với VNnet8 thì máy ảo mới có thể đi internet.

* **Cơ chế Host-only**: ở cơ chế này máy ảo được kết nối với VMnet có tính có tính năng Host-only, trong trường hợp này là VMnet1 (bạn có thể add nhiều VMnet Host-only). VMnet Host-only kết nối ra một card mạng ảo tương ứng ngoài máy thật.

	Ở chế độ này máy ảo không có kết nối internet. IP của máy ảo được cấp bởi DHCP của VMnet tương ứng.Trong nhiều trường hợp đặc biệt cần cấu hình riêng, ta có thể tắt DHCP trên VMnet và cấu hình IP bằng tay cho máy ảo.
