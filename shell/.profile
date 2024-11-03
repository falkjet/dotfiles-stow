#!/bin/sh

pathadd() {
    if [ -d "$1" ]; then
	case ":$PATH:" in
	    *":$1:"*) return
	esac
	PATH="$1${PATH:+":$PATH"}"
    fi
}


### .profile.d ###
for file in ~/.profile.d/*.sh; do
    # shellcheck disable=1090
    . "$file"
done

### environment.d ###
if [ -e "/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator" ]; then
	eval "$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator | grep -v '^HOME' | sed 's/^/export /')"
fi

### XDG variables ###
export XDG_CONFIG_HOME="$HOME/.config"

### neovim ###
export EDITOR=nvim

### Golang ###
export GOPATH="$HOME/.local/share/golang"
pathadd "$GOPATH/bin"

### ls ###
export LS_COLORS="di=38;5;39:ex=31:ln=38"

### nvm ###
export NVM_DIR="$HOME/.local/share/nvm"

### Cargo ###
export CARGO_HOME="$HOME/.local/share/cargo"
pathadd "$CARGO_HOME/bin"

### Path ###
pathadd "$HOME/Scripts"
pathadd "$HOME/.local/bin"

### Pass ###
export PASSWORD_STORE_DIR="$HOME/.local/share/password-storage"

### lf file manager ###
if [ -e "/usr/share/lf/lfcd.sh" ]; then
	# shellcheck disable=SC1091
	. "/usr/share/lf/lfcd.sh"
	alias lf=lfcd
fi

### ipython ###
export IPYTHONDIR="$HOME/.config/ipython"

### Zsh ###
export ZSH="$HOME/.local/share/oh-my-zsh"

### Man ###
export MANROFFOPT="-c"
export MANPAGER="sh -c 'sed \"s/\\\x1b\\\[[0-9]*m//g\" | col -bx | bat -plman'"

### Snap ###
if [ -e "/snap/bin" ]; then
    pathadd "/snap/bin"
fi

### Nix ###
if [ -e ~/.nix-profile ]; then
    pathadd ~/.nix-profile/bin
fi

### Nim ###
if [ -e ~/.nimble ]; then
    pathadd "$HOME/.nimble/bin"
fi

### Elixir ###
if [ -e ~/.mix ]; then
    pathadd "$HOME/.mix/escripts"
fi

### Deduplicate path ###
new_path="$(
    new_path=""
    IFS=:
    for p in $PATH; do
        case ":$new_path:" in
            *:"$p":*);;
            *) new_path="${new_path:+$new_path:}$p";;
        esac
    done
    echo "$new_path"
)"

PATH="$new_path"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

