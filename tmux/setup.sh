#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh
CONF_FILE="tmux/tmux.conf"

# setup bashrc
if [ ! -z "$(which tmux)" ]; then
    add_to_file "$HOME/.tmux.conf" "##### Added by dotfiles bootstrap #####\nsource-file $DOTFILES_ROOT/$CONF_FILE"
fi

