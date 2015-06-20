1) clone the git repo
2) build with `make && make install`
3) run ../redis-install-dir/utils/install_server.sh from ../redis-install-dir/
4) softlink `/usr/local/bin/redis-server` to  `/usr/bin/redis-server`
   lets root get to it without adding /usr/local to its $PATH
	> $ ln -s /usr/local/bin/redis-server /usr/bin/redis-server

......................................................

also might require an init.d script, `/etc/init.d/redis_6379` for `systemctl` to
function correctly and im not sure the `install-server.sh` so I included it in this folder. 

......................................................

`systemctl` requires the port in the service name for this configuration ie:
	> $ systemctl restart redis_6379
