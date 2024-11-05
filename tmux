set -g default-terminal "alacritty"
set -g mouse on

# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

#splitting panes
# bind | split-window -h
# bind - split-window -v
# unbind '"'
# unbind %
bind r source-file ~/.tmux.conf

set-window-option -g mode-keys vi
bind Enter copy-mode # enter copy mode
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
bind -T copy-mode-vi H send b
bind -T copy-mode-vi L send w
bind -T copy-mode-vi K send Pageup
bind -T copy-mode-vi J send Pagedown
bind -T copy-mode-vi Escape send q


#nvim conf
set-option -sg escape-time 10
set-option -a terminal-features "xterm-256color:RGB"
set-option -g focus-events on
set-option -g default-terminal "screen-256color"

# tpm
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-pain-control'
set -g @plugin 'niksingh710/minimal-tmux-status'

# set -g status-position top               # statusbar position
# set -g status-interval 1
# set -g window-status-format '#I:#(pwd="#{pane_current_path}"; echo ${pwd####*/})'
# set -g window-status-current-format '[#I:#(pwd="#{pane_current_path}"; echo ${pwd####*/})]'
# set -g status-right-length 0
# set -g status-right ''
# set -g window-status-current-attr bold

# set -g status-style fg=white,bold,bg=#0e1019
set -g @minimal-tmux-status "top"

set -g @minimal-tmux-fg black
set -g @minimal-tmux-bg yellow
set -g @minimal-tmux-expanded-icon "[Z]"
# 
# set the color of the window list
# setw -g window-status-style fg=white,bg=#0e1019
# 
# set colors of the active window
# setw -g window-status-current-style fg=white,bold,bg=blue
# 
# colors for pane borders
setw -g pane-border-style fg=green,bg=#0e1019
setw -g pane-active-border-style fg=white,bg=#0e1019
# 
# active pane normal, others shaded out
# setw -g window-active-style fg=colour12,bg=colour8
# setw -g window-style fg=colour10,bg=colour8

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
