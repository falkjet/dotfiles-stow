stty -echo
if command -v neofetch > /dev/null; then
    neofetch
fi
stty echo
# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### source .profile
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

### p10k ###
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

### oh my zsh ###
export ZSH="$HOME/.local/share/ohmyzsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE=true

# plugins
plugins=(
    git
)

[[ -e $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

### history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

### input ###
bindkey -e
bindkey "\e[3~" delete-char
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;5C" forward-word
WORDCHARS=''

### Prompt ###
if [[ -n ${ZSH_THEME:+1} ]]; then
  # prompt is set by oh my zsh
elif [[ -e /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  USE_POWERLINE="true"
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
elif command -v starship > /dev/null; then
  source <(/usr/bin/starship init zsh --print-full-init)
fi

### Zoxide ###
if command -v zoxide > /dev/null; then
    eval "$(zoxide init zsh --cmd c)"
fi

### .zshrc.d ###
for file in ~/.zshrc.d/*.zsh; do
    source $file
done

### autocompletion ###
autoload compinit
compinit -y
