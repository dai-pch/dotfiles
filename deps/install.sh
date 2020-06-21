#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/brew.sh
BREW_PATH="$(get_brew_dir)"

if [ -z "$BREW_PATH" ]; then
    echo Error: brew not found.
    exit 1
fi

SW_LIST="$(cat $DOTFILES_ROOT/deps/sw_list.txt)"
INSTALL_LIST=
if [ "-a" = "$1" ]; then
    INSTALL_LIST="$SW_LIST"
else
    for formular in "$SW_LIST"
    do
        while true; do
            read -p "Do you want to install $formular?[Y/n]" yn
            case $yn in
                [Yy]* ) INSTALL_LIST="$INSTALL_LIST $line"; break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no."; break;;
            esac
        done
    done
fi

if [ ! -z $INSTALL_LIST ]; then
    if [ -z $(get_brew_dir) ]; then
        $DOTFILES_ROOT/brew/install.sh
    fi
    brew install $INSTALL_LIST
fi

