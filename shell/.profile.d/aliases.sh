#!/bin/sh
alias sudo='sudo --preserve-env=TERMINFO,EDITOR'
alias please=sudo
alias restart='clear; exec zsh'
alias grep='grep --color'
alias la='ls -la'
alias lA='ls -lA'
alias clip='xclip -selection c'
alias paste='xclip -selection c -o'
alias clipcwd='pwd | xclip -selection c'
alias cdclip='cd $(xclip -selection c -o)'
alias prisma='npx prisma'
alias irssi='irssi --home ~/.config/irssi/ --config ~/.config/irssi/config'
alias config='git --git-dir="$HOME"/dotfiles --work-tree="$HOME"'
alias md='glow -p -w $COLUMNS'
alias lg='lazygit'
alias cls='clear'
alias pypy=pypy3
alias tectonic='tectonic -X'
command -v bat >/dev/null && alias cat='bat -p'

if command -v eza >/dev/null; then
    alias ls='eza --color=auto --group-directories-first --icons=auto -I"*~"'
    alias ll='eza --color=auto --group-directories-first --icons=auto -I"*~" -l'
    alias tree='eza --color=auto --group-directories-first --icons=auto -I"*~" --tree'
elif /bin/ls --help | grep -- --group-directories-first >/dev/null; then
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls --color=auto --group-directories-first -l'
else
    alias ls='ls --color=auto'
    alias ll='ls --color=auto -l'
fi

if [ "$TERM" = xterm-kitty ]; then
    alias ssh='kitty +kitten ssh'
fi

if [ "$(ps -p1 -o comm=)" = systemd ]; then
    alias tmux='systemd-run --scope --user tmux -2'
fi
