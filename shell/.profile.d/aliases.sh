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
alias open="xdg-open 2>/dev/null >/dev/null"
command -v bat >/dev/null && alias cat='bat -p'

# shellcheck disable=2010
if command -v eza >/dev/null; then
    alias ls='eza --color=auto --group-directories-first --icons'
    alias ll='eza --color=auto --group-directories-first --icons -l'
elif /bin/ls --help | grep -- --group-directories-first >/dev/null; then
    alias ls='ls --color=auto --group-directories-first'
    alias ll='ls --color=auto --group-directories-first -l'
else
    alias ls='ls --color=auto'
    alias ll='ls --color=auto -l'
fi
