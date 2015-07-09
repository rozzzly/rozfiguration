#!/bin/bash

#
# mosh ports
#	@see https://www.digitalocean.com/community/tutorials/how-to-install-and-use-mosh-on-a-vps
#
#
# firewalld add new rule
# 	@see https://oracle-base.com/articles/linux/linux-firewall-firewalld
#


## TODO make this shit global to install scripts
BASEPATH="/home/_developers"
CFGSPATH="$BASEPATH/configs"


cp "$CFGSPATH/init/setup/firewalld/mosh.xml" /etc/firewalld/services
cp "$CFGSPATH/init/setup/firewalld/node-with-debug.xml" /etc/firewalld/services

firewall-cmd --permanent --zone=public --add-service=mosh
firewall-cmd --permanent --zone=public --add-service=node-with-debug
firewall-cmd --reload
