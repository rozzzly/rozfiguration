#!/bin/bash

##############################################################################################################
#
# (TEMPORARLY) cache password with ssh-agent 
# 
#    !! !! !! NOTE !! !! !!
#
#	this script must be `source`d to work
#
# TODO condence code
# 
# @see
# 	http://unix.stackexchange.com/questions/90853/how-can-i-run-ssh-add-automatically-without-password-prompt
# 	http://unix.stackexchange.com/questions/122511/configuring-the-default-timeout-for-the-ssh-agent
#
#-------------------------------------------------------------------------------------------------------------
function quash ()
{


IN=$1
ARGV2=$2

if [[ $IN == "reauth" ]] ; then
	IN=$ARGV2
	unset 'SSH_AUTH_SOCK'
fi

TTYL="${IN:=$(echo '30m')}"

echo "TTYL is ${IN}"

if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval `ssh-agent -s`
    	ssh-add -t "$TTYL"
else
	echo "Already authed. If auth has expired, you need to reauth."
	
fi

}
###############################################################################################################
