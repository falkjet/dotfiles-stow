#!/bin/sh

for command in stow git bc make; do
    if ! command -v "$command" >/dev/null; then
        echo command "$command" not found
        exit 1
    fi
done

DOTFILES_REPO="${DOTFILES_REPO:-github.com/falkjet/dotfiles-stow}"
DOTFILES_REPO_SSH_USER="${DOTFILES_REPO_SSH_USER:-git}"
DOTFILES_DIRECTORY="${DOTFILES_DIRECTORY:-"$HOME/dotfiles"}"

if ! [ -e "$DOTFILES_DIRECTORY" ]; then
    echo dotfiles repository not downloaded. trying to download using ssh first
    if ! git clone "ssh://$DOTFILES_REPO_SSH_USER@$DOTFILES_REPO" "$DOTFILES_DIRECTORY"; then
        echo failed to clone using ssh. trying to clone using http
        if ! git clone "https://$DOTFILES_REPO" "$DOTFILES_DIRECTORY"; then
            echo failed to clone using https
            exit 1
        fi
    fi
    if ! [ -z ${DOTFILES_BRANCH:+1} ]; then
        (cd "$DOTFILES_DIRECTORY" && git checkout "$DOTFILES_BRANCH")
    fi
fi

cd "$DOTFILES_DIRECTORY" || (echo failed to change directory to dotfiles directory; exit 1)

for package in ./*; do
    if [ -e "$package/makefile" ] || [ -e "$package/Makefile" ]; then
        make -C "$package"
    fi
done


# Hack unstow packages, so we don't backup symlinks we don't need
stow -d "$DOTFILES_DIRECTORY" -t "$HOME" -D shell setupscript

for file in ~/.bashrc ~/.zshrc ~/.profile ~/.profile.d ~/.zshrc.d; do
    if [ -e "$file" ]; then
        echo "moving $file to backup"
        newfile="$file.bak"
        if [ -e "$newfile" ]; then
            n=1
            while [ -e "$newfile$n" ]; do
                n="$(echo "$n+1" | bc)"
            done
            newfile="$newfile$n"
        fi
        echo mv -- "$file" "$newfile"
        mv -- "$file" "$newfile"
        echo "$file"
    fi
done

# stow essential packages
stow -d "$DOTFILES_DIRECTORY" -t "$HOME" shell setupscript


find ~/.setup.d/ -maxdepth 1 -type f,l -print | while read -r file; do
    "$file"
done

# source .profile
# shellcheck disable=SC1090
. ~/.profile

