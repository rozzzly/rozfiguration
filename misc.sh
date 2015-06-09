#!/bin/bash

###################################################################################################
# developers.sh											
#--------------------------------------------------------------------------------------------------
# basically a global .bashrc that's only for users in the `developers` group
#
# @author: rozzzly
# @created: 6/7/15 1:04am
# @updated: 6/7/15 1:05am
#
###################################################################################################

#==================================================================================================
# demand that user is a member of the `developers` group, exit if not
#--------------------------------------------------------------------------------------------------
if ! id -nG $(whoami) | grep -qE "\bdevelopers\b"; then
	return
fi

echo 'alwayshigh'

exit 0

 
#==================================================================================================
# make ls alot better 
#-------------------------------------------------------------------------------------------------
alias lsd='ls -alhHp --color=always --classify | less -R'


#==================================================================================================
#  
#-------------------------------------------------------------------------------------------------

#==================================================================================================
# setup up fasd and assign alias
#--------------------------------------------------------------------------------------------------
#
# "Fasd (pronounced similar to "fast") is a command-line productivity booster. Fasd offers quick
# access to files and directories for POSIX shells. It is inspired by tools like autojump, z and v.
# Fasd keeps track of files and directories you have accessed, so that you can quickly reference 
# them in the command line"
#
# 	@see https://github.com/clvv/fasd
#
#..................................................................................................
#
# include plug-in
#..................................................................................................
eval "$(fasd --init bash-hook bash-ccomp)"
# function to execute built-in cd
function fasd_cd ()
{
	if [ $# -le 1 ]; then
      		fasd "$@"
  	else
  		local _fasd_ret="$(fasd -e 'printf %s' $@)"
	
		[ -z "$_fasd_ret" ] && return
		[ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\\n "$_fasd_ret"
  	fi
}
#
#
# setup aliases
#..................................................................................................
alias z_rawdawg='fasd_cd -d'      # cd, same functionality as j in autojump + directory listing
alias zi='fasd_cd -d -i'  # cd with interactive selection
alias zadd='fasd -A'	  # add path(s)
alias zrem='fasd -D'	  # delete (paths)s
alias zdel=zrem

alias za='fasd -a'        # any
alias zs='fasd -s'        # show / search / select
alias zis='zs -i'     	  # zs, but interactive

alias zv='za -e vim'      # za to vim
alias zsv='zs -e vim'	  # zs to vim
alias ziv='zs -e vim'	  # zv, but interactive
alias zisv='zis -e vim'   # zs, but interactive

alias zd='fasd -d'        # directory
alias zf='fasd -f'        # file
alias zids='zs -d'        # interactive directory selection
alias zifs='fasd -sif'    # interactive file selection
#
# create alias to internal function in a way such that `z` will run `fasd_cd -d -i` and then `lsd`
#-------------------------------------------------------------------------------------------------- 
function fyuck () 
{
	eval "fasd_cd -d $0";
	lsd;
}

#
# enable autocomplete on aliases
#..................................................................................................
_fasd_bash_hook_cmd_complete z zi zadd zrem za zs zis zv zsv ziv zisv zd zf zids zifs


#==================================================================================================
# enable `cd` auto-correct
#--------------------------------------------------------------------------------------------------
shopt -s cdspell

#==================================================================================================
# make top prettty by default
#--------------------------------------------------------------------------------------------------
#alias top='htop'
alias top='atop'

#==================================================================================================
# create alias for vim's NERDtree 
#--------------------------------------------------------------------------------------------------
#
# thanks to Steven Kryskalla 
#	@see https://stackoverflow.com/questions/1447334/how-do-you-add-nerdtree-to-your-vimrc
#
#..................................................................................................
alias vimt='vim -c "NERDTree" $1'


#==================================================================================================
# psudeo-unlimited (disk space) ./bash_history
#--------------------------------------------------------------------------------------------------
#
# thanks to fotinakis
#	@see  https://superuser.com/questions/137438/how-to-unlimited-bash-shell-history 
#
#..................................................................................................
#
# shouldn't need to `shopt -s histappend` because of  PROMPT... with
# $HISTSIZE/$HISTFILESIZE undefined 
# 
#..................................................................................................
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
