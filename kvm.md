#KVM
KVM là công nghệ ảo hóa phần cứng và đòi hỏi CPU trên máy tính phải được hỗ trợ một trong các công nghệ sau: Intel VT hoặc AMD-V.

Trong kiến trúc KVM, máy ảo là một tiến trình Linux, được lập lịch bởi chuẩn Linux scheduler. Trong thực tế mỗi CPU ảo xuất hiện như là một tiến trình Linux. Điều này cho phép KVM sử dụng tất cả các tính năng của Linux kernel.

![](https://lh3.googleusercontent.com/0ViyDYBAxr5Q0ZZZ8bZphK4CX3oCYUzDCiMV4RwTfpK8d-ELmoJZv3avEEVZ1vtOQgiArZE3Xnd47waf3kdLAJQOuNZbBB4tO8MW4OB5HL9B9NEVIbw0M3Vqjk1W8aWNUgwnjq76fl4)

Chính sách bảo mật và thực thi độc lập sử dụng KVM
![](https://lh5.googleusercontent.com/y9Fqpw95n-XA5TIb1m5ADeRwOpMbGVJzyH7_awf4TTgBHTJ4i-0uSJnxjZMaGGyWBfc4iuBc3nk3uGK8z1932cwhMjLPpOJbeekSnmUGZnQSIj869d-8B6hxXSPQTZISJEWvZuNthLQ)

KVM thừa kế tính năng quản lý bộ nhớ mạnh mẽ của linux. Khi chạy một máy ảo trên KVM thì bộ nhớ(Memory) của nó được lưu trữ như là bộ nhớ của bất kỳ một tiến trình nào chạy trên linux, và chúng có thể trao đổi được với nhau, mà về vấn đề quản lý bộ nhớ thì chúng ta cũng đã có sẵn các tài liệu từ các trang web uy tín, điều đó giúp cho việc quản lý bộ nhớ đạt được hiệu năng tốt nhất, các tập tin về đĩa có thể chia sẽ hoặc hỗ trợ cho bộ nhớ của máy ảo.

![](https://lh5.googleusercontent.com/t7ioB4cXpSUQWAssd20q6sX0iltnEodeyUoWtdsIULpVIiTpZQgk-4CuisOToE-Vugbvs7PdId8fINNFhEqMBono1fK3TwDzp_8wzfNjnL5Xyx7w0xSSN7RI2gDm9SLfD8hHqjKcyQ4)

Lưu trữ trên KVM
![](https://lh4.googleusercontent.com/KgD-dRGdW50_inhyWJBuY3RwdUEIKWa2zUoiKlYf8vrUUhkcXJD0DoTH6enPWdpglDuxMHrTCWoQik_zbZQ1zYVK_TZG2eUXR5BtFvlqe3BcATchYa3YVeLcgsUwPi6f3pwiCYKV5oM)

KVM hỗ trợ live migration cho phép di chuyển máy ảo đang chạy giữa các host vật lý khác nhau mà không bị gián đoạn dịch vụ. Nó trong suốt với người sử dụng cuối(end user). Máy ảo vẫn ở trạng thái running, các kết nối network vẫn hoạt động và ứng dụng của người dùng vẫn chạy trong khi máy ảo di chuyển sang một host vật lý mới.

![](https://lh3.googleusercontent.com/VaM2L6XyiM6BqGcs949pwyUVC-9yDocHYm5gZa8rgERRsqcTs_APfdEs6EJWaGoinREzoi2Kq6yI0Jd6GBMtsqO3umNyM727Gug_-M1CDxNidJdjodz0HV_ZCJmKUjz-UvsWaO7r1lM)
