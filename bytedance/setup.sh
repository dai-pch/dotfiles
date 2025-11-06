#!/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

# depends on add_to_file function
source $DOTFILES_ROOT/functions/add_to_file.sh
source $DOTFILES_ROOT/utils/get_shell_type.sh
INIT_FILE="bytedance/devbox.sh"

# setup rc file
CONTENTS="##### Added by dotfiles bootstrap #####\nsource $DOTFILES_ROOT/$INIT_FILE"

add_to_shrc "$CONTENTS"

# setup git config
if [ ! -f "$HOME/.gitconfig" ]; then
  ln -s $DOTFILES_ROOT/bytedance/gitconfig $HOME/.gitconfig 
fi

# install go proxy
$DOTFILES_ROOT/bytedance/install_goproxy.sh

