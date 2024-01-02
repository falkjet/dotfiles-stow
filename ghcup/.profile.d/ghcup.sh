#!/bin/sh
if [ -f "$HOME/.ghcup/env" ]; then
    #shellcheck disable=SC1091
    . "$HOME/.ghcup/env"
fi
