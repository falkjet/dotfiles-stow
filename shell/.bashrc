[[ $- != *i* ]] && return
PS1='\u@\h \W $ '

### source .profile
[[ -e ~/.profile ]] && source ~/.profile

### Starship ###
if command -v starship >/dev/null; then
  source <(starship init bash --print-full-init)
fi

### Zoxide ###
if command -v zoxide >/dev/null; then
    eval "$(zoxide init posix --cmd c --hook prompt)"
fi

### autocompletion ###
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
