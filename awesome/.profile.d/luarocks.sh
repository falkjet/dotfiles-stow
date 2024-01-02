#!/bin/sh
if command -v luarocks 2>/dev/null; then
    eval "$(luarocks path --bin)"
fi
