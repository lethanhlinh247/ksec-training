#Thêm Card mạng ảo trong ubuntu

* Chỉnh sửa file interfaces
```sh
nano /etc/network/interfaces
```
Phải tên card mạng ảo gồm 2 phần. eno1677736 là tên của card mạng thật. 1, chỉ bí danh của card mạng ảo.

```sh
auto eno1677736:1
iface eno1677736:1 inet static
name Ethernet alias LAN card
address 192.168.1.111
netmask 255.255.255.0
broadcast 192.168.1.255
network 192.168.1.0
```
* Lưu lại và đóng lại file, sau đó restart lại network
```sh
# /etc/init.d/networking restart
```
