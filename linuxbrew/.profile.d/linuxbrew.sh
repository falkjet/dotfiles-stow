if [ -e "$HOME"/.linuxbrew ]; then
    export PATH="$PATH:$HOME/.linuxbrew/bin"
elif [ -e /home/linuxbrew/.linuxbrew ]; then
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi
