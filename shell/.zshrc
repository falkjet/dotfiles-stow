### source .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

### history
HISTFILE=~/.zsh_history
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

### .zshrc.d ###
for file in ~/.zshrc.d/*.zsh; do
    source $file
done

### fpath ###
fpath+=($HOME/.local/share/zsh/functions)


### autocompletion ###
autoload compinit
compinit -y




