#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh
INIT_FILE="config/init.sh"

# setup rc file
if [ -n "$BASH_VERSION" ]; then
    add_to_file "$HOME/.bashrc" "##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$INIT_FILE"
elif [ -n "$ZSH_VERSION" ]; then
    add_to_file "$HOME/.zshrc" "##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$INIT_FILE"
fi

