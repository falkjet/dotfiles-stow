#!/usr/bin/bash
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

### .bashrc.d ###
shopt -s nullglob
for file in ~/.bashrc.d/*.{sh,bash}; do
    source "$file"
done

### autocompletion ###
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
