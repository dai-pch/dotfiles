#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh
source $DOTFILES_ROOT/utils/get_shell_type.sh
INIT_FILE="config/init.sh"

# setup rc file
CONTENTS="##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$INIT_FILE"
case $(get_shell_type) in
    bash*)
        add_to_file "$HOME/.bashrc" $CONTENTS
        ;;
    zsh*)
        add_to_file "$HOME/.zshrc" $CONTENTS
        ;;
    *)
        echo "Unsupported shell type."
esac

