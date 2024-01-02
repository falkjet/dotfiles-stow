#!/bin/sh

if [ "$(ps -p1 -o comm=)" = systemd ]; then
    alias tmux='systemd-run --scope --user tmux -2 -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'
fi
