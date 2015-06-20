#!/bin/bash

CAN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
if [ ${CAN_SUDO} -le 0 ]; then
	#save default so it can be restored
	tput smcup
	#white text
	tput sietaf 7
	#red background
	tput settab 1
        echo "USER UNABLE TO SUDO. Setup script will not run."
	echo "If rozfigure has already been installed, some of the pre-installed functionality will be applied to the session and function as usual. "
	tput rmcup
	#return 
fi
