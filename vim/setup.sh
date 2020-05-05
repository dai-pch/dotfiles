#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh
VIM_FILE="vim/main.vim"

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# setup bashrc
add_to_file "$HOME/.vimrc" "\"##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$VIM_FILE"

