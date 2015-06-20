Shared Configuration Between Users in the `developers` Group
======

This allows me to `sudo -i` and keep the same configuration settings I have set on my default user. This also allows other accounts (witch are a member of the `developers` group) to have these inheritied.

This behavior can be disabled *on a per-user basis* by adding this line to `~/.bashrc`.

needs to be run by `root` thanks to mkdir, that line could be `sudo`ed 
  		  
```bash
# create `_developers` folder in `/home`
cd /home
mkdir _developers

# set ownership for shared access to `_developers` by the `developers` group
chgrp developers -R _developers 

# set SGID on `_developers` to `developers` 
#....................................................................
#
# this causes newly created files/directories in `_developers` to be owned by the `developers` group by default 
#  
# **note** only group is inherited; new files/dirs will have their owner--the user that is--set to the user idenity assocciated with the shell which created the file/dir
chmod g+s _developers

# give owner and `developers` full access, nothing for anyone else
#....................................................................
#
# set permissions on `_developers`
#
chmod 770 -R _developers 
#
# set default permissions new files/directories
setfacl -dR -m u::rwx _developers # grant rwx (full acess) to user (owner of file
setfacl -dR -m g::rwx _developers # grant rwx (full access) to group
setfacl -dR -m o::--- _developers # grant --- (no access) to others
```

```bash
test logic here
```
