neofetch --ascii_colors 4 4 4 4 4 4 --colors 4 1 1 4 7 7

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    fzf
    git
    dnf
    zsh-syntax-highlighting
    zsh-autosuggestions
    dirhistory
    web-search
)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#CUSTOM

export LC_ALL=en_US.utf8
export LANG=en_US.UTF-8
export SUDO_EDITOR=lvim
export EDITOR=lvim
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PATH="$PATH:$HOME/.local/bin/"
export BROWSER=brave

alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias vim="lvim"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias minicom="minicom -con"
alias qtile_log="cat ~/.local/share/qtile/qtile.log"
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias compile_asm='gcc -S -fno-asynchronous-unwind-tables'
alias ghidra_auto='python /opt/013brumm-tools/pwn/ghidra/auto_ghidra.py'
alias auto_ghidra='python /opt/013brumm-tools/pwn/ghidra/auto_ghidra.py'
alias rebuild_packages='paru -S --rebuild --noconfirm $(checkrebuild | awk '{print $2}' | xargs -r)'

command -v lsd > /dev/null && alias ls="lsd --group-dirs first"
command -v lsd > /dev/null && alias tree="lsd --tree"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#zoxide
eval "$(zoxide init zsh)"


# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

# CTRL-F - cd into the selected directory
fzf-cd-widget() {
  local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="cd ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
zle     -N    fzf-cd-widget
bindkey '^f' fzf-cd-widget
