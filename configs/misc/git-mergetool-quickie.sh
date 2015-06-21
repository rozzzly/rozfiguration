#!/bin/bash

# http://www.slashroot.in/how-to-install-and-configure-git

git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false

# TODO	make it auto apply itself