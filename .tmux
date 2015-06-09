# use UTF-8
set -g utf8
set-window-option -g utf8 on

# ^A as magic key binding
set-option -g prefix C-a
unbind-key C-b
bind-key a send-prefix

# turn on 256 colors
set-option -g default-terminal screen-256color

# to make ctrl-arrow, etc. work
set-window-option -g xterm-keys

# turn on the status bar 

# attemt at native copy/paste -- pretty sure its what failed
#set-option -g default-command "reattach-to-user-namespace -l zsh"
#set-window-option -g automatic-rename on


# set some pretty colors
# ----------------------
# set pane colors - hilight the active pane
#set-option -g pane-border-fg colour235 #blue
#set-option -g pane-active-border-fg colour240 #red
#
# colorize messages in the command line
set-option -g message-bg black #base02
set-option -g message-fg brightred #orange

# set up status bar
# ----------------------
#
# turn the status bar on
set-option -g status on
# 
# set update requencey (default 15se)
set -g status-interval 5
#
# center window list for clarity
set -g status-justify centre
#
# position the status bar at top of the screen
set-option -g status-position top

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

#Toggle mouse on with ^A m
bind m \
  set -g mode-mouse on \;\
  set -g mouse-resize-pane on \;\
  set -g mouse-select-pane on \;\
  set -g mouse-select-window on \;\
  display 'Mouse: ON'

# Toggle mouse off with ^A M
bind M \
  set -g mode-mouse off \;\
  set -g mouse-resize-pane off \;\
  set -g mouse-select-pane off \;\
  set -g mouse-select-window off \;\
  display 'Mouse: OFF'

set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
