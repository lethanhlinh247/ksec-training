#LAB - HAProxy kết hợp Keepalived
##1. Mô hình
![](http://i.imgur.com/HFD0YvG.jpg)

```sh
Load Balancer 1: đóng vai trò là Master, có địa chỉ ip là 10.10.10.100
Load Balancer 2: đóng vai trò là Backup, có địa chỉ ip là 10.10.10.200
1 địa chỉ IP ảo để kết nối 2 Load Balancer là 10.10.10.150
Web server 1: 10.10.10.6
Web server 2: 10.10.10.10
```
##2. Cấu hình Keepalived

##TRÊN CẢ HAI MÁY

### Cài đặt Keepalived
```sh
apt-get install keepalved
```


###Để cho phép HAProxy để ràng buộc vào các địa chỉ IP được chia sẻ:

Chúng ta thêm dòng sau vào `/etc/sysctl.conf` :
```sh
net.ipv4.ip_nonlocal_bind=1
```

Kiểm tra
```sh
# sysctl -p
```


### Cấu hình Keepalived Trên LB1:
```sh
/etc/keepalived/keepalived.conf
```

```sh
vrrp_script chk_haproxy {           # Requires keepalived-1.1.13
        script "killall -0 haproxy"     
        interval 2                      # Kiểm tra 2 giây/1 lần
        weight 2                        # Thêm vào 2 điểm của prio
}

vrrp_instance VI_1 {
        interface eno16777736			# Card mạng.
        state MASTER					# Vai trò của Load Balancer
        virtual_router_id 51
        priority 101                    # 101 on master, 100 on backup
        virtual_ipaddress {
            10.10.10.150	            # Địa chỉ IP ảo giữa LB1 và LB2
        }
        track_script {
            chk_haproxy
        }
}
```


![](http://i.imgur.com/XamCUkc.png)



Khởi động lại keepalved
```sh
service keepalived restart
```


Kiểm tra nhận ip ảo
```sh
ip a
```


![](http://i.imgur.com/Zax6RfH.png)


### Cấu hình Keepalived Trên LB2:
```sh
vrrp_script chk_haproxy {           # Requires keepalived-1.1.13
        script "killall -0 haproxy"     
        interval 2                      # Kiểm tra 2 giây/1 lần
        weight 2                        # Thêm vào 2 điểm của prio
}

vrrp_instance VI_1 {
        interface eno16777736			# Card mạng
        state BACKUP					# Vai trò Load Balancer
        virtual_router_id 51
        priority 100                    # 101 on master, 100 on backup
        virtual_ipaddress {
            10.10.10.150	            # Địa chỉ IP ảo giữa LB1 và LB2
        }
        track_script {
            chk_haproxy
        }
}
```


![](http://i.imgur.com/ztAqH4E.png)


```sh
service keepalived start
```

##3. Cấu hình HAProxy trên cả 2 Load Balancer

```sh
/etc/haproxy/haproxy.cfg
```


![](http://i.imgur.com/wiTbOLb.png)



#4. Kết quả


![](http://i.imgur.com/ZNRmb5f.png)





