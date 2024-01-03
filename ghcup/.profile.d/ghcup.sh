#!/bin/sh

[ -z ${PROFILE_D_GHCUP_SOURCED+1} ] || return
export PROFILE_D_GHCUP_SOURCED=1

if [ -f "$HOME/.ghcup/env" ]; then
    #shellcheck disable=SC1091
    . "$HOME/.ghcup/env"
fi
