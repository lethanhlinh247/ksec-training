Prelude

HAProxy is an open source software which can load balance HTTP and TCP servers. In the previous article on HAProxy we configured load balancing for HTTP and in this one we'll do the same for MySQL. All your MySQL servers have to be configured to perform Master-Master replication as load balancing involves both reading and writing to all the backends.

The following three droplets will be used in this article:

Droplet 1 - Load Balancer
Hostname: haproxy
OS: Ubuntu Private IP: 10.0.0.100

Droplet 2 - Node 1
Hostname: mysql-1
OS: Debian 7 Private IP: 10.0.0.1

Droplet 2 - Node 2
Hostname: mysql-2
OS: Debian 7 Private IP: 10.0.0.2

Before proceeding, make sure all MySQL servers are up, running and are properly replicating database writes.
Prepare MySQL Servers

We need to prepare the MySQL servers by creating two additional users for HAProxy. The first user will be used by HAProxy to check the status of a server.

```sh
root@mysql-1# mysql -u root -p -e "INSERT INTO mysql.user (Host,User) values ('10.0.0.100','haproxy_check'); FLUSH PRIVILEGES;"
```

A MySQL user is needed with root privileges when accessing the MySQL cluster from HAProxy. The default root user on all the servers are allowed to login only locally. While this can be fixed by granting additional privileges to the root user, it is better to have a separate user with root privileges.
```sh
root@mysql-1# mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'10.0.0.100' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"
```
Replace haproxy_root and password with your own secure values. It is enough to execute these queries on one MySQL master as changes will replicate to others.
Install MySQL Client

MySQL client has to be installed on the HAProxy droplet to test connectivity.
```sh
root@haproxy# apt-get install mysql-client
```

Now try executing a query on one of the masters as the haproxy_root user.
```sh
root@haproxy# mysql -h 10.0.0.1 -u haproxy_root -p -e "SHOW DATABASES"
```
This should display a list of MySQL databases.

Installing HAProxy

On the HAProxy server install the package.
```sh
root@haproxy# apt-get install haproxy
```

Enable HAProxy to be started by the init script.
```sh
root@haproxy# sed -i "s/ENABLED=0/ENABLED=1/" /etc/default/haproxy
```

To check if this change is done properly execute the init script of HAProxy without any parameters.
```sh
root@haproxy:~# service haproxy
Usage: /etc/init.d/haproxy {start|stop|reload|restart|status}
```

Configuring HAProxy

Rename the original configuration file
```sh
mv /etc/haproxy/haproxy.cfg{,.original}
```

Create and edit a new one
```sh
nano /etc/haproxy/haproxy.cfg
```

The first block is the global and defaults configuration block.
```sh
global
    log 127.0.0.1 local0 notice
    user haproxy
    group haproxy

defaults
    log global
    retries 2
    timeout connect 3000
    timeout server 5000
    timeout client 5000
```
More information about each of these options are covered in this article. Since we've told HAProxy to send log messages to 127.0.0.1 we have to configure rsyslog to listen on it. This has too been covered in the same article under Configure Logging for HAProxy.

Moving to the main configuration part.

```sh
listen mysql-cluster
    bind 127.0.0.1:3306
    mode tcp
    option mysql-check user haproxy_check
    balance roundrobin
    server mysql-1 10.0.0.1:3306 check
    server mysql-2 10.0.0.2:3306 check
```

Unlike HTTP load balancing HAProxy doesn't have a specific "mode" for MySQL so we use tcp. We've set HAProxy to listen only on the loopback address (assuming that application is on the same server) however if your application resides on a different droplet make it listen on 0.0.0.0 or the private IP address.

We need one more configuration block to see the statistics of load balancing. This is completely optional and can be omitted if you don't want stats.
```sh
listen 0.0.0.0:8080
    mode http
    stats enable
    stats uri /
    stats realm Strictly\ Private
    stats auth A_Username:YourPassword
    stats auth Another_User:passwd
```
Replace the usernames and passwords in "stats auth". This will make HAProxy listen on port 8080 for HTTP requests and the statistics will be protected with HTTP Basic Authentication. So you can access stats at

```sh
http://<Public IP of Load Balancer>:8080/
```

Once you're done configuring start the HAProxy service.
```sh
service haproxy start
```
Use the mysql client to query HAProxy.

```sh
root@haproxy# mysql -h 127.0.0.1 -u haproxy_root -p -e "SHOW DATABASES"
```

The "-h" option has to be present with the loopback IP address. Omitting it or using localhost will make the MySQL client connect to the mysql.sock file which will fail.
