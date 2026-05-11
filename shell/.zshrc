### source .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

### Make state and cache dirs ###
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

### history
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

### input ###
bindkey -e
bindkey "\e[3~" delete-char
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5C" forward-word
WORDCHARS='_'

### Prompt ###
if command -v starship > /dev/null; then
    . <(starship init zsh --print-full-init)
fi

### Zoxide ###
if command -v zoxide > /dev/null; then
    . <(zoxide init zsh --cmd c)
fi

### FZF ###
if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
    . /usr/share/fzf/shell/key-bindings.zsh
fi

### .zshrc.d ###
for file in ~/.zshrc.d/*.zsh; do
    source $file
done

### fpath ###
fpath+=($XDG_DATA_HOME/zsh/functions)
fpath+=($XDG_CONFIG_HOME/zsh/functions)

### direnv ###
if command -v direnv >/dev/null; then
    eval "$(direnv hook zsh)"
fi

### autocompletion ###
autoload compinit
compinit -y


function launch() {
    "$@" &>/dev/null & disown
}

function startemacs() {
    launch emacsclient -ca '' "$@"
}

alias emacs='exec startemacs'

