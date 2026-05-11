#!/bin/sh

pathadd() {
    if [ -d "$1" ]; then
	case ":$PATH:" in
	    *":$1:"*) return
	esac
	PATH="$1${PATH:+":$PATH"}"
    fi
}

### XDG base directory variables
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

### .profile.d ###
for file in ~/.profile.d/*.sh; do
    # shellcheck disable=1090
    . "$file"
done

### environment.d ###
if [ -e "/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator" ]; then
	eval "$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator | grep -v '^HOME' | sed 's/^/export /')"
fi

### neovim ###
export EDITOR=nvim

### Golang ###
export GOPATH="$XDG_DATA_HOME/golang"
pathadd "$GOPATH/bin"

### ls ###
export LS_COLORS="di=38;5;39:ex=31:ln=38"

### eza ###
export EZA_COLORS="reset:ur=32:gr=32:tr=32:uw=33:gw=33:tw=33:ue=31:gx=31:tx=31:di=34"

### nvm ###
export NVM_DIR="$XDG_DATA_HOME/nvm"

### Cargo ###
export CARGO_HOME="$XDG_DATA_HOME/cargo"
pathadd "$CARGO_HOME/bin"

### Path ###
pathadd "$HOME/Scripts"
pathadd "$HOME/.local/bin"

### Pass ###
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-storage"

### lf file manager ###
if [ -e "/usr/share/lf/lfcd.sh" ]; then
	# shellcheck disable=SC1091
	. "/usr/share/lf/lfcd.sh"
	alias lf=lfcd
fi

### ipython ###
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

### Zsh ###
export ZSH="$XDG_DATA_HOME/oh-my-zsh"

### Man ###
if command -v bat >/dev/null; then
	export MANROFFOPT="-c"
	export MANPAGER="sh -c 'sed \"s/\\\x1b\\\[[0-9]*m//g\" | col -bx | bat -plman'"
fi

### Snap ###
if [ -e "/snap/bin" ]; then
    pathadd "/snap/bin"
fi

### brew ###
if [ -e "$HOME"/.linuxbrew ]; then
    pathadd "$HOME/.linuxbrew/bin"
elif [ -e /home/linuxbrew/.linuxbrew ]; then
    pathadd "/home/linuxbrew/.linuxbrew/bin"
fi

### Nix ###
if [ -e ~/.nix-profile ]; then
    pathadd ~/.nix-profile/bin
fi

### Mix ###
export MIX_XDG="true"

### Nim ###
if [ -e ~/.nimble ]; then
    pathadd "$HOME/.nimble/bin"
fi

### Elixir ###
if [ -e ~/.mix ]; then
    pathadd "$HOME/.mix/escripts"
fi

### Ruby ###
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export BUNDLE_PATH="$XDG_DATA_HOME/gem"

### Volta ###
export VOLTA_HOME="$XDG_DATA_HOME/volta"
pathadd "$VOLTA_HOME/bin"

### pnpm ###
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
pathadd "$PNPM_HOME"

### ghcup ###
export GHCUP_USE_XDG_DIRS=1
if [ -f "$XDG_DATA_HOME/ghcup/env" ]; then
	. "$XDG_DATA_HOME/ghcup/env"
fi

### gradle ###
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle 

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

