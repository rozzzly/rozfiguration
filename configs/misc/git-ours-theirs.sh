#!/usr/bin/env bash

##################################
# 
# creates `git accept ours` command 
# 
# @see https://stackoverflow.com/questions/914939/simple-tool-to-accept-theirs-or-accept-mine-on-a-whole-file-using-git
# 
##################################

git config --global alias.accept-ours '!f() { git checkout --ours -- "${@:-.}"; git add -u "${@:-.}"; }; f'
git config --global alias.accept-theirs '!f() { git checkout --theirs -- "${@:-.}"; git add -u "${@:-.}"; }; f'

####################################
## beter version from same post   ##
####################################
## actually I think he used zsh   ##
## so now that one isnt working   ##
## I'll have to check on it later ##
####################################
# git config --global alias.accept-ours = '!f() { [ -z \"${@}\" ] && set - '.'; git checkout --ours -- \"${@}\"; git add -u -- \"${@}\"; }; f'
# git config --global alias.accept-theirs = '!f() { [ -z \"$@\" ] && set - '.'; git checkout --theirs -- \"$@\"; git add -u -- \"$@\"; }; f'
