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
export GOPATH=$HOME/.local/share/golang
export PATH=$GOPATH/bin:$PATH

### ls ###
export LS_COLORS="di=38;5;39:ex=31:ln=38"

### nvm ###
export NVM_DIR="$HOME/.local/share/nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

### Cargo ###
export CARGO_HOME="$HOME/.local/share/cargo"

### Path ###
export PATH="$CARGO_HOME/bin:$HOME/Scripts:$HOME/.local/bin:$PATH"

### Pass ###
export PASSWORD_STORE_DIR=$HOME/.local/share/password-storage

### lf file manager ###
if [ -e "/usr/share/lf/lfcd.sh" ]; then
	# shellcheck disable=SC1091
	. "/usr/share/lf/lfcd.sh"
	alias lf=lfcd
fi

### linuxbrew ###
if [ -e "/home/linuxbrew/" ]; then
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
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
    export PATH="$PATH:/snap/bin"
fi
