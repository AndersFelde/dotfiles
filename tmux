set -g default-terminal "alacritty"
set -g mouse on

# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

#splitting panes
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

set-window-option -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
bind -T copy-mode-vi H send b
bind -T copy-mode-vi L send w
# bind -T copy-mode-vi K send }
# bind -T copy-mode-vi J send {
bind -T copy-mode-vi Escape send q
# bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel
# bind P paste-buffer

# reload config file (change file location to your the tmux.conf you want to use)
# bind r source-file ~/.tmux.conf
