### source .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

stty -echo
if [ ! ${SHELL_NO_BANNER:+1} ]; then
    if command -v fastfetch > /dev/null && [ "$TERM_PROGRAM" != vscode ]; then
        FASTFETCH_ARGS=(--structure
            Title:Separator:OS:Host:Kernel:Uptime:Shell:TerminalFont:CPU:GPU:Memory:Disk:Battery:PowerAdapter:Locale:Break:Colors)
        if command -v lolcat > /dev/null; then
            if command -v unbuffer > /dev/null; then
                unbuffer fastfetch "${FASTFETCH_ARGS[@]}" | lolcat --seed 60 --freq 0.05
            else
                fastfetch "${FASTFETCH_ARGS[@]}" | lolcat --seed 60 --freq 0.05
            fi
        else
            fastfetch "${FASTFETCH_ARGS[@]}"
        fi
    fi
fi
stty echo


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
    eval "$(zoxide init zsh --cmd c)"
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




