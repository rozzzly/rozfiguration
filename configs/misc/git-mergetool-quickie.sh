#!/bin/bash

git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false

# TODO	make it auto apply itself