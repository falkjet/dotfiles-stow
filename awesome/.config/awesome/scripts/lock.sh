#!/bin/sh

picture="$(mktemp --suffix .png)"
rm "$picture"
scrot -z "$picture"
convert "$picture" -scale 10% -scale 1000% "$picture"
i3lock -i "$picture" "$@"
rm "$picture"
