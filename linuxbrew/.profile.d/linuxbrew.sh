if [ -e "$HOME"/.linuxbrew ]; then
    pathadd "$HOME/.linuxbrew/bin"
elif [ -e /home/linuxbrew/.linuxbrew ]; then
    pathadd "/home/linuxbrew/.linuxbrew/bin"
fi
