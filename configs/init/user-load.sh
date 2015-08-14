#!/bin/bash

###################################################################################################
# user-load.sh											
#--------------------------------------------------------------------------------------------------
# basically a global .bashrc that's only for users in the `developers` group
#
# @author: rozzzly
# @created: 6/7/15 1:04am
# @updated: 6/19/15 10:40pm
#
###################################################################################################


#==================================================================================================
# demand that user is a member of the `developers` group, "exit" if not
#--------------------------------------------------------------------------------------------------
if ! id -nG ${whoami} | grep -qE "\bdevelopers\b"; then
#	echo "user "
	return
#else 
#	echo "dev"
fi
#==================================================================================================

echo "ohai der"

#-

#==================================================================================================
# demand that user can sudo into root, otherwise exit 
#--------------------------------------------------------------------------------------------------
#
# @see http://goo.gl/qfMfwM
#
# ALSO colored error a la @see http://wiki.bash-hackers.org/scripting/terminalcodes
#
# TODO unbreak this shit
#..................................................................................................
# $CAN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
# if [ ${CAN_SUDO} -ge 0 ]; then
# 	save default so it can be restored
#	tput smcup
#	#white text
#	tput sietaf 7
#	#red background
#	tput settab 1
#       echo "USER UNABLE TO SUDO. Setup script will not run."
# 	echo "If rozfigure has already been installed, some of the pre-installed functionality will be applied to the session and function as usual. "
# 	tput rmcup
#	return 
# fi
#==================================================================================================

#-
 
#==================================================================================================
# make ls alot better 
#--------------------------------------------------------------------------------------------------
#
# keep in same buffer if output fits
# 	@see http://superuser.com/questions/775941/bash-commands-that-dont-fit-on-one-page-make-output-scrollable
#
# keep colors in outputi
#	@see http://www.commandlinefu.com/commands/view/5361/preserve-colors-when-piping-tree-to-less
#	@see http://superuser.com/questions/36022/less-and-grep-getting-colored-results-when-using-a-pipe-from-grep-to-less 
#
# keep output in scroll back
# 	@see http://unix.stackexchange.com/questions/38634/is-there-any-way-to-exit-less-without-clearing-the-screen
#
#..................................................................................................
function lsd() { 
 	ls -alhHp --color=always --classify "$@" |& less -R
	
	# idk what the -F or -R is on less (well -F is follow im pretty sure)
	# but anyways dont know how those got there. they make it freeze until it gets killed by sys.
	#..........................................................................................
	#ls -alhHp --color=always --classify "$@" |& less -FXR	
}

#..................................................................................................
#
# override bash's default `ls` command
#
#..................................................................................................
alias ls='lsd'
#==================================================================================================

#-

#==================================================================================================
#  
#--------------------------------------------------------------------------------------------------

#-

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
#
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
#==================================================================================================

#- 

#==================================================================================================
# setup aliases
#--------------------------------------------------------------------------------------------------
alias z_rawdawg='fasd_cd -d'     # cd, same functionality as j in autojump + directory listing
alias zi='fasd_cd -d -i' 	 # cd with interactive selection
alias zadd='fasd -A'		 # add path(s)
alias zrem='fasd -D'		 # delete (paths)s
alias zdel='zrem'      		 # alias to the zrem alias

alias za='fasd -a'       	 # any
alias zs='fasd -s'       	 # show / search / select
alias zis='zs -i'     		 # zs, but interactive

alias zv='za -e vim'     	 # za to vim
alias zsv='zs -e vim'	 	 # zs to vim
alias ziv='zs -e vim'		 # zv, but interactive
alias zisv='zis -e vim' 	 # zs, but interactive

alias zd='fasd -d'       	 # directory
alias zf='fasd -f'      	 # file
alias zids='zs -d'       	 # interactive directory selection
alias zifs='fasd -sif'   	 # interactive file selection
#..................................................................................................
#
# create alias to internal function in a way such that `z` will run `fasd_cd -d -i` and then `lsd`
#
#.................................................................................................. 
function lcd () 
{
	eval "fasd_cd -d $0";
	lsd;
}
#==================================================================================================

#-

#==================================================================================================
# enable autocomplete on aliases
#--------------------------------------------------------------------------------------------------
_fasd_bash_hook_cmd_complete z zi zadd zrem za zs zis zv zsv ziv zisv zd zf zids zifs
#==================================================================================================

#-

#==================================================================================================
# enable `cd` auto-correct
#--------------------------------------------------------------------------------------------------
shopt -s cdspell
#==================================================================================================

#-

#==================================================================================================
# make top prettty by default
#--------------------------------------------------------------------------------------------------
alias top='htop'
#==================================================================================================

#-

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

#-

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
#
# Undocumented feature which sets the size to "unlimited".
# 	@see http://stackoverflow.com/questions/9457233/unlimited-bash-history
#
#..................................................................................................
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
#
#..................................................................................................
#
# Force prompt to write history after every command.
# 	@see http://superuser.com/questions/20900/bash-history-loss
#
#..................................................................................................
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#==================================================================================================

#-

#==================================================================================================
# `source` in custom scripts
#--------------------------------------------------------------------------------------------------
#
# TODO make this automatic with `./manifest.json` or by copying/synlinking `./configs/scripts/` to `/usr/local/bin/ or ~/bin/
#
# find full directory of this script
#	@see http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
#..................................................................................................
#
# the code below doesnt work for sourced, TODO get abetter solution supporting sysmlinks and sourced scripts
#	`DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )`
#
# hard code the path for now
#
#..................................................................................................
DIR="/home/_developers" # TODO move to top of file, refactor name too
#..................................................................................................
#
# load 'em
#
#..................................................................................................
source "$DIR/configs/scripts/quash.sh"
#..................................................................................................
source ~/.nvm/nvm.sh
#==================================================================================================

#-

#==================================================================================================
# setup git shit
#--------------------------------------------------------------------------------------------------
#source "$DIR/configs/misc/git-mergetool-quickie.sh"
#==================================================================================================

#==================================================================================================
# create `accept-ours` & `accept-theirs` git subcommands
#--------------------------------------------------------------------------------------------------
# @see https://stackoverflow.com/questions/914939/simple-tool-to-accept-theirs-or-accept-mine-on-a-whole-file-using-git
#..................................................................................................

source "$DIR/configs/misc/git-ours-theirs.sh"

#-

#==================================================================================================
# run linking scripts
#--------------------------------------------------------------------------------------------------
# source "$DIR/configs/init/linker.sh"
#==================================================================================================
