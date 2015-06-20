#!/bin/bash

cd /home

if [ ! -e _developers ]; then
	mkdir _developers

        chmod 770 _developers


	chgrp -R developers _developers
	chmod g+s -R _developers
	
	setfacl -dR -m u::rwx _developers # grant rwx (full acess) to user (owner of file)
	setfacl -dR -m g::rwx _developers # grant rwx (full access) to group
	setfacl -dR -m o::--- _developers # grant --- (no access) to others

	# NOTE: new files created will have their perms as [rw-rw----] (660) because you must explicitly run `chown ug+x myfile`

	echo "setup-complete"
fi

cd _developers

touch "$(whoami).htouch"
echo "hello" >>  "$(whoami).pipe"
vim "$(whoami).vim"
ls -alhHp
