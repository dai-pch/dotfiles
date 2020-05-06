#/usr/bin/env bash

brew install grep

GREP_PATH=$(brew --prefix grep)
TARGET_PATH="$HOME/.local/bin/grep"
if [ ! -f $TARGET_PATH ]; then
    ln -s $GREP_PATH $TARGET_PATH
fi

