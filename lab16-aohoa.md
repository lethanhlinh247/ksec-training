#LAB ảo hòa tuần 16
Hướng dẫn chi tiết: https://github.com/cosy294/ksec-training/blob/master/kvm.md

##Mô hình
!()[http://i.imgur.com/UT6y6Fy.jpg]

* Server(192.168.1.188): Chạy KVM và WebVirtMgr

##Cấu hình
###Cấu hình card mạng
![](http://i.imgur.com/2rFMq5g.png)
###Tạo máy ảo
```sh
mkdir -p /var/kvm/images

root@dlp:~# virt-install \
--name template \
--ram 1024 \
--disk path=/var/kvm/images/template.img,size=10 \
--vcpus 1 \
--os-type linux \
--os-variant ubuntuutopic \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'http://vn.archive.ubuntu.com/ubuntu/dists/vivid/main/installer-amd64/' \
--extra-args 'console=ttyS0,115200n8 serial'
```

### mount guest's disk and enable a service like follows
```sh
root@dlp:~# guestmount -d template -i /mnt
root@dlp:~# ln -s /mnt/lib/systemd/system/getty@.service /mnt/etc/systemd/system/getty.target.wants/getty@ttyS0.service
root@dlp:~# umount /mnt
```

##Kết quả
![](http://i.imgur.com/9CcNjLf.png)

![](http://i.imgur.com/G639AHf.png)


