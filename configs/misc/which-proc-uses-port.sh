#!/usr/bin/env bash

#
# http://www.cyberciti.biz/faq/what-process-has-open-linux-port/
#
netstat -tulpn

# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 127.0.0.1:3001          0.0.0.0:*               LISTEN      24862/mongod
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      655/sendmail: accep
# tcp        0      0 127.0.0.1:54270         0.0.0.0:*               LISTEN      24913/node
# tcp        0      0 0.0.0.0:20128           0.0.0.0:*               LISTEN      24913/node
# tcp        0      0 127.0.0.1:27017         0.0.0.0:*               LISTEN      2150/mongod
# tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      808/mysqld
# tcp        0      0 0.0.0.0:6379            0.0.0.0:*               LISTEN      613/redis-server *:
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      583/sshd
# tcp6       0      0 :::443                  :::*                    LISTEN      590/httpd
# tcp6       0      0 :::6379                 :::*                    LISTEN      613/redis-server *:
# tcp6       0      0 :::80                   :::*                    LISTEN      590/httpd
# tcp6       0      0 :::22                   :::*                    LISTEN      583/sshd
# udp        0      0 104.236.16.153:60001    0.0.0.0:*                           10720/mosh-server
# udp        0      0 104.236.16.153:60002    0.0.0.0:*                           28645/mosh-server
# udp        0      0 0.0.0.0:40088           0.0.0.0:*                           349/avahi-daemon: r
# udp        0      0 0.0.0.0:5353            0.0.0.0:*                           349/avahi-daemon: r

# then you can grep that for the port

netstat -tulpn | grep :3306

# tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      808/mysqld

# ?? learn about process with /proc via pid

#ls -l /proc/808/exe

# lrwxrwxrwx 1 root root 0 Jun 22 20:05 /proc/808/exe -> /usr/sbin/mysqld

# and also we can look up a service
netstat -tulpn |  grep /httpd
