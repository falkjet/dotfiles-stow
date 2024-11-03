#!/bin/sh
if command -v luarocks &>/dev/null; then
    eval "$(luarocks path --bin)"
fi
