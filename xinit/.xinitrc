#!/bin/sh
cd

. /etc/X11/xinit/xinitrc-common

# keymap
setxkbmap us

# picom
picom --daemon

# Window manager
awesome
