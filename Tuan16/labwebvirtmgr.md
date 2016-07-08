#LAB Dựng WebVirtMgr
#1. MÔ HÌNH
![](http://i.imgur.com/6edw05i.jpg)

- KVM1: Là nơi chứa các mảy ảo.
- WebVirtMgr: Là nơi chứa giao diện web.

#2. Cài đặt trên KVM1
- Cài đặt các gói
```sh
apt-get install -y qemu-kvm libvirt-bin bridge-utils
```

- Thêm người dùng hiện tại vào group libvirtd:
```sh
sudo adduser `id -un` libvirtd
```

- Cấu hình libvirt
  - Thay đổi các giá trị sau trong file `/etc/libvirt/libvirtd.conf`
  ```sh
  listen_tls = 0
  listen_tcp = 1
  listen_addr = "0.0.0.0"
  auth_tcp = "none"
```
  - Trong file `etc/default/libvirt-bin`, sửa thành các giá trị sau:
  ```sh
  libvirtd_opts="-l -d"
  ```

- Kiểm tra việc cài đặt
```sh
root@adk:~# ps ax | grep [l]ibvirtd
  3592 ?        Sl     0:03 /usr/sbin/libvirtd -l -d
root@adk:~# netstat -pantu | grep libvirtd
tcp        0      0 0.0.0.0:16509           0.0.0.0:*               LISTEN      3592/libvirtd
tcp        0      0 172.16.69.33:16509      172.16.69.33:40615      ESTABLISHED 3592/libvirtd
tcp        0      0 172.16.69.33:16509      172.16.69.33:40639      ESTABLISHED 3592/libvirtd
tcp        0      0 172.16.69.33:16509      172.16.69.33:40617      ESTABLISHED 3592/libvirtd
root@adk:~# virsh -c qemu+tcp://127.0.0.1/system
Welcome to virsh, the virtualization interactive terminal.

Type:  'help' for help with commands
       'quit' to quit

virsh #
```
- Khởi động lại dịch vụ `libvirt-bin`
```sh
service libvirt-bin restart
```

- Cấu hình interface: `/etc/network/interfaces`
```sh
auto br-ex
iface br-ex inet static
address 172.16.69.100/24
gateway 172.16.69.1
dns-nameservers 8.8.8.8
bridge_ports eth0
bridge_fd 9
bridge_hello 2
bridge_maxage 12
bridge_stp off

auto eth0
iface eth0 inet manual
up ip link set dev $IFACE up
down ip link set dev $IFACE down
```
Trong đó:
  - `br-ex`: là card mạng bridge được tạo ra.
  - `eth0`: là card mạng ra bên ngoài.

- Khởi động lại các interfaces
```sh
ifdown -a
ifup -a
```

- Tạo thư mục chứa images
```sh
mkdir -p /var/www/webvirtmgr/images
```

- Upload images lên thư mục vừa tạo ở trên.

#3. Cài đặt trên webvirtmgr
- Cài đặt các gói sau:
```sh
apt -get install -y python-pip python-libvirt python-libxml2 novnc supervisor nginx git
```

- Di chuyển vào thư mục `/var/www` và tải gói webvirtmgr về.
```sh
cd /var/www
git clone https://github.com/retspen/webvirtmgr.git
```

- Tạo user đăng nhập trên webvirtmgr
```sh
./manage.py syncdb
```

- Nhập các thông tin
```sh
You just installed Django's auth system, which means you don't have any superusers defined.
Would you like to create one now? (yes/no): yes (Put: yes)
Username (Leave blank to use 'admin'): admin (Put: your username or login)
E-mail address: username@domain.local (Put: your email)
Password: xxxxxx (Put: your password)
Password (again): xxxxxx (Put: confirm password)
Superuser created successfully.
```

- Tạo gói giao diện static
```sh
./manage.py collectstatic
```

- Nếu bạn muốn thêm superuser khác, chạy lệnh
```sh
 ./manage.py createsuperuser
 ```

##3.1 Cài đặt NGINX
- Tạo file `/etc/nginx/sites-available/webvirtmgr`
 ```sh
 server {
    listen 80 default_server;

    server_name $hostname;
    #access_log /var/log/nginx/webvirtmgr_access_log;

    location /static/ {
        root /var/www/webvirtmgr/webvirtmgr; # or /srv instead of /var
        expires max;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        client_max_body_size 1024M; # Set higher depending on your needs
    }
}
 ```
- Chạy các lệnh sau
```sh
sudo ln -s /etc/nginx/sites-available/webvirtmgr /etc/nginx/site-enabled/webvirtmgr
sudo unlink /etc/nginx/site-enabled/default
/etc/init.d/nginx start
sudo chown -R www-data:www-data /var/www/webvirtmgr
```

##3.2 Setup Supervisor
- Chạy các lệnh sau:
```sh
cd /etc/init.d/
wget https://raw.githubusercontent.com/retspen/webvirtmgr/master/conf/initd/webvirtmgr-console-ubuntu
mv /etc/init.d/webvirtmgr-console-ubuntu /etc/init.d/novnc
chmod +x /etc/init.d/novnc
sudo service novnc stop
/usr/lib/insserv/insserv -r novnc
```
- Tạo file `/etc/insserv/overrides/novnc` với nội dung sau:
```sh
#!/bin/sh
### BEGIN INIT INFO
# Provides:          nova-novncproxy
# Required-Start:    $network $local_fs $remote_fs $syslog
# Required-Stop:     $remote_fs
# Default-Start:
# Default-Stop:
# Short-Description: Nova NoVNC proxy
# Description:       Nova NoVNC proxy
### END INIT INFO
```

- Tạo file `/etc/supervisor/conf.d/webvirtmgr.conf` với nội dung sau:
```sh
[program:webvirtmgr]
command=/usr/bin/python /var/www/webvirtmgr/manage.py run_gunicorn -c /var/www/webvirtmgr/conf/gunicorn.conf.py
directory=/var/www/webvirtmgr
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/webvirtmgr.log
redirect_stderr=true
user=www-data

[program:webvirtmgr-console]
command=/usr/bin/python /var/www/webvirtmgr/console/webvirtmgr-console
directory=/var/www/webvirtmgr
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/webvirtmgr-console.log
redirect_stderr=true
user=www-data
```

- Khởi động lại NGINX và supervisor
```sh
sudo service nginx restart
sudo service supervisor stop
sudo service supervisor start
```

#3. Kết quả
