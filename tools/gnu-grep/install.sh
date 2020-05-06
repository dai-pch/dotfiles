#/usr/bin/env bash
source "$(dirname "$BASH_SOURCE[0]")/../common.sh"

if [ -z $(which brew) ]; then
    $DOTFILES_ROOT/brew/install.sh
fi

brew install grep

GREP_PATH=$(brew --prefix grep)
TARGET_PATH="$HOME/.local/bin/grep"
if [ ! -f $TARGET_PATH ]; then
    ln -s $GREP_PATH $TARGET_PATH
fi

