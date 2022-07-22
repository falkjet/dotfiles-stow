### XDG variables ###
XDG_CONFIG_HOME="$HOME/.config"


### misc aliases ###
alias please=sudo
alias ls='ls --color=auto'
alias restart='clear; exec zsh'
alias tmux='systemd-run --scope --user tmux -2 -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
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

### neovim ###
export EDITOR=nvim
alias vim=nvim

### Golang ###
export GOPATH=$HOME/.golang
export PATH=$GOPATH/bin:$PATH

### ls ###
export LS_COLORS="di=38;5;39:ex=31:ln=34"

### lf ###
export LF_COLORS="di=38;5;39:ex=31:ln=34" 
export LF_ICONS="di=:fi=:ln=:or=:ex=:\
*.vimrc=:*.viminfo=:*.gitignore=:*.c=:*.cc=:*.clj=:*.coffee=:\
*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:\
*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:\
*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:\
*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:\
*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:\
*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:\
*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:\
*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:\
*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:\
*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:\
*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:\
*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:*.nix=:\
"

### nvm ###
export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

### Cargo ###
export CARGO_HOME="$HOME/.local/share/cargo"

### Path ###
export PATH="$CARGO_HOME/bin:$HOME/Scripts:$HOME/.local/bin:$PATH"

### Pass ###
export PASSWORD_STORE_DIR=$HOME/.local/share/password-storage

### lf file manager ###
if [ -e "/usr/share/lf/lfcd.sh" ]; then
	source "/usr/share/lf/lfcd.sh"
	alias lf=lfcd
fi

### linuxbrew ###
if [ -e "/home/linuxbrew/" ]; then
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi

### ipython ###
export IPYTHONDIR="~/.config/ipython"

### Zsh ###
export ZSH="$HOME/.local/share/oh-my-zsh"

### Man ###
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -plman'"

### Snap ###
if [ -e "/snap/bin" ]; then
    export PATH="$PATH:/snap/bin"
fi
