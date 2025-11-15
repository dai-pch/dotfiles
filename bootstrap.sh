#!/usr/bin/env bash
DOTFILES_ROOT="$HOME/.local/dotfiles"
DOTFILES_URL="https://github.com/dai-pch/dotfiles.git"

if [ -f "$DOTFILES_ROOT" ]; then
    echo "File $DOTFILES_ROOT already exits."
    exit
fi

# if already have dotfiles, just update
if [ -d "$DOTFILES_ROOT" ]; then
    $DOTFILES_ROOT/update.sh
    exit
fi

mkdir -p $DOTFILES_ROOT
git clone --recursive $DOTFILES_URL $DOTFILES_ROOT
# $DOTFILES_ROOT/setup_all.sh
$DOTFILES_ROOT/manage/manage.py install

